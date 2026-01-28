get_character(0).npc_story_mode(true)
get_character(0).jump_to(get_character(0).x,get_character(0).y)

if $story_stats["RecQuestNoerSnowflake"] == -1
	#do nothing
else
	call_msg("TagMapNoerTransHouse:Trans/RageQuit0")
	call_msg("TagMapNoerTransHouse:Trans/RageQuit1")
end

get_character(0).animation = get_character(0).animation_atk_mh
$game_player.actor.stat["EventVagRace"] = "Human"
load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
wait(10)
$game_player.animation = $game_player.animation_stun
wait(60)
portrait_hide
chcg_background_color(0,0,0,0,7)
get_character(0).npc_story_mode(false)
call_msg("common:Lona/NarrDriveAway")
#$story_stats["RecQuestNoerSnowflake"] = -1
change_map_leave_tag_map