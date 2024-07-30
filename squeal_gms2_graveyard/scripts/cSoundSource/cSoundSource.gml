/* 
  Sound source class. Has configurable volume, priority etc. Used for making the AI hear things!
  
  The basic idea is that a Sound Source will start at 0, grow to its max volume, 
  then creep back down to 0 and die, or if the life is set it will die when the life reaches 0.
*/
function cSoundSource() class {
    /* 
      volume - The volume ( radius ) of the sound.
      priority - The priority of the sound. Explosions, gunshots etc should be higher priority than a footstep.
      life - the amount of time that a sound source will stick around for
    */
    parent = noone;
    volume = 0;
    volumeGrowRate = 0.80;
    volumeDecayRate = 1;
    volumeMax = 0;
    volumeMin = 0;
    reachedMaxVolume = false;
    
    priority = 0;
    life = -1;
    lifeDrainRate = 0;
    lifeMax = 0;
    
    static SetVolume = function( desiredVolume ) {
        volume = desiredVolume;
        return self;
    }
    static SetParent = function( parentObject ) {
        parent = parentObject;
        return self;
    }
    static GetVolume = function() {
        return {
            volume,
            volumeMax,
            volumeMin
        }
    }
    static Tick = function() {
        if ( life > -1 ) {
        life = max( 0, life - lifeDrainRate );
        }
        
        if ( !reachedMaxVolume ) {
            volume = max( volumeMin, volume + volumeGrowRate );
            
            if ( volume >= volumeMax ) {
                reachedMaxVolume = !reachedMaxVolume;
            }
        }
        else {
            volume = max( volumeMin, volume - volumeDecayRate );
        }
        
        if ( life <= 0 
        && life != -1 ) {
            instance_destroy( parent );
        }
    }
    return self;
}