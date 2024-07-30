#region Wall Collision Properties
switch (wall_mat) {
	case wallmat.wallmat_brick:
		instance_destroy(other);
		break;
		
	case wallmat.wallmat_drywall:
		instance_destroy(other);
		scr_spawn_particle(objSpark1, 8, x + lengthdir_x(8, image_angle - 180 + direction),
			y + lengthdir_y(8, image_angle - 180 + direction), random_range(4, 6) - other.direction, 0.1, 10, direction - random(360))
		break;
	
	case wallmat.wallmat_glass:
		break;
		
	case wallmat.wallmat_metal:
		instance_destroy(other);
		repeat (8) {
		scr_spawn_particle(objSpark1, 8, other.x, other.y, random_range(6, 8) - other.direction , 0.1, 10, -other.direction + random(360))
		}
		break;
}
#endregion