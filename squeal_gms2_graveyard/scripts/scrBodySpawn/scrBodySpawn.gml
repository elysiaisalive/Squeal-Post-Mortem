function scrBodySpawn() {
	edir = objEnemy.direction
	dead = instance_create_depth(x, y, -10, objDeadBody)
	dead.sprite_index = sprJoeDeadShotgun
	dead.gore_spd = 2
	dead.gore_frc = 0.2
	dead.direction = edir + 40 - random(80)
	dead.image_angle = dead.direction
}