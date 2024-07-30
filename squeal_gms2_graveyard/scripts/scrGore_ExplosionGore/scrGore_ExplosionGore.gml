/// @description scrNewGoreExplode(explosion_id, victim_id, is_close)
/// @param explosion_id
/// @param  victim_id
/// @param  is_close
function scrGore_ExplosionGore(argument0, argument1, argument2) {
	var explosion = argument0
	var victim = argument1
	var is_close = argument2

	if (is_close) {
	    // Gore for dying in the initial impact zone
	    repeat 2 {
	        var inst = scrGore_ExplosionGore_Part(victim, explosion, random_range(6, 9), sprPig_Arms);
	    }
	    repeat 2 {
	        var inst = scrGore_ExplosionGore_Part(victim, explosion, random_range(6, 12), sprPiggofd_Legs)
	    }
	    repeat 10 {
	        var inst = scrGore_ExplosionGore_Part(victim, explosion, random_range(6, 8), sprPigSkin)
	    }
	    repeat 2 {
	        var inst = scrGore_ExplosionGore_Part(victim, explosion, random_range(6, 12), sprHeadGore)
	    }
	    repeat 4 {
	        var inst = scrGore_ExplosionGore_Part(victim, explosion, random_range(6, 8), sprBodyGore)
	    }
	    repeat 18 {
	        var inst = scrGore_ExplosionGore_Part(victim, explosion, random_range(8, 12), sprGutGore)
	    }
	}
	else {
	    // Gore for dying to the shockwave
	    var type = irandom(0)
	    switch type {
			//Legs Gone / Blown off
	        case 0:
	            var inst = instance_create_depth(victim.x, victim.y, -7, objExplosionGore);
	            var dir = point_direction(explosion.x, explosion.y, victim.x, victim.y);
	            var dis = point_distance(explosion.x, explosion.y, victim.x, victim.y);
	            var amount = (1 - clamp((dis - 24) / (explosion.shockwave_size * 2), 0, 1)) * random_range(6, 12);
	            inst.image_index = 0
				inst.sprite_index = sprEPigDeadLegless
	            inst.direction = dir
	            inst.image_angle = inst.direction
	            inst.gore_spd = amount
				inst.gore_frc = 0.5
            
	            repeat 2 {
	                var inst = scrGore_ExplosionGore_Part(victim, explosion, random_range(6, 9), sprBodyGore);
	            }
	            repeat 2 {
	                var inst = scrGore_ExplosionGore_Part(victim, explosion, random_range(6, 8), sprPig_Legs)
	            }
	            repeat 16 {
	                var inst = scrGore_ExplosionGore_Part(victim, explosion, random_range(6, 10), sprGutGore)
	            }
	            repeat 12 {
	                var inst = scrGore_ExplosionGore_Part(victim, explosion, random_range(6, 8), sprPigSkin)
	            }
            
	            break
	    }
	}



}
