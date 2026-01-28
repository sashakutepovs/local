if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true
$game_player.actor.stat["EventTargetPart"] = "Vag"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]},OrkindMonsterPregCheck.rb"
#
half_event_key_cleaner


temp_EventAnalRace = $game_player.actor.stat["EventAnalRace"] #RACE需求防呆編碼
temp_EventVagRace = $game_player.actor.stat["EventVagRace"] #RACE需求防呆編碼
temp_EventExt1Race = $game_player.actor.stat["EventExt1Race"] #RACE需求防呆編碼
$game_player.actor.stat["EventVagRace"] = "Human" if $game_player.actor.stat["EventVagRace"] == nil #RACE需求防呆編碼
$game_player.actor.stat["EventAnalRace"] = "Human" if $game_player.actor.stat["EventAnalRace"] == nil #RACE需求防呆編碼
$game_player.actor.stat["EventExt1Race"] = "Human" if $game_player.actor.stat["EventExt1Race"] == nil #RACE需求防呆編碼

 ####本檔案的種族設定
	if rand(100) <75 then temp_EventVagRace 	= "Goblin" else temp_EventVagRace  = "Orkind" end
	if rand(100) <75 then temp_EventAnalRace 	= "Goblin" else temp_EventAnalRace = "Orkind" end
	if rand(100) <75 then temp_EventMouthRace	= "Goblin" else temp_EventMouthRace= "Orkind" end
	if rand(100) <75 then temp_EventExt1Race 	= "Goblin" else temp_EventExt1Race = "Orkind" end
	if rand(100) <75 then temp_EventExt2Race 	= "Goblin" else temp_EventExt2Race = "Orkind" end
	if rand(100) <75 then temp_EventExt3Race 	= "Goblin" else temp_EventExt3Race = "Orkind" end
	if rand(100) <75 then temp_EventExt4Race	= "Goblin" else temp_EventExt4Race = "Orkind" end
	
	$game_player.actor.stat["EventVagRace"] =  "#{temp_EventVagRace}"
	$game_player.actor.stat["EventAnalRace"] = "#{temp_EventAnalRace}"
	$game_player.actor.stat["EventMouthRace"] ="#{temp_EventMouthRace}"
	$game_player.actor.stat["EventExt1Race"] = "#{temp_EventExt1Race}"
	$game_player.actor.stat["EventExt2Race"] = "#{temp_EventExt2Race}"
	$game_player.actor.stat["EventExt3Race"] = "#{temp_EventExt3Race}"
	$game_player.actor.stat["EventExt4Race"] = "#{temp_EventExt4Race}"
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
	
	
	if ["Goblin","Orkind"].include?($game_actors[1].baby_race)
		$story_stats["Record_CapturedPregCheckPassed"] = 1
		call_msg("common:Lona/MonsterPregChecked_pregnant")
	elsif $game_actors[1].baby_race == nil
		call_msg("common:Lona/MonsterPregChecked_no_pregnant")
	elsif $game_actors[1].baby_race != nil
		call_msg("common:Lona/MonsterPregChecked_race_error")
		$game_actors[1].baby_health *=0.5
		load_script("Data/Batch/common_MCtorture_ForcedMiscarriage.rb")
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
