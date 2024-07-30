/// @title Generic Object Constructors
function cInteractable( ent_name = FALLBACK_STRING, _state = false ) constructor {
	// output[trigger, entity, input, delay, onlyonce]
	ent_string = ent_name;
	interact_sound = -1;
	toggled = _state; // Are we toggled/interacted with?
	
	static GetName = function() {
		return ent_string;
	};
	
	static SetState = function( new_state ) {
		toggled = new_state;
	};
	
	static GetParent = function() {
		return ent_string;
	};
	
	static SetParent = function( newparent ) {
		ent_string = newparent;
	};
	
	static SetInteractSound = function( newsound ) {
		interact_sound = newsound;
	};
	
	static GetInteractSound = function() {
		return interact_sound;
	};
	
	static OnInteract = function(){}; // Input from entity i.e character
	static OnTrigger = function(){}; // Do thing when input recieved
};

function cInteractableButton( ent_name = FALLBACK_STRING, _state = false ) : cInteractable( ent_name, _state ) constructor
{
	static OnInteract = function()
	{
		if ( !toggled )
		{
			OnTrigger();
			toggled = true;
		};
	};
};

function cInteractablePickup( ent_name = FALLBACK_STRING ) extends cInteractable( ent_name ) constructor{};

function base_pickup_inventory( ent_name = FALLBACK_STRING ) extends cInteractablePickup( ent_name ) constructor
{
	item_sprite = -1;	// Sprite for inventory
	item_imageindex	= 0;
	item_anim_spd = 0.35;
	IsAnimated = false;
	used		= false; // Have we interacted with this item before?
	
	static SetSpriteFromIndex = function( new_val ) 
	{
		item_sprite = new_val;
	};
	
	static SetIndex = function( new_val )
	{
		item_imageindex = new_val;
	};
	
	static SetAnimated = function( new_val = false )
	{
		IsAnimated = new_val;
	};
};

function create_particlesystem() constructor
{
	particle_array = array_create( 0 );
	
	static AddParticle = function( particle = new create_particle() )
	{
		array_push( particle_array, particle );
		return particle;
	};
	
	static Tick = function()
	{
       array_foreach( particle_array,
        function( item ) 
        {
            item.Tick();
            
			var x_spd = dcos( item.direction ) * item.spd * delta;
			var y_spd = -dsin( item.direction ) * item.spd * delta;
			
			item.x += x_spd;
			item.y += y_spd;
			item.life -= delta;
        });
	};
};

function create_particle() constructor 
{
	self.x			= 0;
	self.y			= 0;
	self.sprite		= -1;
	self.index 		= 0;
	self.alpha		= 1;
	self.life		= 0;
	self.life_max	= 60 * 2;
	self.spd		= 0;
	self.frc		= 0;
	self.angle		= 0;
	self.dir		= 0;
	self.scale		= 1;
	self.max_scale	= 1;
	
	static ParticleSpeed = function( set_speed )
	{
		spd = set_speed;
	};
	
	static ParticleScale = function( newscale,  maxscale = newscale )
	{
		scale = newscale;
		max_scale = maxscale;
	};
	
	static ParticleOrientation = function( new_angle = 0, new_direction = new_angle )
	{
		angle = new_angle;
		dir = new_direction;
	};
	
	static OnDeath = function(){ return true; };
	
	static Tick = function(){};
};

function base_projectile() constructor
{
	proj_x			= 0;
	proj_y			= 0;
	proj_direction	= 0;
	hp_dmg			= -1;
	armour_dmg		= -1;
	pen_power		= 0;
	proj_sprite		= spr_proj_bullet;
	proj_index		= 0;
	proj_id 		= noone;
	owner			= noone;
	faction			= FACTION.NONE;
	velocity		= 0;
	frc				= 0;
	maxvelocity     = 256;
	life			= 0;
	maxlife 		= 0;
	
	static OnImpact = function(){};
	
	static OnLifeEnd = function(){};
	
	static Draw = function(){};
	
	#region Helper Functions
	
	static GetValue = function( get_value )
	{
		return get_value;
	};
	
	static SetHPDamage = function( new_dmg = 0 )
	{
		hp_dmg = new_dmg;
	};
	
	static SetArmourDamage = function( new_dmg = 0 )
	{
		armour_dmg = new_dmg;
	};
	
	static SetPenPower = function( new_pen = 0 )
	{
		pen_power = new_pen;
	};
	
	static SetOwner = function( new_owner )
	{
		owner = new_owner;
	};
	
	static SetID = function( new_id )
	{
		proj_id = new_id;
	};
	
	static SetSpriteFromIndex = function( new_spr )
	{
		proj_sprite = new_spr;
	};
	
	static SetIndex = function( new_ind )
	{
		proj_index = new_ind;
	};
	
	static SetLife = function( new_life = 60 )
	{
		life = new_life;
	};
	
	static SetVelocity = function( new_vel = 12 )
	{
		velocity = new_vel;
	};
	
	static GetSprite = function()
	{
		return proj_sprite;
	};
	
	static GetIndex = function()
	{
		return proj_index;
	};
	
	static GetLife = function()
	{
		return life;
	};	
	
	static GetHPDMG = function()
	{
		return hp_dmg;
	};
	
	static GetArmourDMG = function()
	{
		return armour_dmg;
	};
	
	static GetPenPower = function()
	{
		return pen_power;
	};
	
	static GetID = function()
	{
		return proj_id;
	};
	
	static GetOwner = function()
	{
		return owner;
	};
	#endregion
};