function initEnums() {
	// Cursor
	enum CURSOR {
		DEFAULT = 0,
		ALT = 1,
		CUSTOM = 2,
	}
	
	enum COLLISION_SHAPE {
		BOX,
		CIRCLE,
		CUSTOM
	}
	enum TRIGGER_FLAGS {
		FL_START_ACTIVE = ( 1 << 0 ),
		FL_TRIGGER_ONCE = ( 1 << 1 ),
		FL_DESTROY = ( 1 << 2 ),
	}
	
	enum GLOBALFLAGS {
		IDE 			= ( 1 << 0 ), // If we are compiling from the IDE.
		DEVMODE 		= ( 1 << 1 ), // If we are in DEVMODE. Enables different debug options.
		DEBUG_AI		= ( 1 << 2 ), // AI debug info is displayed.
		DEBUG_NODEGRAPH = ( 1 << 4 ), // AI Nodegraph is displayed.
		DEBUG_GUI		= ( 1 << 8 ), // GUI debug info is displayed
		DEBUG_FPS		= ( 1 << 16 ),// FPS info is displayed
		DEBUG_SPRITES	= ( 1 << 32 ),
		USE_OS_CURSOR	= ( 1 << 64 ),
		NOLIGHT			= ( 1 << 128 ), // Lighting Engine is disabled.
		LOG_DATA		= ( 1 << 256 ), // Flag for if data should be logged to console
		DRAW_TIMESTAMP	= ( 1 << 512 ), // Flag for drawing timestamp for playtests
	}
	// Status Effect Types
	enum EFFECT_TYPE {
		ADD,
		SUB,
		DIV,
		MULTIPLY,
		SET,
	}
	enum EFFECT_REACTIONTYPE {
		CREATE,
		MODIFY,
		REMOVE
	}
	#region Items
	enum SLOT_FLAGS {
		FL_POUCH = ( 1 << 0 ),
		FL_MELEE = ( 1 << 1 ),
		FL_HOLSTER = ( 1 << 2 ),
		FL_SLING = ( 1 << 4 )
	}
	#endregion
	#region User Status
	enum USERSTATUS {
		INGAME,
		IDLE
	}
	#endregion
	#region Serialization flags
	enum OBJFLAGS {
		DYNAMIC = ( 1 << 0 ),
	}
	#endregion
	#region Game Progression
	enum DIFFICULTY {
		NORMAL,
		HARD
	}
	#endregion
	#region Game Controller/UI Specific Enums // Unused
	enum INPUTMODE {
		KB_M,
		XB_CONTROLLER,
		PS_CONTROLLER
	};
	// Enum for ingame camera object
	enum e_cameraMode {
		ortho_topdown,
		perspective_firstperson,
		perspective_thirdperson,
		length
	}
	
	// UI, unused
    enum UI_GROUPS {
        DEFAULT,
        PANEL_MAIN,
        CFG_GRAPHICS,
        CFG_AUDIO,
        CFG_GAMEPLAY,
        CFG_ACCESSIBILITY
    }
    
    enum UI_THEMES {
    	DEFAULT,
    	POLICE,
    	SLAUGHTER,
    	NUCLEAR
    }
    
    enum ANIMATION_TYPE {
        FINITE, // Will animate once and then return to the first frame
        LOOPED, // Will loop over and over
        CHAINED, // Inputted animation will transition to a different one once it ends
    }
	
	// Enum for TIPS in the HUD
	enum TEXT_TIP
	{
		TIP_DEFAULT,
		TIP_HEALTH,
		TIP_HPUPGRADE,
		TIP_ARMOUR,
		TIP_STYLE,		
		TIP_STYLEUPGRADE,
		TIP_COLLECTIBLE
	}
	#endregion
	#region Level Manager Enums
	enum WIN_CONDITION {
		NOTHING = 1 << 0,
		KILL_ENEMIES = 2 << 0,
		KILL_OBJECT = 3 << 0,
		KILL_BOSS = 4 << 0,
		REACH_AREA = 8 << 0,
	}
	#endregion
	#region AI cState Enums
	enum ENT_FLAGS {
		ACTIVE		= 1 << 0,
		NOCHASE		= 2 << 0,
		DEAF		= 3 << 0
	}
	enum ESTATE	// AI States. States control the behaviours that are run.
	{
		IDLE,			// Idle, the starting / default cState
		ATTACK,		// Attack cState
		SEARCH,		// Searching for target
		RETURN,			// Returning from target
		ANIMATING,		// ANIMATING / DOING SOMETHING
	}
	enum EBEHAVIOUR	// Movement Types
	{
		IDLE,			// Idle
		STATIC,
		GUARD,			// Idle Unaffected by gunshots or player movement
		HIDER,			// Idle unaffected by gunshots, but is in a crouched cState
		WANDER,			// Wandering
		PATROL,			// Patrol
		PATROL_POINT,	// Patrol within specified points.
		PATROL_DOG		// Dog patrol rules
	}
	enum EALERT 
	{
		UNALERT,		// Unalerted
		ALERTED,		// Alerted
		READY			// Alerted and ready to fire at target
	}
	#endregion
	#region Character Specific Enums
	// Object heights
	enum HEIGHT {
		CEILING = 60,
		HEAD = 50,
		TORSO = 45,
		WAIST = 35,
		LEGS = 25,
		GROUND = -1,
	}
	// Enum for Character States
	enum CSTATE 
	{
		ALIVE,
		EXECUTE,
		DOWN,
		DEAD,
		ANIMATING,
		MOUNTED
	}
	
	// Enum for Character Status
	enum STATUS
	{
		NEUTRAL,
		STUNNED,
		STAGGERED,
		BURNING
	}

	// Enum for character factions/teams
	enum FACTION
	{
		NONE,		// Default Faction that cannot damage anything
		SOLO,		// Can Damage Anything
		PLAYER,		// Can Damage any faction except default
		AITEAM1,
		AITEAM2
	}
	
	// Enum for character voices
	enum VOICE 
	{
		IDLE,
		HURT,
		RELOAD,
		IN_COVER,
		SUPPRESSING,
		THROWING_HE,
		THROWING_STUN,
		TARGET_RETURNFIRE,
		TARGET_SPOTTED,
		TARGET_LOST,
		TARGET_DOWN
	}
	
	enum ACTION 
	{
		IS_SHOOTING,
		IS_MOVING
	}
	#endregion
	#region Weapon Specific Enums
	// Enum for weapon firemodes
	enum FIREMODE
	{
		MELEE, // Unused type, remove
		SEMI,
		AUTO,
		BURST,
		CHARGE
	}
	
	// #UNUSED# Enum for bullet object calibers
	enum BULLETCAL
	{
		LOW,
		MED,
		HIGH,
		PELLET
	}
	
	// Enum for weapon attack type
	enum ATTACKTYPE
	{
		NONLETHAL,
		GUN,
		BLUNT,
		BLUNT_THROWABLE,
		BLADE,
		BLADE_THROWABLE,
		BLADEHEAVY,
		BLUNTHEAVY
	}
	#endregion
	#region Object/Prop Specific Enums
	enum FLICKERTYPE {
		FAST, // Immediate shut-off similar to defective lights
		AMBIENT, // An ambient flicker similar to a fire
	}
	
	enum material
	{
		wood,
		glass,
		brick,
		drywall,
		metal,
		wood_weak,
		concrete
	}
	#endregion
}