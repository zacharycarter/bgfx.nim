import
  strutils

import
  bgfxdotnim
  , bgfxdotnim.platform
  , sdl2 as sdl

import
  ../graphics,
  logo

const WIDTH = 960
const HEIGHT = 540

proc `/`(x, y: uint16): uint16 =
    x div y


let targetFramePeriod: uint32 = 20 # 20 milliseconds corresponds to 50 fps
var frameTime: uint32 = 0

proc limitFrameRate*() =
  let now = getTicks()
  if frameTime > now:
    delay(frameTime - now) # Delay to maintain steady frame rate
  frameTime += targetFramePeriod

proc getTime(): float64 =
    return float64(sdl.getPerformanceCounter()*1000) / float64 sdl.getPerformanceFrequency()


var g = newGraphics()

g.init("bgfx.nim Example00-HelloWorld", WIDTH, HEIGHT, SDL_WINDOW_SHOWN or SDL_WINDOW_RESIZABLE)

var
  event = sdl.defaultEvent
  runGame = true


while runGame:
  while sdl.pollEvent(event):
    case event.kind
    of sdl.QuitEvent:
      runGame = false
      break
    else:
      discard

  var now = getTime()
  var last {.global.} = getTime()
  let frameTime: float32 = now - last
  let time = getTime()
  last = now
  var toMs = 1000.0'f32

  discard bgfx_touch(0)

  bgfx_dbg_text_clear(0, false)
  bgfx_dbg_text_printf(1, 1, 0x0f, "Frame: %7.3f[ms] FPS: %7.3f", float32(frameTime), (1.0 / frameTime) * toMs)

  bgfx_set_view_clear(0, BGFX_CLEAR_COLOR or BGFX_CLEAR_DEPTH, 0x303030ff, 1.0, 0)

  bgfx_dbg_text_image(max(cast[uint16](960) / 2'u16 / 8'u16, 20'u16) - 20'u16,
                      max(cast[uint16](540) / 2'u16 / 16'u16, 6'u16) - 6'u16,
                      40,
                      12,
                      addr logo[0],
                      160
                      )

  discard bgfx_frame(false)
  
  limitFrameRate()

g.dispose()