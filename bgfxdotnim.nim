{.deadCodeElim: on.}
when defined(windows):
  const
    bgfxdll* = "bgfx-shared-lib(Debug|Release).dll"
elif defined(macosx):
  const
    bgfxdll* = "libbgfx-shared-lib(Debug|Release).dylib"
else:
  const
    bgfxdll* = "libbgfx-shared-lib(Debug|Release).so"

import bgfxdotnim/defines
export defines

type va_list* {.importc,header:"<stdarg.h>".} = object

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
    BGFX_ATTRIB_TEXCOORD5, BGFX_ATTRIB_TEXCOORD6, BGFX_ATTRIB_TEXCOORD7,
    BGFX_ATTRIB_COUNT
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
    BGFX_TEXTURE_FORMAT_PTC22, BGFX_TEXTURE_FORMAT_PTC24, BGFX_TEXTURE_FORMAT_ATC,
    BGFX_TEXTURE_FORMAT_ATCE, BGFX_TEXTURE_FORMAT_ATCI,
    BGFX_TEXTURE_FORMAT_ASTC4x4, BGFX_TEXTURE_FORMAT_ASTC5x5,
    BGFX_TEXTURE_FORMAT_ASTC6x6, BGFX_TEXTURE_FORMAT_ASTC8x5,
    BGFX_TEXTURE_FORMAT_ASTC8x6, BGFX_TEXTURE_FORMAT_ASTC10x5,
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
    BGFX_TEXTURE_FORMAT_RG11B10F, BGFX_TEXTURE_FORMAT_UNKNOWN_DEPTH,
    BGFX_TEXTURE_FORMAT_D16, BGFX_TEXTURE_FORMAT_D24, BGFX_TEXTURE_FORMAT_D24S8,
    BGFX_TEXTURE_FORMAT_D32, BGFX_TEXTURE_FORMAT_D16F, BGFX_TEXTURE_FORMAT_D24F,
    BGFX_TEXTURE_FORMAT_D32F, BGFX_TEXTURE_FORMAT_D0S8, BGFX_TEXTURE_FORMAT_COUNT
  bgfx_uniform_type_t* {.size: sizeof(cint).} = enum
    BGFX_UNIFORM_TYPE_SAMPLER, BGFX_UNIFORM_TYPE_END, BGFX_UNIFORM_TYPE_VEC4,
    BGFX_UNIFORM_TYPE_MAT3, BGFX_UNIFORM_TYPE_MAT4, BGFX_UNIFORM_TYPE_COUNT
  bgfx_backbuffer_ratio_t* {.size: sizeof(cint).} = enum
    BGFX_BACKBUFFER_RATIO_EQUAL, BGFX_BACKBUFFER_RATIO_HALF,
    BGFX_BACKBUFFER_RATIO_QUARTER, BGFX_BACKBUFFER_RATIO_EIGHTH,
    BGFX_BACKBUFFER_RATIO_SIXTEENTH, BGFX_BACKBUFFER_RATIO_DOUBLE,
    BGFX_BACKBUFFER_RATIO_COUNT
  bgfx_occlusion_query_result_t* {.size: sizeof(cint).} = enum
    BGFX_OCCLUSION_QUERY_RESULT_INVISIBLE, BGFX_OCCLUSION_QUERY_RESULT_VISIBLE,
    BGFX_OCCLUSION_QUERY_RESULT_NORESULT, BGFX_OCCLUSION_QUERY_RESULT_COUNT
  bgfx_topology_t* {.size: sizeof(cint).} = enum
    BGFX_TOPOLOGY_TRI_LIST, BGFX_TOPOLOGY_TRI_STRIP, BGFX_TOPOLOGY_LINE_LIST,
    BGFX_TOPOLOGY_LINE_STRIP, BGFX_TOPOLOGY_POINT_LIST, BGFX_TOPOLOGY_COUNT
  bgfx_topology_convert_t* {.size: sizeof(cint).} = enum
    BGFX_TOPOLOGY_CONVERT_TRI_LIST_FLIP_WINDING,
    BGFX_TOPOLOGY_CONVERT_TRI_STRIP_FLIP_WINDING,
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
  bgfx_view_mode_t* {.size: sizeof(cint).} = enum
    BGFX_VIEW_MODE_DEFAULT, BGFX_VIEW_MODE_SEQUENTIAL,
    BGFX_VIEW_MODE_DEPTH_ASCENDING, BGFX_VIEW_MODE_DEPTH_DESCENDING,
    BGFX_VIEW_MODE_CCOUNT
  
  bgfx_encoder_s* {.bycopy.} = object
  
  bgfx_dynamic_index_buffer_handle_t* {.bycopy.} = object
    idx*: uint16

  bgfx_dynamic_vertex_buffer_handle_t* {.bycopy.} = object
    idx*: uint16

  bgfx_frame_buffer_handle_t* {.bycopy.} = object
    idx*: uint16

  bgfx_index_buffer_handle_t* {.bycopy.} = object
    idx*: uint16

  bgfx_indirect_buffer_handle_t* {.bycopy.} = object
    idx*: uint16

  bgfx_occlusion_query_handle_t* {.bycopy.} = object
    idx*: uint16

  bgfx_program_handle_t* {.bycopy.} = object
    idx*: uint16

  bgfx_shader_handle_t* {.bycopy.} = object
    idx*: uint16

  bgfx_texture_handle_t* {.bycopy.} = object
    idx*: uint16

  bgfx_uniform_handle_t* {.bycopy.} = object
    idx*: uint16

  bgfx_vertex_buffer_handle_t* {.bycopy.} = object
    idx*: uint16

  bgfx_vertex_decl_handle_t* {.bycopy.} = object
    idx*: uint16

  bgfx_release_fn_t* = proc (`ptr`: pointer; userData: pointer) {.cdecl.}
  bgfx_memory_t* {.bycopy.} = object
    data*: ptr uint8
    size*: uint32

  bgfx_transform_t* {.bycopy.} = object
    data*: ptr cfloat
    num*: uint16

  bgfx_view_id_t* = uint16
  bgfx_view_stats_t* {.bycopy.} = object
    name*: array[256, char]
    view*: bgfx_view_id_t
    cpuTimeElapsed*: int64
    gpuTimeElapsed*: int64

  bgfx_encoder_stats_t* {.bycopy.} = object
    cpuTimeBegin*: int64
    cpuTimeEnd*: int64

  bgfx_stats_t* {.bycopy.} = object
    cpuTimeFrame*: int64
    cpuTimeBegin*: int64
    cpuTimeEnd*: int64
    cpuTimerFreq*: int64
    gpuTimeBegin*: int64
    gpuTimeEnd*: int64
    gpuTimerFreq*: int64
    waitRender*: int64
    waitSubmit*: int64
    numDraw*: uint32
    numCompute*: uint32
    numBlit*: uint32
    maxGpuLatency*: uint32
    numDynamicIndexBuffers*: uint16
    numDynamicVertexBuffers*: uint16
    numFrameBuffers*: uint16
    numIndexBuffers*: uint16
    numOcclusionQueries*: uint16
    numPrograms*: uint16
    numShaders*: uint16
    numTextures*: uint16
    numUniforms*: uint16
    numVertexBuffers*: uint16
    numVertexDecls*: uint16
    textureMemoryUsed*: int64
    rtMemoryUsed*: int64
    transientVbUsed*: int32
    transientIbUsed*: int32
    numPrims*: array[BGFX_TOPOLOGY_COUNT, uint32]
    gpuMemoryMax*: int64
    gpuMemoryUsed*: int64
    width*: uint16
    height*: uint16
    textWidth*: uint16
    textHeight*: uint16
    numViews*: uint16
    viewStats*: ptr bgfx_view_stats_t
    numEncoders*: uint8
    encoderStats*: ptr bgfx_encoder_stats_t

  bgfx_vertex_decl_t* {.bycopy.} = object
    hash*: uint32
    stride*: uint16
    offset*: array[BGFX_ATTRIB_COUNT, uint16]
    attributes*: array[BGFX_ATTRIB_COUNT, uint16]

  bgfx_transient_index_buffer_t* {.bycopy.} = object
    data*: ptr uint8
    size*: uint32
    handle*: bgfx_index_buffer_handle_t
    startIndex*: uint32

  bgfx_transient_vertex_buffer_t* {.bycopy.} = object
    data*: ptr uint8
    size*: uint32
    startVertex*: uint32
    stride*: uint16
    handle*: bgfx_vertex_buffer_handle_t
    decl*: bgfx_vertex_decl_handle_t

  bgfx_instance_data_buffer_t* {.bycopy.} = object
    data*: ptr uint8
    size*: uint32
    offset*: uint32
    num*: uint32
    stride*: uint16
    handle*: bgfx_vertex_buffer_handle_t

  bgfx_texture_info_t* {.bycopy.} = object
    format*: bgfx_texture_format_t
    storageSize*: uint32
    width*: uint16
    height*: uint16
    depth*: uint16
    numLayers*: uint16
    numMips*: uint8
    bitsPerPixel*: uint8
    cubeMap*: bool

  bgfx_uniform_info_t* {.bycopy.} = object
    name*: array[256, char]
    `type`*: bgfx_uniform_type_t
    num*: uint16

  bgfx_attachment_t* {.bycopy.} = object
    access*: bgfx_access_t
    handle*: bgfx_texture_handle_t
    mip*: uint16
    layer*: uint16
    resolve*: uint8

  bgfx_caps_gpu_t* {.bycopy.} = object
    vendorId*: uint16
    deviceId*: uint16

  bgfx_caps_limits_t* {.bycopy.} = object
    maxDrawCalls*: uint32
    maxBlits*: uint32
    maxTextureSize*: uint32
    maxTextureLayers*: uint32
    maxViews*: uint32
    maxFrameBuffers*: uint32
    maxFBAttachments*: uint32
    maxPrograms*: uint32
    maxShaders*: uint32
    maxTextures*: uint32
    maxTextureSamplers*: uint32
    maxComputeBindings*: uint32
    maxVertexDecls*: uint32
    maxVertexStreams*: uint32
    maxIndexBuffers*: uint32
    maxVertexBuffers*: uint32
    maxDynamicIndexBuffers*: uint32
    maxDynamicVertexBuffers*: uint32
    maxUniforms*: uint32
    maxOcclusionQueries*: uint32
    maxEncoders*: uint32
    transientVbSize*: uint32
    transientIbSize*: uint32

  bgfx_caps_t* {.bycopy.} = object
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

  bgfx_fatal_t* {.size: sizeof(cint).} = enum
    BGFX_FATAL_DEBUG_CHECK, BGFX_FATAL_INVALID_SHADER,
    BGFX_FATAL_UNABLE_TO_INITIALIZE, BGFX_FATAL_UNABLE_TO_CREATE_TEXTURE,
    BGFX_FATAL_DEVICE_LOST, BGFX_FATAL_COUNT
    
  bgfx_callback_interface_t* {.bycopy.} = object
    vtbl*: ptr bgfx_callback_vtbl_t

  bgfx_callback_vtbl_t* {.bycopy.} = object
    fatal*: proc (this: ptr bgfx_callback_interface_t; filePath: cstring; line: uint16;
                code: bgfx_fatal_t; str: cstring) {.cdecl.}
    trace_vargs*: proc (this: ptr bgfx_callback_interface_t; filePath: cstring;
                      line: uint16; format: cstring; argList: va_list) {.cdecl.}
    profiler_begin*: proc (this: ptr bgfx_callback_interface_t; name: cstring;
                         abgr: uint32; filePath: cstring; line: uint16) {.cdecl.}
    profiler_begin_literal*: proc (this: ptr bgfx_callback_interface_t;
                                 name: cstring; abgr: uint32; filePath: cstring;
                                 line: uint16) {.cdecl.}
    profiler_end*: proc (this: ptr bgfx_callback_interface_t) {.cdecl.}
    cache_read_size*: proc (this: ptr bgfx_callback_interface_t; id: uint64): uint32 {.cdecl.}
    cache_read*: proc (this: ptr bgfx_callback_interface_t; id: uint64; data: pointer;
                     size: uint32): bool {.cdecl.}
    cache_write*: proc (this: ptr bgfx_callback_interface_t; id: uint64; data: pointer;
                      size: uint32) {.cdecl.}
    screen_shot*: proc (this: ptr bgfx_callback_interface_t; filePath: cstring;
                      width: uint32; height: uint32; pitch: uint32; data: pointer;
                      size: uint32; yflip: bool) {.cdecl.}
    capture_begin*: proc (this: ptr bgfx_callback_interface_t; width: uint32;
                        height: uint32; pitch: uint32;
                        format: bgfx_texture_format_t; yflip: bool) {.cdecl.}
    capture_end*: proc (this: ptr bgfx_callback_interface_t) {.cdecl.}
    capture_frame*: proc (this: ptr bgfx_callback_interface_t; data: pointer;
                        size: uint32) {.cdecl.}

  bgfx_allocator_interface_t* {.bycopy.} = object
    vtbl*: ptr bgfx_allocator_vtbl_t

  bgfx_allocator_vtbl_t* {.bycopy.} = object
    realloc*: proc (this: ptr bgfx_allocator_interface_t; `ptr`: pointer; size: csize;
                  align: csize; file: cstring; line: uint32): pointer

  bgfx_platform_data_t* {.bycopy.} = object
    ndt*: pointer
    nwh*: pointer
    context*: pointer
    backBuffer*: pointer
    backBufferDS*: pointer

  bgfx_resolution_t* {.bycopy.} = object
    format*: bgfx_texture_format_t
    width*: uint32
    height*: uint32
    reset*: uint32
    numBackBuffers*: uint8
    maxFrameLatency*: uint8

  bgfx_init_limits_t* {.bycopy.} = object
    maxEncoders*: uint16
    transientVbSize*: uint32
    transientIbSize*: uint32

  bgfx_init_t* {.bycopy.} = object
    `type`*: bgfx_renderer_type_t
    vendorId*: uint16
    deviceId*: uint16
    debug*: bool
    profile*: bool
    platformData*: bgfx_platform_data_t
    resolution*: bgfx_resolution_t
    limits*: bgfx_init_limits_t
    callback*: ptr bgfx_callback_interface_t
    allocator*: ptr bgfx_allocator_interface_t

const BGFX_INVALID_HANDLE* = bgfx_shader_handle_t(idx: uint16.high)













proc bgfx_vertex_decl_begin*(decl: ptr bgfx_vertex_decl_t;
                            renderer: bgfx_renderer_type_t) {.
    importc: "bgfx_vertex_decl_begin", dynlib: bgfxdll.}
proc bgfx_vertex_decl_add*(decl: ptr bgfx_vertex_decl_t; attrib: bgfx_attrib_t;
                          num: uint8; `type`: bgfx_attrib_type_t; normalized: bool;
                          asInt: bool) {.importc: "bgfx_vertex_decl_add",
                                       dynlib: bgfxdll.}
proc bgfx_vertex_decl_decode*(decl: ptr bgfx_vertex_decl_t; attrib: bgfx_attrib_t;
                             num: ptr uint8; `type`: ptr bgfx_attrib_type_t;
                             normalized: ptr bool; asInt: ptr bool) {.
    importc: "bgfx_vertex_decl_decode", dynlib: bgfxdll.}
proc bgfx_vertex_decl_has*(decl: ptr bgfx_vertex_decl_t; attrib: bgfx_attrib_t): bool {.
    importc: "bgfx_vertex_decl_has", dynlib: bgfxdll.}
proc bgfx_vertex_decl_skip*(decl: ptr bgfx_vertex_decl_t; num: uint8) {.
    importc: "bgfx_vertex_decl_skip", dynlib: bgfxdll.}
proc bgfx_vertex_decl_end*(decl: ptr bgfx_vertex_decl_t) {.
    importc: "bgfx_vertex_decl_end", dynlib: bgfxdll.}
proc bgfx_vertex_pack*(input: array[4, cfloat]; inputNormalized: bool;
                      attr: bgfx_attrib_t; decl: ptr bgfx_vertex_decl_t;
                      data: pointer; index: uint32) {.importc: "bgfx_vertex_pack",
    dynlib: bgfxdll.}
proc bgfx_vertex_unpack*(output: array[4, cfloat]; attr: bgfx_attrib_t;
                        decl: ptr bgfx_vertex_decl_t; data: pointer; index: uint32) {.
    importc: "bgfx_vertex_unpack", dynlib: bgfxdll.}
proc bgfx_vertex_convert*(destDecl: ptr bgfx_vertex_decl_t; destData: pointer;
                         srcDecl: ptr bgfx_vertex_decl_t; srcData: pointer;
                         num: uint32) {.importc: "bgfx_vertex_convert",
                                      dynlib: bgfxdll.}
proc bgfx_weld_vertices*(output: ptr uint16; decl: ptr bgfx_vertex_decl_t;
                        data: pointer; num: uint16; epsilon: cfloat): uint16 {.
    importc: "bgfx_weld_vertices", dynlib: bgfxdll.}
proc bgfx_topology_convert*(conversion: bgfx_topology_convert_t; dst: pointer;
                           dstSize: uint32; indices: pointer; numIndices: uint32;
                           index32: bool): uint32 {.
    importc: "bgfx_topology_convert", dynlib: bgfxdll.}
proc bgfx_topology_sort_tri_list*(sort: bgfx_topology_sort_t; dst: pointer;
                                 dstSize: uint32; dir: array[3, cfloat];
                                 pos: array[3, cfloat]; vertices: pointer;
                                 stride: uint32; indices: pointer;
                                 numIndices: uint32; index32: bool) {.
    importc: "bgfx_topology_sort_tri_list", dynlib: bgfxdll.}
proc bgfx_get_supported_renderers*(max: uint8; `enum`: ptr bgfx_renderer_type_t): uint8 {.
    importc: "bgfx_get_supported_renderers", dynlib: bgfxdll.}
proc bgfx_get_renderer_name*(`type`: bgfx_renderer_type_t): cstring {.
    importc: "bgfx_get_renderer_name", dynlib: bgfxdll.}
proc bgfx_init_ctor*(init: ptr bgfx_init_t) {.importc: "bgfx_init_ctor",
    dynlib: bgfxdll.}
proc bgfx_init*(init: ptr bgfx_init_t): bool {.importc: "bgfx_init", dynlib: bgfxdll.}
proc bgfx_shutdown*() {.importc: "bgfx_shutdown", dynlib: bgfxdll.}
proc bgfx_reset*(width: uint32; height: uint32; flags: uint32;
                format: bgfx_texture_format_t) {.importc: "bgfx_reset",
    dynlib: bgfxdll.}
proc bgfx_begin*(): ptr bgfx_encoder_s {.importc: "bgfx_begin", dynlib: bgfxdll.}
proc bgfx_end*(encoder: ptr bgfx_encoder_s) {.importc: "bgfx_end", dynlib: bgfxdll.}
proc bgfx_frame*(capture: bool): uint32 {.importc: "bgfx_frame", dynlib: bgfxdll.}
proc bgfx_get_renderer_type*(): bgfx_renderer_type_t {.
    importc: "bgfx_get_renderer_type", dynlib: bgfxdll.}
proc bgfx_get_caps*(): ptr bgfx_caps_t {.importc: "bgfx_get_caps", dynlib: bgfxdll.}
proc bgfx_get_stats*(): ptr bgfx_stats_t {.importc: "bgfx_get_stats", dynlib: bgfxdll.}
proc bgfx_alloc*(size: uint32): ptr bgfx_memory_t {.importc: "bgfx_alloc",
    dynlib: bgfxdll.}
proc bgfx_copy*(data: pointer; size: uint32): ptr bgfx_memory_t {.importc: "bgfx_copy",
    dynlib: bgfxdll.}
proc bgfx_make_ref*(data: pointer; size: uint32): ptr bgfx_memory_t {.
    importc: "bgfx_make_ref", dynlib: bgfxdll.}
proc bgfx_make_ref_release*(data: pointer; size: uint32;
                           releaseFn: bgfx_release_fn_t; userData: pointer): ptr bgfx_memory_t {.
    importc: "bgfx_make_ref_release", dynlib: bgfxdll.}
proc bgfx_set_debug*(debug: uint32) {.importc: "bgfx_set_debug", dynlib: bgfxdll.}
proc bgfx_dbg_text_clear*(attr: uint8; small: bool) {.importc: "bgfx_dbg_text_clear",
    dynlib: bgfxdll.}
proc bgfx_dbg_text_printf*(x: uint16; y: uint16; attr: uint8; format: cstring) {.varargs,
    importc: "bgfx_dbg_text_printf", dynlib: bgfxdll.}
proc bgfx_dbg_text_vprintf*(x: uint16; y: uint16; attr: uint8; format: cstring;
                           argList: va_list) {.importc: "bgfx_dbg_text_vprintf",
    dynlib: bgfxdll.}
proc bgfx_dbg_text_image*(x: uint16; y: uint16; width: uint16; height: uint16;
                         data: pointer; pitch: uint16) {.
    importc: "bgfx_dbg_text_image", dynlib: bgfxdll.}
proc bgfx_create_index_buffer*(mem: ptr bgfx_memory_t; flags: uint16): bgfx_index_buffer_handle_t {.
    importc: "bgfx_create_index_buffer", dynlib: bgfxdll.}
proc bgfx_destroy_index_buffer*(handle: bgfx_index_buffer_handle_t) {.
    importc: "bgfx_destroy_index_buffer", dynlib: bgfxdll.}
proc bgfx_create_vertex_buffer*(mem: ptr bgfx_memory_t;
                               decl: ptr bgfx_vertex_decl_t; flags: uint16): bgfx_vertex_buffer_handle_t {.
    importc: "bgfx_create_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_destroy_vertex_buffer*(handle: bgfx_vertex_buffer_handle_t) {.
    importc: "bgfx_destroy_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_create_dynamic_index_buffer*(num: uint32; flags: uint16): bgfx_dynamic_index_buffer_handle_t {.
    importc: "bgfx_create_dynamic_index_buffer", dynlib: bgfxdll.}
proc bgfx_create_dynamic_index_buffer_mem*(mem: ptr bgfx_memory_t; flags: uint16): bgfx_dynamic_index_buffer_handle_t {.
    importc: "bgfx_create_dynamic_index_buffer_mem", dynlib: bgfxdll.}
proc bgfx_update_dynamic_index_buffer*(handle: bgfx_dynamic_index_buffer_handle_t;
                                      startIndex: uint32; mem: ptr bgfx_memory_t) {.
    importc: "bgfx_update_dynamic_index_buffer", dynlib: bgfxdll.}
proc bgfx_destroy_dynamic_index_buffer*(handle: bgfx_dynamic_index_buffer_handle_t) {.
    importc: "bgfx_destroy_dynamic_index_buffer", dynlib: bgfxdll.}
proc bgfx_create_dynamic_vertex_buffer*(num: uint32; decl: ptr bgfx_vertex_decl_t;
                                       flags: uint16): bgfx_dynamic_vertex_buffer_handle_t {.
    importc: "bgfx_create_dynamic_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_create_dynamic_vertex_buffer_mem*(mem: ptr bgfx_memory_t;
    decl: ptr bgfx_vertex_decl_t; flags: uint16): bgfx_dynamic_vertex_buffer_handle_t {.
    importc: "bgfx_create_dynamic_vertex_buffer_mem", dynlib: bgfxdll.}
proc bgfx_update_dynamic_vertex_buffer*(handle: bgfx_dynamic_vertex_buffer_handle_t;
                                       startVertex: uint32; mem: ptr bgfx_memory_t) {.
    importc: "bgfx_update_dynamic_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_destroy_dynamic_vertex_buffer*(handle: bgfx_dynamic_vertex_buffer_handle_t) {.
    importc: "bgfx_destroy_dynamic_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_get_avail_transient_index_buffer*(num: uint32): uint32 {.
    importc: "bgfx_get_avail_transient_index_buffer", dynlib: bgfxdll.}
proc bgfx_get_avail_transient_vertex_buffer*(num: uint32;
    decl: ptr bgfx_vertex_decl_t): uint32 {.importc: "bgfx_get_avail_transient_vertex_buffer",
                                        dynlib: bgfxdll.}
proc bgfx_get_avail_instance_data_buffer*(num: uint32; stride: uint16): uint32 {.
    importc: "bgfx_get_avail_instance_data_buffer", dynlib: bgfxdll.}
proc bgfx_alloc_transient_index_buffer*(tib: ptr bgfx_transient_index_buffer_t;
                                       num: uint32) {.
    importc: "bgfx_alloc_transient_index_buffer", dynlib: bgfxdll.}
proc bgfx_alloc_transient_vertex_buffer*(tvb: ptr bgfx_transient_vertex_buffer_t;
                                        num: uint32; decl: ptr bgfx_vertex_decl_t) {.
    importc: "bgfx_alloc_transient_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_alloc_transient_buffers*(tvb: ptr bgfx_transient_vertex_buffer_t;
                                  decl: ptr bgfx_vertex_decl_t;
                                  numVertices: uint32;
                                  tib: ptr bgfx_transient_index_buffer_t;
                                  numIndices: uint32): bool {.
    importc: "bgfx_alloc_transient_buffers", dynlib: bgfxdll.}
proc bgfx_alloc_instance_data_buffer*(idb: ptr bgfx_instance_data_buffer_t;
                                     num: uint32; stride: uint16) {.
    importc: "bgfx_alloc_instance_data_buffer", dynlib: bgfxdll.}
proc bgfx_create_indirect_buffer*(num: uint32): bgfx_indirect_buffer_handle_t {.
    importc: "bgfx_create_indirect_buffer", dynlib: bgfxdll.}
proc bgfx_destroy_indirect_buffer*(handle: bgfx_indirect_buffer_handle_t) {.
    importc: "bgfx_destroy_indirect_buffer", dynlib: bgfxdll.}
proc bgfx_create_shader*(mem: ptr bgfx_memory_t): bgfx_shader_handle_t {.
    importc: "bgfx_create_shader", dynlib: bgfxdll.}
proc bgfx_get_shader_uniforms*(handle: bgfx_shader_handle_t;
                              uniforms: ptr bgfx_uniform_handle_t; max: uint16): uint16 {.
    importc: "bgfx_get_shader_uniforms", dynlib: bgfxdll.}
proc bgfx_get_uniform_info*(handle: bgfx_uniform_handle_t;
                           info: ptr bgfx_uniform_info_t) {.
    importc: "bgfx_get_uniform_info", dynlib: bgfxdll.}
proc bgfx_set_shader_name*(handle: bgfx_shader_handle_t; name: cstring; len: int32) {.
    importc: "bgfx_set_shader_name", dynlib: bgfxdll.}
proc bgfx_destroy_shader*(handle: bgfx_shader_handle_t) {.
    importc: "bgfx_destroy_shader", dynlib: bgfxdll.}
proc bgfx_create_program*(vsh: bgfx_shader_handle_t; fsh: bgfx_shader_handle_t;
                         destroyShaders: bool): bgfx_program_handle_t {.
    importc: "bgfx_create_program", dynlib: bgfxdll.}
proc bgfx_create_compute_program*(csh: bgfx_shader_handle_t; destroyShaders: bool): bgfx_program_handle_t {.
    importc: "bgfx_create_compute_program", dynlib: bgfxdll.}
proc bgfx_destroy_program*(handle: bgfx_program_handle_t) {.
    importc: "bgfx_destroy_program", dynlib: bgfxdll.}
proc bgfx_is_texture_valid*(depth: uint16; cubeMap: bool; numLayers: uint16;
                           format: bgfx_texture_format_t; flags: uint64): bool {.
    importc: "bgfx_is_texture_valid", dynlib: bgfxdll.}
proc bgfx_calc_texture_size*(info: ptr bgfx_texture_info_t; width: uint16;
                            height: uint16; depth: uint16; cubeMap: bool;
                            hasMips: bool; numLayers: uint16;
                            format: bgfx_texture_format_t) {.
    importc: "bgfx_calc_texture_size", dynlib: bgfxdll.}
proc bgfx_create_texture*(mem: ptr bgfx_memory_t; flags: uint64; skip: uint8;
                         info: ptr bgfx_texture_info_t): bgfx_texture_handle_t {.
    importc: "bgfx_create_texture", dynlib: bgfxdll.}
proc bgfx_create_texture_2d*(width: uint16; height: uint16; hasMips: bool;
                            numLayers: uint16; format: bgfx_texture_format_t;
                            flags: uint64; mem: ptr bgfx_memory_t): bgfx_texture_handle_t {.
    importc: "bgfx_create_texture_2d", dynlib: bgfxdll.}
proc bgfx_create_texture_2d_scaled*(ratio: bgfx_backbuffer_ratio_t; hasMips: bool;
                                   numLayers: uint16;
                                   format: bgfx_texture_format_t; flags: uint64): bgfx_texture_handle_t {.
    importc: "bgfx_create_texture_2d_scaled", dynlib: bgfxdll.}
proc bgfx_create_texture_3d*(width: uint16; height: uint16; depth: uint16;
                            hasMips: bool; format: bgfx_texture_format_t;
                            flags: uint64; mem: ptr bgfx_memory_t): bgfx_texture_handle_t {.
    importc: "bgfx_create_texture_3d", dynlib: bgfxdll.}
proc bgfx_create_texture_cube*(size: uint16; hasMips: bool; numLayers: uint16;
                              format: bgfx_texture_format_t; flags: uint64;
                              mem: ptr bgfx_memory_t): bgfx_texture_handle_t {.
    importc: "bgfx_create_texture_cube", dynlib: bgfxdll.}
proc bgfx_update_texture_2d*(handle: bgfx_texture_handle_t; layer: uint16;
                            mip: uint8; x: uint16; y: uint16; width: uint16;
                            height: uint16; mem: ptr bgfx_memory_t; pitch: uint16) {.
    importc: "bgfx_update_texture_2d", dynlib: bgfxdll.}
proc bgfx_update_texture_3d*(handle: bgfx_texture_handle_t; mip: uint8; x: uint16;
                            y: uint16; z: uint16; width: uint16; height: uint16;
                            depth: uint16; mem: ptr bgfx_memory_t) {.
    importc: "bgfx_update_texture_3d", dynlib: bgfxdll.}
proc bgfx_update_texture_cube*(handle: bgfx_texture_handle_t; layer: uint16;
                              side: uint8; mip: uint8; x: uint16; y: uint16;
                              width: uint16; height: uint16; mem: ptr bgfx_memory_t;
                              pitch: uint16) {.
    importc: "bgfx_update_texture_cube", dynlib: bgfxdll.}
proc bgfx_read_texture*(handle: bgfx_texture_handle_t; data: pointer; mip: uint8): uint32 {.
    importc: "bgfx_read_texture", dynlib: bgfxdll.}
proc bgfx_set_texture_name*(handle: bgfx_texture_handle_t; name: cstring; len: int32) {.
    importc: "bgfx_set_texture_name", dynlib: bgfxdll.}
proc bgfx_destroy_texture*(handle: bgfx_texture_handle_t) {.
    importc: "bgfx_destroy_texture", dynlib: bgfxdll.}
proc bgfx_create_frame_buffer*(width: uint16; height: uint16;
                              format: bgfx_texture_format_t; textureFlags: uint64): bgfx_frame_buffer_handle_t {.
    importc: "bgfx_create_frame_buffer", dynlib: bgfxdll.}
proc bgfx_create_frame_buffer_scaled*(ratio: bgfx_backbuffer_ratio_t;
                                     format: bgfx_texture_format_t;
                                     textureFlags: uint64): bgfx_frame_buffer_handle_t {.
    importc: "bgfx_create_frame_buffer_scaled", dynlib: bgfxdll.}
proc bgfx_create_frame_buffer_from_handles*(num: uint8;
    handles: ptr bgfx_texture_handle_t; destroyTextures: bool): bgfx_frame_buffer_handle_t {.
    importc: "bgfx_create_frame_buffer_from_handles", dynlib: bgfxdll.}
proc bgfx_create_frame_buffer_from_attachment*(num: uint8;
    attachment: ptr bgfx_attachment_t; destroyTextures: bool): bgfx_frame_buffer_handle_t {.
    importc: "bgfx_create_frame_buffer_from_attachment", dynlib: bgfxdll.}
proc bgfx_create_frame_buffer_from_nwh*(nwh: pointer; width: uint16; height: uint16;
                                       format: bgfx_texture_format_t;
                                       depthFormat: bgfx_texture_format_t): bgfx_frame_buffer_handle_t {.
    importc: "bgfx_create_frame_buffer_from_nwh", dynlib: bgfxdll.}
proc bgfx_get_texture*(handle: bgfx_frame_buffer_handle_t; attachment: uint8): bgfx_texture_handle_t {.
    importc: "bgfx_get_texture", dynlib: bgfxdll.}
proc bgfx_destroy_frame_buffer*(handle: bgfx_frame_buffer_handle_t) {.
    importc: "bgfx_destroy_frame_buffer", dynlib: bgfxdll.}
proc bgfx_create_uniform*(name: cstring; `type`: bgfx_uniform_type_t; num: uint16): bgfx_uniform_handle_t {.
    importc: "bgfx_create_uniform", dynlib: bgfxdll.}
proc bgfx_destroy_uniform*(handle: bgfx_uniform_handle_t) {.
    importc: "bgfx_destroy_uniform", dynlib: bgfxdll.}
proc bgfx_create_occlusion_query*(): bgfx_occlusion_query_handle_t {.
    importc: "bgfx_create_occlusion_query", dynlib: bgfxdll.}
proc bgfx_get_result*(handle: bgfx_occlusion_query_handle_t; result: ptr int32): bgfx_occlusion_query_result_t {.
    importc: "bgfx_get_result", dynlib: bgfxdll.}
proc bgfx_destroy_occlusion_query*(handle: bgfx_occlusion_query_handle_t) {.
    importc: "bgfx_destroy_occlusion_query", dynlib: bgfxdll.}
proc bgfx_set_palette_color*(index: uint8; rgba: array[4, cfloat]) {.
    importc: "bgfx_set_palette_color", dynlib: bgfxdll.}
proc bgfx_set_view_name*(id: bgfx_view_id_t; name: cstring) {.
    importc: "bgfx_set_view_name", dynlib: bgfxdll.}
proc bgfx_set_view_rect*(id: bgfx_view_id_t; x: uint16; y: uint16; width: uint16;
                        height: uint16) {.importc: "bgfx_set_view_rect",
                                        dynlib: bgfxdll.}
proc bgfx_set_view_rect_auto*(id: bgfx_view_id_t; x: uint16; y: uint16;
                             ratio: bgfx_backbuffer_ratio_t) {.
    importc: "bgfx_set_view_rect_auto", dynlib: bgfxdll.}
proc bgfx_set_view_scissor*(id: bgfx_view_id_t; x: uint16; y: uint16; width: uint16;
                           height: uint16) {.importc: "bgfx_set_view_scissor",
    dynlib: bgfxdll.}
proc bgfx_set_view_clear*(id: bgfx_view_id_t; flags: uint16; rgba: uint32;
                         depth: cfloat; stencil: uint8) {.
    importc: "bgfx_set_view_clear", dynlib: bgfxdll.}
proc bgfx_set_view_clear_mrt*(id: bgfx_view_id_t; flags: uint16; depth: cfloat;
                             stencil: uint8; v0: uint8; v1: uint8; v2: uint8; v3: uint8;
                             v4: uint8; v5: uint8; v6: uint8; v7: uint8) {.
    importc: "bgfx_set_view_clear_mrt", dynlib: bgfxdll.}
proc bgfx_set_view_mode*(id: bgfx_view_id_t; mode: bgfx_view_mode_t) {.
    importc: "bgfx_set_view_mode", dynlib: bgfxdll.}
proc bgfx_set_view_frame_buffer*(id: bgfx_view_id_t;
                                handle: bgfx_frame_buffer_handle_t) {.
    importc: "bgfx_set_view_frame_buffer", dynlib: bgfxdll.}
proc bgfx_set_view_transform*(id: bgfx_view_id_t; view: pointer; proj: pointer) {.
    importc: "bgfx_set_view_transform", dynlib: bgfxdll.}
proc bgfx_set_view_transform_stereo*(id: bgfx_view_id_t; view: pointer;
                                    projL: pointer; flags: uint8; projR: pointer) {.
    importc: "bgfx_set_view_transform_stereo", dynlib: bgfxdll.}
proc bgfx_set_view_order*(id: bgfx_view_id_t; num: uint16; order: ptr bgfx_view_id_t) {.
    importc: "bgfx_set_view_order", dynlib: bgfxdll.}
proc bgfx_reset_view*(id: bgfx_view_id_t) {.importc: "bgfx_reset_view",
    dynlib: bgfxdll.}
proc bgfx_set_marker*(marker: cstring) {.importc: "bgfx_set_marker", dynlib: bgfxdll.}
proc bgfx_set_state*(state: uint64; rgba: uint32) {.importc: "bgfx_set_state",
    dynlib: bgfxdll.}
proc bgfx_set_condition*(handle: bgfx_occlusion_query_handle_t; visible: bool) {.
    importc: "bgfx_set_condition", dynlib: bgfxdll.}
proc bgfx_set_stencil*(fstencil: uint32; bstencil: uint32) {.
    importc: "bgfx_set_stencil", dynlib: bgfxdll.}
proc bgfx_set_scissor*(x: uint16; y: uint16; width: uint16; height: uint16): uint16 {.
    importc: "bgfx_set_scissor", dynlib: bgfxdll.}
proc bgfx_set_scissor_cached*(cache: uint16) {.importc: "bgfx_set_scissor_cached",
    dynlib: bgfxdll.}
proc bgfx_set_transform*(mtx: pointer; num: uint16): uint32 {.
    importc: "bgfx_set_transform", dynlib: bgfxdll.}
proc bgfx_alloc_transform*(transform: ptr bgfx_transform_t; num: uint16): uint32 {.
    importc: "bgfx_alloc_transform", dynlib: bgfxdll.}
proc bgfx_set_transform_cached*(cache: uint32; num: uint16) {.
    importc: "bgfx_set_transform_cached", dynlib: bgfxdll.}
proc bgfx_set_uniform*(handle: bgfx_uniform_handle_t; value: pointer; num: uint16) {.
    importc: "bgfx_set_uniform", dynlib: bgfxdll.}
proc bgfx_set_index_buffer*(handle: bgfx_index_buffer_handle_t; firstIndex: uint32;
                           numIndices: uint32) {.importc: "bgfx_set_index_buffer",
    dynlib: bgfxdll.}
proc bgfx_set_dynamic_index_buffer*(handle: bgfx_dynamic_index_buffer_handle_t;
                                   firstIndex: uint32; numIndices: uint32) {.
    importc: "bgfx_set_dynamic_index_buffer", dynlib: bgfxdll.}
proc bgfx_set_transient_index_buffer*(tib: ptr bgfx_transient_index_buffer_t;
                                     firstIndex: uint32; numIndices: uint32) {.
    importc: "bgfx_set_transient_index_buffer", dynlib: bgfxdll.}
proc bgfx_set_vertex_buffer*(stream: uint8; handle: bgfx_vertex_buffer_handle_t;
                            startVertex: uint32; numVertices: uint32) {.
    importc: "bgfx_set_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_set_dynamic_vertex_buffer*(stream: uint8; handle: bgfx_dynamic_vertex_buffer_handle_t;
                                    startVertex: uint32; numVertices: uint32) {.
    importc: "bgfx_set_dynamic_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_set_transient_vertex_buffer*(stream: uint8;
                                      tvb: ptr bgfx_transient_vertex_buffer_t;
                                      startVertex: uint32; numVertices: uint32) {.
    importc: "bgfx_set_transient_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_set_vertex_count*(numVertices: uint32) {.
    importc: "bgfx_set_vertex_count", dynlib: bgfxdll.}
proc bgfx_set_instance_data_buffer*(idb: ptr bgfx_instance_data_buffer_t;
                                   start: uint32; num: uint32) {.
    importc: "bgfx_set_instance_data_buffer", dynlib: bgfxdll.}
proc bgfx_set_instance_data_from_vertex_buffer*(
    handle: bgfx_vertex_buffer_handle_t; startVertex: uint32; num: uint32) {.
    importc: "bgfx_set_instance_data_from_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_set_instance_data_from_dynamic_vertex_buffer*(
    handle: bgfx_dynamic_vertex_buffer_handle_t; startVertex: uint32; num: uint32) {.
    importc: "bgfx_set_instance_data_from_dynamic_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_set_instance_count*(numInstances: uint32) {.
    importc: "bgfx_set_instance_count", dynlib: bgfxdll.}
proc bgfx_set_texture*(stage: uint8; sampler: bgfx_uniform_handle_t;
                      handle: bgfx_texture_handle_t; flags: uint32) {.
    importc: "bgfx_set_texture", dynlib: bgfxdll.}
proc bgfx_touch*(id: bgfx_view_id_t) {.importc: "bgfx_touch", dynlib: bgfxdll.}
proc bgfx_submit*(id: bgfx_view_id_t; handle: bgfx_program_handle_t; depth: uint32;
                 preserveState: bool) {.importc: "bgfx_submit", dynlib: bgfxdll.}
proc bgfx_submit_occlusion_query*(id: bgfx_view_id_t;
                                 program: bgfx_program_handle_t;
                                 occlusionQuery: bgfx_occlusion_query_handle_t;
                                 depth: uint32; preserveState: bool) {.
    importc: "bgfx_submit_occlusion_query", dynlib: bgfxdll.}
proc bgfx_submit_indirect*(id: bgfx_view_id_t; handle: bgfx_program_handle_t;
                          indirectHandle: bgfx_indirect_buffer_handle_t;
                          start: uint16; num: uint16; depth: uint32;
                          preserveState: bool) {.importc: "bgfx_submit_indirect",
    dynlib: bgfxdll.}
proc bgfx_set_image*(stage: uint8; handle: bgfx_texture_handle_t; mip: uint8;
                    access: bgfx_access_t; format: bgfx_texture_format_t) {.
    importc: "bgfx_set_image", dynlib: bgfxdll.}
proc bgfx_set_compute_index_buffer*(stage: uint8;
                                   handle: bgfx_index_buffer_handle_t;
                                   access: bgfx_access_t) {.
    importc: "bgfx_set_compute_index_buffer", dynlib: bgfxdll.}
proc bgfx_set_compute_vertex_buffer*(stage: uint8;
                                    handle: bgfx_vertex_buffer_handle_t;
                                    access: bgfx_access_t) {.
    importc: "bgfx_set_compute_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_set_compute_dynamic_index_buffer*(stage: uint8;
    handle: bgfx_dynamic_index_buffer_handle_t; access: bgfx_access_t) {.
    importc: "bgfx_set_compute_dynamic_index_buffer", dynlib: bgfxdll.}
proc bgfx_set_compute_dynamic_vertex_buffer*(stage: uint8;
    handle: bgfx_dynamic_vertex_buffer_handle_t; access: bgfx_access_t) {.
    importc: "bgfx_set_compute_dynamic_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_set_compute_indirect_buffer*(stage: uint8;
                                      handle: bgfx_indirect_buffer_handle_t;
                                      access: bgfx_access_t) {.
    importc: "bgfx_set_compute_indirect_buffer", dynlib: bgfxdll.}
proc bgfx_dispatch*(id: bgfx_view_id_t; handle: bgfx_program_handle_t; numX: uint32;
                   numY: uint32; numZ: uint32; flags: uint8) {.
    importc: "bgfx_dispatch", dynlib: bgfxdll.}
proc bgfx_dispatch_indirect*(id: bgfx_view_id_t; handle: bgfx_program_handle_t;
                            indirectHandle: bgfx_indirect_buffer_handle_t;
                            start: uint16; num: uint16; flags: uint8) {.
    importc: "bgfx_dispatch_indirect", dynlib: bgfxdll.}
proc bgfx_discard*() {.importc: "bgfx_discard", dynlib: bgfxdll.}
proc bgfx_blit*(id: bgfx_view_id_t; dst: bgfx_texture_handle_t; dstMip: uint8;
               dstX: uint16; dstY: uint16; dstZ: uint16; src: bgfx_texture_handle_t;
               srcMip: uint8; srcX: uint16; srcY: uint16; srcZ: uint16; width: uint16;
               height: uint16; depth: uint16) {.importc: "bgfx_blit", dynlib: bgfxdll.}
proc bgfx_encoder_set_marker*(encoder: ptr bgfx_encoder_s; marker: cstring) {.
    importc: "bgfx_encoder_set_marker", dynlib: bgfxdll.}
proc bgfx_encoder_set_state*(encoder: ptr bgfx_encoder_s; state: uint64; rgba: uint32) {.
    importc: "bgfx_encoder_set_state", dynlib: bgfxdll.}
proc bgfx_encoder_set_condition*(encoder: ptr bgfx_encoder_s;
                                handle: bgfx_occlusion_query_handle_t;
                                visible: bool) {.
    importc: "bgfx_encoder_set_condition", dynlib: bgfxdll.}
proc bgfx_encoder_set_stencil*(encoder: ptr bgfx_encoder_s; fstencil: uint32;
                              bstencil: uint32) {.
    importc: "bgfx_encoder_set_stencil", dynlib: bgfxdll.}
proc bgfx_encoder_set_scissor*(encoder: ptr bgfx_encoder_s; x: uint16; y: uint16;
                              width: uint16; height: uint16): uint16 {.
    importc: "bgfx_encoder_set_scissor", dynlib: bgfxdll.}
proc bgfx_encoder_set_scissor_cached*(encoder: ptr bgfx_encoder_s; cache: uint16) {.
    importc: "bgfx_encoder_set_scissor_cached", dynlib: bgfxdll.}
proc bgfx_encoder_set_transform*(encoder: ptr bgfx_encoder_s; mtx: pointer;
                                num: uint16): uint32 {.
    importc: "bgfx_encoder_set_transform", dynlib: bgfxdll.}
proc bgfx_encoder_alloc_transform*(encoder: ptr bgfx_encoder_s;
                                  transform: ptr bgfx_transform_t; num: uint16): uint32 {.
    importc: "bgfx_encoder_alloc_transform", dynlib: bgfxdll.}
proc bgfx_encoder_set_transform_cached*(encoder: ptr bgfx_encoder_s; cache: uint32;
                                       num: uint16) {.
    importc: "bgfx_encoder_set_transform_cached", dynlib: bgfxdll.}
proc bgfx_encoder_set_uniform*(encoder: ptr bgfx_encoder_s;
                              handle: bgfx_uniform_handle_t; value: pointer;
                              num: uint16) {.importc: "bgfx_encoder_set_uniform",
    dynlib: bgfxdll.}
proc bgfx_encoder_set_index_buffer*(encoder: ptr bgfx_encoder_s;
                                   handle: bgfx_index_buffer_handle_t;
                                   firstIndex: uint32; numIndices: uint32) {.
    importc: "bgfx_encoder_set_index_buffer", dynlib: bgfxdll.}
proc bgfx_encoder_set_dynamic_index_buffer*(encoder: ptr bgfx_encoder_s;
    handle: bgfx_dynamic_index_buffer_handle_t; firstIndex: uint32;
    numIndices: uint32) {.importc: "bgfx_encoder_set_dynamic_index_buffer",
                        dynlib: bgfxdll.}
proc bgfx_encoder_set_transient_index_buffer*(encoder: ptr bgfx_encoder_s;
    tib: ptr bgfx_transient_index_buffer_t; firstIndex: uint32; numIndices: uint32) {.
    importc: "bgfx_encoder_set_transient_index_buffer", dynlib: bgfxdll.}
proc bgfx_encoder_set_vertex_buffer*(encoder: ptr bgfx_encoder_s; stream: uint8;
                                    handle: bgfx_vertex_buffer_handle_t;
                                    startVertex: uint32; numVertices: uint32) {.
    importc: "bgfx_encoder_set_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_encoder_set_dynamic_vertex_buffer*(encoder: ptr bgfx_encoder_s;
    stream: uint8; handle: bgfx_dynamic_vertex_buffer_handle_t; startVertex: uint32;
    numVertices: uint32) {.importc: "bgfx_encoder_set_dynamic_vertex_buffer",
                         dynlib: bgfxdll.}
proc bgfx_encoder_set_transient_vertex_buffer*(encoder: ptr bgfx_encoder_s;
    stream: uint8; tvb: ptr bgfx_transient_vertex_buffer_t; startVertex: uint32;
    numVertices: uint32) {.importc: "bgfx_encoder_set_transient_vertex_buffer",
                         dynlib: bgfxdll.}
proc bgfx_encoder_set_vertex_count*(encoder: ptr bgfx_encoder_s; numVertices: uint32) {.
    importc: "bgfx_encoder_set_vertex_count", dynlib: bgfxdll.}
proc bgfx_encoder_set_instance_data_buffer*(encoder: ptr bgfx_encoder_s;
    idb: ptr bgfx_instance_data_buffer_t; start: uint32; num: uint32) {.
    importc: "bgfx_encoder_set_instance_data_buffer", dynlib: bgfxdll.}
proc bgfx_encoder_set_instance_data_from_vertex_buffer*(
    encoder: ptr bgfx_encoder_s; handle: bgfx_vertex_buffer_handle_t;
    startVertex: uint32; num: uint32) {.importc: "bgfx_encoder_set_instance_data_from_vertex_buffer",
                                    dynlib: bgfxdll.}
proc bgfx_encoder_set_instance_data_from_dynamic_vertex_buffer*(
    encoder: ptr bgfx_encoder_s; handle: bgfx_dynamic_vertex_buffer_handle_t;
    startVertex: uint32; num: uint32) {.importc: "bgfx_encoder_set_instance_data_from_dynamic_vertex_buffer",
                                    dynlib: bgfxdll.}
proc bgfx_encoder_set_texture*(encoder: ptr bgfx_encoder_s; stage: uint8;
                              sampler: bgfx_uniform_handle_t;
                              handle: bgfx_texture_handle_t; flags: uint32) {.
    importc: "bgfx_encoder_set_texture", dynlib: bgfxdll.}
proc bgfx_encoder_touch*(encoder: ptr bgfx_encoder_s; id: bgfx_view_id_t) {.
    importc: "bgfx_encoder_touch", dynlib: bgfxdll.}
proc bgfx_encoder_submit*(encoder: ptr bgfx_encoder_s; id: bgfx_view_id_t;
                         handle: bgfx_program_handle_t; depth: uint32;
                         preserveState: bool) {.importc: "bgfx_encoder_submit",
    dynlib: bgfxdll.}
proc bgfx_encoder_submit_occlusion_query*(encoder: ptr bgfx_encoder_s;
    id: bgfx_view_id_t; program: bgfx_program_handle_t;
    occlusionQuery: bgfx_occlusion_query_handle_t; depth: uint32;
    preserveState: bool) {.importc: "bgfx_encoder_submit_occlusion_query",
                         dynlib: bgfxdll.}
proc bgfx_encoder_submit_indirect*(encoder: ptr bgfx_encoder_s; id: bgfx_view_id_t;
                                  handle: bgfx_program_handle_t; indirectHandle: bgfx_indirect_buffer_handle_t;
                                  start: uint16; num: uint16; depth: uint32;
                                  preserveState: bool) {.
    importc: "bgfx_encoder_submit_indirect", dynlib: bgfxdll.}
proc bgfx_encoder_set_image*(encoder: ptr bgfx_encoder_s; stage: uint8;
                            handle: bgfx_texture_handle_t; mip: uint8;
                            access: bgfx_access_t; format: bgfx_texture_format_t) {.
    importc: "bgfx_encoder_set_image", dynlib: bgfxdll.}
proc bgfx_encoder_set_compute_index_buffer*(encoder: ptr bgfx_encoder_s;
    stage: uint8; handle: bgfx_index_buffer_handle_t; access: bgfx_access_t) {.
    importc: "bgfx_encoder_set_compute_index_buffer", dynlib: bgfxdll.}
proc bgfx_encoder_set_compute_vertex_buffer*(encoder: ptr bgfx_encoder_s;
    stage: uint8; handle: bgfx_vertex_buffer_handle_t; access: bgfx_access_t) {.
    importc: "bgfx_encoder_set_compute_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_encoder_set_compute_dynamic_index_buffer*(encoder: ptr bgfx_encoder_s;
    stage: uint8; handle: bgfx_dynamic_index_buffer_handle_t; access: bgfx_access_t) {.
    importc: "bgfx_encoder_set_compute_dynamic_index_buffer", dynlib: bgfxdll.}
proc bgfx_encoder_set_compute_dynamic_vertex_buffer*(encoder: ptr bgfx_encoder_s;
    stage: uint8; handle: bgfx_dynamic_vertex_buffer_handle_t; access: bgfx_access_t) {.
    importc: "bgfx_encoder_set_compute_dynamic_vertex_buffer", dynlib: bgfxdll.}
proc bgfx_encoder_set_compute_indirect_buffer*(encoder: ptr bgfx_encoder_s;
    stage: uint8; handle: bgfx_indirect_buffer_handle_t; access: bgfx_access_t) {.
    importc: "bgfx_encoder_set_compute_indirect_buffer", dynlib: bgfxdll.}
proc bgfx_encoder_dispatch*(encoder: ptr bgfx_encoder_s; id: bgfx_view_id_t;
                           handle: bgfx_program_handle_t; numX: uint32;
                           numY: uint32; numZ: uint32; flags: uint8) {.
    importc: "bgfx_encoder_dispatch", dynlib: bgfxdll.}
proc bgfx_encoder_dispatch_indirect*(encoder: ptr bgfx_encoder_s;
                                    id: bgfx_view_id_t;
                                    handle: bgfx_program_handle_t; indirectHandle: bgfx_indirect_buffer_handle_t;
                                    start: uint16; num: uint16; flags: uint8) {.
    importc: "bgfx_encoder_dispatch_indirect", dynlib: bgfxdll.}
proc bgfx_encoder_discard*(encoder: ptr bgfx_encoder_s) {.
    importc: "bgfx_encoder_discard", dynlib: bgfxdll.}
proc bgfx_encoder_blit*(encoder: ptr bgfx_encoder_s; id: bgfx_view_id_t;
                       dst: bgfx_texture_handle_t; dstMip: uint8; dstX: uint16;
                       dstY: uint16; dstZ: uint16; src: bgfx_texture_handle_t;
                       srcMip: uint8; srcX: uint16; srcY: uint16; srcZ: uint16;
                       width: uint16; height: uint16; depth: uint16) {.
    importc: "bgfx_encoder_blit", dynlib: bgfxdll.}
proc bgfx_request_screen_shot*(handle: bgfx_frame_buffer_handle_t;
                              filePath: cstring) {.
    importc: "bgfx_request_screen_shot", dynlib: bgfxdll.}