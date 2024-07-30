function spawn_particle(
	particle_obj = obj_particle_generic, 
	particle_sprite = FALLBACK_SPRITE,
	animspd = 0.30,
	particle_dir,
	particle_angle,
	particle_alpha = 1,
	p_x = 0,
	p_y = 0, 
	particle_spd = 0,
	particle_frc = 0, 
	particle_scale = 1,
	_fade = false,
	follow_dir = false,
	depth = -45,
	animated = true,
	fadespeed = 0.01
	)
	{
	if ( object_exists( obj_particle_generic ) )
	{
		{
			var inst = instance_create_depth( p_x, p_y, depth, particle_obj );
			
			inst.sprite_index		= particle_sprite;
			inst.particle_scale 	= particle_scale;
			inst.anim_spd			= animspd;
			inst.particle_spd 	= particle_spd;
			inst.particle_frc	= particle_frc;
			inst.fadespeed			= fadespeed;
			inst.direction			= particle_dir;
			inst.image_angle		= particle_angle;
			
			if ( follow_dir )
			{
				inst.image_angle = particle_dir;
			}
			
			inst.particle_alpha = particle_alpha;
			inst.fade = _fade;
		}
	}
}