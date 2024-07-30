draw_sprite_ext( item.worldSprite, item.animIndex, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha );

// Drawing glint
var _alpha = 1 - ( abs( min( 0, userDistance ) ) / maxDistance );

draw_sprite_ext( spr_effect_itemglint, animIndex, x + glintPosition.x, y + glintPosition.y, 1, 1, rot, c_white, _alpha );