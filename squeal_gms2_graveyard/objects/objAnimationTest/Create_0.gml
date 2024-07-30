depth = -50;
hasSpeedLoader = false;
ammo = 12;
ammoMax = 6;
ammoInGun = 0;
state = STATES.IDLE;

animationLibrary = new cAnimationLibrary();
animationLibrary.AddSection( "weaponUnarmed" );
animationLibrary.AddSection( "weaponFlashlight" );
animationLibrary.AddSection( "weaponColt" );

var _reloadColtSpeedloader = new cAnimoData()
.SetSprite( sprReloadSpeedloader )
.AddEnterCondition( function() {
    if ( hasSpeedLoader ) {
        return true;
    }
} );
var _reloadColt = new cAnimoData()
.SetSprite( sprReloadSingle );
_reloadColt.animSpeed = 0.25;

var _reloadColtEnter = new cAnimoData()
.SetSprite( sprReloadEnter );
var _reloadColtExit = new cAnimoData()
.SetSprite( sprReloadExit );
var _coltIdle = new cAnimoData()
.SetSprite( sprColtAim );

var _coltAim = new cAnimoData()
.SetSprite( sprColtAim );
var _coltAimStart = new cAnimoData()
.SetSprite( sprColtAimStart );
var _coltAimHold = new cAnimoData()
.SetSprite( sprColtAimHold );
var _coltAimEnd = new cAnimoData()
.SetSprite( sprColtAimEnd );

var _coltReloadHold = new cAnimoData()
.SetSprite( sprReloadHold );

canReload = function() {
    if ( ammoInGun < ammoMax ) {
        return true;
    }
}

animationLibrary.AddAnimation( _coltIdle, "coltIdle", "weaponColt" );
animationLibrary.AddAnimation( _coltAim, "coltAim", "weaponColt" );
animationLibrary.AddAnimation( _coltAimStart, "coltAimStart", "weaponColt" );
animationLibrary.AddAnimation( _coltAimHold, "coltAimHold", "weaponColt" );
animationLibrary.AddAnimation( _coltAimEnd, "coltAimEnd", "weaponColt" );
animationLibrary.AddAnimation( _coltReloadHold, "coltReloadHold", "weaponColt" );
animationLibrary.AddAnimation( _reloadColtEnter, "reloadColtEnter", "weaponColt" );
animationLibrary.AddAnimation( _reloadColtExit, "reloadColtExit", "weaponColt" );
animationLibrary.AddAnimation( _reloadColt, "reloadColt", "weaponColt" );
animationLibrary.AddAnimation( _reloadColtSpeedloader, "reloadColtSpeedloader", "weaponColt" );

print( animationLibrary.__animationList );

animationPlayer = new cAnimationPlayer();
animationPlayer.QueueAnimation( animationLibrary.GetAnimation( "coltIdle", "weaponColt" ) );

fsm = new cStateMachine()
.AddState(
    new cState( "idle" )
    .OnEnter( function() {
        print( "Entered Idle" );
    } )
    .OnTick( function() {
        if ( keyboard_check_pressed( ord( "R" ) )
        && canReload() ) {
            fsm.PushState( "reload" );
        }
        if ( mouse_check_button( mb_right ) ) {
            animationPlayer.QueueAnimation( 
                animationLibrary.GetAnimation( "coltAimStart", "weaponColt" )
                .SetSpeed( 0.25 )
            );
            
            fsm.PushState( "aim" );
        }
    } )
    .OnExit( function() {
        print( "Exited Idle" );
    } )
)
.AddState(
    new cState( "aim" )
    .OnEnter( function() {
        print( "Entered Aim" );
    } )
    .OnTick( function() {
        if ( mouse_check_button( mb_right ) ) {
            animationPlayer.QueueAnimation(
                animationLibrary.GetAnimation( "coltAimHold", "weaponColt" ) 
                .SetSpeed( 0.45 )
                .SetRepeats( mouse_check_button( mb_right ) ? -1 : 0 )
                // .AddExitCondition( function() {
                //     if ( !mouse_check_button( mb_right ) ) {
                //         return true;
                //     }
                // } )
            );
        }
        
        if ( mouse_check_button_released( mb_right ) ) {
            fsm.Exit();
        }
    } )
    .OnExit( function() {
        print( "Exited Aim" );
        animationPlayer.QueueAnimation( 
            animationLibrary.GetAnimation( "coltAimEnd", "weaponColt" ) 
            .SetSpeed( 0.35 )
            .SetAnimationEnd( function() {
                fsm.PopState();
            } )
        );
        animationPlayer.QueueAnimation( animationLibrary.GetAnimation( "coltIdle", "weaponColt" ) );
    } )
)
.AddState(
    new cState( "reload" )
    .OnEnter( function() {
        print( "Entered reload" );
        animationPlayer.QueueAnimation( animationLibrary.GetAnimation( "reloadColtEnter", "weaponColt" ) );
        
        if ( !hasSpeedLoader ) {
            var _ammoLeftToReload = max( 0, ammoInGun + ammoMax );
            
            animationPlayer.QueueAnimation( 
                animationLibrary.GetAnimation( "reloadColt", "weaponColt" )
                .SetRepeats( _ammoLeftToReload ) 
                .SetAnimationEnd( function() {
                    ++ammoInGun;
                } )
            );
        }
        else {
            animationPlayer.QueueAnimation( 
                animationLibrary.GetAnimation( "reloadColtSpeedloader", "weaponColt" )
                .SetAnimationEnd( function() {
                    ammoInGun = ammoMax;
                } )
            );
        }
        
        animationPlayer.QueueAnimation( 
            animationLibrary.GetAnimation( "reloadColtExit", "weaponColt" )
            .SetAnimationEnd( function() {
                fsm.PopState();
            } ) 
        );
        animationPlayer.QueueAnimation( animationLibrary.GetAnimation( "coltIdle", "weaponColt" ) );
    } )    
    .OnTick( function() {
    } )
    .OnExit( function() {
        print( "Exited reload" );
    } )
);

fsm.PushState( "idle" );