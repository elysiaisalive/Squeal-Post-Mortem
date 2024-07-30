function charDoBleedout() {
    if ( statuses.HasStatusEffect( "effectBleed" ) ) {
        bleedout = true;
        bleedout_timer -= 1 * delta;
    
        if ( bleedout_timer <= 0 ) {
        	var inst = instance_create_depth( x, y, -10, objBloodSpeck );
        	
        	inst.sprite_index = choose( spr_bloodsplatter_small, spr_bloodsplatter_tiny );
        	inst.image_index = random( image_number );
        	inst.x += random_range( -1.5, 1.5 );
        	inst.y += random_range( -1.5, 1.5 );
        	inst.image_angle = random( 360 );
        	
        	repeat( random_range( 1, 2 ) )
        	{
        		var inst = instance_create_depth( x, y, -10, obj_gore_generic );
        		
        		inst.sprite_index = choose( spr_bloodpools_tiny, spr_bloodpool_tiny );
        		inst.animated = true;
        		inst.done = false;
        		inst.advancespeed = random_range( 0.1, 0.2 );
        		inst.x += random_range( -2, 2 );
        		inst.y += random_range( -2, 2 );
        		inst.image_angle = random( 360 );
        	}
        	
        	repeat( random_range( 1, 8 ) )
        	{
        		var inst = instance_create_depth( x, y, -10, obj_gore_generic );
        		
        		inst.sprite_index = spr_bloodpool_tiny;
        		inst.animated = true;
        		inst.done = false;
        		inst.advancespeed = random_range( 0.1, 0.2 );
        		inst.x += random_range( -8, 8 );
        		inst.y += random_range( -8, 8 );
        		inst.image_angle = random( 360 );
        	}
        
        	bleedout_timer = choose( random_range( 5, 80 ), random_range( 5, 10 ) );
        
        // 	if ( CanBleedHP ) {
        // 		stats.hp -= stats.hp_bleedamount;
        // 	}
        	
        	if ( object_index == obj_player ) {
        		global.blood_lost += 5;
        		global.blood_lost = clamp( global.blood_lost, 0, 6400000 );
        		
        		if ( bleedout ) {
        			bleedout_a += 0.03;
        		}
        	
        		if ( hit_a >= 0 ) {
        			hit_a -= 0.05;
        			hit_a = clamp( hit_a, 0, 1 );
        		}
        	    }
            }
        }
}