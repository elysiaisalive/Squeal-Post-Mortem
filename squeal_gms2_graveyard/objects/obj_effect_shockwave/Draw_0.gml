var x1 = x - ( shockwave_size * shockwave_amount );
var x2 = x + ( shockwave_size * shockwave_amount );
var y1 = y - ( shockwave_size * shockwave_amount );
var y2 = y + ( shockwave_size * shockwave_amount );

if ( !surface_exists( appsurf ) )
{
	surface_depth_disable( true );
	appsurf = surface_create( appsurf_size, appsurf_size );
}

surface_set_target( appsurf );
draw_clear( c_black );
draw_surface_stretched( application_surface, 0, 0, appsurf_size, appsurf_size );
surface_reset_target();

shader_set( shd_shockwave );

shader_set_uniform_f( u_fTime, current_time / 1000 );
texture_set_stage( u_pAppSurf, surface_get_texture( appsurf) );
texture_set_stage( u_pDistortionMap, sprite_get_texture( spr_effect_shockwave, 0 ) );

texture_set_interpolation_ext( u_pAppSurf, true );
texture_set_interpolation_ext( u_pDistortionMap, true );


draw_set_color( merge_color( shockwave_intensity, c_black, shockwave_amount ) );
draw_primitive_begin_texture( pr_trianglestrip, -1 );
draw_vertex_texture( x1, y1, 0, 0 );
draw_vertex_texture( x2, y1, 1, 0 );
draw_vertex_texture( x1, y2, 0, 1 );
draw_vertex_texture( x2, y2, 1, 1 );
draw_primitive_end();

shader_reset();
texture_set_interpolation( false );