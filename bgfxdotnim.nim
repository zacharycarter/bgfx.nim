 {.deadCodeElim: on.}
when defined(windows):
  const
    libname* = "bgfx-shared-lib(Debug|Release).dll"
elif defined(macosx):
  const
    libname* = "libbgfx-shared-lib(Debug|Release).dylib"
else:
  const
    libname* = "libbgfx-shared-lib(Debug|Release).so"

import bgfxdotnim/defines
export defines

type va_list* {.importc,header:"<stdarg.h>".} = object

## 
##  Copyright 2011-2017 Branimir Karadzic. All rights reserved.
##  License: https://github.com/bkaradzic/bgfx/blob/master/LICENSE
## 
##  vim: set tabstop=4 expandtab:
## 
## 
## #ifndef BGFX_C99_H_HEADER_GUARD
## #define BGFX_C99_H_HEADER_GUARD
## 
## #include <stdarg.h>  // va_list
## #include <stdbool.h> // bool
## #include <stdint.h>  // uint32
## #include <stdlib.h>  // size_t
## 
## #ifndef BGFX_SHARED_LIB_BUILD
## #    define BGFX_SHARED_LIB_BUILD 0
## #endif // BGFX_SHARED_LIB_BUILD
## 
## #ifndef BGFX_SHARED_LIB_USE
## #    define BGFX_SHARED_LIB_USE 0
## #endif // BGFX_SHARED_LIB_USE
## 
## #if defined(_MSC_VER)
## #   if BGFX_SHARED_LIB_BUILD
## #       define BGFX_SHARED_LIB_API __declspec(dllexport)
## #   elif BGFX_SHARED_LIB_USE
## #       define BGFX_SHARED_LIB_API __declspec(dllimport)
## #   else
## #       define BGFX_SHARED_LIB_API
## #   endif // BGFX_SHARED_LIB_*
## #else
## #   define BGFX_SHARED_LIB_API
## #endif // defined(_MSC_VER)
## 
## #if defined(__cplusplus)
## #   define BGFX_C_API extern "C" BGFX_SHARED_LIB_API
## #else
## #   define BGFX_C_API BGFX_SHARED_LIB_API
## #endif // defined(__cplusplus)
## 
## #include <bgfx/defines.h>
## 

type
  bgfx_renderer_type_t* {.size: sizeof(cint).} = enum
    BGFX_RENDERER_TYPE_NOOP, BGFX_RENDERER_TYPE_DIRECT3D9,
    BGFX_RENDERER_TYPE_DIRECT3D11, BGFX_RENDERER_TYPE_DIRECT3D12,
    BGFX_RENDERER_TYPE_GNM, BGFX_RENDERER_TYPE_METAL, BGFX_RENDERER_TYPE_OPENGLES,
    BGFX_RENDERER_TYPE_OPENGL, BGFX_RENDERER_TYPE_VULKAN, BGFX_RENDERER_TYPE_COUNT
  bgfx_access_t* {.size: sizeof(cint).} = enum
    BGFX_ACCESS_READ, BGFX_ACCESS_WRITE, BGFX_ACCESS_READWRITE, BGFX_ACCESS_COUNT
  bgfx_attrib_t* {.size: sizeof(cint).} = enum
    BGFX_ATTRIB_POSITION, BGFX_ATTRIB_NORMAL, BGFX_ATTRIB_TANGENT,
    BGFX_ATTRIB_BITANGENT, BGFX_ATTRIB_COLOR0, BGFX_ATTRIB_COLOR1,
    BGFX_ATTRIB_COLOR2, BGFX_ATTRIB_COLOR3, BGFX_ATTRIB_INDICES, 
    BGFX_ATTRIB_WEIGHT, BGFX_ATTRIB_TEXCOORD0, BGFX_ATTRIB_TEXCOORD1, 
    BGFX_ATTRIB_TEXCOORD2, BGFX_ATTRIB_TEXCOORD3, BGFX_ATTRIB_TEXCOORD4, 
    BGFX_ATTRIB_TEXCOORD5, BGFX_ATTRIB_TEXCOORD6, BGFX_ATTRIB_TEXCOORD7, BGFX_ATTRIB_COUNT
  bgfx_attrib_type_t* {.size: sizeof(cint).} = enum
    BGFX_ATTRIB_TYPE_UINT8, BGFX_ATTRIB_TYPE_UINT10, BGFX_ATTRIB_TYPE_INT16,
    BGFX_ATTRIB_TYPE_HALF, BGFX_ATTRIB_TYPE_FLOAT, BGFX_ATTRIB_TYPE_COUNT
  bgfx_texture_format_t* {.size: sizeof(cint).} = enum
    BGFX_TEXTURE_FORMAT_BC1, BGFX_TEXTURE_FORMAT_BC2, BGFX_TEXTURE_FORMAT_BC3,
    BGFX_TEXTURE_FORMAT_BC4, BGFX_TEXTURE_FORMAT_BC5, BGFX_TEXTURE_FORMAT_BC6H,
    BGFX_TEXTURE_FORMAT_BC7, BGFX_TEXTURE_FORMAT_ETC1, BGFX_TEXTURE_FORMAT_ETC2,
    BGFX_TEXTURE_FORMAT_ETC2A, BGFX_TEXTURE_FORMAT_ETC2A1,
    BGFX_TEXTURE_FORMAT_PTC12, BGFX_TEXTURE_FORMAT_PTC14,
    BGFX_TEXTURE_FORMAT_PTC12A, BGFX_TEXTURE_FORMAT_PTC14A,
    BGFX_TEXTURE_FORMAT_PTC22, BGFX_TEXTURE_FORMAT_PTC24,
    BGFX_TEXTURE_FORMAT_UNKNOWN, BGFX_TEXTURE_FORMAT_R1, BGFX_TEXTURE_FORMAT_A8,
    BGFX_TEXTURE_FORMAT_R8, BGFX_TEXTURE_FORMAT_R8I, BGFX_TEXTURE_FORMAT_R8U,
    BGFX_TEXTURE_FORMAT_R8S, BGFX_TEXTURE_FORMAT_R16, BGFX_TEXTURE_FORMAT_R16I,
    BGFX_TEXTURE_FORMAT_R16U, BGFX_TEXTURE_FORMAT_R16F, BGFX_TEXTURE_FORMAT_R16S,
    BGFX_TEXTURE_FORMAT_R32I, BGFX_TEXTURE_FORMAT_R32U, BGFX_TEXTURE_FORMAT_R32F,
    BGFX_TEXTURE_FORMAT_RG8, BGFX_TEXTURE_FORMAT_RG8I, BGFX_TEXTURE_FORMAT_RG8U,
    BGFX_TEXTURE_FORMAT_RG8S, BGFX_TEXTURE_FORMAT_RG16, BGFX_TEXTURE_FORMAT_RG16I,
    BGFX_TEXTURE_FORMAT_RG16U, BGFX_TEXTURE_FORMAT_RG16F,
    BGFX_TEXTURE_FORMAT_RG16S, BGFX_TEXTURE_FORMAT_RG32I,
    BGFX_TEXTURE_FORMAT_RG32U, BGFX_TEXTURE_FORMAT_RG32F,
    BGFX_TEXTURE_FORMAT_RGB8, BGFX_TEXTURE_FORMAT_RGB8I,
    BGFX_TEXTURE_FORMAT_RGB8U, BGFX_TEXTURE_FORMAT_RGB8S,
    BGFX_TEXTURE_FORMAT_RGB9E5F, BGFX_TEXTURE_FORMAT_BGRA8,
    BGFX_TEXTURE_FORMAT_RGBA8, BGFX_TEXTURE_FORMAT_RGBA8I,
    BGFX_TEXTURE_FORMAT_RGBA8U, BGFX_TEXTURE_FORMAT_RGBA8S,
    BGFX_TEXTURE_FORMAT_RGBA16, BGFX_TEXTURE_FORMAT_RGBA16I,
    BGFX_TEXTURE_FORMAT_RGBA16U, BGFX_TEXTURE_FORMAT_RGBA16F,
    BGFX_TEXTURE_FORMAT_RGBA16S, BGFX_TEXTURE_FORMAT_RGBA32I,
    BGFX_TEXTURE_FORMAT_RGBA32U, BGFX_TEXTURE_FORMAT_RGBA32F,
    BGFX_TEXTURE_FORMAT_R5G6B5, BGFX_TEXTURE_FORMAT_RGBA4,
    BGFX_TEXTURE_FORMAT_RGB5A1, BGFX_TEXTURE_FORMAT_RGB10A2,
    BGFX_TEXTURE_FORMAT_R11G11B10F, BGFX_TEXTURE_FORMAT_UNKNOWN_DEPTH,
    BGFX_TEXTURE_FORMAT_D16, BGFX_TEXTURE_FORMAT_D24, BGFX_TEXTURE_FORMAT_D24S8,
    BGFX_TEXTURE_FORMAT_D32, BGFX_TEXTURE_FORMAT_D16F, BGFX_TEXTURE_FORMAT_D24F,
    BGFX_TEXTURE_FORMAT_D32F, BGFX_TEXTURE_FORMAT_D0S8, BGFX_TEXTURE_FORMAT_COUNT
  bgfx_uniform_type_t* {.size: sizeof(cint).} = enum
    BGFX_UNIFORM_TYPE_INT1, BGFX_UNIFORM_TYPE_END, BGFX_UNIFORM_TYPE_VEC4,
    BGFX_UNIFORM_TYPE_MAT3, BGFX_UNIFORM_TYPE_MAT4, BGFX_UNIFORM_TYPE_COUNT
  bgfx_backbuffer_ratio_t* {.size: sizeof(cint).} = enum
    BGFX_BACKBUFFER_RATIO_EQUAL, BGFX_BACKBUFFER_RATIO_HALF,
    BGFX_BACKBUFFER_RATIO_QUARTER, BGFX_BACKBUFFER_RATIO_EIGHTH,
    BGFX_BACKBUFFER_RATIO_SIXTEENTH, BGFX_BACKBUFFER_RATIO_DOUBLE,
    BGFX_BACKBUFFER_RATIO_COUNT
  bgfx_occlusion_query_result_t* {.size: sizeof(cint).} = enum
    BGFX_OCCLUSION_QUERY_RESULT_INVISIBLE, BGFX_OCCLUSION_QUERY_RESULT_VISIBLE,
    BGFX_OCCLUSION_QUERY_RESULT_NORESULT, BGFX_OCCLUSION_QUERY_RESULT_COUNT
  bgfx_topology_convert_t* {.size: sizeof(cint).} = enum
    BGFX_TOPOLOGY_CONVERT_TRI_LIST_FLIP_WINDING,
    BGFX_TOPOLOGY_CONVERT_TRI_LIST_TO_LINE_LIST,
    BGFX_TOPOLOGY_CONVERT_TRI_STRIP_TO_TRI_LIST,
    BGFX_TOPOLOGY_CONVERT_LINE_STRIP_TO_LINE_LIST, BGFX_TOPOLOGY_CONVERT_COUNT
  bgfx_topology_sort_t* {.size: sizeof(cint).} = enum
    BGFX_TOPOLOGY_SORT_DIRECTION_FRONT_TO_BACK_MIN,
    BGFX_TOPOLOGY_SORT_DIRECTION_FRONT_TO_BACK_AVG,
    BGFX_TOPOLOGY_SORT_DIRECTION_FRONT_TO_BACK_MAX,
    BGFX_TOPOLOGY_SORT_DIRECTION_BACK_TO_FRONT_MIN,
    BGFX_TOPOLOGY_SORT_DIRECTION_BACK_TO_FRONT_AVG,
    BGFX_TOPOLOGY_SORT_DIRECTION_BACK_TO_FRONT_MAX,
    BGFX_TOPOLOGY_SORT_DISTANCE_FRONT_TO_BACK_MIN,
    BGFX_TOPOLOGY_SORT_DISTANCE_FRONT_TO_BACK_AVG,
    BGFX_TOPOLOGY_SORT_DISTANCE_FRONT_TO_BACK_MAX,
    BGFX_TOPOLOGY_SORT_DISTANCE_BACK_TO_FRONT_MIN,
    BGFX_TOPOLOGY_SORT_DISTANCE_BACK_TO_FRONT_AVG,
    BGFX_TOPOLOGY_SORT_DISTANCE_BACK_TO_FRONT_MAX, BGFX_TOPOLOGY_SORT_COUNT











## #define BGFX_HANDLE_T(_name) \
##    typedef struct _name { uint16 idx; } _name##_t
## BGFX_HANDLE_T(bgfx_dynamic_index_buffer_handle);
## BGFX_HANDLE_T(bgfx_dynamic_vertex_buffer_handle);
## BGFX_HANDLE_T(bgfx_frame_buffer_handle);
## BGFX_HANDLE_T(bgfx_index_buffer_handle);
## BGFX_HANDLE_T(bgfx_indirect_buffer_handle);
## BGFX_HANDLE_T(bgfx_occlusion_query_handle);
## BGFX_HANDLE_T(bgfx_program_handle);
## BGFX_HANDLE_T(bgfx_shader_handle);
## BGFX_HANDLE_T(bgfx_texture_handle);
## BGFX_HANDLE_T(bgfx_uniform_handle);
## BGFX_HANDLE_T(bgfx_vertex_buffer_handle);
## BGFX_HANDLE_T(bgfx_vertex_decl_handle);

type
  bgfx_dynamic_index_buffer_handle_t* = object
    idx*: uint16

  bgfx_dynamic_vertex_buffer_handle_t* = object
    idx*: uint16

  bgfx_frame_buffer_handle_t* = object
    idx*: uint16

  bgfx_index_buffer_handle_t* = object
    idx*: uint16

  bgfx_indirect_buffer_handle_t* = object
    idx*: uint16

  bgfx_occlusion_query_handle_t* = object
    idx*: uint16

  bgfx_program_handle_t* = object
    idx*: uint16

  bgfx_shader_handle_t* = object
    idx*: uint16

  bgfx_texture_handle_t* = object
    idx*: uint16

  bgfx_uniform_handle_t* = object
    idx*: uint16

  bgfx_vertex_buffer_handle_t* = object
    idx*: uint16

  bgfx_vertex_decl_handle_t* = object
    idx*: uint16


## 

type
  bgfx_release_fn_t* = proc (`ptr`: pointer; userData: pointer)

## 

type
  bgfx_memory_t* = object
    data*: ptr uint8
    size*: uint32


## 

type
  bgfx_transform_t* = object
    data*: ptr cfloat
    num*: uint16


## 

type
  bgfx_hmd_eye_t* = object
    rotation*: array[4, cfloat]
    translation*: array[3, cfloat]
    fov*: array[4, cfloat]
    viewOffset*: array[3, cfloat]
    projection*: array[16, cfloat]
    pixelsPerTanAngle*: array[2, cfloat]


## 

type
  bgfx_hmd_t* = object
    eye*: array[2, bgfx_hmd_eye_t]
    width*: uint16
    height*: uint16
    deviceWidth*: uint32
    deviceHeight*: uint32
    flags*: uint8


## 

type
  bgfx_stats_t* = object
    cpuTimeBegin*: uint64
    cpuTimeEnd*: uint64
    cpuTimerFreq*: uint64
    gpuTimeBegin*: uint64
    gpuTimeEnd*: uint64
    gpuTimerFreq*: uint64
    waitRender*: int64
    waitSubmit*: int64
    numDraw*: uint32
    numCompute*: uint32
    maxGpuLatency*: uint32
    width*: uint16
    height*: uint16
    textWidth*: uint16
    textHeight*: uint16


## 

type
  bgfx_vertex_decl_t* = object
    hash*: uint32
    stride*: uint16
    offset*: array[BGFX_ATTRIB_COUNT, uint16]
    attributes*: array[BGFX_ATTRIB_COUNT, uint16]


## 

type
  bgfx_transient_index_buffer_t* = object
    data*: ptr uint8
    size*: uint32
    handle*: bgfx_index_buffer_handle_t
    startIndex*: uint32


## 

type
  bgfx_transient_vertex_buffer_t* = object
    data*: ptr uint8
    size*: uint32
    startVertex*: uint32
    stride*: uint16
    handle*: bgfx_vertex_buffer_handle_t
    decl*: bgfx_vertex_decl_handle_t


## 

type
  bgfx_instance_data_buffer_t* = object
    data*: ptr uint8
    size*: uint32
    offset*: uint32
    num*: uint32
    stride*: uint16
    handle*: bgfx_vertex_buffer_handle_t


## 

type
  bgfx_texture_info_t* = object
    format*: bgfx_texture_format_t
    storageSize*: uint32
    width*: uint16
    height*: uint16
    depth*: uint16
    numLayers*: uint16
    numMips*: uint8
    bitsPerPixel*: uint8
    cubeMap*: bool


## 

type
  bgfx_uniform_info_t* = object
    name*: array[256, char]
    `type`*: bgfx_uniform_type_t
    num*: uint16


## 

type
  bgfx_attachment_t* = object
    handle*: bgfx_texture_handle_t
    mip*: uint16
    layer*: uint16


## 

type
  bgfx_caps_gpu_t* = object
    vendorId*: uint16
    deviceId*: uint16

  bgfx_caps_limits_t* = object
    maxDrawCalls*: uint32
    maxBlits*: uint32
    maxTextureSize*: uint32
    maxViews*: uint32
    maxFrameBuffers*: uint32
    maxFBAttachments*: uint32
    maxPrograms*: uint32
    maxShaders*: uint32
    maxTextures*: uint32
    maxTextureSamplers*: uint32
    maxVertexDecls*: uint32
    maxVertexStreams*: uint32
    maxIndexBuffers*: uint32
    maxVertexBuffers*: uint32
    maxDynamicIndexBuffers*: uint32
    maxDynamicVertexBuffers*: uint32
    maxUniforms*: uint32
    maxOcclusionQueries*: uint32


## 

type
  bgfx_caps_t* = object
    rendererType*: bgfx_renderer_type_t
    supported*: uint64
    vendorId*: uint16
    deviceId*: uint16
    homogeneousDepth*: bool
    originBottomLeft*: bool
    numGPUs*: uint8
    gpu*: array[4, bgfx_caps_gpu_t]
    limits*: bgfx_caps_limits_t
    formats*: array[BGFX_TEXTURE_FORMAT_COUNT, uint16]


## 

type
  bgfx_fatal_t* {.size: sizeof(cint).} = enum
    BGFX_FATAL_DEBUG_CHECK, BGFX_FATAL_INVALID_SHADER,
    BGFX_FATAL_UNABLE_TO_INITIALIZE, BGFX_FATAL_UNABLE_TO_CREATE_TEXTURE,
    BGFX_FATAL_DEVICE_LOST, BGFX_FATAL_COUNT


## 

type
  bgfx_callback_interface_t* = object
    vtbl*: ptr bgfx_callback_vtbl_t


  bgfx_callback_vtbl_t* = object
    fatal*: proc (this: ptr bgfx_callback_interface_t; code: bgfx_fatal_t;
                str: cstring)
    trace_vargs*: proc (this: ptr bgfx_callback_interface_t; filePath: cstring;
                      line: uint16; format: cstring; argList: va_list)
    cache_read_size*: proc (this: ptr bgfx_callback_interface_t; id: uint64): uint32
    cache_read*: proc (this: ptr bgfx_callback_interface_t; id: uint64;
                     data: pointer; size: uint32): bool
    cache_write*: proc (this: ptr bgfx_callback_interface_t; id: uint64;
                      data: pointer; size: uint32)
    screen_shot*: proc (this: ptr bgfx_callback_interface_t; filePath: cstring;
                      width: uint32; height: uint32; pitch: uint32;
                      data: pointer; size: uint32; yflip: bool)
    capture_begin*: proc (this: ptr bgfx_callback_interface_t; width: uint32;
                        height: uint32; pitch: uint32;
                        format: bgfx_texture_format_t; yflip: bool)
    capture_end*: proc (this: ptr bgfx_callback_interface_t)
    capture_frame*: proc (this: ptr bgfx_callback_interface_t; data: pointer;
                        size: uint32)

  bgfx_allocator_interface_t* = object
    vtbl*: ptr bgfx_allocator_vtbl_t

  bgfx_allocator_vtbl_t* = object
    realloc*: proc (this: ptr bgfx_allocator_interface_t; `ptr`: pointer; size: csize;
                  align: csize; file: cstring; line: uint32): pointer


## 

proc bgfx_vertex_decl_begin*(decl: ptr bgfx_vertex_decl_t;
                            renderer: bgfx_renderer_type_t) {.
    importc: "bgfx_vertex_decl_begin", dynlib: libname.}
## 

proc bgfx_vertex_decl_add*(decl: ptr bgfx_vertex_decl_t; attrib: bgfx_attrib_t;
                          num: uint8; `type`: bgfx_attrib_type_t;
                          normalized: bool; asInt: bool) {.
    importc: "bgfx_vertex_decl_add", dynlib: libname.}
## 

proc bgfx_vertex_decl_skip*(decl: ptr bgfx_vertex_decl_t; num: uint8) {.
    importc: "bgfx_vertex_decl_skip", dynlib: libname.}
## 

proc bgfx_vertex_decl_end*(decl: ptr bgfx_vertex_decl_t) {.
    importc: "bgfx_vertex_decl_end", dynlib: libname.}
## 

proc bgfx_vertex_pack*(input: array[4, cfloat]; inputNormalized: bool;
                      attr: bgfx_attrib_t; decl: ptr bgfx_vertex_decl_t;
                      data: pointer; index: uint32) {.
    importc: "bgfx_vertex_pack", dynlib: libname.}
## 

proc bgfx_vertex_unpack*(output: array[4, cfloat]; attr: bgfx_attrib_t;
                        decl: ptr bgfx_vertex_decl_t; data: pointer;
                        index: uint32) {.importc: "bgfx_vertex_unpack",
    dynlib: libname.}
## 

proc bgfx_vertex_convert*(destDecl: ptr bgfx_vertex_decl_t; destData: pointer;
                         srcDecl: ptr bgfx_vertex_decl_t; srcData: pointer;
                         num: uint32) {.importc: "bgfx_vertex_convert",
    dynlib: libname.}
## 

proc bgfx_weld_vertices*(output: ptr uint16; decl: ptr bgfx_vertex_decl_t;
                        data: pointer; num: uint16; epsilon: cfloat): uint16 {.
    importc: "bgfx_weld_vertices", dynlib: libname.}
## 

proc bgfx_topology_convert*(conversion: bgfx_topology_convert_t; dst: pointer;
                           dstSize: uint32; indices: pointer;
                           numIndices: uint32; index32: bool): uint32 {.
    importc: "bgfx_topology_convert", dynlib: libname.}
## 

proc bgfx_topology_sort_tri_list*(sort: bgfx_topology_sort_t; dst: pointer;
                                 dstSize: uint32; dir: array[3, cfloat];
                                 pos: array[3, cfloat]; vertices: pointer;
                                 stride: uint32; indices: pointer;
                                 numIndices: uint32; index32: bool) {.
    importc: "bgfx_topology_sort_tri_list", dynlib: libname.}
## 

proc bgfx_image_swizzle_bgra8*(dst: pointer; width: uint32; height: uint32;
                              pitch: uint32; src: pointer) {.
    importc: "bgfx_image_swizzle_bgra8", dynlib: libname.}
## 

proc bgfx_image_rgba8_downsample_2x2*(dst: pointer; width: uint32;
                                     height: uint32; pitch: uint32;
                                     src: pointer) {.
    importc: "bgfx_image_rgba8_downsample_2x2", dynlib: libname.}
## 

proc bgfx_get_supported_renderers*(max: uint8; `enum`: ptr bgfx_renderer_type_t): uint8 {.
    importc: "bgfx_get_supported_renderers", dynlib: libname.}
## 

proc bgfx_get_renderer_name*(`type`: bgfx_renderer_type_t): cstring {.
    importc: "bgfx_get_renderer_name", dynlib: libname.}
## 

proc bgfx_init*(`type`: bgfx_renderer_type_t; vendorId: uint16;
               deviceId: uint16; callback: ptr bgfx_callback_interface_t;
               allocator: ptr bgfx_allocator_interface_t): bool {.
    importc: "bgfx_init", dynlib: libname.}
## 

proc bgfx_shutdown*() {.importc: "bgfx_shutdown", dynlib: libname.}
## 

proc bgfx_reset*(width: uint32; height: uint32; flags: uint32) {.
    importc: "bgfx_reset", dynlib: libname.}
## 

proc bgfx_frame*(capture: bool): uint32 {.importc: "bgfx_frame", dynlib: libname.}
## 

proc bgfx_get_renderer_type*(): bgfx_renderer_type_t {.
    importc: "bgfx_get_renderer_type", dynlib: libname.}
## 

proc bgfx_get_caps*(): ptr bgfx_caps_t {.importc: "bgfx_get_caps", dynlib: libname.}
## 

proc bgfx_get_hmd*(): ptr bgfx_hmd_t {.importc: "bgfx_get_hmd", dynlib: libname.}
## 

proc bgfx_get_stats*(): ptr bgfx_stats_t {.importc: "bgfx_get_stats", dynlib: libname.}
## 

proc bgfx_alloc*(size: uint32): ptr bgfx_memory_t {.importc: "bgfx_alloc",
    dynlib: libname.}
## 

proc bgfx_copy*(data: pointer; size: uint32): ptr bgfx_memory_t {.
    importc: "bgfx_copy", dynlib: libname.}
## 

proc bgfx_make_ref*(data: pointer; size: uint32): ptr bgfx_memory_t {.
    importc: "bgfx_make_ref", dynlib: libname.}
## 

proc bgfx_make_ref_release*(data: pointer; size: uint32;
                           releaseFn: bgfx_release_fn_t; userData: pointer): ptr bgfx_memory_t {.
    importc: "bgfx_make_ref_release", dynlib: libname.}
## 

proc bgfx_set_debug*(debug: uint32) {.importc: "bgfx_set_debug", dynlib: libname.}
## 

proc bgfx_dbg_text_clear*(attr: uint8; small: bool) {.
    importc: "bgfx_dbg_text_clear", dynlib: libname.}
## 

proc bgfx_dbg_text_printf*(x: uint16; y: uint16; attr: uint8; format: cstring) {.
    varargs, importc: "bgfx_dbg_text_printf", dynlib: libname.}
## 

proc bgfx_dbg_text_vprintf*(x: uint16; y: uint16; attr: uint8;
                           format: cstring; argList: va_list) {.
    importc: "bgfx_dbg_text_vprintf", dynlib: libname.}
## 

proc bgfx_dbg_text_image*(x: uint16; y: uint16; width: uint16;
                         height: uint16; data: pointer; pitch: uint16) {.
    importc: "bgfx_dbg_text_image", dynlib: libname.}
## 

proc bgfx_create_index_buffer*(mem: ptr bgfx_memory_t; flags: uint16): bgfx_index_buffer_handle_t {.
    importc: "bgfx_create_index_buffer", dynlib: libname.}
## 

proc bgfx_destroy_index_buffer*(handle: bgfx_index_buffer_handle_t) {.
    importc: "bgfx_destroy_index_buffer", dynlib: libname.}
## 

proc bgfx_create_vertex_buffer*(mem: ptr bgfx_memory_t;
                               decl: ptr bgfx_vertex_decl_t; flags: uint16): bgfx_vertex_buffer_handle_t {.
    importc: "bgfx_create_vertex_buffer", dynlib: libname.}
## 

proc bgfx_destroy_vertex_buffer*(handle: bgfx_vertex_buffer_handle_t) {.
    importc: "bgfx_destroy_vertex_buffer", dynlib: libname.}
## 

proc bgfx_create_dynamic_index_buffer*(num: uint32; flags: uint16): bgfx_dynamic_index_buffer_handle_t {.
    importc: "bgfx_create_dynamic_index_buffer", dynlib: libname.}
## 

proc bgfx_create_dynamic_index_buffer_mem*(mem: ptr bgfx_memory_t; flags: uint16): bgfx_dynamic_index_buffer_handle_t {.
    importc: "bgfx_create_dynamic_index_buffer_mem", dynlib: libname.}
## 

proc bgfx_update_dynamic_index_buffer*(handle: bgfx_dynamic_index_buffer_handle_t;
                                      startIndex: uint32;
                                      mem: ptr bgfx_memory_t) {.
    importc: "bgfx_update_dynamic_index_buffer", dynlib: libname.}
## 

proc bgfx_destroy_dynamic_index_buffer*(handle: bgfx_dynamic_index_buffer_handle_t) {.
    importc: "bgfx_destroy_dynamic_index_buffer", dynlib: libname.}
## 

proc bgfx_create_dynamic_vertex_buffer*(num: uint32;
                                       decl: ptr bgfx_vertex_decl_t;
                                       flags: uint16): bgfx_dynamic_vertex_buffer_handle_t {.
    importc: "bgfx_create_dynamic_vertex_buffer", dynlib: libname.}
## 

proc bgfx_create_dynamic_vertex_buffer_mem*(mem: ptr bgfx_memory_t;
    decl: ptr bgfx_vertex_decl_t; flags: uint16): bgfx_dynamic_vertex_buffer_handle_t {.
    importc: "bgfx_create_dynamic_vertex_buffer_mem", dynlib: libname.}
## 

proc bgfx_update_dynamic_vertex_buffer*(handle: bgfx_dynamic_vertex_buffer_handle_t;
                                       startVertex: uint32;
                                       mem: ptr bgfx_memory_t) {.
    importc: "bgfx_update_dynamic_vertex_buffer", dynlib: libname.}
## 

proc bgfx_destroy_dynamic_vertex_buffer*(handle: bgfx_dynamic_vertex_buffer_handle_t) {.
    importc: "bgfx_destroy_dynamic_vertex_buffer", dynlib: libname.}
## 

proc bgfx_get_avail_transient_index_buffer*(num: uint32): uint32 {.
    importc: "bgfx_get_avail_transient_index_buffer", dynlib: libname.}
## 

proc bgfx_get_avail_transient_vertex_buffer*(num: uint32;
    decl: ptr bgfx_vertex_decl_t): uint32 {.
    importc: "bgfx_get_avail_transient_vertex_buffer", dynlib: libname.}
## 

proc bgfx_get_avail_instance_data_buffer*(num: uint32; stride: uint16): uint32 {.
    importc: "bgfx_get_avail_instance_data_buffer", dynlib: libname.}
## 

proc bgfx_alloc_transient_index_buffer*(tib: ptr bgfx_transient_index_buffer_t;
                                       num: uint32) {.
    importc: "bgfx_alloc_transient_index_buffer", dynlib: libname.}
## 

proc bgfx_alloc_transient_vertex_buffer*(tvb: ptr bgfx_transient_vertex_buffer_t;
                                        num: uint32;
                                        decl: ptr bgfx_vertex_decl_t) {.
    importc: "bgfx_alloc_transient_vertex_buffer", dynlib: libname.}
## 

proc bgfx_alloc_transient_buffers*(tvb: ptr bgfx_transient_vertex_buffer_t;
                                  decl: ptr bgfx_vertex_decl_t;
                                  numVertices: uint32;
                                  tib: ptr bgfx_transient_index_buffer_t;
                                  numIndices: uint32): bool {.
    importc: "bgfx_alloc_transient_buffers", dynlib: libname.}
## 

proc bgfx_alloc_instance_data_buffer*(num: uint32; stride: uint16): ptr bgfx_instance_data_buffer_t {.
    importc: "bgfx_alloc_instance_data_buffer", dynlib: libname.}
## 

proc bgfx_create_indirect_buffer*(num: uint32): bgfx_indirect_buffer_handle_t {.
    importc: "bgfx_create_indirect_buffer", dynlib: libname.}
## 

proc bgfx_destroy_indirect_buffer*(handle: bgfx_indirect_buffer_handle_t) {.
    importc: "bgfx_destroy_indirect_buffer", dynlib: libname.}
## 

proc bgfx_create_shader*(mem: ptr bgfx_memory_t): bgfx_shader_handle_t {.
    importc: "bgfx_create_shader", dynlib: libname.}
## 

proc bgfx_get_shader_uniforms*(handle: bgfx_shader_handle_t;
                              uniforms: ptr bgfx_uniform_handle_t; max: uint16): uint16 {.
    importc: "bgfx_get_shader_uniforms", dynlib: libname.}
## 

proc bgfx_get_uniform_info*(handle: bgfx_uniform_handle_t;
                           info: ptr bgfx_uniform_info_t) {.
    importc: "bgfx_get_uniform_info", dynlib: libname.}
## 

proc bgfx_destroy_shader*(handle: bgfx_shader_handle_t) {.
    importc: "bgfx_destroy_shader", dynlib: libname.}
## 

proc bgfx_create_program*(vsh: bgfx_shader_handle_t; fsh: bgfx_shader_handle_t;
                         destroyShaders: bool): bgfx_program_handle_t {.
    importc: "bgfx_create_program", dynlib: libname.}
## 

proc bgfx_create_compute_program*(csh: bgfx_shader_handle_t; destroyShaders: bool): bgfx_program_handle_t {.
    importc: "bgfx_create_compute_program", dynlib: libname.}
## 

proc bgfx_destroy_program*(handle: bgfx_program_handle_t) {.
    importc: "bgfx_destroy_program", dynlib: libname.}
## 

proc bgfx_is_texture_valid*(depth: uint16; cubeMap: bool; numLayers: uint16;
                           format: bgfx_texture_format_t; flags: uint32): bool {.
    importc: "bgfx_is_texture_valid", dynlib: libname.}
## 

proc bgfx_calc_texture_size*(info: ptr bgfx_texture_info_t; width: uint16;
                            height: uint16; depth: uint16; cubeMap: bool;
                            hasMips: bool; numLayers: uint16;
                            format: bgfx_texture_format_t) {.
    importc: "bgfx_calc_texture_size", dynlib: libname.}
## 

proc bgfx_create_texture*(mem: ptr bgfx_memory_t; flags: uint32; skip: uint8;
                         info: ptr bgfx_texture_info_t): bgfx_texture_handle_t {.
    importc: "bgfx_create_texture", dynlib: libname.}
## 

proc bgfx_create_texture_2d*(width: uint16; height: uint16; hasMips: bool;
                            numLayers: uint16; format: bgfx_texture_format_t;
                            flags: uint32; mem: ptr bgfx_memory_t): bgfx_texture_handle_t {.
    importc: "bgfx_create_texture_2d", dynlib: libname.}
## 

proc bgfx_create_texture_2d_scaled*(ratio: bgfx_backbuffer_ratio_t;
                                   hasMips: bool; numLayers: uint16;
                                   format: bgfx_texture_format_t;
                                   flags: uint32): bgfx_texture_handle_t {.
    importc: "bgfx_create_texture_2d_scaled", dynlib: libname.}
## 

proc bgfx_create_texture_3d*(width: uint16; height: uint16; depth: uint16;
                            hasMips: bool; format: bgfx_texture_format_t;
                            flags: uint32; mem: ptr bgfx_memory_t): bgfx_texture_handle_t {.
    importc: "bgfx_create_texture_3d", dynlib: libname.}
## 

proc bgfx_create_texture_cube*(size: uint16; hasMips: bool; numLayers: uint16;
                              format: bgfx_texture_format_t; flags: uint32;
                              mem: ptr bgfx_memory_t): bgfx_texture_handle_t {.
    importc: "bgfx_create_texture_cube", dynlib: libname.}
## 

proc bgfx_update_texture_2d*(handle: bgfx_texture_handle_t; layer: uint16;
                            mip: uint8; x: uint16; y: uint16;
                            width: uint16; height: uint16;
                            mem: ptr bgfx_memory_t; pitch: uint16) {.
    importc: "bgfx_update_texture_2d", dynlib: libname.}
## 

proc bgfx_update_texture_3d*(handle: bgfx_texture_handle_t; mip: uint8;
                            x: uint16; y: uint16; z: uint16;
                            width: uint16; height: uint16; depth: uint16;
                            mem: ptr bgfx_memory_t) {.
    importc: "bgfx_update_texture_3d", dynlib: libname.}
## 

proc bgfx_update_texture_cube*(handle: bgfx_texture_handle_t; layer: uint16;
                              side: uint8; mip: uint8; x: uint16;
                              y: uint16; width: uint16; height: uint16;
                              mem: ptr bgfx_memory_t; pitch: uint16) {.
    importc: "bgfx_update_texture_cube", dynlib: libname.}
## 

proc bgfx_read_texture*(handle: bgfx_texture_handle_t; data: pointer; mip: uint8): uint32 {.
    importc: "bgfx_read_texture", dynlib: libname.}
## 

proc bgfx_destroy_texture*(handle: bgfx_texture_handle_t) {.
    importc: "bgfx_destroy_texture", dynlib: libname.}
## 

proc bgfx_create_frame_buffer*(width: uint16; height: uint16;
                              format: bgfx_texture_format_t;
                              textureFlags: uint32): bgfx_frame_buffer_handle_t {.
    importc: "bgfx_create_frame_buffer", dynlib: libname.}
## 

proc bgfx_create_frame_buffer_scaled*(ratio: bgfx_backbuffer_ratio_t;
                                     format: bgfx_texture_format_t;
                                     textureFlags: uint32): bgfx_frame_buffer_handle_t {.
    importc: "bgfx_create_frame_buffer_scaled", dynlib: libname.}
## 

proc bgfx_create_frame_buffer_from_handles*(num: uint8;
    handles: ptr bgfx_texture_handle_t; destroyTextures: bool): bgfx_frame_buffer_handle_t {.
    importc: "bgfx_create_frame_buffer_from_handles", dynlib: libname.}
## 

proc bgfx_create_frame_buffer_from_attachment*(num: uint8;
    attachment: ptr bgfx_attachment_t; destroyTextures: bool): bgfx_frame_buffer_handle_t {.
    importc: "bgfx_create_frame_buffer_from_attachment", dynlib: libname.}
## 

proc bgfx_create_frame_buffer_from_nwh*(nwh: pointer; width: uint16;
                                       height: uint16;
                                       depthFormat: bgfx_texture_format_t): bgfx_frame_buffer_handle_t {.
    importc: "bgfx_create_frame_buffer_from_nwh", dynlib: libname.}
## 

proc bgfx_get_texture*(handle: bgfx_frame_buffer_handle_t; attachment: uint8): bgfx_texture_handle_t {.
    importc: "bgfx_get_texture", dynlib: libname.}
## 

proc bgfx_destroy_frame_buffer*(handle: bgfx_frame_buffer_handle_t) {.
    importc: "bgfx_destroy_frame_buffer", dynlib: libname.}
## 

proc bgfx_create_uniform*(name: cstring; `type`: bgfx_uniform_type_t; num: uint16): bgfx_uniform_handle_t {.
    importc: "bgfx_create_uniform", dynlib: libname.}
## 

proc bgfx_destroy_uniform*(handle: bgfx_uniform_handle_t) {.
    importc: "bgfx_destroy_uniform", dynlib: libname.}
## 

proc bgfx_create_occlusion_query*(): bgfx_occlusion_query_handle_t {.
    importc: "bgfx_create_occlusion_query", dynlib: libname.}
## 

proc bgfx_get_result*(handle: bgfx_occlusion_query_handle_t; result: ptr int32): bgfx_occlusion_query_result_t {.
    importc: "bgfx_get_result", dynlib: libname.}
## 

proc bgfx_destroy_occlusion_query*(handle: bgfx_occlusion_query_handle_t) {.
    importc: "bgfx_destroy_occlusion_query", dynlib: libname.}
## 

proc bgfx_set_palette_color*(index: uint8; rgba: array[4, cfloat]) {.
    importc: "bgfx_set_palette_color", dynlib: libname.}
## 

proc bgfx_set_view_name*(id: uint8; name: cstring) {.
    importc: "bgfx_set_view_name", dynlib: libname.}
## 

proc bgfx_set_view_rect*(id: uint8; x: uint16; y: uint16; width: uint16;
                        height: uint16) {.importc: "bgfx_set_view_rect",
    dynlib: libname.}
## 

proc bgfx_set_view_rect_auto*(id: uint8; x: uint16; y: uint16;
                             ratio: bgfx_backbuffer_ratio_t) {.
    importc: "bgfx_set_view_rect_auto", dynlib: libname.}
## 

proc bgfx_set_view_scissor*(id: uint8; x: uint16; y: uint16; width: uint16;
                           height: uint16) {.importc: "bgfx_set_view_scissor",
    dynlib: libname.}
## 

proc bgfx_set_view_clear*(id: uint8; flags: uint16; rgba: uint32;
                         depth: cfloat; stencil: uint8) {.
    importc: "bgfx_set_view_clear", dynlib: libname.}
## 

proc bgfx_set_view_clear_mrt*(id: uint8; flags: uint16; depth: cfloat;
                             stencil: uint8; zero: uint8; one: uint8; two: uint8;
                             three: uint8; four: uint8; five: uint8; six: uint8;
                             seven: uint8) {.importc: "bgfx_set_view_clear_mrt",
    dynlib: libname.}
## 

proc bgfx_set_view_seq*(id: uint8; enabled: bool) {.importc: "bgfx_set_view_seq",
    dynlib: libname.}
## 

proc bgfx_set_view_frame_buffer*(id: uint8; handle: bgfx_frame_buffer_handle_t) {.
    importc: "bgfx_set_view_frame_buffer", dynlib: libname.}
## 

proc bgfx_set_view_transform*(id: uint8; view: pointer; proj: pointer) {.
    importc: "bgfx_set_view_transform", dynlib: libname.}
## 

proc bgfx_set_view_transform_stereo*(id: uint8; view: pointer; projL: pointer;
                                    flags: uint8; projR: pointer) {.
    importc: "bgfx_set_view_transform_stereo", dynlib: libname.}
## 

proc bgfx_set_view_order*(id: uint8; num: uint8; order: pointer) {.
    importc: "bgfx_set_view_order", dynlib: libname.}
## 

proc bgfx_reset_view*(id: uint8) {.importc: "bgfx_reset_view", dynlib: libname.}
## 

proc bgfx_set_marker*(marker: cstring) {.importc: "bgfx_set_marker", dynlib: libname.}
## 

proc bgfx_set_state*(state: uint64; rgba: uint32) {.importc: "bgfx_set_state",
    dynlib: libname.}
## 

proc bgfx_set_condition*(handle: bgfx_occlusion_query_handle_t; visible: bool) {.
    importc: "bgfx_set_condition", dynlib: libname.}
## 

proc bgfx_set_stencil*(fstencil: uint32; bstencil: uint32) {.
    importc: "bgfx_set_stencil", dynlib: libname.}
## 

proc bgfx_set_scissor*(x: uint16; y: uint16; width: uint16; height: uint16): uint16 {.
    importc: "bgfx_set_scissor", dynlib: libname.}
## 

proc bgfx_set_scissor_cached*(cache: uint16) {.
    importc: "bgfx_set_scissor_cached", dynlib: libname.}
## 

proc bgfx_set_transform*(mtx: pointer; num: uint16): uint32 {.
    importc: "bgfx_set_transform", dynlib: libname.}
## 

proc bgfx_alloc_transform*(transform: ptr bgfx_transform_t; num: uint16): uint32 {.
    importc: "bgfx_alloc_transform", dynlib: libname.}
## 

proc bgfx_set_transform_cached*(cache: uint32; num: uint16) {.
    importc: "bgfx_set_transform_cached", dynlib: libname.}
## 

proc bgfx_set_uniform*(handle: bgfx_uniform_handle_t; value: pointer;
                      num: uint16) {.importc: "bgfx_set_uniform", dynlib: libname.}
## 

proc bgfx_set_index_buffer*(handle: bgfx_index_buffer_handle_t;
                           firstIndex: uint32; numIndices: uint32) {.
    importc: "bgfx_set_index_buffer", dynlib: libname.}
## 

proc bgfx_set_dynamic_index_buffer*(handle: bgfx_dynamic_index_buffer_handle_t;
                                   firstIndex: uint32; numIndices: uint32) {.
    importc: "bgfx_set_dynamic_index_buffer", dynlib: libname.}
## 

proc bgfx_set_transient_index_buffer*(tib: ptr bgfx_transient_index_buffer_t;
                                     firstIndex: uint32; numIndices: uint32) {.
    importc: "bgfx_set_transient_index_buffer", dynlib: libname.}
## 

proc bgfx_set_vertex_buffer*(stream: uint8, handle: bgfx_vertex_buffer_handle_t;
                            startVertex: uint32; numVertices: uint32) {.
    importc: "bgfx_set_vertex_buffer", dynlib: libname.}
## 

proc bgfx_set_dynamic_vertex_buffer*(stream: uint8, handle: bgfx_dynamic_vertex_buffer_handle_t;
                                    startVertex: uint32; numVertices: uint32) {.
    importc: "bgfx_set_dynamic_vertex_buffer", dynlib: libname.}
## 

proc bgfx_set_transient_vertex_buffer*(stream: uint8, tvb: ptr bgfx_transient_vertex_buffer_t;
                                      startVertex: uint32;
                                      numVertices: uint32) {.
    importc: "bgfx_set_transient_vertex_buffer", dynlib: libname.}
## 

proc bgfx_set_instance_data_buffer*(idb: ptr bgfx_instance_data_buffer_t;
                                   num: uint32) {.
    importc: "bgfx_set_instance_data_buffer", dynlib: libname.}
## 

proc bgfx_set_instance_data_from_vertex_buffer*(
    handle: bgfx_vertex_buffer_handle_t; startVertex: uint32; num: uint32) {.
    importc: "bgfx_set_instance_data_from_vertex_buffer", dynlib: libname.}
## 

proc bgfx_set_instance_data_from_dynamic_vertex_buffer*(
    handle: bgfx_dynamic_vertex_buffer_handle_t; startVertex: uint32;
    num: uint32) {.importc: "bgfx_set_instance_data_from_dynamic_vertex_buffer",
                    dynlib: libname.}
## 

proc bgfx_set_texture*(stage: uint8; sampler: bgfx_uniform_handle_t;
                      handle: bgfx_texture_handle_t; flags: uint32) {.
    importc: "bgfx_set_texture", dynlib: libname.}
## 

proc bgfx_touch*(id: uint8): uint32 {.importc: "bgfx_touch", dynlib: libname.}
## 

proc bgfx_submit*(id: uint8; handle: bgfx_program_handle_t; depth: int32;
                 preserveState: bool): uint32 {.importc: "bgfx_submit",
    dynlib: libname.}
## 

proc bgfx_submit_occlusion_query*(id: uint8; program: bgfx_program_handle_t;
    occlusionQuery: bgfx_occlusion_query_handle_t; depth: int32;
                                 preserveState: bool): uint32 {.
    importc: "bgfx_submit_occlusion_query", dynlib: libname.}
## 

proc bgfx_submit_indirect*(id: uint8; handle: bgfx_program_handle_t;
                          indirectHandle: bgfx_indirect_buffer_handle_t;
                          start: uint16; num: uint16; depth: int32;
                          preserveState: bool): uint32 {.
    importc: "bgfx_submit_indirect", dynlib: libname.}
## 

proc bgfx_set_image*(stage: uint8; sampler: bgfx_uniform_handle_t;
                    handle: bgfx_texture_handle_t; mip: uint8;
                    access: bgfx_access_t; format: bgfx_texture_format_t) {.
    importc: "bgfx_set_image", dynlib: libname.}
## 

proc bgfx_set_compute_index_buffer*(stage: uint8;
                                   handle: bgfx_index_buffer_handle_t;
                                   access: bgfx_access_t) {.
    importc: "bgfx_set_compute_index_buffer", dynlib: libname.}
## 

proc bgfx_set_compute_vertex_buffer*(stage: uint8;
                                    handle: bgfx_vertex_buffer_handle_t;
                                    access: bgfx_access_t) {.
    importc: "bgfx_set_compute_vertex_buffer", dynlib: libname.}
## 

proc bgfx_set_compute_dynamic_index_buffer*(stage: uint8;
    handle: bgfx_dynamic_index_buffer_handle_t; access: bgfx_access_t) {.
    importc: "bgfx_set_compute_dynamic_index_buffer", dynlib: libname.}
## 

proc bgfx_set_compute_dynamic_vertex_buffer*(stage: uint8;
    handle: bgfx_dynamic_vertex_buffer_handle_t; access: bgfx_access_t) {.
    importc: "bgfx_set_compute_dynamic_vertex_buffer", dynlib: libname.}
## 

proc bgfx_set_compute_indirect_buffer*(stage: uint8;
                                      handle: bgfx_indirect_buffer_handle_t;
                                      access: bgfx_access_t) {.
    importc: "bgfx_set_compute_indirect_buffer", dynlib: libname.}
## 

proc bgfx_dispatch*(id: uint8; handle: bgfx_program_handle_t; numX: uint16;
                   numY: uint16; numZ: uint16; flags: uint8): uint32 {.
    importc: "bgfx_dispatch", dynlib: libname.}
## 

proc bgfx_dispatch_indirect*(id: uint8; handle: bgfx_program_handle_t;
                            indirectHandle: bgfx_indirect_buffer_handle_t;
                            start: uint16; num: uint16; flags: uint8): uint32 {.
    importc: "bgfx_dispatch_indirect", dynlib: libname.}
## 

proc bgfx_discard*() {.importc: "bgfx_discard", dynlib: libname.}
## 

proc bgfx_blit*(id: uint8; dst: bgfx_texture_handle_t; dstMip: uint8;
               dstX: uint16; dstY: uint16; dstZ: uint16;
               src: bgfx_texture_handle_t; srcMip: uint8; srcX: uint16;
               srcY: uint16; srcZ: uint16; width: uint16; height: uint16;
               depth: uint16) {.importc: "bgfx_blit", dynlib: libname.}
## 

proc bgfx_request_screen_shot*(handle: bgfx_frame_buffer_handle_t;
                              filePath: cstring) {.
    importc: "bgfx_request_screen_shot", dynlib: libname.}
