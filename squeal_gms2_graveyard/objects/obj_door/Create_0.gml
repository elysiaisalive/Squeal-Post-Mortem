event_inherited();

flags.SetFlag( OBJFLAGS.DYNAMIC );
stats.hp = 200;
stats.hp_max = 200;

setPropHeight( 58 );
Solid_ClearFlags();
Solid_SetFlags( BLOCK_VISION );

__self = new cDoor( self.id );
__self.SetName( $"door{id}" );
__self.SetStartAngle( image_angle );
__self.SetLocked( locked );
__self.Init();

if ( __self.isLocked ) {
    Solid_AddFlag( BLOCK_MOVEMENT );
}