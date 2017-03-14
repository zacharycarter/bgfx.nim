 {.deadCodeElim: on.}
when defined(windows):
  const
    libname* = "libhyperclient.dll"
elif defined(macosx):
  const
    libname* = "libbgfx-shared-libDebug.dylib"
else:
  const
    libname* = "libhyperclient.so"

import defines, ../bgfxdotnim
export defines

## 
##  Copyright 2011-2017 Branimir Karadzic. All rights reserved.
##  License: https://github.com/bkaradzic/bgfx/blob/master/LICENSE
## 
##  vim: set tabstop=4 expandtab:
## 

##  NOTICE:
##  This header file contains platform specific interfaces. It is only
##  necessary to use this header in conjunction with creating windows.

type
  bgfx_render_frame_t* {.size: sizeof(cint).} = enum
    BGFX_RENDER_FRAME_NO_CONTEXT, BGFX_RENDER_FRAME_RENDER,
    BGFX_RENDER_FRAME_TIMEOUT, BGFX_RENDER_FRAME_EXITING, BGFX_RENDER_FRAME_COUNT


## *
##  WARNING: This call should be only used on platforms that don't
##  allow creating separate rendering thread. If it is called before
##  to bgfx_init, render thread won't be created by bgfx_init call.
## 

proc bgfx_render_frame*(): bgfx_render_frame_t {.importc: "bgfx_render_frame",
    dynlib: libname.}
type
  bgfx_platform_data_t* = object
    ndt*: pointer
    nwh*: pointer
    context*: pointer
    backBuffer*: pointer
    backBufferDS*: pointer
    session*: pointer


## 

proc bgfx_set_platform_data*(data: ptr bgfx_platform_data_t) {.
    importc: "bgfx_set_platform_data", dynlib: libname.}
type
  bgfx_internal_data_t* = object
    caps*: ptr bgfx_caps_t
    context*: pointer


## 

proc bgfx_get_internal_data*(): ptr bgfx_internal_data_t {.
    importc: "bgfx_get_internal_data", dynlib: libname.}
## 

proc bgfx_override_internal_texture_ptr*(handle: bgfx_texture_handle_t;
                                        `ptr`: uint): uint {.
    importc: "bgfx_override_internal_texture_ptr", dynlib: libname.}
## 

proc bgfx_override_internal_texture*(handle: bgfx_texture_handle_t;
                                    width: uint16; height: uint16;
                                    numMips: uint8;
                                    format: bgfx_texture_format_t;
                                    flags: uint32): uint {.
    importc: "bgfx_override_internal_texture", dynlib: libname.}
## 

type
  bgfx_interface_vtbl_t* = object
    render_frame*: proc (): bgfx_render_frame_t
    set_platform_data*: proc (data: ptr bgfx_platform_data_t)
    get_internal_data*: proc (): ptr bgfx_internal_data_t
    override_internal_texture_ptr*: proc (handle: bgfx_texture_handle_t;
                                        `ptr`: uint): uint
    override_internal_texture*: proc (handle: bgfx_texture_handle_t;
                                    width: uint16; height: uint16;
                                    numMips: uint8;
                                    format: bgfx_texture_format_t;
                                    flags: uint32): uint
    vertex_decl_begin*: proc (decl: ptr bgfx_vertex_decl_t;
                            renderer: bgfx_renderer_type_t)
    vertex_decl_add*: proc (decl: ptr bgfx_vertex_decl_t; attrib: bgfx_attrib_t;
                          num: uint8; `type`: bgfx_attrib_type_t;
                          normalized: bool; asInt: bool)
    vertex_decl_skip*: proc (decl: ptr bgfx_vertex_decl_t; num: uint8)
    vertex_decl_end*: proc (decl: ptr bgfx_vertex_decl_t)
    vertex_pack*: proc (input: array[4, cfloat]; inputNormalized: bool;
                      attr: bgfx_attrib_t; decl: ptr bgfx_vertex_decl_t;
                      data: pointer; index: uint32)
    vertex_unpack*: proc (output: array[4, cfloat]; attr: bgfx_attrib_t;
                        decl: ptr bgfx_vertex_decl_t; data: pointer;
                        index: uint32)
    vertex_convert*: proc (destDecl: ptr bgfx_vertex_decl_t; destData: pointer;
                         srcDecl: ptr bgfx_vertex_decl_t; srcData: pointer;
                         num: uint32)
    weld_vertices*: proc (output: ptr uint16; decl: ptr bgfx_vertex_decl_t;
                        data: pointer; num: uint16; epsilon: cfloat): uint16
    topology_convert*: proc (conversion: bgfx_topology_convert_t; dst: pointer;
                           dstSize: uint32; indices: pointer;
                           numIndices: uint32; index32: bool): uint32
    topology_sort_tri_list*: proc (sort: bgfx_topology_sort_t; dst: pointer;
                                 dstSize: uint32; dir: array[3, cfloat];
                                 pos: array[3, cfloat]; vertices: pointer;
                                 stride: uint32; indices: pointer;
                                 numIndices: uint32; index32: bool)
    image_swizzle_bgra8*: proc (dst: pointer; width: uint32; height: uint32;
                              pitch: uint32; src: pointer)
    image_rgba8_downsample_2x2*: proc (dst: pointer; width: uint32;
                                     height: uint32; pitch: uint32;
                                     src: pointer)
    get_supported_renderers*: proc (max: uint8; `enum`: ptr bgfx_renderer_type_t): uint8
    get_renderer_name*: proc (`type`: bgfx_renderer_type_t): cstring
    init*: proc (`type`: bgfx_renderer_type_t; vendorId: uint16;
               deviceId: uint16; callback: ptr bgfx_callback_interface_t;
               allocator: ptr bgfx_allocator_interface_t): bool
    shutdown*: proc ()
    reset*: proc (width: uint32; height: uint32; flags: uint32)
    frame*: proc (capture: bool): uint32
    get_renderer_type*: proc (): bgfx_renderer_type_t
    get_caps*: proc (): ptr bgfx_caps_t
    get_hmd*: proc (): ptr bgfx_hmd_t
    get_stats*: proc (): ptr bgfx_stats_t
    alloc*: proc (size: uint32): ptr bgfx_memory_t
    copy*: proc (data: pointer; size: uint32): ptr bgfx_memory_t
    make_ref*: proc (data: pointer; size: uint32): ptr bgfx_memory_t
    make_ref_release*: proc (data: pointer; size: uint32;
                           releaseFn: bgfx_release_fn_t; userData: pointer): ptr bgfx_memory_t
    set_debug*: proc (debug: uint32)
    dbg_text_clear*: proc (attr: uint8; small: bool)
    dbg_text_printf*: proc (x: uint16; y: uint16; attr: uint8; format: cstring) {.
        varargs.}
    dbg_text_vprintf*: proc (x: uint16; y: uint16; attr: uint8;
                           format: cstring; argList: va_list)
    dbg_text_image*: proc (x: uint16; y: uint16; width: uint16;
                         height: uint16; data: pointer; pitch: uint16)
    create_index_buffer*: proc (mem: ptr bgfx_memory_t; flags: uint16): bgfx_index_buffer_handle_t
    destroy_index_buffer*: proc (handle: bgfx_index_buffer_handle_t)
    create_vertex_buffer*: proc (mem: ptr bgfx_memory_t;
                               decl: ptr bgfx_vertex_decl_t; flags: uint16): bgfx_vertex_buffer_handle_t
    destroy_vertex_buffer*: proc (handle: bgfx_vertex_buffer_handle_t)
    create_dynamic_index_buffer*: proc (num: uint32; flags: uint16): bgfx_dynamic_index_buffer_handle_t
    create_dynamic_index_buffer_mem*: proc (mem: ptr bgfx_memory_t; flags: uint16): bgfx_dynamic_index_buffer_handle_t
    update_dynamic_index_buffer*: proc (handle: bgfx_dynamic_index_buffer_handle_t;
                                      startIndex: uint32;
                                      mem: ptr bgfx_memory_t)
    destroy_dynamic_index_buffer*: proc (handle: bgfx_dynamic_index_buffer_handle_t)
    create_dynamic_vertex_buffer*: proc (num: uint32;
                                       decl: ptr bgfx_vertex_decl_t;
                                       flags: uint16): bgfx_dynamic_vertex_buffer_handle_t
    create_dynamic_vertex_buffer_mem*: proc (mem: ptr bgfx_memory_t;
        decl: ptr bgfx_vertex_decl_t; flags: uint16): bgfx_dynamic_vertex_buffer_handle_t
    update_dynamic_vertex_buffer*: proc (handle: bgfx_dynamic_vertex_buffer_handle_t;
                                       startVertex: uint32;
                                       mem: ptr bgfx_memory_t)
    destroy_dynamic_vertex_buffer*: proc (handle: bgfx_dynamic_vertex_buffer_handle_t)
    get_avail_transient_index_buffer*: proc (num: uint32): uint32
    get_avail_transient_vertex_buffer*: proc (num: uint32;
        decl: ptr bgfx_vertex_decl_t): uint32
    get_avail_instance_data_buffer*: proc (num: uint32; stride: uint16): uint32
    alloc_transient_index_buffer*: proc (tib: ptr bgfx_transient_index_buffer_t;
                                       num: uint32)
    alloc_transient_vertex_buffer*: proc (tvb: ptr bgfx_transient_vertex_buffer_t;
                                        num: uint32;
                                        decl: ptr bgfx_vertex_decl_t)
    alloc_transient_buffers*: proc (tvb: ptr bgfx_transient_vertex_buffer_t;
                                  decl: ptr bgfx_vertex_decl_t;
                                  numVertices: uint32;
                                  tib: ptr bgfx_transient_index_buffer_t;
                                  numIndices: uint32): bool
    alloc_instance_data_buffer*: proc (num: uint32; stride: uint16): ptr bgfx_instance_data_buffer_t
    create_indirect_buffer*: proc (num: uint32): bgfx_indirect_buffer_handle_t
    destroy_indirect_buffer*: proc (handle: bgfx_indirect_buffer_handle_t)
    create_shader*: proc (mem: ptr bgfx_memory_t): bgfx_shader_handle_t
    get_shader_uniforms*: proc (handle: bgfx_shader_handle_t;
                              uniforms: ptr bgfx_uniform_handle_t; max: uint16): uint16
    destroy_shader*: proc (handle: bgfx_shader_handle_t)
    create_program*: proc (vsh: bgfx_shader_handle_t; fsh: bgfx_shader_handle_t;
                         destroyShaders: bool): bgfx_program_handle_t
    create_compute_program*: proc (csh: bgfx_shader_handle_t; destroyShaders: bool): bgfx_program_handle_t
    destroy_program*: proc (handle: bgfx_program_handle_t)
    is_texture_valid*: proc (depth: uint16; cubeMap: bool; numLayers: uint16;
                           format: bgfx_texture_format_t; flags: uint32): bool
    calc_texture_size*: proc (info: ptr bgfx_texture_info_t; width: uint16;
                            height: uint16; depth: uint16; cubeMap: bool;
                            hasMips: bool; numLayers: uint16;
                            format: bgfx_texture_format_t)
    create_texture*: proc (mem: ptr bgfx_memory_t; flags: uint32; skip: uint8;
                         info: ptr bgfx_texture_info_t): bgfx_texture_handle_t
    create_texture_2d*: proc (width: uint16; height: uint16; hasMips: bool;
                            numLayers: uint16; format: bgfx_texture_format_t;
                            flags: uint32; mem: ptr bgfx_memory_t): bgfx_texture_handle_t
    create_texture_2d_scaled*: proc (ratio: bgfx_backbuffer_ratio_t;
                                   hasMips: bool; numLayers: uint16;
                                   format: bgfx_texture_format_t;
                                   flags: uint32): bgfx_texture_handle_t
    create_texture_3d*: proc (width: uint16; height: uint16; depth: uint16;
                            hasMips: bool; format: bgfx_texture_format_t;
                            flags: uint32; mem: ptr bgfx_memory_t): bgfx_texture_handle_t
    create_texture_cube*: proc (size: uint16; hasMips: bool; numLayers: uint16;
                              format: bgfx_texture_format_t; flags: uint32;
                              mem: ptr bgfx_memory_t): bgfx_texture_handle_t
    update_texture_2d*: proc (handle: bgfx_texture_handle_t; layer: uint16;
                            mip: uint8; x: uint16; y: uint16;
                            width: uint16; height: uint16;
                            mem: ptr bgfx_memory_t; pitch: uint16)
    update_texture_3d*: proc (handle: bgfx_texture_handle_t; mip: uint8;
                            x: uint16; y: uint16; z: uint16;
                            width: uint16; height: uint16; depth: uint16;
                            mem: ptr bgfx_memory_t)
    update_texture_cube*: proc (handle: bgfx_texture_handle_t; layer: uint16;
                              side: uint8; mip: uint8; x: uint16;
                              y: uint16; width: uint16; height: uint16;
                              mem: ptr bgfx_memory_t; pitch: uint16)
    read_texture*: proc (handle: bgfx_texture_handle_t; data: pointer; mip: uint8): uint32
    destroy_texture*: proc (handle: bgfx_texture_handle_t)
    create_frame_buffer*: proc (width: uint16; height: uint16;
                              format: bgfx_texture_format_t;
                              textureFlags: uint32): bgfx_frame_buffer_handle_t
    create_frame_buffer_scaled*: proc (ratio: bgfx_backbuffer_ratio_t;
                                     format: bgfx_texture_format_t;
                                     textureFlags: uint32): bgfx_frame_buffer_handle_t
    create_frame_buffer_from_attachment*: proc (num: uint8;
        attachment: ptr bgfx_attachment_t; destroyTextures: bool): bgfx_frame_buffer_handle_t
    create_frame_buffer_from_nwh*: proc (nwh: pointer; width: uint16;
                                       height: uint16;
                                       depthFormat: bgfx_texture_format_t): bgfx_frame_buffer_handle_t
    get_texture*: proc (handle: bgfx_frame_buffer_handle_t; attachment: uint8): bgfx_texture_handle_t
    destroy_frame_buffer*: proc (handle: bgfx_frame_buffer_handle_t)
    create_uniform*: proc (name: cstring; `type`: bgfx_uniform_type_t; num: uint16): bgfx_uniform_handle_t
    get_uniform_info*: proc (handle: bgfx_uniform_handle_t;
                           info: ptr bgfx_uniform_info_t)
    destroy_uniform*: proc (handle: bgfx_uniform_handle_t)
    create_occlusion_query*: proc (): bgfx_occlusion_query_handle_t
    get_result*: proc (handle: bgfx_occlusion_query_handle_t; result: ptr int32): bgfx_occlusion_query_result_t
    destroy_occlusion_query*: proc (handle: bgfx_occlusion_query_handle_t)
    set_palette_color*: proc (index: uint8; rgba: array[4, cfloat])
    set_view_name*: proc (id: uint8; name: cstring)
    set_view_rect*: proc (id: uint8; x: uint16; y: uint16; width: uint16;
                        height: uint16)
    set_view_scissor*: proc (id: uint8; x: uint16; y: uint16; width: uint16;
                           height: uint16)
    set_view_clear*: proc (id: uint8; flags: uint16; rgba: uint32;
                         depth: cfloat; stencil: uint8)
    set_view_clear_mrt*: proc (id: uint8; flags: uint16; depth: cfloat;
                             stencil: uint8; zero: uint8; one: uint8; two: uint8;
                             three: uint8; four: uint8; five: uint8; six: uint8;
                             seven: uint8)
    set_view_seq*: proc (id: uint8; enabled: bool)
    set_view_frame_buffer*: proc (id: uint8; handle: bgfx_frame_buffer_handle_t)
    set_view_transform*: proc (id: uint8; view: pointer; proj: pointer)
    set_view_transform_stereo*: proc (id: uint8; view: pointer; projL: pointer;
                                    flags: uint8; projR: pointer)
    set_view_order*: proc (id: uint8; num: uint8; order: pointer)
    set_marker*: proc (marker: cstring)
    set_state*: proc (state: uint64; rgba: uint32)
    set_condition*: proc (handle: bgfx_occlusion_query_handle_t; visible: bool)
    set_stencil*: proc (fstencil: uint32; bstencil: uint32)
    set_scissor*: proc (x: uint16; y: uint16; width: uint16; height: uint16): uint16
    set_scissor_cached*: proc (cache: uint16)
    set_transform*: proc (mtx: pointer; num: uint16): uint32
    alloc_transform*: proc (transform: ptr bgfx_transform_t; num: uint16): uint32
    set_transform_cached*: proc (cache: uint32; num: uint16)
    set_uniform*: proc (handle: bgfx_uniform_handle_t; value: pointer;
                      num: uint16)
    set_index_buffer*: proc (handle: bgfx_index_buffer_handle_t;
                           firstIndex: uint32; numIndices: uint32)
    set_dynamic_index_buffer*: proc (handle: bgfx_dynamic_index_buffer_handle_t;
                                   firstIndex: uint32; numIndices: uint32)
    set_transient_index_buffer*: proc (tib: ptr bgfx_transient_index_buffer_t;
                                     firstIndex: uint32; numIndices: uint32)
    set_vertex_buffer*: proc (handle: bgfx_vertex_buffer_handle_t;
                            startVertex: uint32; numVertices: uint32)
    set_dynamic_vertex_buffer*: proc (handle: bgfx_dynamic_vertex_buffer_handle_t;
                                    startVertex: uint32; numVertices: uint32)
    set_transient_vertex_buffer*: proc (tvb: ptr bgfx_transient_vertex_buffer_t;
                                      startVertex: uint32;
                                      numVertices: uint32)
    set_instance_data_buffer*: proc (idb: ptr bgfx_instance_data_buffer_t;
                                   num: uint32)
    set_instance_data_from_vertex_buffer*: proc (
        handle: bgfx_vertex_buffer_handle_t; startVertex: uint32; num: uint32)
    set_instance_data_from_dynamic_vertex_buffer*: proc (
        handle: bgfx_dynamic_vertex_buffer_handle_t; startVertex: uint32;
        num: uint32)
    set_texture*: proc (stage: uint8; sampler: bgfx_uniform_handle_t;
                      handle: bgfx_texture_handle_t; flags: uint32)
    touch*: proc (id: uint8): uint32
    submit*: proc (id: uint8; handle: bgfx_program_handle_t; depth: int32;
                 preserveState: bool): uint32
    submit_occlusion_query*: proc (id: uint8; program: bgfx_program_handle_t;
        occlusionQuery: bgfx_occlusion_query_handle_t; depth: int32;
                                 preserveState: bool): uint32
    submit_indirect*: proc (id: uint8; handle: bgfx_program_handle_t;
                          indirectHandle: bgfx_indirect_buffer_handle_t;
                          start: uint16; num: uint16; depth: int32;
                          preserveState: bool): uint32
    set_image*: proc (stage: uint8; sampler: bgfx_uniform_handle_t;
                    handle: bgfx_texture_handle_t; mip: uint8;
                    access: bgfx_access_t; format: bgfx_texture_format_t)
    set_compute_index_buffer*: proc (stage: uint8;
                                   handle: bgfx_index_buffer_handle_t;
                                   access: bgfx_access_t)
    set_compute_vertex_buffer*: proc (stage: uint8;
                                    handle: bgfx_vertex_buffer_handle_t;
                                    access: bgfx_access_t)
    set_compute_dynamic_index_buffer*: proc (stage: uint8;
        handle: bgfx_dynamic_index_buffer_handle_t; access: bgfx_access_t)
    set_compute_dynamic_vertex_buffer*: proc (stage: uint8;
        handle: bgfx_dynamic_vertex_buffer_handle_t; access: bgfx_access_t)
    set_compute_indirect_buffer*: proc (stage: uint8;
                                      handle: bgfx_indirect_buffer_handle_t;
                                      access: bgfx_access_t)
    dispatch*: proc (id: uint8; handle: bgfx_program_handle_t; numX: uint16;
                   numY: uint16; numZ: uint16; flags: uint8): uint32
    dispatch_indirect*: proc (id: uint8; handle: bgfx_program_handle_t;
                            indirectHandle: bgfx_indirect_buffer_handle_t;
                            start: uint16; num: uint16; flags: uint8): uint32
    `discard`*: proc ()
    blit*: proc (id: uint8; dst: bgfx_texture_handle_t; dstMip: uint8;
               dstX: uint16; dstY: uint16; dstZ: uint16;
               src: bgfx_texture_handle_t; srcMip: uint8; srcX: uint16;
               srcY: uint16; srcZ: uint16; width: uint16; height: uint16;
               depth: uint16)
    request_screen_shot*: proc (handle: bgfx_frame_buffer_handle_t;
                              filePath: cstring)

  PFN_BGFX_GET_INTERFACE* = proc (version: uint32): ptr bgfx_interface_vtbl_t
