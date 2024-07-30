function initAchievements() {
    var _achNormal = new cAchievement()
    .SetIcon( FALLBACK_SPRITE )
    .SetID( "normal" )
    .SetTitle( LOC_STRING( "#game.achname.normal" ) )
    .SetDesc( LOC_STRING( "#game.achdesc.normal" ) )
    .Register();
    
    var _achHardcore = new cAchievement()
    .SetIcon( FALLBACK_SPRITE )
    .SetID( "hardcore" )
    .SetTitle( LOC_STRING( "#game.achname.hardcore" ) )
    .SetDesc( LOC_STRING( "#game.achname.hardcore" ) )
    .Register();
    
    var _achNightmare = new cAchievement()
    .SetIcon( FALLBACK_SPRITE )
    .SetID( "nightmare" )
    .SetTitle( LOC_STRING( "#game.achname.nightmare" ) )
    .SetDesc( LOC_STRING( "#game.achname.nightmare" ) )
    .Register();
    
    var _achSkinOfMyTeeth = new cAchievement()
    .SetIcon( FALLBACK_SPRITE )
    .SetID( "skinofmyteeth" )
    .SetTitle( LOC_STRING( "#game.achname.skinomyteeth" ) )
    .SetDesc( LOC_STRING( "#game.achname.skinomyteeth" ) )
    .Register();
    
    var _achUntouchable = new cAchievement()
    .SetIcon( FALLBACK_SPRITE )
    .SetID( "untouchable" )
    .SetTitle( LOC_STRING( "#game.achname.untouchable" ) )
    .SetDesc( LOC_STRING( "#game.achname.untouchable" ) )
    .Register(); 
    
    var _achBeatBlind = new cAchievement()
    .SetIcon( FALLBACK_SPRITE )
    .SetID( "beatblind" )
    .SetTitle( LOC_STRING( "#game.achname.beatblind" ) )
    .SetDesc( LOC_STRING( "#game.achname.beatblind" ) )
    .SetProgressTarget( 25 )
    .Register(); 
    
    var _achKeepThePeace = new cAchievement()
    .SetIcon( FALLBACK_SPRITE )
    .SetID( "peace" )
    .SetTitle( LOC_STRING( "#game.achname.peace" ) )
    .SetDesc( LOC_STRING( "#game.achname.peace" ) )
    .Register();   
    
    var _achTranq = new cAchievement()
    .SetIcon( FALLBACK_SPRITE )
    .SetID( "tranq" )
    .SetTitle( LOC_STRING( "#game.achname.tranq" ) )
    .SetDesc( LOC_STRING( "#game.achname.tranq" ) )
    .SetProgressTarget( 3 )
    .Register();      
    
    var _achLockedAndLoaded = new cAchievement()
    .SetIcon( FALLBACK_SPRITE )
    .SetID( "locknload" )
    .SetTitle( LOC_STRING( "#game.achname.locknload" ) )
    .SetDesc( LOC_STRING( "#game.achname.locknload" ) )
    .Register();    
    
    var _achModelOfficer = new cAchievement()
    .SetIcon( FALLBACK_SPRITE )
    .SetID( "modelofficer" )
    .SetTitle( LOC_STRING( "#game.achname.modelofficer" ) )
    .SetDesc( LOC_STRING( "#game.achname.modelofficer" ) )
    .Register();    
    
    var _achShockValue = new cAchievement()
    .SetIcon( FALLBACK_SPRITE )
    .SetID( "shockvalue" )
    .SetTitle( LOC_STRING( "#game.achname.shockvalue" ) )
    .SetDesc( LOC_STRING( "#game.achname.shockvalue" ) )
    .SetProgressTarget( 10 )
    .Register();  
    
    var _achLightTheWay = new cAchievement()
    .SetIcon( FALLBACK_SPRITE )
    .SetID( "lighttheway" )
    .SetTitle( LOC_STRING( "#game.achname.lighttheway" ) )
    .SetDesc( LOC_STRING( "#game.achname.lighttheway" ) )
    .Register();
}