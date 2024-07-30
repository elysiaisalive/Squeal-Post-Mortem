function initTextures() {
	var _texture_groups = [
	    "Default",
	    "tex_ide",
	    "tex_ui",
	    "tex_furniture",
	    "tex_items",
	    "tex_gore",
	    "tex_effects",
	    "tex_debris",
	    "tex_enemy",
	    "tex_derby",
	    "tex_joe",
	    "tex_collisionmasks"
	];
	
	print( "precaching textures" );
	
	for ( var i = 0; i < array_length( _texture_groups ); i++ ) {
	    var _textures = texturegroup_get_textures( _texture_groups[i] );
		
	    for ( var j = 0; j < array_length( _textures ); j++ ) {
	        texture_prefetch( _textures[j] );
	    }
	}
	
	texture_debug_messages( true );
}