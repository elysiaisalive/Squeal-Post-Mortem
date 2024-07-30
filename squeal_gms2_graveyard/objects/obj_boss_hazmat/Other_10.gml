#region Animations list
char = "BossHazmat"
anim_list=[]
var temp_array=tag_get_assets(char)
for(var i=0;i<array_length(temp_array);i++){
array_push(anim_list,asset_get_index(temp_array[i]))
array_push(anim_list,string_replace(sprite_get_name(asset_get_index(temp_array[i])),"spr"+char+"_","") )
}
show_debug_message(string(anim_list))
#endregion