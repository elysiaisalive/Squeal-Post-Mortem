if ( !IDE_MODE )
{
	if ( irandom( 64 ) == 1 )
	{
		room_goto( rm_ );
	}
	else
	{
		instance_destroy();
	}
}
else
{
	instance_destroy();
}