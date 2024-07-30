var _user = user().GetController();

if ( !instance_exists( _user ) ) {
    return;
}

userDistance = point_distance( x, y, _user.transform.position.x, _user.transform.position.y );
animIndex += animSpeed;
rot += rotSpeed;

var _tex = sprite_get_texture( item.worldSprite, 0 );
var _texW = texture_get_width( _tex );
var _texH = texture_get_height( _tex );

if ( animIndex >= sprite_get_number( spr_effect_itemglint ) ) {
    glintPosition.x = random_range( -_texW, _texW );
    glintPosition.y = random_range( -_texW, _texW );
    animIndex = 0;
    rotSpeed = random_range( -4, 6 );
    animSpeed = random_range( 0.1, 0.3 );
}