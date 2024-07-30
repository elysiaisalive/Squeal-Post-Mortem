switch(wallmat) {
	case wallmat.wallmat_drywall:
		instance_destroy();
		break;
	case wallmat.wallmat_brick:
		instance_destroy();
		break;
	case wallmat.wallmat_metal:
		objProj_Bullet.bullet_velocity = -objProj_Bullet.bullet_velocity
		break;
}