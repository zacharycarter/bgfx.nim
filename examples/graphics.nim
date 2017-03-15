import
  strutils

import
  bgfxdotnim
  , bgfxdotnim.platform
  , sdl2 as sdl

import 
  window

# Printable format: "$1.$2.$3" % [MAJOR, MINOR, PATCHLEVEL]
const
  MAJOR_VERSION* = 2
  MINOR_VERSION* = 0
  PATCHLEVEL* = 5

template version*(x: untyped) = ##  \
  ##  Template to determine SDL version program was compiled against.
  ##
  ##  This template fills in a Version object with the version of the
  ##  library you compiled against. This is determined by what header the
  ##  compiler uses. Note that if you dynamically linked the library, you might
  ##  have a slightly newer or older version at runtime. That version can be
  ##  determined with getVersion(), which, unlike version(),
  ##  is not a template.
  ##
  ##  ``x`` Version object to initialize.
  ##
  ##  See also:
  ##
  ##  ``Version``
  ##
  ##  ``getVersion``
  (x).major = MAJOR_VERSION
  (x).minor = MINOR_VERSION
  (x).patch = PATCHLEVEL

type
  Graphics* = ref TGraphics
  TGraphics* = object
    rootWindow: Window


when defined(macosx):
  type
    SysWMinfoCocoaObj = object
      window: pointer ## The Cocoa window

    SysWMinfoKindObj = object
      cocoa: SysWMinfoCocoaObj

when defined(linux):
  import 
    x, 
    xlib

  type
    SysWMmsgX11Obj* = object  ## when defined(SDL_VIDEO_DRIVER_X11)
      display*: ptr xlib.TXDisplay  ##  The X11 display
      window*: ptr x.TWindow            ##  The X11 window


    SysWMinfoKindObj* = object ## when defined(SDL_VIDEO_DRIVER_X11)
      x11*: SysWMMsgX11Obj

proc getTime(): float64 =
    return float64(sdl.getPerformanceCounter()*1000) / float64 sdl.getPerformanceFrequency()

proc linkSDL2BGFX(window: sdl.WindowPtr) =
    var pd: ptr bgfx_platform_data_t = create(bgfx_platform_data_t) 
    var info: sdl.WMinfo
    version(info.version)
    assert sdl.getWMInfo(window, info)
    echo  "SDL2 version: $1.$2.$3 - Subsystem: $4".format(info.version.major.int, info.version.minor.int, info.version.patch.int, 
    info.subsystem)
    
    case(info.subsystem):
        of SysWM_Windows:
          when defined(windows):
            pd.nwh = cast[pointer](info.info.win.window)
          pd.ndt = nil
        of SysWM_X11:
          when defined(linux):
            let info = cast[ptr SysWMinfoKindObj](addr info.padding[0])
            pd.nwh = info.x11.window
            pd.ndt = info.x11.display
        of SysWM_Cocoa:
          when defined(macosx):
            let info = cast[ptr SysWMinfoKindObj](addr info.padding[0])
            pd.nwh = info.cocoa.window
          pd.ndt = nil
        else:
          echo "SDL2 failed to get handle: $1".format(sdl.getError())
          raise newException(OSError, "No structure for subsystem type")

    pd.backBuffer = nil
    pd.backBufferDS = nil
    pd.context = nil
    bgfx_set_platform_data(pd)

proc newGraphics*(): Graphics =
  result = Graphics()

proc init*(graphics: Graphics, title: string, width, height: int, flags: uint32) =
  if not sdl.init(INIT_TIMER or INIT_VIDEO or INIT_JOYSTICK or INIT_HAPTIC or INIT_GAMECONTROLLER or INIT_EVENTS):
    echo "Error initializing SDL2."
    quit(QUIT_FAILURE)
  
  graphics.rootWindow = newWindow()

  graphics.rootWindow.init(title, width, height, flags)

  if graphics.rootWindow.isNil:
    echo "Error creating SDL2 window."
    quit(QUIT_FAILURE)

  linkSDL2BGFX(graphics.rootWindow.handle)

  if not bgfx_init(BGFX_RENDERER_TYPE_COUNT, 0'u16, 0, nil, nil):
    echo "Error initializng BGFX."
    quit(QUIT_FAILURE)

  bgfx_set_debug(BGFX_DEBUG_TEXT)

  bgfx_reset(uint32 width, uint32 height, BGFX_RESET_NONE)

  bgfx_set_view_rect(0, 0, 0, uint16 width, uint16 height)

proc dispose*(graphics: Graphics) =
  sdl.destroyWindow(graphics.rootWindow.handle)
  sdl.quit()
  bgfx_shutdown()