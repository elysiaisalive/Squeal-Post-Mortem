var surf = obj_ui_choice.draw_surf;

if ( surface_exists( surf ) )
{
	surface_set_target( surf );
	draw_sprite_ext( sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha );
	surface_reset_target();
	
	instance_destroy();
}