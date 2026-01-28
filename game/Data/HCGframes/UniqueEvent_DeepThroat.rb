if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
 if $game_actors[1].sensitivity_mouth >=5 || $game_actors[1].state_stack(102) !=0 || $game_player.actor.stat["AsVulva_Esophageal"] ==1
	$game_player.actor.stat["AllowOgrasm"] = true
	else
	$game_player.actor.stat["AllowOgrasm"] = false
end
$game_player.actor.stat["EventTargetPart"] = "Mouth" 
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_DeepThroat"
$game_portraits.lprt.hide

#removed race key 18 8 23
chcg_background_color
#half_event_key_cleaner
temp_EventMouthRace = $game_player.actor.stat["EventMouthRace"] #RACE需求防呆編碼
$game_player.actor.stat["EventMouthRace"] = "Human" if $game_player.actor.stat["EventMouthRace"] == nil #RACE需求防呆編碼
chcg_decider_basic(pose=5)
########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventMouth"] ="nil"
lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -143
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
call_msg("commonH:Lona/DeepThroat_begin")

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventMouth"] ="DeepThroat1"
lona_mood "chcg5fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -143
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
call_msg("commonH:Lona/DeepThroat_begin2#{talk_style}")

########################################################################frame 2!!!!!!!###################################################################################################

4.times{
	SndLib.sound_chs_pyu(80)
	$game_player.actor.stat["EventMouth"] ="DeepThroat2"
	$game_player.actor.stat["HeadGround"] = 0
	$game_player.actor.stat["mouth"] = 0
	lona_mood nil
	$game_player.actor.stat["chcg_x"] = -148 ; $game_player.actor.stat["chcg_y"] = -161
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.update
	
	wait(10)
	#SndLib.sound_chs_dopyu(80)
	$game_player.actor.stat["EventMouth"] ="DeepThroat3"
	$game_player.actor.stat["HeadGround"] = 1
	$game_player.actor.stat["mouth"] = 0
	lona_mood "chcg5fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -127 ; $game_player.actor.stat["chcg_y"] = -148
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.update
	wait(10)
}
load_script("Data/Batch/DeepThroat_control.rb")
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#message control
call_msg("commonH:Lona/beaten#{rand(10)}")
call_msg("commonH:Lona/DeepThroat_begin3")
########################################################################frame 2!!!!!!!###################################################################################################
4.times{
	SndLib.sound_chs_pyu(80)
	$game_player.actor.stat["EventMouth"] ="DeepThroat2"
	$game_player.actor.stat["HeadGround"] = 0
	$game_player.actor.stat["mouth"] = 0
	lona_mood nil
	$game_player.actor.stat["chcg_x"] = -148 ; $game_player.actor.stat["chcg_y"] = -161
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.update
	wait(10)
	SndLib.sound_chs_dopyu(80)
	
	$game_player.actor.stat["EventMouth"] ="DeepThroat3"
	$game_player.actor.stat["HeadGround"] = 1
	$game_player.actor.stat["mouth"] = 0
	lona_mood "chcg5fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -127 ; $game_player.actor.stat["chcg_y"] = -148
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.update
	wait(8)
}
load_script("Data/Batch/DeepThroat_control.rb")
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#message control
call_msg("commonH:Lona/beaten#{rand(10)}")
call_msg("commonH:Lona/DeepThroat_begin4")

########################################################################frame 2!!!!!!!###################################################################################################
4.times{
	SndLib.sound_chs_pyu(80)
	$game_player.actor.stat["EventMouth"] ="DeepThroat2"
	$game_player.actor.stat["HeadGround"] = 0
	$game_player.actor.stat["mouth"] = 0
	lona_mood nil
	$game_player.actor.stat["chcg_x"] = -148 ; $game_player.actor.stat["chcg_y"] = -161
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.update
	wait(5+rand(9))
	
	SndLib.sound_chs_dopyu(80)
	$game_player.actor.stat["EventMouth"] ="DeepThroat3"
	$game_player.actor.stat["HeadGround"] = 1
	$game_player.actor.stat["mouth"] = 0
	lona_mood "chcg5fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -127 ; $game_player.actor.stat["chcg_y"] = -148
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.update
	wait(5)
}
load_script("Data/Batch/DeepThroat_control.rb")
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#message control
call_msg("commonH:Lona/beaten#{rand(10)}")
########################################################################frame 2!!!!!!!###################################################################################################
6.times{
	SndLib.sound_chs_pyu(80)
	$game_player.actor.stat["EventMouth"] ="DeepThroat2"
	$game_player.actor.stat["HeadGround"] = 0
	$game_player.actor.stat["mouth"] = 0
	lona_mood nil
	$game_player.actor.stat["chcg_x"] = -148 ; $game_player.actor.stat["chcg_y"] = -161
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.update
	wait(5)
	
	SndLib.sound_chs_dopyu(80)
	$game_player.actor.stat["EventMouth"] ="DeepThroat3"
	$game_player.actor.stat["HeadGround"] = 1
	$game_player.actor.stat["mouth"] = 0
	lona_mood "chcg5fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -127 ; $game_player.actor.stat["chcg_y"] = -148
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.update
	wait(5+rand(5))
}
load_script("Data/Batch/DeepThroat_control.rb")
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#message control
call_msg("commonH:Lona/beaten#{rand(10)}")
call_msg("commonH:Lona/DeepThroat_begin5")
call_msg("commonH:Lona/DeepThroat_begin6")
#########################################################################frame 2!!!!!!!###################################################################################################
2.times{
	SndLib.sound_chs_pyu(80)
	$game_player.actor.stat["EventMouth"] ="DeepThroat2"
	$game_player.actor.stat["HeadGround"] = 0
	$game_player.actor.stat["mouth"] = 0
	lona_mood nil
	$game_player.actor.stat["chcg_x"] = -148 ; $game_player.actor.stat["chcg_y"] = -161
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.shake
	$game_player.actor.portrait.update
	wait(40)
	
	SndLib.sound_chs_dopyu(80)
	$game_player.actor.stat["EventMouth"] ="DeepThroat3"
	$game_player.actor.stat["HeadGround"] = 1
	$game_player.actor.stat["mouth"] = 0
	lona_mood "chcg5fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -127 ; $game_player.actor.stat["chcg_y"] = -148
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.update
	wait(20)
}
load_script("Data/Batch/DeepThroat_control.rb")
chcg_add_cums("EventMouthRace","CumsMouth") ; $game_player.actor.puke_value_normal += rand(100)
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#message control
call_msg("commonH:Lona/beaten#{rand(10)}")
########################################################################frame 2!!!!!!!###################################################################################################
1.times{
	SndLib.sound_chs_pyu(80)
	$game_player.actor.stat["EventMouth"] ="DeepThroat6"
	$game_player.actor.stat["HeadGround"] = 0
	$game_player.actor.stat["mouth"] = 0
	lona_mood nil
	$game_player.actor.stat["chcg_x"] = -148 ; $game_player.actor.stat["chcg_y"] = -161
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.shake
	$game_player.actor.portrait.update
	wait(50)
	
	SndLib.sound_chs_dopyu(80)
	$game_player.actor.stat["EventMouth"] ="DeepThroat7"
	$game_player.actor.stat["HeadGround"] = 1
	$game_player.actor.stat["mouth"] = 0
	lona_mood "chcg5fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -127 ; $game_player.actor.stat["chcg_y"] = -148
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.update
	$game_player.actor.portrait.shake
	wait(30)
}
load_script("Data/Batch/DeepThroat_control.rb")
chcg_add_cums("EventMouthRace","CumsMouth") ; $game_player.actor.puke_value_normal += rand(100)
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#message control
call_msg("commonH:Lona/beaten#{rand(10)}")
########################################################################frame 2!!!!!!!###################################################################################################

$game_player.actor.stat["EventMouth"] ="DeepThroat8"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = -159 ; $game_player.actor.stat["chcg_y"] = -137
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/DeepThroat_control.rb")
chcg_add_cums("EventMouthRace","CumsHead")
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#message control
call_msg("commonH:Lona/DeepThroat_end")
########################################################################frame 2!!!!!!!###################################################################################################

$game_player.actor.stat["EventMouth"] ="DeepThroat8"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = -159 ; $game_player.actor.stat["chcg_y"] = -137
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
check_over_event
#message control
call_msg("commonH:Lona/DeepThroat_end2#{talk_style}")
################################################################################################

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$game_player.actor.stat["EventMouthRace"] = temp_EventMouthRace #RACE需求防呆編碼
$game_player.actor.stat["HeadGround"] = 0 #return to default
$game_player.actor.stat["EventMouth"] = nil
$story_stats["sex_record_mouth_count"]+=1
half_event_key_cleaner
chcg_background_color_off
