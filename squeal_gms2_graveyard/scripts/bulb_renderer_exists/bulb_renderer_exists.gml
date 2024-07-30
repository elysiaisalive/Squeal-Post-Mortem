function bulb_renderer_exists() {
	if ( instance_exists( obj_lightingengine )
	&& obj_lightingengine.renderer ) {
		return true;
	}
}