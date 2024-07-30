// Creating the grid
nav_grid = mp_grid_create(
	0 + grid_offset,
	0 + grid_offset,
	nav_grid_w / cell_w,
	nav_grid_h / cell_h,
	cell_w,
	cell_h
);

initNavgrid();

nav_grid = ds_grid_create( nav_grid_w / cell_w, nav_grid_h / cell_h, );
mp_grid_to_ds_grid( nav_grid, nav_grid );