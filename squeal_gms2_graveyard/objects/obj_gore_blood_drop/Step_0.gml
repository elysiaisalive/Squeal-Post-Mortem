event_inherited();

if ( ( gore_spd <= 0 ) || done )
{
	var inst = instance_create_depth( x, y, -15, obj_gore_blood_splat );
	inst.sprite_index = choose( sprBloodSplat, sprBloodSplat3, sprBloodSplat4, sprBloodSplat5 );
	inst.advancespeed = random_range( 0.1, 0.3 );
	inst.done = false;
	inst.animated = true;
	inst.image_angle = random_range( -360, 360 );
	
	instance_destroy();
}