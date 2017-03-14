import
  bgfx.bgfx,
  bgfx.platform as platform,
  sdl2 as sdl

when defined(macosx):
  type
    SysWMinfoCocoaObj = object
      window: pointer ## The Cocoa window

    SysWMinfoKindObj = object
      cocoa: SysWMinfoCocoaObj

when defined(linux):
  type
    SysWMinfoX11Obj* = object
      display*: pointer  ##  The X11 display
      window*: pointer  ##  The X11 window

    SysWMinfoKindObj* = object
      x11*: SysWMinfoX11Obj

proc getTime(): float64 =
    return float64(sdl.getPerformanceCounter()*1000) / float64 sdl.getPerformanceFrequency()

proc linkSDL2BGFX(window: sdl.WindowPtr) =
    var pd: ptr platform.bgfx_platform_data_t = create(bgfx_platform_data_t) 
    var info: sdl.WMinfo
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
