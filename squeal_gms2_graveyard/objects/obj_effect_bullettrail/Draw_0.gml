if ( instance_exists( parent_inst ) ) {
	x = parent_inst.x;
	y = parent_inst.y;
}

if ( !surface_exists( appsurf ) ) {
	surface_depth_disable( true );
	appsurf = surface_create( appsurf_size, appsurf_size );
}

direction = point_direction( bullet_xstart, bullet_ystart, x, y );

surface_set_target( appsurf );
draw_clear( c_black );
draw_surface_stretched( application_surface, 0, 0, appsurf_size, appsurf_size );
surface_reset_target();

var size = bullet_size / 2.0;

var xadd = dcos( direction + 90 ) * ( size );
var yadd = - dsin( direction + 90 ) * ( size );

var xadd2 = dcos( direction + 270 ) * ( size );
var yadd2 = - dsin( direction + 270 ) * ( size );

// assuming it is being fired directly upwards

// top left
var x1 = x + xadd2;
var y1 = y + yadd2;

// top right
var x2 = x + xadd;
var y2 = y + yadd;

// bottom left
var x3 = lerp( x, bullet_xstart, 1 ) + xadd2 ;
var y3 = lerp( y, bullet_ystart, 1 ) + yadd2 ;

// bottom right
var x4 = lerp( x, bullet_xstart, 1 ) + xadd;
var y4 = lerp( y, bullet_ystart, 1 ) + yadd;

var blend = merge_color( c_black, merge_color( c_black, c_white, min( ( 1 - bullet_amount ) * 2, 1 ) ), bullet_amount * ( 1 - delta * 0.9 ) );

shader_set( shd_bullettrail );
shader_set_uniform_f( u_fTime, current_time / 1000 );
texture_set_stage( u_pAppSurf, surface_get_texture( appsurf) );

gpu_push_state();
gpu_set_cullmode( cull_noculling );
draw_primitive_begin_texture( pr_trianglestrip, -1 );
draw_vertex_texture_color( x1, y1, 0, 1, c_black, 1 );
draw_vertex_texture_color( x, y, 1, 1, blend, 1 );
draw_vertex_texture_color( x3, y3, 0, 0, c_black, 1 );
draw_vertex_texture_color( bullet_xstart, bullet_ystart, 1, 0, blend, 1 );
draw_primitive_end();

draw_primitive_begin_texture( pr_trianglestrip, -1 );
draw_vertex_texture_color( x, y, 1, 1, blend, 1 );
draw_vertex_texture_color( x2, y2, 0, 1, c_black, 1 );
draw_vertex_texture_color( bullet_xstart, bullet_ystart, 1, 0, blend, 1 );
draw_vertex_texture_color( x4, y4, 0, 0, c_black, 1 );
draw_primitive_end();

shader_reset();
gpu_pop_state();