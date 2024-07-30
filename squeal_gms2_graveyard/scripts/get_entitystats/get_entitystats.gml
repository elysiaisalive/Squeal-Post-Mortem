//function get_entitystats( entity = obj_character ) {
		
//	var list		= ds_list_create();
//	var result		= false;
//	var _id			= [];
//	var ent_detect	= collision_circle_list( global.mousex, global.mousey, 8, entity, false, false, list, false );
//	var _x			= 0;
//	var _y			= 0;
//	var _angle		= 0;
//	var _stats		= 0;
//	var _char		= 0;
	
//	for ( var i = 0; i < ent_detect; ++i )
//	{
//		var inst = list[| i];

//		array_push( _id, inst );
				
//		result	= true;
		
//		_x		= entity.x;
//		_y		= entity.y;
//		_angle	= entity.charLookDir;
//		_stats	= entity.stats;
//		_char	= entity.char;

//		break;
//	}

//	ds_list_destroy( list );
	
//	return [result, _id, _stats, _char];
//}