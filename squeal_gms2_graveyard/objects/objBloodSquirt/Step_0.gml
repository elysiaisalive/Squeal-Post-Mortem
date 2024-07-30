event_inherited();
if sprite_index=sprBloodSquirt {
if round(random(3))=2 and image_index>=4
{
squirt=instance_create_depth(x+lengthdir_x(38-(image_index-4)*8,image_angle)-2+random(4),y+lengthdir_y(38-(image_index-4)*8,image_angle)-2+random(4),-1,objBloodSplat)
squirt.image_yscale=squirt.image_xscale
}
}

if sprite_index=sprBloodSquirt2 {
if round(random(3))=2 and image_index>=4
{
squirt=instance_create_depth(x+lengthdir_x(64-(image_index-4)*13,image_angle)-2+random(4),y+lengthdir_y(64-(image_index-4)*13,image_angle)-2+random(4),-1,objBloodSplat)
squirt.image_yscale=squirt.image_xscale

squirt=instance_create_depth(x+lengthdir_x(64-(image_index-4)*13,image_angle)-2+random(4),y+lengthdir_y(64-(image_index-4)*13,image_angle)-2+random(4),-1,objBloodSplat)
squirt.image_yscale=squirt.image_xscale
}
}

