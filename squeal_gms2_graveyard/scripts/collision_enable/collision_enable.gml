function collision_enable( range = 64, _lookfor = BLOCK_MOVEMENT, check_3d = true, _entity = self.id ) {
	
	instance_deactivate_object( obj_solid );
	instance_activate_region( _entity.x - range, _entity.y - range, range * 2, range * 2, true );
	
	with ( obj_solid )
	{
		if ( check_3d 
		&& !ignore3DCollisions )
		{
			if ( other.z < ( z - height ) )
			|| ( ( other.z - other.height ) > z )
				instance_deactivate_object( id );
		};
		try 
		{
			solid = ( Solid_GetFlag( _lookfor ) );
		}
		catch( e ) 
		{
			solid = true;
		}
	};
};