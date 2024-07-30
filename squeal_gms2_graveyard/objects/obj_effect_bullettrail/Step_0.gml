bullet_timer += ( 1 / 60 ) * delta;
bullet_amount = 1 - ( bullet_timer / bullet_duration );

if ( bullet_amount <= 0 )
{
	instance_destroy();
	exit;
}