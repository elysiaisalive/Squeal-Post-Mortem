event_inherited();

glow_sin += 0.18 * delta;
glow_c1 = merge_color( c_yellow, c_white, abs( sin( glow_sin ) ) + 0.20 );
