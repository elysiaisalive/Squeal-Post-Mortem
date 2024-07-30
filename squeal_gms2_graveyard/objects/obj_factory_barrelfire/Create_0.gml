event_inherited();

isAnimated = true;
animSpd = 0.10;

var light = instance_create_depth( x, y, z, obj_light_generic );
light.lightScale = 1;
light.lightSprite = spr_lightmask_small;
light.lightAngle = image_angle;
light.lightColour = #ca1200;
light.scaleWhileFlickering = true;
light.flicker = true;
light.playAmbSound = false;
light.flickerSound = -1;