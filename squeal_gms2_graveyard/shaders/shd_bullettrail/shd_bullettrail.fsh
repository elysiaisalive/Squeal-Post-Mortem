varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vPosition;
varying vec4 v_vWorldPosition;

uniform float u_fTime;
uniform sampler2D u_pAppSurf;
uniform sampler2D u_pDistortionMap;

const float fRefractIntensity = 0.1;

float fX;
float fY;

void main()
{
	float fRefractAmount = ( v_vColour.r );
	float fAmount = v_vTexcoord.y * min( fRefractAmount * 4.0, 1.0 );
	
	float fDistortX = ( v_vTexcoord.x - 0.5 ) * fRefractIntensity * fRefractAmount * fAmount;
	float fDistortY = ( v_vTexcoord.x - 0.5 ) * fRefractIntensity * fRefractAmount * fAmount;
	
	vec2 vScreenPos = ( ( ( v_vPosition.xy / v_vPosition.w )  ) * 0.5 ) + 0.5;
	fX = vScreenPos.x + fDistortX;
	fY = ( 1.0 - vScreenPos.y ) + fDistortY;
	vec4 vBehind = texture2D( u_pAppSurf, vec2( fX, fY ) );
	
	vec4 vColour = vBehind;
	
	if ( v_vTexcoord.x * fAmount <= 0.1 )
		vColour = ( vec4( v_vTexcoord.x ) ) * fAmount;
	else if ( v_vTexcoord.x * fAmount >= 0.46 )
		vColour += vec4( v_vTexcoord.x ) * 0.05 * fAmount;
	
	gl_FragColor = vColour;
}
