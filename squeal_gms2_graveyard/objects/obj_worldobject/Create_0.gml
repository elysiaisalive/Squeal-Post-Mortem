entityID = 0;

z = 0;
collision_flags = -1;
flags = new cFlags();
z_init	= false;
height	= 24;
stats = {
	hp			: 0,
	hp_max		: 0,
	armour		: 0,
	armour_max	: 0
}

/// @self {obj_worldobject}
transform = new cTransform2D();
transform.SetNewPos( x, y, depth );
transform.scale.x = image_xscale;
transform.scale.y = image_yscale;

GetTransform = function() {
	return transform;
}

__self = new cWorldObject( self.id );
__self.SetName( entityName );

currentFaction		= FACTION.NONE;
currentState = -1;
isTangible = true;
isVulnerable = false;
isValidLockonTarget = false;

// This is the name that will be referenced by buttons, actors and other objects that need to access SPECIFIC objects of one type in a room i.e a button.
ent_name			= "";
// Empty function that will be called by other objects when needed.
TriggerEvent = function(){};

// // Empty struct for Save Data.
// saveData = {};

// InitSaveData = function( dataToSave ) {
// }

Serialize = function( _saveData ) {
    var _encodedData = SnapToJSON( _saveData );
    
    return _encodedData;
}
Deserialize = function( encodedData ) {
	var _decodedData = SnapFromJSON( encodedData );
	
	if ( is_undefined( _decodedData ) ) {
		return;
	}
	
	return _decodedData;
} 

collisionShape = COLLISION_SHAPE.BOX;

GetBboxSize = function() {
	var _size = ( bbox_left + bbox_top ) + ( bbox_right + bbox_bottom );
	
	return _size;
}
IsColliding = function( _entity ) {
	var _collidingEntity = false;
	
	switch( collisionShape ) {
		case COLLISION_SHAPE.BOX :
			_collidingEntity = collision_rectangle( bbox_left - 2, bbox_top - 2, bbox_right + 2, bbox_bottom + 2, _entity, false, true );
			break;		
		case COLLISION_SHAPE.CIRCLE :
			var _collisionMask = mask_index;
			var _maskWidth = sprite_get_width( _collisionMask );
			var _maskHeight = sprite_get_height( _collisionMask );
			var _collisionDimensions = _maskWidth / 2 + _maskHeight / 2;
			
			_collidingEntity = collision_circle( x, y, _collisionDimensions, _entity, false, true );
			break;
		default : 
			_collidingEntity = collision_rectangle( bbox_left, bbox_top, bbox_right, bbox_bottom, _entity, false, true );
			break;
	}
	
	if ( _collidingEntity ) {
		return true;
	}
}
IsInRadius = function( _entity, _radius = 64 ) {
	var _collidingEntity = false;
	var _position = transform.position;

	_collidingEntity = collision_circle( _position.x, _position.y, _radius, _entity, false, true );
	
	if ( _collidingEntity ) {
		return true;
	}
}

ChangeState = function( _newstate = sNullState, _func = -1 ) {
	currentState = _newstate;
	currentState.InitState( _newstate );
	
	if ( _func != -1 ) {
		_func();
	}
};

Draw3D = function()
{
	draw_self();
}