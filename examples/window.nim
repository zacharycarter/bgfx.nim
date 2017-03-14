import
  sdl2 as sdl

type
  Window* = ref TWindow
  TWindow* = object
    handle*: sdl.WindowPtr

proc newWindow*(): Window =
  result = Window()

proc init*(window: Window, title: string, width, height: int, flags: uint32) =
  window.handle = sdl.createWindow(
    title
    , sdl.SDL_WINDOWPOS_UNDEFINED, sdl.SDL_WINDOWPOS_UNDEFINED
    , width.cint, height.cint
    , flags
  )