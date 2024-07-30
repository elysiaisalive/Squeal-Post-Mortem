event_inherited();

setPropHeight( 50 );
Solid_AddFlag( BLOCK_PROJECTILE | BLOCK_MOVEMENT );
Solid_RemoveFlag( BLOCK_VISION );

stats.hp = 0;
shadow_depth = 1;

// ALL TEMP HERE //
timeSinceLastSave = 0;
canRefresh = true;