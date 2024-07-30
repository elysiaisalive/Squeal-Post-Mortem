function charAttackWeapon( cameraShakeEnabled ) {
	var _shootDirection = charLookDir;
	
	if ( canAttack 
	&& !isAttacking ) {
		// Set the prev animation and index so that we can switch back to them later.
		lastAnimation = currentAnimation;
		lastAnimIndex = animIndex;
		
		switch( currentWeapon.attackType ) {
			case ATTACKTYPE.GUN :
			var _bulletDirection = point_direction( 0, 0, currentWeapon.bulletPos.x, currentWeapon.bulletPos.y );
			var _bulletDistance = point_distance( 0, 0, currentWeapon.bulletPos.x, currentWeapon.bulletPos.y );
			var _bulletVector = new Vector2( lengthdir_x( _bulletDistance, _bulletDirection + _shootDirection ), lengthdir_y( _bulletDistance, _bulletDirection + _shootDirection ) );
			var flashdist = _bulletDistance - 6;
			var check_solid = collision_line( x, y, x + _bulletVector.x, y + _bulletVector.y, obj_solid, false, true );
			var check_enemy = collision_point( x + _bulletVector.x, y + _bulletVector.y, obj_character, false, true );
			
			// set bullet to player origin if colliding with solids
			if ( check_solid
			&& check_solid.collision_flags & BLOCK_PROJECTILE ) {
				_bulletDistance = 0;	
			};
			
			// set bullet to player origin if colliding with enemy
			// In the future, we could possibly change this to instead be that the potential damage is just transferred
			// to the enemy, that way we save on CPU and dont spawn a bullet or do any FX. The enemy just dies!
			if ( check_enemy 
			&& charCheckFactionIsAllied( self.id, check_enemy.id ) ) {
				_bulletDistance = 0;
			}
			
			// If our trigger is reset, and we have ammo!
			if ( ( currentTriggerReset <= 0 ) 
			&& ( currentWeapon.ammo > 0 ) ) {
				// Lets start attacking!
				isAttacking = true;
				
				global.shake = currentWeapon.cameraShakeAmount * cameraShakeEnabled;
				
				// God this is a mess, pls fix this dumb shit
				spawnProjectile(
					x + lengthdir_x( _bulletDistance, _bulletDirection + _shootDirection ),
					y + lengthdir_y( _bulletDistance, _bulletDirection + _shootDirection ),
					currentWeapon.bulletProjectile,
					self.id,
					currentWeapon.bulletAmount,
					currentWeapon.bulletVelocity,
					_shootDirection,
					currentWeapon.spread, 
					currentWeapon.bulletStagger
				);
				
				if ( currentWeapon.muzzleFlashSprite != -1 ) {
					var inst = instance_create_depth( x, y, -45, obj_particle_generic );
					
					inst.xoff = lengthdir_x( flashdist, _bulletDirection + _shootDirection );
					inst.yoff = lengthdir_y( flashdist, _bulletDirection + _shootDirection );
					inst.sprite_index		= currentWeapon.muzzleFlashSprite;
					inst.particle_scale 	= 1;
					inst.anim_spd			= currentWeapon.muzzleFlashAnimSpeed * random_range( 1.25, 1.85 );
					inst.particle_spd 		= 0;
					inst.particle_frc		= 0;
					inst.direction			= _shootDirection;
					inst.image_angle		= _shootDirection;
					inst.particle_alpha 	= 1;
					inst.parent_inst		= self.id;
				};
	
				global.stats.BulletsFired ++;
				currentWeapon.ammo -= currentWeapon.ammoPerShot;
				
				currentTriggerReset = currentWeapon.fireRate;
				
				// Setting animation properties to be correct.
				animIndex = 0;
				
				currentAnimation = modify_animation_from_index( charName, currentWeapon.attackSprite, {
					animType : ANIMATION_TYPE.CHAINED,
					animSpd : currentWeapon.animSpeed,
					animNext : lastAnimation, // change this at some point.
					animStartIndex : 0,
					animRepeats : 0,
				} );	
	
				var sound;
	
				// sound = currentWeapon.attackSounds[currentWeapon.sound_index];
				// currentWeapon.sound_index = ( currentWeapon.sound_index + 1 ) % array_length( currentWeapon.attackSounds );
				
				//sfx_play_at( self.id, sound, false, x, y );
				
				if ( currentWeapon.dryfireSound != -1 ) {
					if ( currentWeapon.ammo <= ( currentWeapon.ammoMax * 0.50 ) ) {
						sfx_play_at( self.id, currentWeapon.dryfireSound, false, x, y );	
						global.shake = 2;
					}
				}
			}
			else if ( currentWeapon.dryfireSound != -1 ) {
					if ( currentWeapon.ammo <= 0 ) {
						sfx_play_at( self.id, currentWeapon.dryfireSound, false, x, y );	
						global.shake = 2;
					}
				}
				break;
			// Melee
			default :
				#region MELEE
				if ( currentTriggerReset <= 0 ) {
					isAttacking = true;
					IsMeleeAttacking = true;
					meleePenetration = currentWeapon.penetration;
					
					global.shake = currentWeapon.cameraShakeAmount * cameraShakeEnabled;
			
					currentTriggerReset = currentWeapon.fireRate;
	
					// Setting animation properties to be correct.
					animIndex = 0;
					
					// Eventually make slight changes. If the mouse is held down or there are successive
					// inputs, the next animation in line should be another attack!!!!!
					currentAnimation = modify_animation_from_index( charName, currentWeapon.attackSprite, {
						animType : ANIMATION_TYPE.CHAINED,
						animSpd : 0.35 * melee_attackmultiplier,
						animNext : get_animation_from_index( charName, currentWeapon.walkSprite ),
						animStartIndex : 0,
						animRepeats : 0,
					} );
				
					var sound;
				
					if ( currentWeapon.random_attack_sounds == true )
					{
						sound = currentWeapon.attack_sound[random_range( 0, array_length( currentWeapon.attack_sound ) )];
					}
					else
					{
						sound = currentWeapon.attack_sound[currentWeapon.sound_index];
						currentWeapon.sound_index = ( currentWeapon.sound_index + 1 ) % array_length( currentWeapon.attack_sound );
					}
				
					sfx_play_at( self.id, sound, false, x, y );
	
				}
				#endregion
				break;
		}
	}
};