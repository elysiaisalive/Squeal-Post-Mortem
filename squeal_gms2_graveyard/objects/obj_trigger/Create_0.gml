event_inherited();

setPropHeight( 62 );
Solid_RemoveFlag( BLOCK_ALL );

__self = new cTriggerVolume( self.id );
__self.SetName( triggerName );
__self.SetTriggerTarget( triggerTarget );
__self.Init();