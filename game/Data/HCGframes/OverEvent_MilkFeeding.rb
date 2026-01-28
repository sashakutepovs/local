if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["EventTargetPart"] = "Breast"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_MilkFeeding.rb"
$game_portraits.lprt.hide
#todo p a error msg when player dont have child on invenrtory
chcg_background_color
half_event_key_cleaner

temp_EventMouthRace = $game_player.actor.stat["EventMouthRace"] #race需求防呆編碼
$game_player.actor.stat["EventMouthRace"] = "Human" if $game_player.actor.stat["EventMouthRace"] == nil #race需求防呆編碼

call_msg("commonH:Lona/FeedingChild_begin")
################################################################################################
	$game_player.actor.stat["EventMouth"] ="Feeding"
	lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.angle=90
	$game_portraits.rprt.set_position(250,710)
	load_script("Data/Batch/baby_Feeding.rb")
	call_msg("QuickMsg:Lona/Feeding#{rand(3)}")
################################################################################################
################################################################################################
	$game_player.actor.stat["EventMouth"] ="Feeding"
	lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.angle=90
	$game_portraits.rprt.set_position(250,710)
	load_script("Data/Batch/baby_Feeding.rb")
	call_msg("QuickMsg:Lona/Feeding#{rand(3)}")
################################################################################################
################################################################################################
	$game_player.actor.stat["EventMouth"] ="Feeding"
	lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.angle=90
	$game_portraits.rprt.set_position(250,710)
	load_script("Data/Batch/baby_Feeding.rb")
	call_msg("QuickMsg:Lona/Feeding#{rand(3)}")
################################################################################################

$story_stats["sex_record_BreastFeeding"] +=1
$game_player.actor.stat["EventMouthRace"] = temp_EventMouthRace #race需求防呆編碼
checkOev_Arousal
$game_player.actor.stat["pose"] = "pose1"
chcg_background_color_off
