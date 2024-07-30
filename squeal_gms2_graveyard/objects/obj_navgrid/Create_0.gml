depth		= HEIGHT.GROUND;
cell_w		= 16;
cell_h		= 16;
grid_offset	= 8;
nav_grid_w	= room_width;
nav_grid_h = room_height; 
nav_grid	= 0;
surf		= -1;
redraw		= true;
nav_grid = -1;
bIsUpToDate = false;
solidCount = 0;

// Reinitializes the entire nav_grid 
UpdateGrid = function() {
	mp_grid_clear_all( nav_grid );
	initNavgrid();
	
	bIsUpToDate = true;
}

Cleanup = function()
{
	ds_grid_destroy( nav_grid );
	mp_grid_destroy( nav_grid );
};