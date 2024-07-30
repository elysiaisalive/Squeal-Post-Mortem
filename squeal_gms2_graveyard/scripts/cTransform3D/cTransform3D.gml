function cTransform3D() constructor {
    self.origin = new Vector3( 0, 0, 0 );
    self.rotation = new Vector3( 0, 0, 0 );
    self.scale = new Vector3( 0, 0, 0 );
    
    static SetNewPos = function( x = 0, y = 0, z = 0 ) {
        self.origin = new Vector3( x, y, z );
    }
}