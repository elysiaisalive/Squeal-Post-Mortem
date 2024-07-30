function scrBloodSplosion(argument0, argument1) {
	var puss;
	//Initial Splat
	puss=instance_create_depth(x, y, -7, objBloodSplosion)
		puss.image_xscale=2+random(0.5)
		puss.image_yscale=puss.image_xscale
		puss.image_angle = random_range(0 , 360)
	repeat (12) {
		puss=instance_create_depth(x, y, -10, objPussSplat)
		puss.gore_spd=random_range(6, 8)
		puss.gore_frc=random_range(0.4, 0.6)
		puss.direction=random_range(0, 360)
		puss.image_angle=(360)+puss.direction
	}
	repeat (22) {
		puss=instance_create_depth(x, y, -10, objPussSplat)
		puss.sprite_index = choose(sprPussSplat1,sprPussSplat2)
		puss.gore_spd=random_range(6, 8)
		puss.gore_frc=random_range(0.4, 0.6)
		puss.direction=random_range(0, 360)
		puss.image_angle=(360)+puss.direction
	}
	repeat (32){
		puss=instance_create_depth(x, y, -10, objFatPuss)
		puss.gore_spd=random_range(6, 8)
		puss.gore_frc=random_range(0.4, 0.6)
		puss.direction=random_range(0, 360)
		puss.image_angle=(360)+puss.direction
	}
	repeat (6) {
		puss=instance_create_depth(x, y, -10, obj_gore_blood_splat)
		puss.sprite_index = choose(sprBloodSplat2, sprBloodSplat4, sprBloodSplat5)
		puss.gore_spd=4+random(1)
		puss.gore_frc = 0.4
		puss.direction=random_range(0, 360)
	}
	repeat (48) {
		puss=instance_create_depth(x, y, -10, objBloodWave)
		puss.sprite_index = choose(sprBloodWave1, sprBloodWave2, sprBloodWave3)
		puss.gore_spd = random_range(8, 10)
		puss.gore_frc = 0.6
		puss.direction = random_range(0, 360)
		puss.image_angle=(360)+puss.direction
	}
	repeat (4) {
		puss=instance_create_depth(x, y, -10, objPussSplat)
		puss.sprite_index = choose(sprPussSplat1,sprPussSplat2)
		puss.gore_spd=random_range(6, 8)
		puss.gore_frc=random_range(0.4, 0.6)
		puss.direction=random_range(0, 360)
		puss.image_angle=(360)+puss.direction
	}
}