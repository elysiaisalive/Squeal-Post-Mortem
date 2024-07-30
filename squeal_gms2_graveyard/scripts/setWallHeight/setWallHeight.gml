function setWallHeight( wall_height = 64 ) {
	if ( !variable_instance_exists( self.id, "z" ) ) {
		z = depth;
	}
	
	self.height = wall_height;
	self.depth = ( self.z - wall_height );
}