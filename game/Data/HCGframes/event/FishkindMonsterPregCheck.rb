if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true
$game_player.actor.stat["EventTargetPart"] = "Vag"
#
half_event_key_cleaner


temp_EventAnalRace = $game_player.actor.stat["EventAnalRace"] #RACE需求防呆編碼
temp_EventVagRace = $game_player.actor.stat["EventVagRace"] #RACE需求防呆編碼
temp_EventExt1Race = $game_player.actor.stat["EventExt1Race"] #RACE需求防呆編碼
$game_player.actor.stat["EventVagRace"] = "Human" if $game_player.actor.stat["EventVagRace"] == nil #RACE需求防呆編碼
$game_player.actor.stat["EventAnalRace"] = "Human" if $game_player.actor.stat["EventAnalRace"] == nil #RACE需求防呆編碼
$game_player.actor.stat["EventExt1Race"] = "Human" if $game_player.actor.stat["EventExt1Race"] == nil #RACE需求防呆編碼

	$game_player.actor.stat["EventVagRace"] =  "Fishkind"
	$game_player.actor.stat["EventAnalRace"] = "Fishkind"
	$game_player.actor.stat["EventMouthRace"] ="Fishkind"
	$game_player.actor.stat["EventExt1Race"] = "Fishkind"
	$game_player.actor.stat["EventExt2Race"] = "Fishkind"
	$game_player.actor.stat["EventExt3Race"] = "Fishkind"
	$game_player.actor.stat["EventExt4Race"] = "Fishkind"
####本檔案的種族設定 END

#################################ForcedMiscarriage#############################
# if $story_stats["Record_CapturedPregCheckPassed"] !=1 && rand(100)+1 >= 75
	$game_player.actor.stat["EventAnal"] = "AnalTouch"
	$game_player.actor.stat["EventVag"] = "Snuff"
	$game_player.actor.stat["EventExt1"] = "Grab"
	
	if $story_stats["sex_record_baby_birth"] >=1 || $story_stats["sex_record_miscarriage"] >=1
	call_msg("common:Lona/MonsterPregCheckbegin1_exped")
	else
	call_msg("common:Lona/MonsterPregCheckbegin1_unexped")
	end
	check_over_event
	call_msg("common:Lona/MonsterPregCheckbegin2#{talk_style}")
	check_over_event
	call_msg("common:Lona/MonsterPregCheckbegin3")
	check_over_event
	
	
	if ["Deepone","Fishkind"].include?($game_player.actor.baby_race)
		$story_stats["Record_CapturedPregCheckPassed"] = 1
		call_msg("common:Lona/MonsterPregChecked_pregnant")
	elsif $game_player.actor.baby_race == nil
		call_msg("common:Lona/MonsterPregChecked_no_pregnant")
	elsif $game_player.actor.baby_race != nil
		call_msg("common:Lona/MonsterPregChecked_race_error")
		$game_player.actor.baby_health *=0.5
		load_script("Data/Batch/common_MCtorture_ForcedMiscarriage.rb")
		$game_player.actor.health = 50 if $game_player.actor.health < 50
	end
	
#end
#################################ForcedMiscarriage#############################



$game_player.actor.stat["EventVagRace"] = temp_EventVagRace #RACE需求防呆編碼
$game_player.actor.stat["EventAnalRace"] = temp_EventAnalRace #RACE需求防呆編碼
$game_player.actor.stat["EventExt1Race"] = temp_EventExt1Race #RACE需求防呆編碼
$story_stats["sex_record_groped"] +=1
$story_stats["sex_record_groin_harassment"] +=1
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
half_event_key_cleaner
