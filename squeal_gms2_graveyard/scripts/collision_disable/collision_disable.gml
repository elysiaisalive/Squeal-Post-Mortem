function collision_disable() {
	with ( obj_solid )
	{
		solid = false;
	};
	
	instance_activate_object( obj_solid );
};