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

import defines, ../bgfxdotnim

type
  bgfx_render_frame_t* {.size: sizeof(cint).} = enum
    BGFX_RENDER_FRAME_NO_CONTEXT, BGFX_RENDER_FRAME_RENDER,
    BGFX_RENDER_FRAME_TIMEOUT, BGFX_RENDER_FRAME_EXITING, BGFX_RENDER_FRAME_COUNT


proc bgfx_render_frame*(msecs: int32): bgfx_render_frame_t {.
    importc: "bgfx_render_frame", dynlib: bgfxdll.}
proc bgfx_set_platform_data*(data: ptr bgfx_platform_data_t) {.
    importc: "bgfx_set_platform_data", dynlib: bgfxdll.}
type
  bgfx_internal_data_t* {.bycopy.} = object
    caps*: ptr bgfx_caps_t
    context*: pointer


proc bgfx_get_internal_data*(): ptr bgfx_internal_data_t {.
    importc: "bgfx_get_internal_data", dynlib: bgfxdll.}
proc bgfx_override_internal_texture_ptr*(handle: bgfx_texture_handle_t;
                                        `ptr`: pointer): pointer {.
    importc: "bgfx_override_internal_texture_ptr", dynlib: bgfxdll.}
proc bgfx_override_internal_texture*(handle: bgfx_texture_handle_t; width: uint16;
                                    height: uint16; numMips: uint8;
                                    format: bgfx_texture_format_t; flags: uint32): pointer {.
    importc: "bgfx_override_internal_texture", dynlib: bgfxdll.}
type
  bgfx_interface_vtbl_t* {.bycopy.} = object
    render_frame*: proc (msecs: int32): bgfx_render_frame_t
    set_platform_data*: proc (data: ptr bgfx_platform_data_t)
    get_internal_data*: proc (): ptr bgfx_internal_data_t
    override_internal_texture_ptr*: proc (handle: bgfx_texture_handle_t;
                                        `ptr`: pointer): pointer
    override_internal_texture*: proc (handle: bgfx_texture_handle_t; width: uint16;
                                    height: uint16; numMips: uint8;
                                    format: bgfx_texture_format_t; flags: uint32): pointer
    vertex_layout_begin*: proc (decl: ptr bgfx_vertex_layout_t;
                            renderer: bgfx_renderer_type_t)
    vertex_layout_add*: proc (decl: ptr bgfx_vertex_layout_t; attrib: bgfx_attrib_t;
                          num: uint8; `type`: bgfx_attrib_type_t; normalized: bool;
                          asInt: bool)
    vertex_layout_decode*: proc (decl: ptr bgfx_vertex_layout_t; attrib: bgfx_attrib_t;
                             num: ptr uint8; `type`: ptr bgfx_attrib_type_t;
                             normalized: ptr bool; asInt: ptr bool)
    vertex_layout_has*: proc (decl: ptr bgfx_vertex_layout_t; attrib: bgfx_attrib_t): bool
    vertex_layout_skip*: proc (decl: ptr bgfx_vertex_layout_t; num: uint8)
    vertex_layout_end*: proc (decl: ptr bgfx_vertex_layout_t)
    vertex_pack*: proc (input: array[4, cfloat]; inputNormalized: bool;
                      attr: bgfx_attrib_t; decl: ptr bgfx_vertex_layout_t;
                      data: pointer; index: uint32)
    vertex_unpack*: proc (output: array[4, cfloat]; attr: bgfx_attrib_t;
                        decl: ptr bgfx_vertex_layout_t; data: pointer; index: uint32)
    vertex_convert*: proc (destDecl: ptr bgfx_vertex_layout_t; destData: pointer;
                         srcDecl: ptr bgfx_vertex_layout_t; srcData: pointer;
                         num: uint32)
    weld_vertices*: proc (output: ptr uint16; decl: ptr bgfx_vertex_layout_t;
                        data: pointer; num: uint16; epsilon: cfloat): uint16
    topology_convert*: proc (conversion: bgfx_topology_convert_t; dst: pointer;
                           dstSize: uint32; indices: pointer; numIndices: uint32;
                           index32: bool): uint32
    topology_sort_tri_list*: proc (sort: bgfx_topology_sort_t; dst: pointer;
                                 dstSize: uint32; dir: array[3, cfloat];
                                 pos: array[3, cfloat]; vertices: pointer;
                                 stride: uint32; indices: pointer;
                                 numIndices: uint32; index32: bool)
    get_supported_renderers*: proc (max: uint8; `enum`: ptr bgfx_renderer_type_t): uint8
    get_renderer_name*: proc (`type`: bgfx_renderer_type_t): cstring
    init_ctor*: proc (init: ptr bgfx_init_t)
    init*: proc (init: ptr bgfx_init_t): bool
    shutdown*: proc ()
    reset*: proc (width: uint32; height: uint32; flags: uint32;
                format: bgfx_texture_format_t)
    frame*: proc (capture: bool): uint32
    get_renderer_type*: proc (): bgfx_renderer_type_t
    get_caps*: proc (): ptr bgfx_caps_t
    get_stats*: proc (): ptr bgfx_stats_t
    alloc*: proc (size: uint32): ptr bgfx_memory_t
    copy*: proc (data: pointer; size: uint32): ptr bgfx_memory_t
    make_ref*: proc (data: pointer; size: uint32): ptr bgfx_memory_t
    make_ref_release*: proc (data: pointer; size: uint32;
                           releaseFn: bgfx_release_fn_t; userData: pointer): ptr bgfx_memory_t
    set_debug*: proc (debug: uint32)
    dbg_text_clear*: proc (attr: uint8; small: bool)
    dbg_text_printf*: proc (x: uint16; y: uint16; attr: uint8; format: cstring) {.varargs.}
    dbg_text_vprintf*: proc (x: uint16; y: uint16; attr: uint8; format: cstring;
                           argList: va_list)
    dbg_text_image*: proc (x: uint16; y: uint16; width: uint16; height: uint16;
                         data: pointer; pitch: uint16)
    create_index_buffer*: proc (mem: ptr bgfx_memory_t; flags: uint16): bgfx_index_buffer_handle_t
    destroy_index_buffer*: proc (handle: bgfx_index_buffer_handle_t)
    create_vertex_buffer*: proc (mem: ptr bgfx_memory_t;
                               decl: ptr bgfx_vertex_layout_t; flags: uint16): bgfx_vertex_buffer_handle_t
    destroy_vertex_buffer*: proc (handle: bgfx_vertex_buffer_handle_t)
    create_dynamic_index_buffer*: proc (num: uint32; flags: uint16): bgfx_dynamic_index_buffer_handle_t
    create_dynamic_index_buffer_mem*: proc (mem: ptr bgfx_memory_t; flags: uint16): bgfx_dynamic_index_buffer_handle_t
    update_dynamic_index_buffer*: proc (handle: bgfx_dynamic_index_buffer_handle_t;
                                      startIndex: uint32; mem: ptr bgfx_memory_t)
    destroy_dynamic_index_buffer*: proc (handle: bgfx_dynamic_index_buffer_handle_t)
    create_dynamic_vertex_buffer*: proc (num: uint32; decl: ptr bgfx_vertex_layout_t;
                                       flags: uint16): bgfx_dynamic_vertex_buffer_handle_t
    create_dynamic_vertex_buffer_mem*: proc (mem: ptr bgfx_memory_t;
        decl: ptr bgfx_vertex_layout_t; flags: uint16): bgfx_dynamic_vertex_buffer_handle_t
    update_dynamic_vertex_buffer*: proc (handle: bgfx_dynamic_vertex_buffer_handle_t;
                                       startVertex: uint32; mem: ptr bgfx_memory_t)
    destroy_dynamic_vertex_buffer*: proc (handle: bgfx_dynamic_vertex_buffer_handle_t)
    get_avail_transient_index_buffer*: proc (num: uint32): uint32
    get_avail_transient_vertex_buffer*: proc (num: uint32;
        decl: ptr bgfx_vertex_layout_t): uint32
    get_avail_instance_data_buffer*: proc (num: uint32; stride: uint16): uint32
    alloc_transient_index_buffer*: proc (tib: ptr bgfx_transient_index_buffer_t;
                                       num: uint32)
    alloc_transient_vertex_buffer*: proc (tvb: ptr bgfx_transient_vertex_buffer_t;
                                        num: uint32; decl: ptr bgfx_vertex_layout_t)
    alloc_transient_buffers*: proc (tvb: ptr bgfx_transient_vertex_buffer_t;
                                  decl: ptr bgfx_vertex_layout_t;
                                  numVertices: uint32;
                                  tib: ptr bgfx_transient_index_buffer_t;
                                  numIndices: uint32): bool
    alloc_instance_data_buffer*: proc (idb: ptr bgfx_instance_data_buffer_t;
                                     num: uint32; stride: uint16)
    create_indirect_buffer*: proc (num: uint32): bgfx_indirect_buffer_handle_t
    destroy_indirect_buffer*: proc (handle: bgfx_indirect_buffer_handle_t)
    create_shader*: proc (mem: ptr bgfx_memory_t): bgfx_shader_handle_t
    get_shader_uniforms*: proc (handle: bgfx_shader_handle_t;
                              uniforms: ptr bgfx_uniform_handle_t; max: uint16): uint16
    set_shader_name*: proc (handle: bgfx_shader_handle_t; name: cstring; len: int32)
    destroy_shader*: proc (handle: bgfx_shader_handle_t)
    create_program*: proc (vsh: bgfx_shader_handle_t; fsh: bgfx_shader_handle_t;
                         destroyShaders: bool): bgfx_program_handle_t
    create_compute_program*: proc (csh: bgfx_shader_handle_t; destroyShaders: bool): bgfx_program_handle_t
    destroy_program*: proc (handle: bgfx_program_handle_t)
    is_texture_valid*: proc (depth: uint16; cubeMap: bool; numLayers: uint16;
                           format: bgfx_texture_format_t; flags: uint64): bool
    calc_texture_size*: proc (info: ptr bgfx_texture_info_t; width: uint16;
                            height: uint16; depth: uint16; cubeMap: bool;
                            hasMips: bool; numLayers: uint16;
                            format: bgfx_texture_format_t)
    create_texture*: proc (mem: ptr bgfx_memory_t; flags: uint64; skip: uint8;
                         info: ptr bgfx_texture_info_t): bgfx_texture_handle_t
    create_texture_2d*: proc (width: uint16; height: uint16; hasMips: bool;
                            numLayers: uint16; format: bgfx_texture_format_t;
                            flags: uint64; mem: ptr bgfx_memory_t): bgfx_texture_handle_t
    create_texture_2d_scaled*: proc (ratio: bgfx_backbuffer_ratio_t; hasMips: bool;
                                   numLayers: uint16;
                                   format: bgfx_texture_format_t; flags: uint64): bgfx_texture_handle_t
    create_texture_3d*: proc (width: uint16; height: uint16; depth: uint16;
                            hasMips: bool; format: bgfx_texture_format_t;
                            flags: uint64; mem: ptr bgfx_memory_t): bgfx_texture_handle_t
    create_texture_cube*: proc (size: uint16; hasMips: bool; numLayers: uint16;
                              format: bgfx_texture_format_t; flags: uint64;
                              mem: ptr bgfx_memory_t): bgfx_texture_handle_t
    update_texture_2d*: proc (handle: bgfx_texture_handle_t; layer: uint16;
                            mip: uint8; x: uint16; y: uint16; width: uint16;
                            height: uint16; mem: ptr bgfx_memory_t; pitch: uint16)
    update_texture_3d*: proc (handle: bgfx_texture_handle_t; mip: uint8; x: uint16;
                            y: uint16; z: uint16; width: uint16; height: uint16;
                            depth: uint16; mem: ptr bgfx_memory_t)
    update_texture_cube*: proc (handle: bgfx_texture_handle_t; layer: uint16;
                              side: uint8; mip: uint8; x: uint16; y: uint16;
                              width: uint16; height: uint16; mem: ptr bgfx_memory_t;
                              pitch: uint16)
    read_texture*: proc (handle: bgfx_texture_handle_t; data: pointer; mip: uint8): uint32
    set_texture_name*: proc (handle: bgfx_texture_handle_t; name: cstring; len: int32)
    get_direct_access_ptr*: proc (handle: bgfx_texture_handle_t): pointer
    destroy_texture*: proc (handle: bgfx_texture_handle_t)
    create_frame_buffer*: proc (width: uint16; height: uint16;
                              format: bgfx_texture_format_t; textureFlags: uint64): bgfx_frame_buffer_handle_t
    create_frame_buffer_scaled*: proc (ratio: bgfx_backbuffer_ratio_t;
                                     format: bgfx_texture_format_t;
                                     textureFlags: uint64): bgfx_frame_buffer_handle_t
    create_frame_buffer_from_attachment*: proc (num: uint8;
        attachment: ptr bgfx_attachment_t; destroyTextures: bool): bgfx_frame_buffer_handle_t
    create_frame_buffer_from_nwh*: proc (nwh: pointer; width: uint16; height: uint16;
                                       format: bgfx_texture_format_t;
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
    set_view_name*: proc (id: bgfx_view_id_t; name: cstring)
    set_view_rect*: proc (id: bgfx_view_id_t; x: uint16; y: uint16; width: uint16;
                        height: uint16)
    set_view_scissor*: proc (id: bgfx_view_id_t; x: uint16; y: uint16; width: uint16;
                           height: uint16)
    set_view_clear*: proc (id: bgfx_view_id_t; flags: uint16; rgba: uint32;
                         depth: cfloat; stencil: uint8)
    set_view_clear_mrt*: proc (id: bgfx_view_id_t; flags: uint16; depth: cfloat;
                             stencil: uint8; v0: uint8; v1: uint8; v2: uint8; v3: uint8;
                             v4: uint8; v5: uint8; v6: uint8; v7: uint8)
    set_view_mode*: proc (id: bgfx_view_id_t; mode: bgfx_view_mode_t)
    set_view_frame_buffer*: proc (id: bgfx_view_id_t;
                                handle: bgfx_frame_buffer_handle_t)
    set_view_transform*: proc (id: bgfx_view_id_t; view: pointer; proj: pointer)
    set_view_transform_stereo*: proc (id: bgfx_view_id_t; view: pointer;
                                    projL: pointer; flags: uint8; projR: pointer)
    set_view_order*: proc (id: bgfx_view_id_t; num: uint16; order: ptr bgfx_view_id_t)
    encoder_set_marker*: proc (encoder: ptr bgfx_encoder_s; marker: cstring)
    encoder_set_state*: proc (encoder: ptr bgfx_encoder_s; state: uint64; rgba: uint32)
    encoder_set_condition*: proc (encoder: ptr bgfx_encoder_s;
                                handle: bgfx_occlusion_query_handle_t;
                                visible: bool)
    encoder_set_stencil*: proc (encoder: ptr bgfx_encoder_s; fstencil: uint32;
                              bstencil: uint32)
    encoder_set_scissor*: proc (encoder: ptr bgfx_encoder_s; x: uint16; y: uint16;
                              width: uint16; height: uint16): uint16
    encoder_set_scissor_cached*: proc (encoder: ptr bgfx_encoder_s; cache: uint16)
    encoder_set_transform*: proc (encoder: ptr bgfx_encoder_s; mtx: pointer;
                                num: uint16): uint32
    encoder_alloc_transform*: proc (encoder: ptr bgfx_encoder_s;
                                  transform: ptr bgfx_transform_t; num: uint16): uint32
    encoder_set_transform_cached*: proc (encoder: ptr bgfx_encoder_s; cache: uint32;
                                       num: uint16)
    encoder_set_uniform*: proc (encoder: ptr bgfx_encoder_s;
                              handle: bgfx_uniform_handle_t; value: pointer;
                              num: uint16)
    encoder_set_index_buffer*: proc (encoder: ptr bgfx_encoder_s;
                                   handle: bgfx_index_buffer_handle_t;
                                   firstIndex: uint32; numIndices: uint32)
    encoder_set_dynamic_index_buffer*: proc (encoder: ptr bgfx_encoder_s;
        handle: bgfx_dynamic_index_buffer_handle_t; firstIndex: uint32;
        numIndices: uint32)
    encoder_set_transient_index_buffer*: proc (encoder: ptr bgfx_encoder_s;
        tib: ptr bgfx_transient_index_buffer_t; firstIndex: uint32;
        numIndices: uint32)
    encoder_set_vertex_buffer*: proc (encoder: ptr bgfx_encoder_s; stream: uint8;
                                    handle: bgfx_vertex_buffer_handle_t;
                                    startVertex: uint32; numVertices: uint32)
    encoder_set_dynamic_vertex_buffer*: proc (encoder: ptr bgfx_encoder_s;
        stream: uint8; handle: bgfx_dynamic_vertex_buffer_handle_t;
        startVertex: uint32; numVertices: uint32)
    encoder_set_transient_vertex_buffer*: proc (encoder: ptr bgfx_encoder_s;
        stream: uint8; tvb: ptr bgfx_transient_vertex_buffer_t; startVertex: uint32;
        numVertices: uint32)
    encoder_set_vertex_count*: proc (encoder: ptr bgfx_encoder_s; numVertices: uint32)
    encoder_set_instance_data_buffer*: proc (encoder: ptr bgfx_encoder_s;
        idb: ptr bgfx_instance_data_buffer_t; start: uint32; num: uint32)
    encoder_set_instance_data_from_vertex_buffer*: proc (
        encoder: ptr bgfx_encoder_s; handle: bgfx_vertex_buffer_handle_t;
        startVertex: uint32; num: uint32)
    encoder_set_instance_data_from_dynamic_vertex_buffer*: proc (
        encoder: ptr bgfx_encoder_s; handle: bgfx_dynamic_vertex_buffer_handle_t;
        startVertex: uint32; num: uint32)
    encoder_set_instance_count*: proc (encoder: ptr bgfx_encoder_s;
                                     numInstance: uint32)
    encoder_set_texture*: proc (encoder: ptr bgfx_encoder_s; stage: uint8;
                              sampler: bgfx_uniform_handle_t;
                              handle: bgfx_texture_handle_t; flags: uint32)
    encoder_touch*: proc (encoder: ptr bgfx_encoder_s; id: bgfx_view_id_t)
    encoder_submit*: proc (encoder: ptr bgfx_encoder_s; id: bgfx_view_id_t;
                         handle: bgfx_program_handle_t; depth: uint32;
                         preserveState: bool)
    encoder_submit_occlusion_query*: proc (encoder: ptr bgfx_encoder_s;
        id: bgfx_view_id_t; program: bgfx_program_handle_t;
        occlusionQuery: bgfx_occlusion_query_handle_t; depth: uint32;
        preserveState: bool)
    encoder_submit_indirect*: proc (encoder: ptr bgfx_encoder_s; id: bgfx_view_id_t;
                                  handle: bgfx_program_handle_t; indirectHandle: bgfx_indirect_buffer_handle_t;
                                  start: uint16; num: uint16; depth: uint32;
                                  preserveState: bool)
    encoder_set_image*: proc (encoder: ptr bgfx_encoder_s; stage: uint8;
                            handle: bgfx_texture_handle_t; mip: uint8;
                            access: bgfx_access_t; format: bgfx_texture_format_t)
    encoder_set_compute_index_buffer*: proc (encoder: ptr bgfx_encoder_s;
        stage: uint8; handle: bgfx_index_buffer_handle_t; access: bgfx_access_t)
    encoder_set_compute_vertex_buffer*: proc (encoder: ptr bgfx_encoder_s;
        stage: uint8; handle: bgfx_vertex_buffer_handle_t; access: bgfx_access_t)
    encoder_set_compute_dynamic_index_buffer*: proc (encoder: ptr bgfx_encoder_s;
        stage: uint8; handle: bgfx_dynamic_index_buffer_handle_t;
        access: bgfx_access_t)
    encoder_set_compute_dynamic_vertex_buffer*: proc (encoder: ptr bgfx_encoder_s;
        stage: uint8; handle: bgfx_dynamic_vertex_buffer_handle_t;
        access: bgfx_access_t)
    encoder_set_compute_indirect_buffer*: proc (encoder: ptr bgfx_encoder_s;
        stage: uint8; handle: bgfx_indirect_buffer_handle_t; access: bgfx_access_t)
    encoder_dispatch*: proc (encoder: ptr bgfx_encoder_s; id: bgfx_view_id_t;
                           handle: bgfx_program_handle_t; numX: uint32;
                           numY: uint32; numZ: uint32; flags: uint8)
    encoder_dispatch_indirect*: proc (encoder: ptr bgfx_encoder_s;
                                    id: bgfx_view_id_t;
                                    handle: bgfx_program_handle_t; indirectHandle: bgfx_indirect_buffer_handle_t;
                                    start: uint16; num: uint16; flags: uint8)
    encoder_discard*: proc (encoder: ptr bgfx_encoder_s)
    encoder_blit*: proc (encoder: ptr bgfx_encoder_s; id: bgfx_view_id_t;
                       dst: bgfx_texture_handle_t; dstMip: uint8; dstX: uint16;
                       dstY: uint16; dstZ: uint16; src: bgfx_texture_handle_t;
                       srcMip: uint8; srcX: uint16; srcY: uint16; srcZ: uint16;
                       width: uint16; height: uint16; depth: uint16)
    request_screen_shot*: proc (handle: bgfx_frame_buffer_handle_t;
                              filePath: cstring)

  PFN_BGFX_GET_INTERFACE* = proc (version: uint32): ptr bgfx_interface_vtbl_t
