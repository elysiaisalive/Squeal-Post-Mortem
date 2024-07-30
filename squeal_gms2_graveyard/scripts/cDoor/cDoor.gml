function cDoor( instanceRef ) extends cWorldObject( instanceRef ) class {
    #region Door Properties
    doorSprite = spr_door_woodH;
    collidingEntity = noone;
    isLocked = false;
    openOnTouch = true;
    entityIsColliding = false;
    startAngle = 0;
    maxOpenAngle = 165;
    swingSpeed = 0;
    swingFriction = 0.085;
    swingWeight = 1;
    openAngle = 0;
    autoClose = false;
    #endregion
    #region Parent Class Methods
    static Serialize = function() {
        var _saveData = {
            startAngle,
            swingSpeed,
            openAngle,
            isLocked,
            entityIsColliding
        }
        var _encodedData = SnapToJSON( _saveData );
        
        return _encodedData;
    }
    static Deserialize = function( encodedData ) {
        var _decodedData = SnapFromJSON( encodedData );
        
        startAngle = _decodedData.startAngle;
        swingSpeed = _decodedData.swingSpeed;
        openAngle = _decodedData.openAngle;
        isLocked = _decodedData.isLocked;
        entityIsColliding = _decodedData.entityIsColliding;
    }
    #endregion
    #region Class Methods
    static SetStartAngle = function( angle ) {
        startAngle = angle;
        __self.transform.angle = startAngle;
        return self;
    }
    static SetLocked = function( _locked = true ) {
        isLocked = _locked;
        return self;
    }
    static GetOpenAngle = function( instanceID ) {
        if ( !instance_exists( instanceID ) ) {
            // Eventually replace with a console error log.
            print( $"Instance for 'openAngle' doesn't exist!" );
            return;
        }
        
        var _instanceTransformPosition = instanceID.GetTransform().position ?? new Vector2( instanceID.x, instanceID.y );
        var _collisionDirection = point_direction( __self.GetTransform().position.x, __self.GetTransform().position.y, _instanceTransformPosition.x, _instanceTransformPosition.y );
        var _openDirection = angle_difference( _collisionDirection, __self.GetTransform().angle + clamp( -180 * __self.GetTransform().scale.x, 0, 180 ) );
        
        // The direction that the door is going to rotate towards.
        return -sign( _openDirection );
    }
    #endregion
    #region Object Methods
    static Tick = function() {
        if ( swingSpeed != 0 ) {
            __self.transform.angle += openAngle * swingSpeed;
        }
    
        // Apply swing motion
        swingSpeed = max( 0, swingSpeed - swingFriction * swingWeight );
        
        // Collision Check.
        // I hope this is performant.
        with( __self ) {
            other.collidingEntity = instance_place( GetTransform().position.x, GetTransform().position.y, obj_character );
        }
        //
        
        var _doorInteractRadius = 24;
        var _player = user().GetController();
    
        if ( IsInRadius( _player, _doorInteractRadius ) 
        && !entityIsColliding ) {
            // MouseWheelStuff
            var _mouseWheelMagnitude = point_distance( 0, 0, 0, input_check( "key_dooropen" ) - input_check( "key_doorclose" ) );
            
            if ( input_check_pressed( "key_interact" ) ) {
                openAngle = GetOpenAngle( _player );
                swingSpeed = 5;
                sfx_play_at( __self.id, snd_env_door_open, false, __self.GetTransform().position.x, __self.GetTransform().position.y );
            }
        }
    
        if ( collidingEntity 
        && openOnTouch 
        && !isLocked 
        && !entityIsColliding ) {
            var _entitySpeedVec = point_distance( 0, 0, collidingEntity.currentXSpd, collidingEntity.currentYSpd );
            var _swingFactor = 2;
            var _swingSpeed = _entitySpeedVec * _swingFactor; 
            
            // The final direction that the door is going to rotate towards.
            openAngle = GetOpenAngle( collidingEntity );
            entityIsColliding = true;
            swingSpeed = min( 3, _swingSpeed );
            __self.transform.angle += openAngle * swingSpeed;
        }
        else {
            entityIsColliding = false;
        }
    
        var _bounceStrength = 0.8;
        // This is kind of stupid
        if ( __self.transform.angle > ( startAngle + maxOpenAngle ) ) {
            __self.transform.angle = startAngle + maxOpenAngle;
            swingSpeed *= _bounceStrength;
            openAngle = -openAngle;
        }
        else if ( __self.transform.angle < ( startAngle - maxOpenAngle ) ) {
            __self.transform.angle = startAngle - maxOpenAngle;
            swingSpeed *= _bounceStrength;
            openAngle *= -1;
        }
    }
    static Draw = function() {
        draw_sprite_ext( 
            doorSprite, 
            -1, 
            __self.GetTransform().position.x, 
            __self.GetTransform().position.y, 
            __self.GetTransform().scale.x, 
            __self.GetTransform().scale.y, 
            __self.GetTransform().angle, 
            c_white, 
            1 
            );
    }
    #endregion

    return self;
}