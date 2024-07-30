/* 
     The status effect class.
     Used for applying various state-changing or other to game entities.
*/
/// @self {cStatusEffect|object|instance}
function cStatusEffect() class {
    label = "defaultStatusEffect";
    displayIcon = -1;
    canApply = true;
    
    // Whether or not the effect will add or subtract to the variable(s) it is affecting.
    effectType = EFFECT_TYPE.ADD;
    
    // A list of all the effectLabels that this effect will affect when applied.
    __reactedEffects = [];
    
    #region Private
    // The timer for the effect to take hold
    __effectDelayTimer = new cTimer( 60 );
    // The timer for when this effect can be reapplied again
    __cooldownTimer = new cTimer( 1 );
    // The timer for how long this effect will last
    __expiryTimer = new cTimer( 60 * 5 );
    /// @param {string}
    // The amount a variable will change depending on its type
    __affectedVariables = [];
    
    // Every 1 seconds by default.
    effectCooldownTimer = new cTimer( 60 );
    // Must be a string
    
    static __statusHasExpired = function() {
        var _evaluation = __expiryTimer.GetTime() <= 0 ? true : false;
        
        if ( __expiryTimer.looped ) {
            _evaluation = false;
        }
        
        return _evaluation;
    }
    #endregion
    /* 
    EFFECT_REACTIONTYPE.REMOVE <- Removes the effect. #DEFAULT#.
    EFFECT_REACTIONTYPE.REACT <- Reacts with the effect to create a new effect.
    EFFECT_REACTIONTYPE.MODIFY <- Modifies a property of the effect e.g increases the time, reduces cooldown etc ...
    
    Reaction Examples;
        statusBleedEffect has a reaction with statusBandageHealingEffect. 
        statusBleedEffect's reaction type is defined as 'REMOVE'.
        statusBleedEffect now gets removed.
        
        statusMorphineHealingEffect has a reaction with statusBleedEffect.
        statusMorphineHealingEffect's reaction type is defined as 'MULTIPLY'.
        statusBleedEffect now has it's affectedVariable change multiplied by whatever factor was defined.
        
        statusBleedingEffect has a reaction with statusBleedingEffect.
        statusBleedingEffect's reaction effect is defined as 'statusHeavyBleedingEffect'.
        statusBleedingEffect is now removed, as well as the other effect reacted with, and statusHeavyBleedingEffect is applied.
    */
    static AddEffectReaction = function( statusName, reactionEffectName, _type = EFFECT_REACTIONTYPE.CREATE ) {
        if ( !is_string( statusName ) ) {
            throw $"Affected Status must be valid name.";
        }        
        if ( !is_string( reactionEffectName ) ) {
            throw $"Reacted Status must be valid name.";
        }
        
        var _reactData = {
            name : statusName,
            reactioName : reactionEffectName,
            type : _type,
        };
        
        array_push( __reactedEffects, statusName );
        return self;
    }
    static AddAffectedVariable = function( variableName, _structMember = undefined, _change = 1, _type = EFFECT_TYPE.ADD ) {
        var _variableData = {
            name : variableName,
            member : _structMember,
            type : _type,
            change : _change
        };
        
        array_push( __affectedVariables, _variableData );
        return self;
    } 
    static SetName = function( effectName ) {
        label = effectName;
        return self;
    }
    static SetCooldown = function( coolDownTime ) {
        effectCooldownTimer.SetNewTime( coolDownTime );
        return self;
    }    
    static SetExpiry = function( expiryTime ) {
        __expiryTimer.SetNewTime( expiryTime );
        return self;
    }    
    static SetDelay = function( applyDelayTime ) {
        __effectDelayTimer.SetNewTime( applyDelayTime );
        return self;
    }
    #region Class Methods
    static OnRecieveEffect = function(){};
    static OnCooldownExpired = function(){};
    static OnEffectExpired = function(){};
    #endregion

    return self;
}