
/* 
     Status effect manager class.
     Instanced per instance.
     Used to apply, reapply, remove or amplify an existing status effect. Also used to manage when or if a status effect can be active again.
*/
function cStatusEffectManager( instanceRef ) class {
    __instance = instanceRef;
    __statusEffects = [];

    static GetStatusEffects = function() {
        return __statusEffects;
    }
    
    static HasStatusEffect = function( effectName ) {
        var _result = false;
        var _statusListSize = array_length( __statusEffects );
        var _statusEffectLookup = string_lower( effectName );
        
        if ( _statusListSize < 0 ) {
            return;
        }
        
        for( var i = 0; i < _statusListSize; ++i ) {
            var _effectName = string_lower( __statusEffects[i].label );
            
            if ( _statusEffectLookup == _effectName ) {
                _result = true;
                break;
            }
        }
        
        return _result;
    }
    
    /* 
    TODO;
    - Add "comorbidity" where effects can combine to create another status effect or remove another..?
    - draw icons to hud based on a priority of when they were added to the instance.
    */
    static Tick = function() {
        var _effectAmount = array_length( __statusEffects );
        
        if ( _effectAmount < 0 ) {
            return;
        }

        for( var i = 0; i < _effectAmount; ++i ) {
            var _effect = __statusEffects[i];
            
            _effect.__effectDelayTimer.Tick();
            
            // Check if the effect has expired and remove it from the status list
            if ( _effect.__statusHasExpired() ) {
                _effect.OnEffectExpired();
                array_delete( __statusEffects, i, 0 );
                --_effectAmount;
                --i;
                continue;
            }
            else {
                var _statusVariablesAmount = array_length( _effect.__affectedVariables );
                var _statusVariableName = 0;
                var _statusVariableMember = 0;
                var _statusVariableChange = 0;
                var _statusVariableType = 0;
                // The amount of variables that have changed
                var _changeAmount = 0;
                
                for( var j = 0; j < _statusVariablesAmount; ++j ) {
                    _statusVariableName = _effect.__affectedVariables[j].name;
                    _statusVariableMember = _effect.__affectedVariables[j].member;
                    _statusVariableChange = _effect.__affectedVariables[j].change;
                    _statusVariableType = _effect.__affectedVariables[j].type;
                    
                    if ( _effect.__effectDelayTimer.GetTime() <= 0 ) {
                        _effect.__expiryTimer.Tick();
                        _effect.effectCooldownTimer.Tick();
                        
                        if ( _effect.effectCooldownTimer.GetTime() <= 0 ) {
                            //FUCK GAMEMAKER STUDIO 2 ( danny wanted me to write this )
                            switch( _statusVariableType ) {
                                case EFFECT_TYPE.ADD :
                                    if ( is_undefined( _statusVariableMember ) ) {
                                        __instance[$ _statusVariableName] += _statusVariableChange;
                                    }
                                    else {
                                        __instance[$ _statusVariableName][$ _statusVariableMember] += _statusVariableChange;
                                    }
                                    break;                        
                                case EFFECT_TYPE.SUB :
                                    if ( is_undefined( _statusVariableMember ) ) {
                                        __instance[$ _statusVariableName] -= _statusVariableChange;
                                    }
                                    else {
                                        __instance[$ _statusVariableName][$ _statusVariableMember] -= _statusVariableChange;
                                    }
                                    break;                                   
                                case EFFECT_TYPE.DIV :
                                    if ( is_undefined( _statusVariableMember ) ) {
                                        __instance[$ _statusVariableName] /= _statusVariableChange;
                                    }
                                    else {
                                        __instance[$ _statusVariableName][$ _statusVariableMember] /= _statusVariableChange;
                                    }
                                    break;                                   
                                case EFFECT_TYPE.MULTIPLY :
                                    if ( is_undefined( _statusVariableMember ) ) {
                                        __instance[$ _statusVariableName] *= _statusVariableChange;
                                    }
                                    else {
                                        __instance[$ _statusVariableName][$ _statusVariableMember] *= _statusVariableChange;
                                    }
                                    break;                                
                                case EFFECT_TYPE.SET :
                                    if ( is_undefined( _statusVariableMember ) ) {
                                        __instance[$ _statusVariableName] = _statusVariableChange;
                                    }
                                    else {
                                        __instance[$ _statusVariableName][$ _statusVariableMember] = _statusVariableChange;
                                    }
                                    break;
                            }
                            // Increment the amount of variables changed
                            ++_changeAmount;
                            // If we have changed all the variables, reset the cooldown so we can continue applying the effect!
                            if ( _changeAmount >= _statusVariablesAmount ) {
                                _effect.OnCooldownExpired();
                                _effect.effectCooldownTimer.ResetTimer();
                                _changeAmount = 0;
                            }
                        }
                    }
                }
            }
        }
    }
    
    static ApplyStatusEffect = function( newStatus ) {
        array_push( __statusEffects, newStatus );
        newStatus.OnRecieveEffect();
        return self;
    }    
    static RemoveStatusEffect = function( statusToRemove ) {
        var _effectAmount = array_length( __statusEffects );
        
        if ( _effectAmount < 0 ) {
            return;
        }

        for ( var i = 0; i < _effectAmount; ++i ) {
            if ( __statusEffects[i].label == statusToRemove ) {
                array_delete( __statusEffects, i, 0 );
                --_effectAmount;
                --i;
                break;
            }
        }
        return self;
    }   
    static ClearEffects = function() {
        array_empty( __statusEffects );
    }
    
    return self;
}