event_inherited();

height = 45;
currentTurret = instance_create_depth( x, y, depth, obj_lav_turret );

// Prototype
cAI = new cAILAV( self.id, currentTurret.id, "LAV" );
cAI.Init();
cAI.SetSpriteFromIndex( spr_lav_body );
cAI.SetFaction( FACTION.AITEAM2 );
cAI.Draw = function()
{
	// Shadow
	draw_sprite_ext( cAI.charSpriteIndex, cAI.animIndex, x + 1, y + 1, cAI.charSpriteScaleX, cAI.charSpriteScaleY, cAI.charLookDir, c_black, image_alpha * 0.50 );
	//Legs
	if ( cAI.charLegSpriteIndex != -1 )
	{
		draw_sprite_ext( cAI.charLegSpriteIndex, cAI.charLegAnimIndex, x + 1, y + 1, cAI.charSpriteScaleX, cAI.charSpriteScaleY, cAI.charLegDir, c_black, image_alpha * 0.50 );
		draw_sprite_ext( cAI.charLegSpriteIndex, cAI.charLegAnimIndex, x, y, cAI.charSpriteScaleX, cAI.charSpriteScaleY, cAI.charLegDir, image_blend, image_alpha );
	};
	// Body
	draw_sprite_ext( cAI.charSpriteIndex, cAI.animIndex, x, y, cAI.charSpriteScaleX, cAI.charSpriteScaleY, cAI.charLookDir, c_white, image_alpha );
	
	draw_sprite_ext( currentTurret.sprite_index, cAI.animIndex, x - lengthdir_x( 24, cAI.charLookDir ), y - lengthdir_x( 6, cAI.charLookDir ), cAI.charSpriteScaleX, cAI.charSpriteScaleY, cAI.charLookDir, c_white, image_alpha );
	// Overlay
};

#region States
#region Idle cState
idleState = new cState();
idleState.Start = function(){};
idleState.Run = function()
{
    // Is target in vision or can be seen through windows?
    if ( CheckVisionLoS( cAI.GetTarget() ) 
    || CheckMovementLoS( cAI.GetTarget() ) )
	{
        cAI.ChangeState( attackState );
	};
};
#endregion

cAI.ChangeState( idleState );