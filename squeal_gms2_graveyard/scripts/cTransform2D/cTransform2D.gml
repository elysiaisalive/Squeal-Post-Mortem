/* 
    A modified Transform2D Class.
    
    Position is a Vec3 purely for drawing and z buffer purposes!!!
*/
function cTransform2D() constructor {
    position = new Vector3( 0, 0, 0 );
    scale = new Vector2( 1, 1 );
    angle = 0;
    
    static Serialize = function() {
    	var _saveData = {
    		position : position,
    		scale : scale,
    		angle : angle
    	}
    	var _serializedData = SnapToJSON( _saveData );
    	
    	return _serializedData;
    }
    static Deserialize = function( data ) {
    	if ( is_undefined( data ) ) {
    		throw $"Data is undefined";
    	}
    	
        var _decodedData = SnapFromJSON( data );
        
    	try {
    	    position = new Vector3( _decodedData.position.x, _decodedData.position.y, _decodedData.position.z );
    	    scale = new Vector2( _decodedData.scale.x, _decodedData.scale.y );
    	    angle = _decodedData.angle;
    	}
    	catch(e) {
    		throw e;
    	}
    }
    
    static SetNewPos = function( x = 0, y = 0, z = 0 ) {
        position = new Vector3( x, y, z );
    }
    static Translate = function( deltaX, deltaY ) {
        position.x += deltaX;
        position.y += deltaY;
    }
    static Scale = function( scaleX, scaleY ) {
        scale.x *= scaleX;
        scale.y *= scaleY;
    }
    static Rotate = function( targetAngle, _rotateSpeed = 1 ) {
        return angle + clamp( angle_difference( targetAngle, angle ), -_rotateSpeed, _rotateSpeed );
    }
    static RotateTo = function( targetAngle, _rotateSpeed = 1 ) {
	    angle = Rotate( targetAngle, abs( angle_difference( targetAngle, angle ) * _rotateSpeed ) );
    }
    static Magnitude = function() {
        return sqrt( ( position.x * position.x ) + ( position.y * position.y ) );
    }
    static Normalize = function() {
		var _normalized = 1.0 / Magnitude();
		
		return {
			x : position.x * _normalized,
			y : position.y * _normalized
		};
    }
    static DotProduct = function( Vec, Vec2 ) {
        return ( Vec.x * Vec.x ) + ( Vec2.y * Vec2.y );
    }
    static DegToRad = function( degrees ) {
        return degrees * pi / 180;
    }
    static RadToDeg = function( radians ) {
        return radians * 180 / pi;
    }
}