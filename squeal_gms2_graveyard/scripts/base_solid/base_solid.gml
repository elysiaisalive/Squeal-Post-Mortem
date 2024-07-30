// Solid properties

#macro BLOCK_ALL           255
#macro BLOCK_MOVEMENT      ( 1 << 0 )
#macro BLOCK_PROJECTILE    ( 1 << 1 )
#macro BLOCK_VISION        ( 1 << 2 )
#macro BLOCK_OBJECTS       ( 1 << 3 )
#macro BLOCK_PATROL        ( 1 << 4 )
#macro BLOCK_LIGHT         ( 1 << 5 )

function init_solid()
{
	collision_flags = 0;
}

function Solid_ClearFlags()
{
	collision_flags = 0;
}

function Solid_SetFlags( flags )
{
	collision_flags = flags;
}

function Solid_AddFlag( flag )
{
	collision_flags |= flag;
}

function Solid_RemoveFlag( flag )
{
	collision_flags &= ~flag;
}

function Solid_SetFlag( flag, on )
{
	if ( on )
		Solid_AddFlag( flag );
	else
		Solid_RemoveFlag( flag );
}

function Solid_GetFlag( flag )
{
	return ( collision_flags & flag );
}

function Solid_GetFlags()
{
	return ( collision_flags );
}



function Solid_Block( flags )
{
	return Solid_GetFlag( flags );
}

// Blocks movement
function Solid_BlockMovement()
{
	return Solid_Block( BLOCK_MOVEMENT );
}

// Blocks bullets
function Solid_BlockBullets()
{
	return Solid_Block( BLOCK_PROJECTILE );
}

// Blocks vision
function Solid_BlockVision()
{
	return Solid_Block( BLOCK_VISION );
}

// Blocks objects ( weapons, basketballs, etc. )
function Solid_BlockObjects()
{
	return Solid_Block( BLOCK_OBJECTS );
}
