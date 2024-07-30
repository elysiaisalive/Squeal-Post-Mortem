//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	float focusPower = 8.0;
    int focusDetail = 8;

	vec2 iResolution = vec2( 1920.0, 1080.0 );
    vec2 uv = v_vTexcoord.xy;
    vec2 focusPos = vec2( 0.5 );
    vec2 focus = uv - focusPos;
    

    vec4 outColor;
    outColor = vec4( 0, 0, 0, 1 );


    for ( int i = 0; i < focusDetail; ++i ) 
	{
        float power = 1.0 - focusPower * ( 1.0 / iResolution.x ) * float( i );
        outColor.rgb += texture2D( gm_BaseTexture, focus * power + focusPos ).rgb;
    };
    
    outColor.rgb *= 1.0 / float( focusDetail );

	gl_FragColor = outColor;
}