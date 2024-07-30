light = new BulbLight( obj_lightingengine.renderer, lightSprite, lightIndex, lightPos.x, lightPos.y );
light.SetScale( lightScale );
light.SetBlend( lightColour );
light.alpha = lightAlpha;
light.angle = lightAngle;
light.penumbraSize = lightPenumbra;

if ( !global.lighting_enabled ) {
    light.Destroy();
}