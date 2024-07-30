// Code

/*
 Usage: CheckVisionLoS( <Instance to look at>, <Instance to look from> )
 
 Returns true if source can see target
*/

function CheckLoS( target = noone, source = self, flag = -1, range = 32 * 12 )
{
	if !( instance_exists( target ) && instance_exists( source ) )
	{
		return false;
	}

	var distance = point_distance( source.x, source.y, target.x, target.y );

	if ( distance > range )
	{
		return false;
	}

	var result = true;

	// Deactivate solid objects that arent in the collision area
	var region_x1 = min( source.bbox_left, target.bbox_left );
	var region_x2 = max( source.bbox_right, target.bbox_right );
	var region_y1 = min( source.bbox_top, target.bbox_top );
	var region_y2 = max( source.bbox_bottom, target.bbox_bottom );
	var region_w = region_x2 - region_x1;
	var region_h = region_y2 - region_y1;

	instance_deactivate_object( obj_solid );
	instance_activate_region( region_x1, region_y1, region_w, region_h, true );

	with ( obj_solid )
	{
		if !( Solid_Block( flag ) )
		{
			instance_deactivate_object( id );
		}
	}

	if ( collision_line( source.x, source.y, target.x, target.y, obj_solid, true, true ) )
	{
		result = false;
	}
	else
	{
		if ( ( source.x > target.x ) && ( source.y > target.y ) ) || ( ( source.x < target.x ) && ( source.y < target.y ) )
		{
			// Top right, bottom left.
			var check_topright = collision_line( source.bbox_right, source.bbox_top, target.bbox_right, target.bbox_top, obj_solid, true, true );
			var check_bottomleft = collision_line( source.bbox_bottom, source.bbox_left, target.bbox_bottom, target.bbox_left, obj_solid, true, true );
		  
			if ( check_topright || check_bottomleft )
			{
				result = false;
			}
		}
		else
		{
			var check_topleft = collision_line( source.bbox_left, source.bbox_top, target.bbox_left, target.bbox_top, obj_solid, true, true );
			var check_bottomright = collision_line( source.bbox_bottom, source.bbox_right, target.bbox_bottom, target.bbox_right, obj_solid, true, true );
			// Top left, bottom right
			if ( check_topleft || check_bottomright )
			{
				result = false;
			}
		}
	}
   
	instance_activate_object( obj_solid );
	return result;
}
 
function CheckMovementLoS( target = noone, source = id, range = 32 * 12 )
{
	return CheckLoS( target, source, BLOCK_MOVEMENT, range );
};

function CheckProjectileLoS( target = noone, source = id, range = 32 * 12 )
{
	return CheckLoS( target, source, BLOCK_PROJECTILE, range );
};

function CheckVisionLoS( target = noone, source = id, range = 32 * 12 )
{
	return CheckLoS( target, source, BLOCK_VISION, range );
};

function CheckAnyLoS( target = noone, source = id, range = 32 * 12 )
{
	return CheckLoS( target, source, BLOCK_MOVEMENT & BLOCK_VISION, range );
};


