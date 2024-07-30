/// @desc Player Height is 50 by default.
function setPropHeight( height = 24, forced_z = undefined ) {
	if ( !variable_instance_exists( self.id, "z" ) ) {
		self.z = depth;
	}
	
	if ( forced_z != undefined ) {
		self.z = forced_z;
	}
	
	self.height = height;
	self.depth = ( self.z - self.height );
}