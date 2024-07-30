#region Positive Statuses
function statusBandageHealing() {
    var _statusEffect = new cStatusEffect()
    .SetName( "effectBandage" )
    .AddAffectedVariable( "stats", "hp", 5, EFFECT_TYPE.ADD )
    .SetDelay( 60 * 1.5 )
    .SetCooldown( 60 * 10 )
    .SetExpiry( 60 * 5 );
    
    return _statusEffect;
}
function statusMorphineHealing() {
    var _statusEffect = new cStatusEffect()
    .SetName( "effectMorphine" )
    .AddAffectedVariable( "stats", "hp", 1, EFFECT_TYPE.ADD )
    .AddAffectedVariable( "accuracy", undefined, 1.25, EFFECT_TYPE.MULTIPLY )
    .AddAffectedVariable( "currentWeapon", "aimSpeed", 1.25, EFFECT_TYPE.MULTIPLY )
    .AddAffectedVariable( "currentWeapon", "reloadSpeed", 1.25, EFFECT_TYPE.MULTIPLY )
    .SetDelay( 60 * 0.5 )
    .SetCooldown( 60 * 10 )
    .SetExpiry( 60 * 3 );
    
    return _statusEffect;
}
#endregion
#region Negative Statuses
function statusBleeding() {
    var _statusEffect = new cStatusEffect()
    .SetName( "effectBleed" )
    .AddAffectedVariable( "stats", "hp", 5, EFFECT_TYPE.SUB )
    .SetDelay( 1 )
    .SetCooldown( 60 * 10 )
    .SetExpiry( 60 * 99 );
    
    return _statusEffect;
}
// There is no cure...
function statusOverdose() {
    var _statusEffect = new cStatusEffect()
    .SetName( "effectOverdose" )
    .AddAffectedVariable( "stats", "hp", 1, EFFECT_TYPE.SUB )
    .AddAffectedVariable( "charWalkSpd", undefined, 0.75, EFFECT_TYPE.MULTIPLY )
    .SetDelay( -1 )
    .SetCooldown( 60 * 1 )
    .SetExpiry( 60 * 99 );
    
    return _statusEffect;
}
function statusBurning() {
    var _statusEffect = new cStatusEffect()
    .SetName( "effectBurning" )
    .AddAffectedVariable( "stats", "hp", 5, EFFECT_TYPE.SUB )
    .SetDelay( 1 )
    .SetCooldown( 60 * 2 )
    .SetExpiry( 60 * 3 );
    
    return _statusEffect;
}
#endregion