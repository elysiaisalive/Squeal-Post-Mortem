function spawn_muzzleflash( flash_index = -1, flash_speed = 0.5, flash_angle = charLookDir, _id = noone, xx, yy )
{
	var inst = instance_create_depth( x + lengthdir_x( xx, flash_angle ), y + lengthdir_y( yy, flash_angle ), -15, obj_muzzleflash );
	
	inst.sprite_index = flash_index;
	inst.flash_speed = flash_speed;
	inst.direction = flash_angle;
	inst.flash_angle = inst.direction;
	inst.shooter_id = _id;
};