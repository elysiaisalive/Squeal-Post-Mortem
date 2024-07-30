if other.object_index=objWallSoftH or other.object_index=objWallSoftV or other.object_index=objDoorV or other.object_index=objDoorH
or other.object_index=objDoorV2 or other.object_index=objDoorH2{
if solid=1 {
x+=hspeed
y+=vspeed
}
if passed=0 {
passed=1
dirx=x-lengthdir_x(16,direction)
diry=y-lengthdir_y(16,direction)
}
exit
}

if other.object_index=objGlassPanelH {
SteamIncStat("Windows",1)
if vspeed>0 {
other.add=-1
} else {
other.add=1
}
with other {
i=0
repeat (24) {
my_id=instance_create_depth(x+i*1.5,y,-6,objShard)
my_id.speed=random(5)
my_id.direction=add*90-8+random(16)
i+=1
}
instance_create_depth(x,y,0,objGlassPanelHBroken)
instance_destroy()
if !sound_isplaying(sndGlass1) and !sound_isplaying(sndGlass2) {
sound_play(choose(sndGlass1,sndGlass2))
}
}
exit
}

if other.object_index=objGlassPanelV {
SteamIncStat("Windows",1)
if hspeed>0 {
other.add=-1
} else {
other.add=1
}
with other {
i=0
repeat (24) {
my_id=instance_create_depth(x,y+i*1.5,-6,objShard)
my_id.speed=random(5)
my_id.direction=90+add*90-8+random(16)
i+=1
}
instance_create_depth(x,y,0,objGlassPanelVBroken)
instance_destroy()
if !sound_isplaying(sndGlass1) and !sound_isplaying(sndGlass2) {
sound_play(choose(sndGlass1,sndGlass2))
}
}
exit
}

