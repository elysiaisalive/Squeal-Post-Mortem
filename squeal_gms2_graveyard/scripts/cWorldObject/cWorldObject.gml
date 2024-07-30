/// @self {object|cWorldObject}
function cWorldObject( instanceRef ) class {
    self.entityName = "";
    self.__self = instanceRef; // The Object in the room that this class is instanced to.
    self.active = true;
    self.flags = new cFlags();
    self.collisionShape = COLLISION_SHAPE.BOX;
    
    self.parent = noone;
    self.children = [];
    self.components = {};
    
    self.inheritParentPhysics = false;
    self.thinkInterval = 60 / 1000;
    
    #region Setters
    static SetName = function( nameString ) {
        if ( !is_string( nameString ) ) {
            throw $"entityName must be a string!";
        }
        
        entityName = nameString;
        return self;
    } 
    #endregion
    #region Object Methods
    static RoomStart = function(){};
    static RoomEnd = function(){};
    static Init = function(){};
    static TickBegin = function (){};
    static Tick = function (){};
    static TickEnd = function (){};
    static Draw = function (){};
    static Cleanup = function(){};
    static Destroy = function(){};
    static Serialize = function() {};
    static Deserialize = function( encodedData ) {};
    #endregion
    #region Collision Methods
    static IsColliding = function( _entity, _position ) {
    	var _collidingEntity = false;
    	
    	switch( collisionShape ) {
    		case COLLISION_SHAPE.BOX :
    			_collidingEntity = collision_rectangle( __self.bbox_left - 2, __self.bbox_top - 2, __self.bbox_right + 2, __self.bbox_bottom + 2, _entity, false, true );
    			break;		
    		case COLLISION_SHAPE.CIRCLE :
    			var _collisionMask = mask_index;
    			var _maskWidth = sprite_get_width( _collisionMask );
    			var _maskHeight = sprite_get_height( _collisionMask );
    			var _collisionDimensions = _maskWidth / 2 + _maskHeight / 2;
    			
    			_collidingEntity = collision_circle( _position.x, _position.y, _collisionDimensions, _entity, false, true );
    			break;
    		default : 
    			_collidingEntity = collision_rectangle( __self.bbox_left, __self.bbox_top, __self.bbox_right, __self.bbox_bottom, _entity, false, true );
    			break;
    	}
    	
    	if ( _collidingEntity ) {
    		return true;
    	}
    }
    static IsInRadius = function( _entity, _radius = 64 ) {
    	var _collidingEntity = false;
    	var _position = __self.GetTransform().position;
    
    	_collidingEntity = collision_circle( _position.x, _position.y, _radius, _entity, false, true );
    	
    	if ( _collidingEntity ) {
    		return true;
    	}
    }
    #endregion
    #region Components
    /// @param {struct} component
    static AddComponent = function( component ) {
        if ( is_struct( component ) ) {
            print( "Component is not component!" );
            return;
        }
        
        var _componentName = instanceof( component );
        
        components[$ _componentName] = component;
        return self;
    }
    /// @param {string} componentName
    static GetComponent = function( componentName ) {
        return components[$ componentName];
    }
    #endregion
    
    /// @param {instance} childObject
    /// @returns {void}
    static AddChild = function( childObject ) {
        if ( childObject != instance ) {
            show_error( $"Cannot add new child : {childObject} as it is not a valid instance!", true );
            return;
        }
        
        for( var i = 0; i < argument_count; ++i ) {
            array_push( self.children, argument[i] );
        }
    }

    /// @desc Runs 'Tick' on each child instance and also removes the reference if the child suddenly stops existing
    static UpdateChildren = function() {
        if ( array_length( self.children ) > 0 ) {
            for( var i = 0; i < array_length( self.children ); ++i ) {
                // If the child instance suddenly stops existing, remove the entry
                if ( !instance_exists( children[i] ) ) {
                    array_delete( children, i, 1 );
                }
                
                children[i].Tick();
            }
        }
    }
    
    /// @param {instance} user The object reference that is going to be interacting with the object
    /// @returns {void}
    static Interact = function( user ) {
        if ( instance_exists( user ) ) {
            with( user.id ) {
                other.OnInteract();
            }
        }
        
        return;
    };
    
    static Think = function() {};
    
    static StopThink = function() {
        //call_cancel( self.thinkFuncHandle );
    }
    
    /// @desc REDFINE THIS WHEREVER YOU WANT! Callback that gets invoked when Interact() is called. Used for entity to object interaction.
    static OnInteract = function(){};
    
    /// @desc This function is invoked when it is triggered
    static Trigger = function(){};
    
    static OnTrigger = function(){};
};