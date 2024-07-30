if ( fade )
{
	particle_alpha -= fadespeed * delta;
};

if ( particle_alpha == 0 )
{
	instance_destroy();
};

if ( !fade )
{
	anim_index += anim_spd * delta;
}
else
if ( fade && ( anim_index <= image_number ) )
{
	anim_index += anim_spd * delta;
};

if ( !fade && ( anim_index >= image_number ) )
{
	instance_destroy();
	exit;
}
else
if ( fade && ( particle_alpha <= 0 ) )
{
	instance_destroy();
};

particle_spd -= particle_frc * delta;
particle_spd = clamp( particle_spd, 0, 256 );
x += dcos( direction ) * particle_spd * delta;
y -= dsin( direction ) * particle_spd * delta;
