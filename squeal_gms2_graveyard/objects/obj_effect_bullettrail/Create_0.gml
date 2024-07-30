// Create

appsurf = -1;
appsurf_size = 1024;

// uniforms
u_fTime = shader_get_uniform( shd_bullettrail, "u_fTime" );
u_pAppSurf = shader_get_sampler_index( shd_bullettrail, "u_pAppSurf" );


// bullet
parent_inst = noone;
bullet_xstart = x;
bullet_ystart = y;

bullet_duration = 0.4;
bullet_timer = 0;
bullet_amount = 1;
bullet_size = 6;


// gms2 
texture_set_repeat = gpu_set_texrepeat;
texture_set_interpolation = gpu_set_texfilter;
texture_set_repeat_ext = gpu_set_texrepeat_ext;
texture_set_interpolation_ext = gpu_set_texfilter_ext;
