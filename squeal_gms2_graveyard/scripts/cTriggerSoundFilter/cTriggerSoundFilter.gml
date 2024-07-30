/// @self {object|cTriggerVolume}
function cTriggerSoundFilter( instanceRef ) extends cTriggerVolume( instanceRef ) class {
    mixChange = 0.3;
    mixChangeRate = 0.01;
    sizeChange = 0.2;
    sizeChangeRate = 0.01;
    
    triggerSprite = spr_ambientscape;
    flags.RemoveFlag( TRIGGER_FLAGS.FL_TRIGGER_ONCE );
    
    #region Object Methods
    static Tick = function() {
        // __SUPER__.Tick();
        
        if ( hasTouched ) {
            global.reverbPass.size = lerp( global.reverbPass.size, sizeChange, sizeChangeRate );
            global.reverbPass.mix = lerp( global.reverbPass.mix, mixChange, mixChangeRate );
            
            if ( global.reverbPass.size >= sizeChange ) {
                hasTouched = false;
            }
        }
    }
    #endregion
    #region Trigger Methods
    #endregion
}