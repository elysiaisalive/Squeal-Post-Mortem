varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vPosition;
varying vec4 v_vWorldPosition;

uniform float u_fTime;
uniform sampler2D u_pAppSurf;
uniform sampler2D u_pDistortionMap;

const float fShockwaveIntensitity = 0.3;

float fX;
float fY;

void main()
{
	float fShockwaveAmount = ( v_vColour.r );
	vec4 vDistortColour = texture2D( u_pDistortionMap, v_vTexcoord );
	
	if ( vDistortColour.b == 1.0 )
		discard;
	
	float fDistortX = ( vDistortColour.r - 0.5 ) * fShockwaveIntensitity * fShockwaveAmount;
	float fDistortY = ( vDistortColour.g - 0.5 ) * fShockwaveIntensitity * fShockwaveAmount;
	
	vec2 vScreenPos = ( ( ( v_vPosition.xy / v_vPosition.w )  ) * 0.5 ) + 0.5;
	fX = vScreenPos.x + fDistortX;
	fY = ( 1.0 - vScreenPos.y ) + fDistortY;
	vec4 vBehind = texture2D( u_pAppSurf, vec2( fX, fY ) );
	
	vec4 vColour = vBehind;
	
	gl_FragColor = vColour;
}
