return SndLib.sys_trigger if $story_stats["RecQuestMT_GotSaintSym"] >= 1
return SndLib.sys_trigger if $game_map.threat
return SndLib.sys_trigger if !cocona_in_group?
return SndLib.sys_trigger if !follower_in_range?(0,5)
call_msg("TagMapMT_crunch:UndeadX/cocona0")
call_msg("TagMapMT_crunch:UndeadX/cocona1")
get_character(0).npc_story_mode(true)
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character($game_player.get_followerID(0)).moveto(get_character(0).x,get_character(0).y+1)
	get_character($game_player.get_followerID(0)).direction = 8
	$game_player.direction = 8
	$game_player.moveto(get_character(0).x+1,get_character(0).y+1)
chcg_background_color(0,0,0,255,-7)
call_msg("TagMapMT_crunch:UndeadX/cocona2") ; portrait_hide
2.times{
	get_character($game_player.get_followerID(0)).call_balloon(20)
	wait(60)
	get_character(0).call_balloon(20)
	wait(60)
}
get_character(0).effects=["CutTree",0,false,nil,nil,[true,false].sample]
SndLib.sound_UndeadDed
wait(60)
get_character(0).effects=["FadeOutDelete",0,false,nil,nil,[true,false].sample]
SndLib.sound_UndeadDed
wait(60)
call_msg("TagMapMT_crunch:UndeadX/cocona2")
get_character($game_player.get_followerID(0)).direction = 6
$game_player.direction = 4
call_msg("TagMapMT_crunch:UndeadX/cocona3")

get_character($game_player.get_followerID(0)).npc_story_mode(true)
get_character($game_player.get_followerID(0)).animation = get_character($game_player.get_followerID(0)).animation_atk_sh
$story_stats["RecQuestMT_GotSaintSym"] = 1
optain_item("ItemMhSaintSym",1) #a23
SndLib.sys_equip
call_msg("TagMapMT_crunch:UndeadX/cocona4")
get_character($game_player.get_followerID(0)).npc_story_mode(false)
eventPlayEnd
