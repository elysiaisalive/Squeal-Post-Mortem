event_inherited();

setPropHeight( 10, -35 );

hp = 50;

Solid_SetFlags( BLOCK_ALL );

on_break = function( xx, yy, dir ) // Called whenever the object is "destroyed"
{
	hp = 0;
	image_index = 1;
	
	global.shake = 5;
	playsound_at( snd_impact_character, xx, yy );
	
	#region Debris
	repeat( random_range( 4, 8 ) )
	{
		var inst = instance_create_depth( x + lengthdir_x( 8, image_angle ), y + lengthdir_y( 8, image_angle ), depth, obj_debris_generic );
		
		inst.sprite_index = spr_debris_drugs;
		inst.image_index = floor( random_range( 0, inst.image_number ) );
		inst.debris_spd = random_range( 2, 4 );
		inst.debris_frc = random_range( 0.080, 0.20 );
		inst.direction = image_angle - 180 + random_range( -45, 45 );
		inst.debris_dir = random_range( -360, 360 );
		inst.flying = true;
		inst.flyspeed = random_range( 8, 16 );
	};
	
	if ( irandom( 2 ) == 1 )
	{
		repeat( random_range( 1, 3 ) )
		{
    		var inst = instance_create_depth( x + lengthdir_x( 8, image_angle ), y + lengthdir_y( 8, image_angle ), depth, obj_debris_generic );
    		
    		inst.sprite_index = spr_debris_pillbottle;
    		inst.image_index = floor( random_range( 0, inst.image_number ) );
    		inst.debris_spd = random_range( 2, 4 );
    		inst.debris_frc = random_range( 0.080, 0.20 );
    		inst.direction = image_angle - 180 + random_range( -45, 45 );
    		inst.debris_dir = random_range( -360, 360 );
    		inst.flying = true;
    		inst.flyspeed = random_range( 8, 16 );   
    		
    		var inst = instance_create_depth( x + lengthdir_x( 8, image_angle ), y + lengthdir_y( 8, image_angle ), depth, obj_debris_generic );
    		
    		inst.sprite_index = spr_debris_pillcap;
    		inst.image_index = 0;
    		inst.debris_spd = random_range( 2, 4 );
    		inst.debris_frc = random_range( 0.080, 0.20 );
    		inst.direction = image_angle - 180 + random_range( -45, 45 );
    		inst.debris_dir = random_range( -360, 360 );
    		inst.flying = true;
    		inst.flyspeed = random_range( 8, 16 );
		};
		
		repeat( random_range( 24, 32 ) )
		{
     		var inst = instance_create_depth( x + lengthdir_x( 16, image_angle ), y + lengthdir_y( 16, image_angle ), depth, obj_debris_generic );
        		
        	inst.sprite_index = spr_debris_pills;
        	inst.image_index = floor( random_range( 0, inst.image_number ) );
        	inst.debris_spd = random_range( 1, 2 );
        	inst.debris_frc = random_range( 0.35, 0.40 );
        	inst.direction = image_angle - 180 + random_range( -45, 45 );
        	inst.bounce = true;
		};
	};
	
 	var inst = instance_create_depth( x + lengthdir_x( 8, image_angle ), y + lengthdir_y( 8, image_angle ), depth, obj_debris_generic );
		
	inst.sprite_index = spr_general_medcabinet_door;
	inst.image_index = floor( random_range( 0, inst.image_number ) );
	inst.debris_spd = random_range( 3, 4 );
	inst.debris_frc = random_range( 0.080, 0.20 );
	inst.direction = image_angle - 180 + random_range( -30, 30 );
	inst.debris_dir = random_range( -360, 360 );
	inst.flying = true;
	inst.flyspeed = random_range( 8, 12 );
	#endregion
};
on_melee_hit = function( xx, yy, dir )
{
	if ( hp > 0 )
	{
	    on_break( xx, yy, dir );
	    return true;
	};
};