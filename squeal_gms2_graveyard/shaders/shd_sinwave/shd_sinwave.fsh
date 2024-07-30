varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

uniform float u_fTime;
uniform float u_fIntensity;
uniform float u_fWaveSize;

void main()
{
	vec2 uv = ( v_vPosition + vec2( 1.0 ) ) / 2.0;
	vec4 col = texture2D( gm_BaseTexture, vec2( v_vTexcoord.x, v_vTexcoord.y + sin( ( uv.x * 40.0 ) + degrees( u_fTime * u_fIntensity ) ) / u_fWaveSize ) );
	
    gl_FragColor = col * v_vColour;
}