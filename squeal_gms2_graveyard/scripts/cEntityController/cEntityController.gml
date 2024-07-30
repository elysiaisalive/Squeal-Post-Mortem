/* 
    The entity controller component/class is added to an instance via variable definition
    Entity controllers can take up an additional few components;
    - inputMoveComponent ( Requires the User object be assigned to the instance to control it. )
    - navMoveComponent ( For pathfinding movement, etc )
    
    ^^ 
    This is intended so that an entity controller can have its move components swapped for cutscene scenarios.
    
    The entity controller features some very basic velocity and speed calculations, as well as moving the position/transform as a result etc..
    
    A basic entity will have access to a few different component types;
    - healthComponent ( Healthstate, armour, pretty self explanatory... )
*/
function cEntityController() extends cWorldObject() class {
    velocity = 0;
    minVelocity = 0;
    maxVeloctiy = 64;
    acceleration = 0;
    deceleration = 0;
    
    angle = 0;
    velocityDirection = 0;
    
    static Tick = function() {};
}

function cComponent() class {
    name = instanceof( self );
    
    static SetName = function( newName ) {
        name = newName ?? instanceof( self );
        
        return self;
    }
}

function cDrawComponent() extends cComponent() class {
    // Includes stuff like drawing with palette, layered masks etc... ???? Multiple sprites ??
    animations = {};
    
    static AddAnimation = function( animStruct = new cAnimation(), label = $"{~~random( 64 )}" ) {
        if ( !is_instanceof( animStruct, cAnimation ) ) {
            show_error( $"Error! Animation is not valid type: {instanceof( cAnimation )}", true );
        }
        
        animations[$ label] = {};
        animations[$ label].animation = animStruct;
        animations[$ label].transform = new cTransform2D();
        
        return self;
    }
    
    static Draw = function() {
        var _animationAmount = array_length( animations );
        
        for( var i = 0; i < _animationAmount; ++i ) {
            var _animation = animations[$ i];
            
            draw_sprite( _animation.animation.anim, -1, _animation.transform.x, _animation.transform.y );
        }
    }
    
    return self;
}
function cInputMoveComponent() extends cComponent() class {}
function cNavMoveComponent() extends cComponent() class {}

function cHealthComponent() extends cComponent() class {
    hp = 0;
    hpMax = 0;
    armour = 0;
    armourMax = 0;
    
    #region Data Serialization
    static Serialize = function() {
        var _data = {
            hp : hp,
            hpMax : hpMax,
            armour : armour,
            armourMax : armourMax
        };
        
        var _encodedString = SnapToJSON( _data );
        
        return _encodedString;
    }
    static Deserialize = function( data ) {
        var _decodedData = SnapFromJSON( data );
        
        if ( !is_undefined( _decodedData ) ) {
            hp = _decodedData.hp;
            hpMax = _decodedData.hpMax;
            armour = _decodedData.armour;
            armourMax = _decodedData.armourMax;
        }
    }
    #endregion
    #region Get
    #endregion
    #region Set
    static SetHP = function( _newHP = 0 ) {
        hp = _newHP;
        hpMax = hp;
        
        return self;
    }
    static SetArmour = function( _newArmour = 0 ) {
        armour = _newArmour;
        armourMax = armour;
        
        return self;
    }
    #endregion
    
    static OnHPDepleted = function() {};
    static OnArmourDepleted = function() {};
    static DoDamage = function( _incomingDamage = 0 ) {
        hp = max( 0, hpMax );
        armour = max( 0, armourMax );
        
        if ( armour <= 0 ) {
            hp -= _incomingDamage;
        }
        else {
            armour -= _incomingDamage;
        }
        
        if ( hp <= 0 ) {
            OnHPDepleted();
        }
        // Send OnArmourBreak() callback.
        if ( _incomingDamage >= armour ) {
            OnArmourDepleted();
        }
    }
}