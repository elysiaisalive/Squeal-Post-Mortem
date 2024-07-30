/// @param {number} x
/// @param {number} y
/// @param {object} projectile
/// @param {object} owner
/// @param {number} amount
/// @param {number} projectileVelocity
/// @param {number} initialAngle
/// @param {number} spreadAngle
/// @param {number} staggerSpeed
function spawnProjectile( x, y, projectileObject, ownerObject, projectileAmount, projectileVelocity, initialAngle, spreadAngle, staggerSpeed = 0 ) {
	repeat( projectileAmount ) {
		var inst = instance_create_depth( x, y, -HEIGHT.HEAD, projectileObject );
		
		inst.bullet.owner = ownerObject;
		inst.direction = initialAngle + random_range( -spreadAngle, spreadAngle );
		inst.bullet.velocity = projectileVelocity + random_range( -staggerSpeed, staggerSpeed );
		inst.image_angle = inst.direction;
	};
};