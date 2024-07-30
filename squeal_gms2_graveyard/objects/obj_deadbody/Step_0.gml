event_inherited();

if ( ( gore_spd <= 0 ) && create_bloodpool && !bloodpool_created )
{
	_inst = instance_create_depth( x, y, -1, obj_gore_generic );
	_inst.x = x + lengthdir_x( 4, _inst.image_angle );
	_inst.y = y + lengthdir_y( 4, _inst.image_angle );
	_inst.sprite_index = spr_bloodpool_large;
	_inst.animated = true;
	_inst.image_angle = random( 360 );
	_inst.advancespeed = random_range( 0.1, 0.2 );
	_inst.done = false;
	
	bloodpool_created = true;
}