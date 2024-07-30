currentTriggerReset = clamp( currentTriggerReset - delta / 60, 0, 10000 );

siner += 4 * delta;
siner2 += 0.01 * delta;
	
// if ( gun.bTriggerPressed ) {
// 	shooting_timer.Unpause();
// };

shooting_timer.Tick();

if ( gun_spd > 0 ) {
	gun_spd -= ( gun_fric * delta );
	
	gun_spd = clamp( gun_spd, 0, 256 );
	
	if ( gun_spd == 0 ) {
		z = 0;
	};
	
	depth = ( z - height ) * max( 1, gun_spd );
};

// On ground shooting
// If we are an inmstance of the gun class
// if ( is_instanceof( gun, cWeaponGun )
// && gun.bTriggerPressed
// && ( currentTriggerReset <= 0 ) 
// && ( gun.ammo > 0 )
// && shooting_timer.GetTime() >= 0 ) {
// 	spawnProjectile(
// 		x + lengthdir_x( 0 + sprite_get_width( spr_item_weapons ) / 2, gun_angle ),
// 		y + lengthdir_y( 0 + sprite_get_height( spr_item_weapons ) / 2, gun_angle ),
// 		gun.projectile,
// 		self.id,
// 		gun.amount,
// 		gun_angle,
// 		gun.spread, 
// 		gun.staggered
// 	);
	
// 	if ( gun.muzzleflash_sprite != -1 ) {
// 		spawn_particle(
// 			obj_particle_generic, 
// 			gun.muzzleflash_sprite, 
// 			gun.muzzleflash_animspd * random_range( 1.25, 1.85 ), 
// 			gun_angle, 
// 			gun_angle, 
// 			1, 
// 			x + lengthdir_x( 0 + sprite_get_width( spr_item_weapons ) / 2, gun_angle ),
// 			y + lengthdir_y( 0 + sprite_get_height( spr_item_weapons ) / 2, gun_angle ),,,,,
// 			true
// 		);
// 	};
	
// 	var sound;

// 	if ( gun.random_attack_sounds ) {
// 		sound = gun.attack_sound[random_range( 0, array_length( gun.attack_sound ) )];
// 	}
// 	else {
// 		sound = gun.attack_sound[gun.sound_index];
// 		gun.sound_index = ( gun.sound_index + 1 ) % array_length( gun.attack_sound );
// 	};

// 	playsound_at( sound, x, y );
	
// 	currentTriggerReset = gun.firerate;
// }

x += dcos( direction ) * ( gun_spd * gun.weight ) * delta;
y -= dsin( direction ) * ( gun_spd * gun.weight ) * delta;
gun_angle += ( gun_spd * gun.weight ) * 3 * delta;

// if ( ( gun.ammo <= 0 ) 
// && gun.attack_type == ATTACKTYPE.GUN
// && ( gun_spd <= 9 ) ) {
// 	sprite_index = spr_item_weapons_unloaded;
	
// 	if ( !gun.bMagIsEjected 
// 	&& gun.bEjectMagazine ) {
// 		var inst = instance_create_depth( x, y, height, obj_debris_generic );
		
// 		inst.sprite_index = spr_junk_magazines;
// 		inst.x = x + lengthdir_x( 8, direction ); 
// 		inst.y = y + lengthdir_y( 8, direction );
// 		inst.image_index = gun.mag_frame;
// 		inst.flying = true;
// 		inst.flyspeed = random_range( 10, 12 );
// 		inst.done = false;
// 		inst.gun_angle = random_range( -360, 360 );
// 		inst.debris_spd = random_range( 4, 6 );
// 		inst.debris_frc = random_range( 0.2, 0.3 );
// 		inst.direction = direction - 90;
		
// 		gun.bMagIsEjected = true;
// 	};
// };

x = clamp( x, 0, room_width );
y = clamp( y, 0, room_height );