event_inherited();

setPropHeight( 0 );

#macro MODE_PREV 0
#macro MODE_NEXT 1

Solid_SetFlags( BLOCK_OBJECTS );

active			= false;
entered			= false;
current_mode	= MODE_NEXT;
target_room		= noone;
prev_room		= noone;

teleport_x		= 0;
teleport_y		= 0;

siner			= 0;

arrow_sprite	= spr_icon_goarrow_generic;
arrow_xmove		= 0;
arrow_ymove		= 0;
arrow_intensity = 4;

orgx			= sprite_get_width( arrow_sprite ) / 2;
orgy			= sprite_get_height( arrow_sprite ) / 2;

image_speed		= 0;