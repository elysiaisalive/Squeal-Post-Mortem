// Extreme boss special effects
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vPosition;
varying vec4 v_vWorldPosition;

uniform float u_fTime;

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c )
{
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}


// Holes (Parasite)
uniform bool u_bHoles;
void ApplyHoles( inout vec4 vColour )
{
	
}


// Rainbow (All bosses)
varying vec4 v_vRainbowColor;

void ApplyRainbow( inout vec4 vColour )
{
	float fRainbowHue = ( v_vWorldPosition.z / 32.0 ) - ( u_fTime * ( 0.5 / 1.0 ) );
	vec4 vRainbow = vec4( hsb2rgb( vec3( fRainbowHue, 1.0, 1.0 ) ), vColour.a );
	
	vColour += ( vRainbow * 0.15 );
	vColour = mix( vColour, vRainbow, 0.1);
}


void main()
{
	vec4 vColour = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	if ( ( vColour.a < ( gm_AlphaRefValue / 255.0  ) ) )
		discard;
	
	ApplyHoles( vColour );
	ApplyRainbow( vColour );
	
	
	if ( vColour.a == 0.0 )
		discard;
	gl_FragColor = vColour;
}
