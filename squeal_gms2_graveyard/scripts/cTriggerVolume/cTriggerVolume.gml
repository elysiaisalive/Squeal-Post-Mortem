/// @self {object|cTriggerVolume}
function cTriggerVolume( instanceRef ) extends cWorldObject( instanceRef ) class {
    #region Private
    __defaultTriggerTarget = "obj_player";
    __triggerTargetInstance = asset_get_index( __defaultTriggerTarget );
    #endregion
    #region Trigger Properties
    enabled = true;
    isInside = false;
    hasTouched = false; // If the entity has touched the trigger AT ALL
    triggerSprite = spr_trigger;
    flags.SetFlag( TRIGGER_FLAGS.FL_TRIGGER_ONCE );
    #endregion
    #region Class Methods
    static Enable = function() {
        enabled = true;
        return self;
    }
    static Disable = function() {
        enabled = false;
        return self;
    }
    static Toggle = function() {
        enabled = !enabled;
        return self;
    }
    static OnEnterVolume = function() {} // Executed when triggerTarget enters volume
    static InVolume = function() {} // Executed while triggerTarget is in volume
    static OnExitVolume = function() {} // Executed when triggerTarget exits volume
    static SetTriggerTarget = function( target ) {
        if ( is_string( target ) ) {
            var _targetAsset = asset_get_index( target );
            
            if ( instance_exists( _targetAsset ) ) {
                __triggerTargetInstance = asset_get_index( target );
            }
        }
        else if ( !instance_exists( target ) ) {
    		print( "TriggerTarget must be a valid Instance!\nSetting to defaults ..." );
    		__triggerTargetInstance = asset_get_index( __defaultTriggerTarget );
    	}
    	return self;
    }
    #endregion
    #region Object Methods
    static Init = function() {
        if ( flags.HasFlag( TRIGGER_FLAGS.FL_START_ACTIVE ) ) {
        	active = true;
        }
        
        return self;
    }
    static Tick = function() {
        if ( enabled ) {
            if ( IsColliding( __triggerTargetInstance, __self.GetTransform().position ) ) {
                if ( !isInside ) {
                    OnEnterVolume();
                    eventhandler_publish( itemName );
                    hasTouched = true;
                    isInside = true;
                }
                else {
            	    InVolume();
                }
            	
            	if ( flags.HasFlag( TRIGGER_FLAGS.FL_TRIGGER_ONCE ) ) {
            		flags.SetFlag( TRIGGER_FLAGS.FL_DESTROY );
            		enabled = false;
            	}
            }
            else if ( isInside ) {
                OnExitVolume();
                isInside = false;
            }
        }
    }
    static TickEnd = function() {
        if ( flags.HasFlag( TRIGGER_FLAGS.FL_DESTROY ) ) {
        	instance_destroy( __self );
        } 
    }
    static Draw = function() {
        var _transform = __self.GetTransform();
        
        draw_sprite_ext( triggerSprite, -1, _transform.position.x, _transform.position.y, _transform.scale.x, _transform.scale.y, _transform.angle, c_white, 1 );
    }
    #endregion
    
    return self;
}