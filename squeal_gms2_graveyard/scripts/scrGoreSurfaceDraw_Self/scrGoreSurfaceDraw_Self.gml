/// @description scrGoreSurfaceDraw()
function scrGoreSurfaceDraw_Self() {
	if (instance_exists(obj_surface_manager) and surface_exists(obj_surface_manager.GetSurf())) {
	    x *= obj_surface_manager.scale
	    y *= obj_surface_manager.scale
	    image_xscale *= obj_surface_manager.scale
	    image_yscale *= obj_surface_manager.scale
    
	    draw_self()
    
	    x /= obj_surface_manager.scale
	    y /= obj_surface_manager.scale
	    image_xscale /= obj_surface_manager.scale
	    image_yscale /= obj_surface_manager.scale
    
	}




}
