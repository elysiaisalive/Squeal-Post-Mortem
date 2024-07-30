event_inherited();

charAbilitySwap();
charAbilityReload();
charAbilityAim();

flashlight.light.x = x;
flashlight.light.y = y;
flashlight.light.angle = transform.angle;
flashlight.light.alpha = flashlightOn;

movement_impulse -= 1 * delta;
movement_impulse = clamp( movement_impulse, 0, 12 );
 
currentXSpd += dcos( charDiveDir ) * movement_impulse * delta;
currentYSpd -= dsin( charDiveDir ) * movement_impulse * delta;