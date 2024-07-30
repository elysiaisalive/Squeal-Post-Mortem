event_inherited();

z					= depth;
height = 10;
image_speed			= 0;
shadow_depth		= 1;

hp					= 0;
hp_max				= 0;
destructible		= false;
impact_snd			= noone;
spr_debris			= noone;
debris_amnt			= 0;
spr_particle		= noone;
particle_amnt		= 0;

isAnimated = false;
animIndex = image_index;
animSpd = 0;
					
scale				= 2;
draw_simpleshadow	= true;

draw_under			= false;
spr_under			= noone;
frame_under			= 0;

draw_over			= false;
spr_over			= noone;
frame_over			= 0;

offset_x			= 0;
offset_y			= 0;

bSortDepth = false;
occluder = -1;
HasLightMask = false; // Used for sprite traced shadows
lightmask = -1;

collision_flags		= 0;
collision_flags		= BLOCK_ALL;
ignore3DCollisions = false;
IsMovingObject = false;

nodegraph_ignore		= false;
nodegraph_clear_self = function()
{
	if ( instance_exists( obj_navgrid ) )
	{
		mp_grid_clear_rectangle(
			obj_navgrid.nav_grid,
			x - lengthdir_x( xoffset, image_angle + org_to_start ),
			y - lengthdir_y( yoffset, image_angle + org_to_start ),
			x - lengthdir_x( xoffset, image_angle + org_to_start ) + lengthdir_x( sprite_width, image_angle + start_to_end ),
			y - lengthdir_y( yoffset, image_angle + org_to_start ) + lengthdir_y( sprite_height, image_angle + start_to_end )
		);
	}
};

proj_hit_id			= noone;
object_hit_id		= noone;
register_proj_hit	= function()
{
	return true;
};
on_proj_hit			= function(){};
on_object_hit		= function(){};
on_melee_hit		= function(){};

if ( bSortDepth ) {
	call_later( 1, time_source_units_frames, function() {
		with obj_solid_furniture if ( id != other.id )
		with other
		{
			if place_meeting( x, y, other )
			&& z != ( other.z - other.height )
			{
				print( "Sorting depth!" );
				depth = other.depth - 1;
			}
		}
	}, false );
}

Draw3D = function()
{
	for ( var acc = 3, i = height - 1; i > 1; i -= acc )
	{
		matrix_set( matrix_world, matrix_build( 0, 0, i, 0, 0, 0, 1, 1, 1 ) );
		draw_self();
	}
	matrix_set( matrix_world, matrix_build_identity() );
	
	draw_self();
}

isPushable = true;
isBeingPushed = false;
pushDirection = 0;
pushTime = 60 * 2;
pushCooldown = 30;