function scrRegularLimbs(argument0 = false, argument1 = false) {
	var goredir;
	    goredir = point_direction(x, y, objExplosion.x, objExplosion.y) - 180
	repeat (8) {
	    puss=instance_create_layer(x, y, "Ground_Blood", objBloodSplat)
	        puss.speed=random_range(4,6)
	        puss.friction=0.5
	        puss.direction=random_range(0, 360)
	}
	repeat (4) {
	    blood=instance_create_layer(x, y, "Ground_Blood", objExplosionGore)
	        blood.sprite_index=sprBodyGore
	        blood.image_index=random(4)
	        blood.speed=random_range(6,9)
	        blood.friction=0.5
	        blood.direction=goredir+random_range(-35, 35)
	        blood.image_angle=objExplosionGore.direction
	}
	repeat (32) {
	    blood=instance_create_layer(x, y, "Ground_Blood", objExplosionGore)
	        blood.sprite_index=sprGutGore
	        blood.image_index=random(9)
	        blood.speed=random_range(6,10)
	        blood.friction=0.5
	        blood.direction=goredir+random_range(-35, 35)
	        blood.image_angle=objExplosionGore.direction
	}
	repeat (24) {
	    blood=instance_create_layer(x, y, "Ground_Blood", objExplosionGore)
	        blood.sprite_index=sprPigSkin
	        blood.image_index=random(6)
	        blood.speed=random_range(6,8)
	        blood.friction=0.5
	        blood.direction=goredir+random_range(-35, 35)
	        blood.image_angle=objExplosionGore.direction
	}
	{
	    blood=instance_create_layer(x, y, "Ground_Blood", objPigSkin)
	        blood.sprite_index=sprHeadGore
	        blood.image_index=random(4)
	        blood.speed=random_range(6,8)
	        blood.friction=0.5
	        blood.direction=+random_range(0, 360)
	        blood.image_angle=blood.direction+random_range(0, 360)
	}
	{
	    blood=instance_create_layer(x, y, "Ground_Blood", objPigSkin)
	        blood.sprite_index=sprHeadGore
	        blood.image_index=random(4)
	        blood.speed=random_range(6,8)
	        blood.friction=0.5
	        blood.direction=+random_range(0, 360)
	        blood.image_angle=blood.direction+random_range(0, 360)
	}
	repeat (2) {
	    puss=instance_create_layer(x, y, "Ground_Blood", objLimbs)
	        puss.sprite_index=(sprPig_Arms)
	        puss.image_index=random(3)
	        puss.speed=random_range(7,8)
	        puss.friction=0.5+random(0.2)
	        puss.direction=random_range(0, 360)
	        puss.image_angle=(360)+puss.direction
	}
	repeat (2) {
	    puss=instance_create_layer(x, y, "Ground_Blood", objLimbs)
	        puss.sprite_index=(sprPig_Legs)
	        puss.image_index=random(2)
	        puss.speed=random_range(7,8)
	        puss.friction=0.5+random(0.2)
	        puss.direction=random_range(0, 360)
	        puss.image_angle=(360)+puss.direction
	}



}
