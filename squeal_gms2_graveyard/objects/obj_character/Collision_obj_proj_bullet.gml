instance_destroy(other)
if hp_armor <= 0 {
#region HP Hit
global.stats.DamageTaken += other.hp_damage
global.stats.BloodLost += 5
hp -= other.hp_damage
hit_a ++

var inst = instance_create_depth(x, y, -10, objBloodSpeck)
inst.sprite_index = spr_bloodsplatter_small
inst.x += random_range(1, 2)
inst.y += random_range(1, 2)
inst.image_index = random(5)
inst.image_angle = random(360)

var inst = instance_create_depth(x, y, -10, objBloodSmudge)
inst.sprite_index = spr_bloodsplatter_med
inst.image_index = random(3)
inst.gorespeed = random_range(3, 4)
inst.gorefric = random_range(0.5, 0.8)
inst.direction = random(360)
inst.image_angle = inst.direction + (360)

scr_spawn_particle(
	objSpark1,
	spr_bloodspray,
	2,
	x + lengthdir_x(8, image_angle - 180),
	y + lengthdir_y(8, image_angle - 180),
	random_range(4, 6), 
	random_range(0.3, 0.6), 
	60,
	random(360)
	)
scr_playsound(choose(snd_gore_hit, snd_gore_hit2))
#endregion
}else{
#region Armor Hit
hp_armor -= other.hp_damage
global.stats.DamageTaken += other.hp_damage
scr_playsound(choose(snd_armor_hit, snd_armor_hit2, snd_armor_hit3))

if hp_armor <= 25
	scr_playsound(sndGlass1)

scr_spawn_particle(
	objSpark1,
	sprSmokeHit,
	2,
	x + lengthdir_x(8, image_angle - 180),
	y + lengthdir_y(8, image_angle - 180),
	random_range(4, 6), 
	random_range(0.3, 0.6), 
	60,
	random(360)
	)
}
#endregion
hp = clamp(hp, 0, hp_max)
hp_armor = clamp(hp_armor, 0, hp_armor_max)