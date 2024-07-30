event_inherited();

setPropHeight( 8 );

image_speed		= 0;

shadow_depth	= 1;

draw_under		= true

Solid_RemoveFlag( BLOCK_VISION | BLOCK_PROJECTILE | BLOCK_OBJECTS );

if ( image_index == 1 )
{
	spr_under = sprite_index;
	frame_under = 2;
}