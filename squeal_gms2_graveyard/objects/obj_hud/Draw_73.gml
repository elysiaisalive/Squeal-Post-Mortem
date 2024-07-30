init_camera_gui( 480, 270 );
inventoryMenu.Draw();
screen.DrawElements();
current_hud.DrawElements();

gpu_set_blendmode( bm_add );
//draw_sprite_ext( spr_noise, -1, 0, 0, camera_get_view_width( view_get_camera(view_current) ), camera_get_view_height( view_get_camera(view_current) ), 0, c_white, 1 );
gpu_set_blendmode( bm_normal );

#region TO BE UPDATED
// var c1 = #ff00c6;
// var c2 = #9200df;

// #region SlowMo Juice Bar
// var sSlow = spr_hud_joe_slometer_back;
// var _style = ( obj_player.stats.style / obj_player.stats.style_max );
// var w2 = sprite_get_width( sSlow );
// var h2 = sprite_get_height( sSlow );

// shader_set( shd_sinwave );

// var uniform = shader_get_uniform( shd_sinwave, "u_fTime" );
// var uniform2 = shader_get_uniform( shd_sinwave, "u_fIntensity" );
// var uniform3 = shader_get_uniform( shd_sinwave, "u_fWaveSize" );

// shader_set_uniform_f( uniform, current_time / 1000 );
// shader_set_uniform_f( uniform2, 0.10 );
// shader_set_uniform_f( uniform3, 80.0 );

// gpu_set_blendmode( bm_add );
// draw_sprite( spr_hud_joe_juicebar, 0, 0, joe_juicebary );
// gpu_set_blendmode( bm_normal );

// shader_reset();

// #endregion
// #region Bars
// draw_sprite_ext( spr_hud_joe_health, 0, 428, 171, 1, 1, 0, c_white, 1 ); // Outline

// var sHP = spr_hud_joe_health;
// var w = sprite_get_width( sHP );
// var h = sprite_get_height( sHP );
// var offx = sprite_get_xoffset( sHP );
// var offy = sprite_get_yoffset( sHP );

// var screen_w = camera_get_view_width( CURRENT_VIEW );
// var screen_h = camera_get_view_height( CURRENT_VIEW );

// if ( !surface_exists( overlay_surf ) )
// {
// 	overlay_surf = surface_create( screen_w, screen_h );
// }
// else
// {
// 	surface_set_target( overlay_surf );
// 	draw_clear_alpha( c_white, 0 );

// 	#region HP Juice
// 	draw_sprite_ext( spr_hud_joe_health, 1, 428, 171, 1, 1, 0, c_white, 1 ); // Silohuette

// 	var _hp = ( obj_player.stats.hp / obj_player.stats.hp_max );

// 	gpu_set_colorwriteenable( 1, 1, 1, 0 );
// 	shader_set( shd_sinwave );

// 	var uniform = shader_get_uniform( shd_sinwave, "u_fTime" );
// 	var uniform2 = shader_get_uniform( shd_sinwave, "u_fIntensity" );
// 	var uniform3 = shader_get_uniform( shd_sinwave, "u_fWaveSize" );

// 	shader_set_uniform_f( uniform, current_time / 1000 );
// 	shader_set_uniform_f( uniform2, 0.15 );
// 	shader_set_uniform_f( uniform3, 40.0 );

// 	gpu_set_blendmode( bm_add );
// 	draw_sprite_ext( spr_hud_joe_health_juice, 0, 428, 266, 1, _hp, 0, c_white, 1 );

// 	gpu_set_blendmode( bm_normal );

// 	gpu_set_colorwriteenable( 1, 1, 1, 1 );

// 	shader_reset();
// 	#endregion
// 	#region Slo Juice
// 	draw_sprite_ext( spr_hud_joe_slometer_back, 0, joe_syringeposx, joe_syringeposy, 1, 1, 0, c_white, 1 ); // Silohuette

// 	var _style = ( obj_player.stats.style / obj_player.stats.style_max );

// 	gpu_set_colorwriteenable( 1, 1, 1, 0 );
// 	shader_set( shd_sinwave );

// 	var uniform = shader_get_uniform( shd_sinwave, "u_fTime" );
// 	var uniform2 = shader_get_uniform( shd_sinwave, "u_fIntensity" );
// 	var uniform3 = shader_get_uniform( shd_sinwave, "u_fWaveSize" );

// 	shader_set_uniform_f( uniform, current_time / 1000 );
// 	shader_set_uniform_f( uniform2, 0.05 );
// 	shader_set_uniform_f( uniform3, 35.0 );

// 	gpu_set_blendmode( bm_add );
// 	draw_sprite_ext( spr_hud_joe_slometer_juice, 0, joe_syringeposx, joe_syringeposy2, 1, _style, 0, c_white, 1 );
// 	gpu_set_blendmode( bm_normal );

// 	gpu_set_colorwriteenable( 1, 1, 1, 1 );
// 	shader_reset();
// 	#endregion

// 	surface_reset_target();

// 	// top left, width and height, draw pos
// 	draw_surface( overlay_surf, 0, 0 );

// 	draw_sprite_ext( spr_hud_joe_slometer, joe_syringeindex, joe_syringeposx, joe_syringeposy, 1, 1, 0, c_white, 1 ); // SlowMo Overlay
// }
#endregion
