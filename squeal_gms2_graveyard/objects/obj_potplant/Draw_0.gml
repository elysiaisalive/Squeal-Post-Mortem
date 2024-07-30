event_inherited();

for( var i = 0; i < ileafAmnt; ++i ) {
    draw_sprite_ext( spr_potplant_leaves, ileafIndex * i, x + 8 + 1, y + 8 + 1, 1, 1, fleafRotation * i * 180, c_black, 0.50 );
    draw_sprite_ext( spr_potplant_leaves, ileafIndex * i, x + 8, y + 8, 1, 1, fleafRotation * i * 180, c_white, 1 );
}