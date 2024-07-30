/// @desc Initializes the nodegraph by adding objects with the block_movement solid flag
function initNavgrid() {
	var wsize = cell_w / 16;
	var hsize = cell_h / 16;
	
	with ( obj_solid )
	{
		if ( Solid_GetFlag( BLOCK_MOVEMENT ) && !nodegraph_ignore )
		{
			var xpos = x;
			var ypos = y;
			
			for ( var i = 0; i < 360; i += 45 )
			{
				x = xpos + ( dcos( i ) * wsize );
				y = ypos + ( dsin( i ) * hsize );
				mp_grid_add_instances( obj_navgrid.nav_grid, id, true );
			};
			
			x = xpos;
			y = ypos;
		};
	};
};