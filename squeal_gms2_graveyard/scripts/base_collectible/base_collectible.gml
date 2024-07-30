// Trophies

global.trophies = {};

// Basic trophy
function create_trophy( title = FALLBACK_STRING, desc = FALLBACK_STRING, sprite = FALLBACK_SPRITE ) constructor
{
    static trophy_count = 0;
	
    _id				= trophy_count++;

    _title			= title;
    _desc			= desc;
    _sprite			= sprite;
    _state			= false;

    // Get details
    static GetName = function()
    {
        return _title;
    }

    static GetDescription = function()
    {
        return _desc;
    }

    static GetSprite = function()
    {
        return _sprite;
    }
	
    // Called when unlocked, will eventually display a notification of some kind
    static OnUnlock = function()
    {
		//global.displaynotif = true;
	}

    // Unlock the trophy
    static Unlock = function()
	{
        if ( _state == false )
		{
			_state = true;
			OnUnlock();
		}
		return _state
	}

	// Get if the trophy is unlocked
	static IsUnlocked = function()
	{
	    return _state;
	}
}

// Quest trophy ( e.g. do something 5 times )
function create_trophy_quest( _name, _desc, _sprite, _target = 5 ) : create_trophy( _name, _desc, _sprite ) constructor
{
    quest_prog = 0;
    quest_target = _target;
    quest_name = _name;

    // Add this many points to the quest (default 1)
    static Add = function( amnt = 1 )
    {
        if ( quest_prog < quest_target )
        {
            quest_prog = min( quest_prog + amnt, quest_target );
			
            if ( quest_prog >= quest_target )
			{
                Unlock();
			}
        }
    }
	
	quest_prog = clamp( quest_prog, 0, quest_target );


    // Get the progress
    static GetProgress = function()
    {
        return quest_prog;
    }
	
    // Get the name
    static GetName = function()
    {
        return quest_name;
    }
}

/* Functions */

// Returns name of a trophy as a string
function Trophy_Get( _name )
{
    return global.trophies[$ _name];
}

// Unlocks a trophy 
function Trophy_Unlock( _name )
{
    var Trophy = Trophy_Get( _name );
	
    if ( Trophy )
    {
        Trophy.Unlock();
    }
}