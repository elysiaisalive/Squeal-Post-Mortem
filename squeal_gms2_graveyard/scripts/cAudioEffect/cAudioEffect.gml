/* 
Audio effect class. more or less a wrapper for the very *poorly* documented and implemented audio fx.
*/
function cAudioEffect() class {
    /* 
    effectType <- Enum AudioEffectType {
        Reverb1,
        Delay,
        Gain,
        Bitcrusher,
        Tremolo,
        EQ
    }
    bypass <- Whether or not the effect should bypass existing effects
    roomSize <- [0, 1] The size of the 'room'. Used for Reverb.
    damping <- [0, 1] The amount that higher frequencies should be attenuated
    effectMix <- [0, 1] The amount of the original signal that will come through the effect. 0 is None of the effect and 1 is the maximum signal of the effect.
    */
    effectType = AudioEffectType.Reverb1;
    bypass = false;
    roomSize = 0;
    damping = 0;
    effectMix = 0.5;
    
    #region Setters
    static SetType = function( type ) {
        effectType = type;
        return self;
    } 
    static SetBypassed = function( _bypassed = true ) {
        bypass = _bypassed;
        return self;
    }
    static SetRoomSize = function( _roomSize = 0 ) {
        roomSize = _roomSize;
        return self;
    }
    static SetDamping = function( damp ) {
        damping = damp;
        return self;
    }
    static SetMix = function( fxMix ) {
        effectMix = fxMix;
        return self;
    }
    #endregion
    
    static Build = function() {
        var _effect = audio_effect_create( effectType );
        _effect.size = bypass;
        _effect.size = roomSize;
        _effect.size = effectMix;
        _effect.size = damping;
        
        return _effect;
    }
    
    return self;
}