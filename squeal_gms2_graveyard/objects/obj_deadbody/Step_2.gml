if ( ( gore_spd <= 0 ) && create_bloodpool )
{
	if ( !instance_exists( _inst ) )
	{
		done = true;
	}
	else
	{
		done = false;
	}
}