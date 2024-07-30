function spawn_shell(shell_obj = obj_shellcasing, shell_sprite = spr_debris_bullet, shell_index = 0, shell_dir = charLookDir, _sound = snd_shellcasing_small, _left = left) {
	var inst = instance_create_depth(x + lengthdir_x(5, shell_dir - 5 * shell_dir), y + lengthdir_y(5, shell_dir - 5 * _left), random_range( -30, -50 ), obj_shellcasing);
	inst.shell_sprite = shell_sprite;
	inst.shell_index = shell_index;
	inst.shell_spd = random_range(3, 4);
	inst.shell_frc = random_range(0.6, 0.8);
	inst.sound = _sound;
	inst.direction = shell_dir - 90 * _left - 20 + random_range( -20, 20 );
	inst.image_angle = random(360);
	inst.zsp = -random( 3 );
}