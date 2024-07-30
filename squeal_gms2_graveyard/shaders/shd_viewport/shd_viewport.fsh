varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void PremultiplyAlpha( inout vec4 vColour )
{
	vColour = mix( vColour, vec4( vColour.rgb * vColour.a, vColour.a ), 1.0 - vColour.a );
	if ( vColour.a == 0.0 )
		discard;
}


void main()
{
	vec4 vColour = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	if ( ( vColour.a ) < ( gm_AlphaRefValue / 255.0 ) )
		discard;
	
	vColour.a = 1.0;
	
	PremultiplyAlpha( vColour );
	
	gl_FragColor = vColour;
}