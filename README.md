# bgfx.nim
Nim bindings to the BGFX C99 API

Cross-platform, graphics API agnostic, "Bring Your Own Engine/Framework" style rendering library.

Supported rendering backends:

    Direct3D 9
    Direct3D 11
    Direct3D 12
    Metal
    OpenGL 2.1
    OpenGL 3.1+
    OpenGL ES 2
    OpenGL ES 3.1
    WebGL 1.0
    WebGL 2.0

Supported platforms:

    Android (14+, ARM, x86, MIPS)
    asm.js/Emscripten (1.25.0)
    FreeBSD
    iOS (iPhone, iPad, AppleTV)
    Linux
    MIPS Creator CI20
    OSX (10.12+)
    RaspberryPi
    SteamLink
    Windows (XP, Vista, 7, 8, 10)
    UWP (Universal Windows, Xbox One)

Supported compilers:

    Clang 3.3 and above
    GCC 5 and above
    VS2017 and above

https://github.com/bkaradzic/bgfx

API Docs - https://bkaradzic.github.io/bgfx/bgfx.html

Installation instructions -

    $ nimble install

Run example -

    $ nim c -r examples/00-HelloWorld/main.nim
    
Example dependencies:
    
    SDL2
