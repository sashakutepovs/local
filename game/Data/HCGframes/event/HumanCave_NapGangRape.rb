 ####本檔案的種族設定
	if rand(100) <75 then tmpRace 	= "Human" else tmpRace  = "Moot" end
	
	chcg_set_all_race(tmpRace)
####本檔案的種族設定 END

#==========================================劇情FUCK區塊====================================
#==========================================劇情FUCK區塊====================================
#==========================================劇情FUCK區塊====================================
#==========================================劇情FUCK區塊====================================
	chcg_background_color(0,0,0,0,7)

	load_script("Data/Batch/common_MCtorture_Begin_event.rb") if rand(100)+1 >= 80
	chcg_set_all_race(tmpRace)

	
	
#==========================================標準FUCK區塊=====================================
#==========================================標準FUCK區塊=====================================
#==========================================標準FUCK區塊=====================================
#==========================================標準FUCK區塊=====================================
#once we got chsH,  delete this part, use chsH

portrait_hide
chcg_background_color(0,0,0,255)
portrait_off
SndLib.Breathing_Human(80,110)
SndLib.sound_chcg_fapper(80)
SndLib.sound_chcg_full(80)
wait(45)
SndLib.sound_chcg_fapper(80)
SndLib.sound_chcg_full(80)
wait(45)
SndLib.sound_chcg_fapper(80)
SndLib.sound_chcg_full(80)
wait(45)
SndLib.sound_chcg_fapper(80)
SndLib.sound_chcg_full(80)
wait(45)
SndLib.sound_chcg_fapper(80)
SndLib.sound_chcg_full(80)
wait(180)

#$game_player.actor.stat["pose"] = "chcg#{rand(4)+1}"
temp_record_anal_count 		= rand(3)+1   ;$story_stats["sex_record_anal_count"] 		+= temp_record_anal_count
temp_record_vaginal_count	= rand(3)+1   ;$story_stats["sex_record_vaginal_count"] 	+= temp_record_vaginal_count
temp_record_mouth_count 	= rand(3)+1   ;$story_stats["sex_record_mouth_count"] 		+= temp_record_mouth_count
temp_record_cumin_anal 		= rand(3)+1    ;$story_stats["sex_record_cumin_anal"] 		+= temp_record_cumin_anal
temp_record_cumin_mouth 	= rand(1)+1    ;$story_stats["sex_record_cumin_mouth"] 		+= temp_record_cumin_mouth
temp_record_cumin_vaginal	= rand(1)+1    ;$story_stats["sex_record_cumin_vaginal"] 	+= temp_record_cumin_vaginal
temp_record_cumshotted 		= rand(10)+1   ;$story_stats["sex_record_cumshotted"] 		+= temp_record_cumshotted
temp_record_anal_wash 		= rand(1)+1    ;$story_stats["sex_record_anal_wash"] 		+= temp_record_anal_wash 		if $story_stats["Setup_UrineEffect"] >=1
temp_record_piss_drink		= rand(1)+1    ;$story_stats["sex_record_piss_drink"] 		+= temp_record_piss_drink		if $story_stats["Setup_UrineEffect"] >=1
temp_record_pussy_wash		= rand(1)+1    ;$story_stats["sex_record_pussy_wash"]		+= temp_record_pussy_wash		if $story_stats["Setup_UrineEffect"] >=1
$story_stats["sex_record_biggest_gangbang"] +=1
check_over_event


chcg_background_color
#各Slot的key1
$game_player.actor.stat["EventMouth"] = "CumInside1"
$game_player.actor.stat["EventVag"] = "CumInside1"
$game_player.actor.stat["EventAnal"] = "CumInside1"
$game_player.actor.stat["EventExt1"] = "FapperCuming1"
$game_player.actor.stat["EventExt2"] = "FapperCuming1"
$game_player.actor.stat["EventExt3"] = "FapperCuming1"
$game_player.actor.stat["EventExt4"] = "FapperCuming1"

#強制設定SLOT開關
$game_player.actor.stat["analopen"] = 1 if $game_player.actor.stat["EventAnalRace"] != nil
$game_player.actor.stat["vagopen"] = 1 if $game_player.actor.stat["EventVagRace"]   != nil
temp_CumStyle=[
"_CumOutside", ##human only
"_CumInside",
"_CumInside_Overcum"
]
#rb loader
chcg_decider_basic_arousal(pose=rand(5+1))
chcg_decider_basic_mouth(pose=rand(5+1))
load_script("Data/HCGframes/EventMouth#{temp_CumStyle[rand(temp_CumStyle.length)]}.rb")
chcg_decider_basic_anal(pose=rand(5+1))
load_script("Data/HCGframes/EventAnal#{temp_CumStyle[rand(temp_CumStyle.length)]}.rb")
chcg_decider_basic_vag(pose=rand(5+1))
load_script("Data/HCGframes/EventVag#{temp_CumStyle[rand(temp_CumStyle.length)]}.rb")
chcg_decider_basic_fapper(pose=rand(5+1))
load_script("Data/HCGframes/Ext1_Fapper.rb")
load_script("Data/HCGframes/Ext2_Fapper.rb")
load_script("Data/HCGframes/Ext3_Fapper.rb")
load_script("Data/HCGframes/Ext4_Fapper.rb")
half_event_key_cleaner
#事件結束後的清理行為

load_script("Data/Batch/common_MCtorture_End_event.rb") if rand(100) >= 80
chcg_set_all_race(tmpRace)
#若PREG LV1 且異族受孕 且SAT過低 則餵食 (50%)(RB)
check_over_event
check_half_over_event
#==========================================清稿設定====================================
whole_event_end
$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
$story_stats["RapeLoopTorture"] = 0
