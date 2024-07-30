function initGlobalVariables() {
	#macro IDE_MODE true
	#macro FALLBACK_STRING lang().GetLangString()
	#macro FALLBACK_SPRITE spr_default
	#macro FALLBACK_ANIMATION animation_init_looped( FALLBACK_SPRITE, 0 )
	
	#macro COMPUTER_NAME environment_get_variable( "USERNAME" )
	#macro MAX_SAVES 64
	
	#macro CURRENT_DATE date_current_datetime()
    
    // Code macros
    #macro extends :
    #macro class constructor
    
    // Lang Macros
    #macro LOC_STRING lang().GetLangString
    
    #region Version
    #macro RUNTIME_VERSION GM_runtime_version
    #endregion
    
    // Change this
    #macro GAME_VERSION 0
    #macro GAME_FPS game_get_speed( gamespeed_fps )
    
    // Current CURRENT_VIEW being displayed
    #macro CURRENT_VIEW view_camera[0]
    #macro LISTENER_DATA audio_listener_get_data( 0 )
    
	globalvar globFlags;
	globFlags = 0;
	
	print( $"Runtime Version : {RUNTIME_VERSION}" );
	print( $"Running Init ..." );
	
	globalflags_set( GLOBALFLAGS.IDE );
	globalflags_add( GLOBALFLAGS.DEBUG_FPS );
	
	#region Settings
	default_settings = {
		vol_mas : 0.5,
		vol_sfx : 0.1,
		vol_mus : 0.1,
		vol_amb : 0.5,
		vol_stereo : false,
		
		ctrl_sens : 0.20,
		ctrl_toggleaim : false,
		
		gfx_mode : 1,
		gfx_lighton : true,
		gfx_particles : false,
		gfx_rr : 60, // refresh rate
		gfx_surface_quality : 3,
	};
	
	global.settings = {
		vol_master_volume	: default_settings.vol_mas, 
		vol_music_volume	: default_settings.vol_mus, 
		vol_sfx_volume		: default_settings.vol_sfx,	
		vol_amb_volume		: default_settings.vol_amb,	
		vol_stereo			: default_settings.vol_stereo,
		
		ctrl_sens			: default_settings.ctrl_sens,
		ctrl_toggleaim		: default_settings.ctrl_toggleaim,
		
		gfx_lighton			: default_settings.gfx_lighton,
		gfx_smoothlights	: default_settings.gfx_mode,
		gfx_particles		: default_settings.gfx_particles,
		gfx_debris			: true,
		gfx_surfaces		: true,
		gfx_surfquality		: default_settings.gfx_surface_quality
	};
	#endregion
	#region Audio
	global.audioMix = {
		main : {
			gain : global.settings.vol_master_volume,
			bus : audio_bus_create()
		},
		sfx : {
			gain : global.settings.vol_sfx_volume,
			bus : audio_bus_create()
		},
		ambience : {
			gain : global.settings.vol_amb_volume,
			bus : audio_bus_create()
		},
		music : {
			gain : global.settings.vol_music_volume,
			bus : audio_bus_create()
		}
	};
	global.audioBus = {
		main : audio_bus_create(),
		sfx : audio_bus_create(),
		amb : audio_bus_create(),
		music : audio_bus_create()
	}
	
	global.reverbPass = audio_effect_create( AudioEffectType.Reverb1 );
	global.reverbPass.bypass = false;
	global.reverbPass.mix = 0.0;
	global.reverbPass.size = 0.1;//0.2 sounds nice
	
	/* 
	Audio fx system idea
	
	trigger volume obj to activate/change sfx params.
	has an arbitrary "room_size" variable that gets normalized to range 0-1.
	wamo!
	*/
	array_push( global.audioBus.sfx.effects, global.reverbPass );
	#endregion
	#region Save Data
	/* 
		global.
		worldState <- A struct containing data pertaining to the current saves worldstate.
		profiles <- An array of all the profiles from the game folder.
		currentProfile <- The current profile the game is saving/loading to.
		currentSaveSlot <- The current save slot the game is saving/loading to.
		itemList <- An internal list of all registered / valid items. Used when loading items from a save file.
	*/
	global.worldStates = undefined;
	global.profiles = array_create( 3, -1 );
	global.currentProfile = 0; // Int, the index of the current game profile ( 0 - 2 )
	global.currentSaveSlot = 0;
	global.itemList = [];
	#endregion
	#region Progression and Collectibles
	global.unlockedNotes = {};
	global.difficulty = DIFFICULTY.NORMAL;
	#endregion

	global.slomo_amount = 0.35;
	
	global.saving_checkpoint = false;
	global.last_saved_room = -1;
	global.selected_saveslot = 0;
	global.game_savebuffer = buffer_create( 1, buffer_grow, 1 );
	global.last_save = undefined;
	
	global.input_mouse_lock		= true;
	global.input_blocked		= false;
	global.firstperson			= false;
	
	global.mousex_raw = 0;
	global.mousey_raw = 0;
	
	#region Game Data / Progression
	global.achievements = {};
	global.current_chapter = 0;
	
	global.current_saveslot = 0;
	global.current_save = -1;
	
	// Used for persistent upgrades within a save
	global.player_stats = {
		hp : 500,
		armour : 0,
		inventory_size : 6
	}
	#endregion
	
	global.cursor_custom = noone;
	
	// Global boolean that controls whether or not the player will move based on device-inputs
	global.input_enabled = true;
	
	// Instance that we are currently sending inputs to
	global.input_target = noone;
	// Instance the camera is focused on currently
	global.camera_target = noone;
	global.camera_target_previous = noone;
	
	// Whether or not the camera will approach the target
	global.camera_follow = true;
	
	global.debug		= false;
	global.pause		= false;
	global.pause_png	= noone;
	global.shake		= 0;
	global.checkpoint	= buffer_create( 1, buffer_grow, 1 );
	
	global.stage			= -1;
	global.checkpointarray	= -1;
	
	global.choice		= noone;
	global.ai_on		= true;
	
	global.room_clean	= false;
	global.exit_room	= noone;
	
	audio_group_load( audiogroup_default );
	audio_group_load( audio_sfx );
	audio_group_load( audio_amb );
	
	#region Settings

	// GFX Options
	global.lighting_enabled = default_settings.gfx_lighton;
	global.amblight_colour = #16161d;
	global.smooth_lighting = default_settings.gfx_mode >= 1 ? 1 : 0;
	
	global.music_pitch	= 1;
	global.music_playing = false;
	global.current_song = noone;
	global.currentambience	= -1;
	global.prevambience		= -1;
	
	// global.bus_sfx			= audio_bus_create();
	// global.bus_ambience 	= audio_bus_create();
	
	/*  
		GFX 0 = default
		GFX 1 = smooth lights off
		GFX 2 = no particles, no debris
	*/
	global.shake_intensity	= 1;
	global.shake_enabled	= true;
	
	global.refreshrate		= default_settings.gfx_rr;
	
	// ##Default controls are located inside	__input_config_verbs##
	
	global.mouse_sensitivity = default_settings.ctrl_sens;
	
	global.look_factor		= 1; // Factor for the cursor position
	global.zoom_on			= false;
	global.zoom_mode		= 0; // 0 for default hold to look, 1 for toggle, 2 for always on, 3 for always on but shift disables
	global.zoom_maxdist		= 16 * 8; // 8 Tile Zoom distance by default
	#endregion
	
	// Global score struct referenced by everything in the game that uses score : )
	global.score = {
		total_score			: 0,		// Total score tallied after all bonuses
		combo				: 0,		// Current and FINAL combo
		combo_time			: 0,		// Combo Time
		kills				: 0,		// Kill score is awarded when you kill an enemy
		time				: 0,		// Time Score is the amount of time the player takes to complete a level; 50 for 2 mins, 100 for 1 min
		style				: 0,		// Style Points are award when the player gets grazed by bullets, gets slomo kills, slides under bullets or executes enemies
		environmental		: 0,		// Environmental Kill score
		score_grade			: 0,		// Score grade; ZZZ=1, 1.5=F, 2=D, 2.5=D+, 3=C, 3.5=C+, 4=B, 4.5=B+, 5=A, 5.5=A+, 6=S, 6.5=S+, 7=Z
		
		Reset : function()
		{
			total_score			= 0;
			combo				= 0;
			combo_time			= 0;
			kills				= 0;
			time				= 0;
			style				= 0;
			environmental		= 0;
		}
	};
	
	globalvar joe_style;
	joe_style = 0;
	globalvar joe_maxstyle;
	joe_maxstyle = 60 * 4;
	globalvar cursor_scale;
	cursor_scale = 1;
	globalvar delta;
	delta = 1;
	globalvar timescale;
	timescale = 1;
	globalvar cursor_animationspeed;
	cursor_animationspeed = 0;
	globalvar cursor_color;
	cursor_color = c_white;
	
	#region stats
	global.stats = 
	{
		TimePlayed			: 0,
		EnemiesKilled		: 0,
		HighestCombo		: 0,
		HasKilledEnemy		: 0,
		SpecialEnemiesKilled: 0,
		BulletsFired		: 0,
		GunsPickedUp		: 0,
		GunsThrown			: 0,
		HasPickedUpItem		: 0,
		DistanceWalked		: 0,
		DeathCount			: 0,
		TimeInSlowMo		: 0,
		KillDeathRatio		: 0,
		TotalBloodLost		: 0,
		DamageTaken			: 0,
		DamageDealt			: 0
	};
	
	global.gained_score = 0;
	
	global.days = 0;
	global.hours = 0;
	global.minutes = 0;
	global.seconds = 0;
	global.combo_multiplier = 1;
	global.blood_lost = 0;
	#endregion
}

function init_classes()
{
	audio().Init();
	
}

function cleanup_classes()
{
	
	audio().Cleanup();
}
