/*if abs(swingspeed)>0 exit
if image_angle<-1 {swingspeed=1 exit}
if image_angle>1 {swingspeed=-1 exit}*/
if solid=1 exit
if /*other.object_index=objDogPatrol or*/ other.object_index=objEnemyFat or other.object_index=objInspector  {
swinger=2
if abs(swingspeed)<2 sound_play(sndDoorOpen)
if x>other.x and other.y<y {swingspeed=-8 exit}
if x>other.x and other.y>y {swingspeed=8 exit}
if other.y<y+lengthdir_y(32,image_angle) swingspeed=-8 else swingspeed=8
exit
}

if abs(swingspeed)>3.5 {
if swinger=1 or swinger=0 {
if other.sprite_index=sprEWalkUnarmed or other.sprite_index=sprPoliceWalkUnarmed noweapon=1 else noweapon=0
with other {
if object_get_parent(object_index)=objEnemyIdle {
if room=rmTrainstationEntrance or room=rmHouse3Downstairs or room=rmBossClubFloor3 sprite_index=sprEWalkBat else sprite_index=choose(sprEWalkClub,sprEWalkBat,sprEWalkKnife,sprEWalkPipe,sprEWalkM16,sprEWalkShotgun)
ammo=0
if sprite_index=sprEWalkShotgun ammo=6 
if sprite_index=sprEWalkM16 ammo=24
}
}
sound_play(sndDoorHit)
global.shake=6
if global.maskindex=4 {
my_id=instance_create(other.x,other.y,objDeadBody) 
my_id.sprite_index=choose(sprEBackBlunt,sprEBackBlunt,sprEFrontBlunt)
my_id.image_index=4+round(random(10))
} else my_id=instance_create(other.x,other.y,objKnockedOut)
ds_list_add(global.bonuslist,"Door Slam")
if global.bonustime<12 global.bonustime=12
my_id.type=other.object_index
if scrIsPolice(other.object_index) {if global.maskindex=4 my_id.sprite_index=choose(sprPoliceBackBlunt,sprPoliceBackBlunt,sprPoliceFrontBlunt) else my_id.sprite_index=sprPoliceGetUp}
if swingspeed>0 my_id.direction=90-15+random(30) else my_id.direction=255+random(30)
my_id.angle=my_id.direction
if global.maskindex=4 my_id.image_angle=my_id.direction
my_id.speed=abs(swingspeed)*0.5
if noweapon=0 {
global.test=0
with objEnemy if alert=1 global.test+=1
my_id=instance_create(x,y-12,objScore)
my_id.text="+"+string(180+300*global.factor)+"pts"
global.myscore+=180+300*global.factor
global.boldscore+=180+300*global.factor
global.combotime+=100
global.killx[global.kills]=x
global.killy[global.kills]=y
global.kills+=1
my_id=instance_create(other.x,other.y,objWeaponThrow)
if swingspeed>0 my_id.direction=90-15+random(30)+25 else my_id.direction=255+random(30)+25
my_id.speed=1+random(2)
my_id.ammo=other.ammo
my_id.image_index=scrCurrentWeaponExt(other.sprite_index)
}
with other instance_destroy()
}
exit
}
swinger=2
if abs(swingspeed)<2 sound_play(sndDoorOpen)
if x>other.x and other.y<y {swingspeed=-8 exit}
if x>other.x and other.y>y {swingspeed=8 exit}
if other.y<y+lengthdir_y(32,image_angle) swingspeed=-8 else swingspeed=8

/* */
/*  */
