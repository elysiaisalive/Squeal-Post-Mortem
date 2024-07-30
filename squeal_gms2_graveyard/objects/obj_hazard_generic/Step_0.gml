hazard_spd -= hazard_frc * delta;
hazard_spd = clamp(hazard_spd, 0, 256)

x += dcos(direction) * hazard_spd * delta;
y -= dsin(direction) * hazard_spd * delta;
