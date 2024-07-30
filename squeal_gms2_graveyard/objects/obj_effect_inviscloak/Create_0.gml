// Create

z = 0;

shockwave_intensity = c_white;
appsurf = -1;
appsurf_size = 1024;

// uniforms
u_fTime = shader_get_uniform( shd_shockwave, "u_fTime" );
u_pAppSurf = shader_get_sampler_index( shd_shockwave, "u_pAppSurf" );
u_pDistortionMap = shader_get_sampler_index( shd_shockwave, "u_pDistortionMap" );


//shockwave
shockwave_size = 48; // how big the effect is



// gms2 
texture_set_repeat = gpu_set_texrepeat;
texture_set_interpolation = gpu_set_texfilter;
texture_set_repeat_ext = gpu_set_texrepeat_ext;
texture_set_interpolation_ext = gpu_set_texfilter_ext;
