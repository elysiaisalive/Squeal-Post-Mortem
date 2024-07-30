event_inherited();

char_derby();

rolling = false;

on_proj_hit = function()
{
	playsound( snd_gore_hit2 );
	
	repeat( random_range( 12, 16 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_gore_generic );
		inst.sprite_index = spr_bloodspeck_med;
		inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
		inst.done = false;
		inst.gore_spd = random_range( 2, 6 );
		inst.gore_frc = random_range( 0.4, 0.5 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
	}
	
	repeat( random_range( 2, 4 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_gore_blood_drop );
		inst.sprite_index = spr_blood_drop;
		inst.done = false;
		inst.advancespeed = random_range( 0.1, 0.3 );
		inst.gore_spd = random_range( 2, 6 );
		inst.gore_frc = random_range( 0.4, 0.5 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
	}
	
	repeat( random_range( 1, 2 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_gore_generic )
		inst.sprite_index = spr_gore_fleshchunkhuman;
		inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
		inst.gore_spd = random_range( 4, 6 );
		inst.gore_frc = random_range( 0.3, 0.5 );
		inst.done = false;
		inst.splat = true;
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
	}
	
	global.shake = 8;
};
on_proj_hit_armour		= function()
{		
	#region Particles
	var _lenx = lengthdir_x( 14, proj_hit_id.direction );
	var _leny = lengthdir_y( 14, proj_hit_id.direction );
	
	repeat( random_range( 6, 8 ) )
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_spark_armour,
			0.4,
			proj_hit_id.direction - 180 + random_range( -30, 30 ),
			0,
			1,
			x - _lenx,
			y - _leny,
			random_range( 4, 6 ), 
			random_range( 0.3, 0.6 ),
			1,
			false,
			true,
			-95,
			true
			);
	}
	#endregion
};
on_armour_break		= function()
{
	playsound_at( snd_impact_character, x, y );
	DrawMask = false;
	
	var inst = instance_create_depth( x, y, -18, obj_derbyhelmet )
	inst.sprite_index = sprDerby_Helmet_Shot;
	inst.junk_spd = random_range( 3, 4 );
	inst.junk_fric = random_range( 0.1, 0.2 );
	inst.direction = proj_hit_id.direction;
					
	#region Particles
	repeat( random_range( 6, 8 ) )
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_spark,
			0.6,
			random_range( -360, 360 ),
			0,
			1,
			x,
			y,
			random_range( 4, 6 ), 
			random_range( 0.3, 0.6 ),
			1,
			false,
			true,
			-95,
			true
			);
		spawn_particle(
			obj_particle_generic,
			spr_effect_smoke_tiny3,
			0.1,
			random_range( -360, 360 ),
			0,
			1,
			x + random_range( -16, 16 ),
			y + random_range( -16, 16 ),
			random_range( 1, 3 ), 
			random_range( 0.2, 0.3 ),
			1,
			true,
			true,
			-95,
			true
			);
	}
	
	spawn_particle(
		obj_particle_generic,
		spr_effect_shatter,
		0.3,
		0,
		0,
		1,
		x,
		y,
		0, 
		0,
		1,
		true,
		true,
		-255,
		true
		);
	#endregion
};