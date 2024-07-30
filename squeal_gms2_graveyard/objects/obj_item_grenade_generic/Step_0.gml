grenade_spd -= grenade_frc * delta;

grenade_spd = clamp( grenade_spd, 0, 256 );

x += dcos(direction) * grenade_spd * delta;
y -= dsin(direction) * grenade_spd * delta;
