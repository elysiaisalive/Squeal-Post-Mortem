/// @desc  Save the current gamestate as a checkpoint
function gamestate_tempsave( buf = global.checkpoint )
{
	// check if buffer exists before saving
	if ( !buffer_exists( buf ) )
	{
		return false;
	};
	
	buffer_seek( buf, buffer_seek_start, 0 );
	
	// global.last_saved_room = room;
	// buffer_write( buf, buffer_u8, global.last_saved_room );
	
	var assets = tag_get_asset_ids( "is_saved", asset_object );
	var inst_count = 0;	// Determines when we stop reading the buffer
	var instances = []; // Array of instances that we are writing to the buffer
	
	println( "Saving Surfaces" );
	obj_surface_manager.SaveState( buf );
	obj_lightingengine.SaveState( buf );
	
	buffer_write( buf, buffer_f32, obj_camera_control.camera_x );
	buffer_write( buf, buffer_f32, obj_camera_control.camera_y );
	
	buffer_write( buf, buffer_f32, obj_hud.joe_syringeinject );
	buffer_write( buf, buffer_bool, obj_hud.slowmo_active );
	
	// Looping through the array of instances tagged with is_saved
	for( var i = 0; i < array_length( assets ); ++i )
	{
		with( assets[i] )
		{
			array_push( instances, id );
			++inst_count;
		};
	};
	
	buffer_write( buf, buffer_u16, inst_count );
	
	for ( var i = 0; i < inst_count; ++i )
	{
		var inst = instances[i];
		
		try {
			buffer_write( buf, buffer_u16, inst.object_index );
			buffer_write( buf, buffer_f32, inst.x );
			buffer_write( buf, buffer_f32, inst.y );
			buffer_write( buf, buffer_f32, inst.depth );
			buffer_write( buf, buffer_u16, inst.sprite_index );
			buffer_write( buf, buffer_f16, inst.image_index );
			buffer_write( buf, buffer_f16, inst.image_angle );
			if ( object_is_ancestor( inst.object_index, obj_solid_dynamic ) )
			{
				buffer_write( buf, buffer_f32, inst.z );
				buffer_write( buf, buffer_f16, inst.height );
				buffer_write( buf, buffer_string, inst.ent_name );
				buffer_write( buf, buffer_u16, inst.collision_flags );
				inst.SaveState( buf );
			};
			if ( object_is_ancestor( inst.object_index, obj_weapon_generic ) )
			{
				inst.SaveState( buf );
			};
			if( object_is_ancestor( inst.object_index, obj_entity ) )
			{
				buffer_write( buf, buffer_f32, inst.z );
				buffer_write( buf, buffer_f16, inst.height );
			};
			if ( object_is_ancestor( inst.object_index, obj_character ) )
			{
				// Character Properties
				buffer_write( buf, buffer_string, inst.charName );
				buffer_write( buf, buffer_u8, inst.char_state );
				//
				buffer_write( buf, buffer_f16, inst.animIndex );
				buffer_write( buf, buffer_f16, inst.charLookDir );
				buffer_write( buf, buffer_u8, inst.no_chase );
				buffer_write( buf, buffer_f16, inst.start_angle );
				buffer_write( buf, buffer_f16, inst.movementDirection );
				buffer_write( buf, buffer_f16, inst.charVelocity );
				
				// Character Stats
				var stats_itemnames = variable_struct_get_names( inst.stats );
				array_sort( stats_itemnames, true );
				for ( var j = 0, count = array_length( stats_itemnames ); j < count; j++ ) {
					buffer_write( buf, buffer_f16, inst.stats[$ stats_itemnames[j]] );
				};
				
				// Character Weapons
				//inst.SaveState( buf );
			};
		
			if ( object_is_ancestor( inst.object_index, obj_player ) )
			{
				buffer_write( buf, buffer_u8, inst.drain );
			};
		
			if ( object_is_ancestor( inst.object_index, obj_ai_dummy ) )
			{
				buffer_write( buf, buffer_u16, inst.entFlags.GetFlags() );
				buffer_write( buf, buffer_f16, inst.patrol_dir );
			};
		}
		catch (e) {
			show_message( "Save failed! - object = " + object_get_name( inst.object_index ) );
			throw e;
		}
	};
	
	if ( global.input_target != noone ) {
		buffer_write( buf, buffer_f32, global.input_target.object_index );
	}
	buffer_write( buf, buffer_f32, global.camera_target.object_index );
	
	print( "Saved [" + string( buffer_tell( buf ) ) + "] Bytes" );
};