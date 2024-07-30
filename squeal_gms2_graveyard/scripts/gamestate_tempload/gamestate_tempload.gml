/// @desc Load the previous gamestate from checkpoint buffer
function gamestate_tempload( buf = global.checkpoint )
{
	if ( !buffer_exists( buf ) )
	{
		return false;
	};

	buffer_seek( buf, buffer_seek_start, 0 );
	
	// global.last_saved_room = buffer_read( buf, buffer_u8 );
	// room_goto( global.last_saved_room );
	
	var assets = tag_get_asset_ids( "is_saved", asset_object );
	var instances = []; // Array of instances that we are writing to the buffer
	
	println( "Loading Surfaces" );
	obj_surface_manager.LoadState( buf );
	obj_lightingengine.LoadState( buf );
	
	obj_camera_control.camera_x = buffer_read( buf, buffer_f32 );
	obj_camera_control.camera_y = buffer_read( buf, buffer_f32 );
	
	obj_hud.joe_syringeinject = buffer_read( buf, buffer_f32 );
	obj_hud.slowmo_active = buffer_read( buf, buffer_bool );
	
	// Looping through the array of instances tagged with is_saved
	for( var i = 0; i < array_length( assets ); ++i )
	{
		with( assets[i] )
		{
			instance_destroy( self, false );
		};
	};
	
	var inst_count = buffer_read( buf, buffer_u16 );
	
	for ( var i = 0; i < inst_count; ++i )
	{
		var inst_id 	= buffer_read( buf, buffer_u16 );
		var inst_x		= buffer_read( buf, buffer_f32 );
		var inst_y		= buffer_read( buf, buffer_f32 );
		var inst_depth	= buffer_read( buf, buffer_f32 );
		var inst_sprite = buffer_read( buf, buffer_u16 );
		var inst_index	= buffer_read( buf, buffer_f16 );
		var inst_angle	= buffer_read( buf, buffer_f16 );
		var inst = instance_create_depth( inst_x, inst_y, inst_depth, inst_id );
		
		inst.sprite_index	= inst_sprite;
		inst.image_index	= inst_index;
		inst.image_angle	= inst_angle;
		
		if ( object_is_ancestor( inst_id, obj_solid_dynamic ) )
		{
			inst.z = buffer_read( buf, buffer_f32 );
			inst.height = buffer_read( buf, buffer_f16 );
			inst.ent_name = buffer_read( buf, buffer_string );
			inst.collision_flags = buffer_read( buf, buffer_u16 );
			inst.depth = inst.z - inst.height;
			inst.LoadState( buf );
		};
					
		if ( object_is_ancestor( inst_id, obj_weapon_generic ) )
		{
			inst.LoadState( buf );
		};
		
		if ( object_is_ancestor( inst_id, obj_entity ) )
		{
			inst.z = buffer_read( buf, buffer_f32 );	
			inst.height = buffer_read( buf, buffer_f16 );	
		};
		
		if ( object_is_ancestor( inst_id, obj_character ) )
		{
			// Character Properties
			inst.charName				= buffer_read( buf, buffer_string );
			inst.char_state				= buffer_read( buf, buffer_u8 );
			//
			inst.animIndex			= buffer_read( buf, buffer_f16 );
			inst.charLookDir			= buffer_read( buf, buffer_f16 );
			inst.no_chase				= buffer_read( buf, buffer_u8 );
			inst.start_angle			= buffer_read( buf, buffer_f16 );
			inst.movementDirection		= buffer_read( buf, buffer_f16 );
			inst.charVelocity		= buffer_read( buf, buffer_f16 );
			
			// Character Stats
			var stats_itemnames = variable_struct_get_names( inst.stats );
			array_sort( stats_itemnames, true );
			for ( var j = 0, count = array_length( stats_itemnames ); j < count; j++ )
			{
				inst.stats[$ stats_itemnames[j]] = buffer_read( buf, buffer_f16 );
			};

			// Character Weapons
			//inst.LoadState( buf );
		};
		
		if ( object_is_ancestor( inst_id, obj_player ) )
		{
			inst.drain	= buffer_read( buf, buffer_u8 );
		};
		
		if ( object_is_ancestor( inst_id, obj_ai_dummy ) )
		{
			inst.entFlags.SetFlags( buffer_read( buf, buffer_u16 ) );
			inst.patrol_dir	= buffer_read( buf, buffer_f16 );
		};
	};
	
	global.input_target = buffer_read( buf, buffer_f32 );
	global.camera_target = buffer_read( buf, buffer_f32 );
	
	// Camera Target must be set after we read the character objects as the camera target is almost always going to be set to a characters instance id
	if ( instance_exists( global.camera_target ) )
	{
		global.camera_target = global.camera_target.id;
	}
	else
	{
		global.camera_target = noone;
	};
	
	if ( instance_exists( global.input_target ) )
	{
		global.input_target = global.input_target.id;
	}
	else
	{
		global.input_target = noone;
	};
	
	print( "Loaded [" + string( buffer_tell( buf ) ) + "] Bytes" );
};