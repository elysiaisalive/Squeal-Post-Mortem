bullet.velocity -= bullet.frc * delta;
bullet.velocity = clamp( bullet.velocity, 0, bullet.maxvelocity );
bullet.life = max( 0, bullet.life - 1 * delta );

x += dcos( direction ) * bullet.velocity * delta;
y -= dsin( direction ) * bullet.velocity * delta;

if ( bullet.life <= 0 )
{
	bullet.OnLifeEnd();
	instance_destroy();
};