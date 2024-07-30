var dist = point_distance( x, y, obj_player.x, obj_player.y );

if ( ( dist <= 16 ) && ( keyboard_check_direct( global.inputs.key_secondary ) ) )
{
	item.OnInteract();
};

if ( item.IsAnimated )
{
	item.item_imageindex += item.item_anim_spd * delta;
};