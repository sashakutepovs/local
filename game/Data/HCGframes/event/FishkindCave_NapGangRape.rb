 ####本檔案的種族設定
	chcg_set_all_race("Fishkind")
####本檔案的種族設定 END

#==========================================劇情FUCK區塊====================================
#==========================================劇情FUCK區塊====================================
#==========================================劇情FUCK區塊====================================
#==========================================劇情FUCK區塊====================================
	chcg_background_color(0,0,0,0,7)
	if $story_stats["RapeLoopTorture"] == 1
		call_msg("TagMapRandFishkindCave:Lona/RapeLoopTorture")
		load_script("Data/Batch/common_MCtorture_Begin_Fish.rb")
		chcg_set_all_race("Fishkind")
		load_script("Data/Batch/common_MCtorture_FunBeaten_event.rb")
		chcg_set_all_race("Fishkind")
	elsif rand(100) >=50
		temp_value = [
		"Data/HCGframes/UniqueEvent_VagDilatation.rb",
		"Data/HCGframes/UniqueEvent_UrinaryDilatation.rb",
		"Data/HCGframes/UniqueEvent_AnalDilatation.rb"
		]
		load_script("#{temp_value[rand(temp_value.length)]}")
		chcg_set_all_race("Fishkind")
	end
	#魔物聞主角的陰部 檢查PREG (50%)(RB) > #若PREG LV2 非 ORKIND GOBLIN > BELLY PUNCH(100%)
	
	
#==========================================標準FUCK區塊=====================================
#==========================================標準FUCK區塊=====================================
#==========================================標準FUCK區塊=====================================
#==========================================標準FUCK區塊=====================================
#once we got chsH,  delete this part, use chsH

portrait_hide
chcg_background_color(0,0,0,255)
portrait_off
SndLib.Breathing_Goblin(40,120)
SndLib.sound_chcg_fapper(80)
SndLib.sound_chcg_full(80)
SndLib.FishkindSmHurt(70)
wait(10+rand(25))
SndLib.FishkindLgSkill(70)
wait(45)
SndLib.sound_chcg_fapper(80)
SndLib.sound_chcg_full(80)
SndLib.FishkindSmHurt(70)
wait(10+rand(25))
SndLib.FishkindLgSkill(70)
wait(45)
SndLib.sound_chcg_fapper(80)
SndLib.sound_chcg_full(80)
SndLib.FishkindSmHurt(70)
wait(10+rand(25))
SndLib.FishkindLgSkill(70)
wait(45)
SndLib.sound_chcg_fapper(80)
SndLib.sound_chcg_full(80)
SndLib.FishkindSmHurt(70)
wait(10+rand(25))
SndLib.FishkindLgSkill(70)
wait(45)
SndLib.sound_chcg_fapper(80)
SndLib.sound_chcg_full(80)
SndLib.FishkindSmHurt(70)
wait(10+rand(25))
SndLib.FishkindLgSkill(70)
wait(60)
$story_stats.sex_record_vag(["DataNpcName:group/FishkindCave"])
$story_stats.sex_record_anal(["DataNpcName:group/FishkindCave"])
$story_stats.sex_record_mouth(["DataNpcName:group/FishkindCave"])

#$game_player.actor.stat["pose"] = "chcg#{rand(4)+1}"
temp_record_anal_count 		= rand(10)+1   ;$story_stats["sex_record_anal_count"] 		+= temp_record_anal_count
temp_record_vaginal_count	= rand(10)+1   ;$story_stats["sex_record_vaginal_count"] 	+= temp_record_vaginal_count
temp_record_mouth_count 	= rand(10)+1   ;$story_stats["sex_record_mouth_count"] 		+= temp_record_mouth_count
temp_record_cumin_anal 		= rand(5)+1    ;$story_stats["sex_record_cumin_anal"] 		+= temp_record_cumin_anal
temp_record_cumin_mouth 	= rand(5)+1    ;$story_stats["sex_record_cumin_mouth"] 		+= temp_record_cumin_mouth
temp_record_cumin_vaginal	= rand(5)+1    ;$story_stats["sex_record_cumin_vaginal"] 	+= temp_record_cumin_vaginal
temp_record_cumshotted 		= rand(20)+1   ;$story_stats["sex_record_cumshotted"] 		+= temp_record_cumshotted
temp_record_anal_wash 		= rand(2)+1    ;$story_stats["sex_record_anal_wash"] 		+= temp_record_anal_wash 		if $story_stats["Setup_UrineEffect"] >=1
temp_record_piss_drink		= rand(2)+1    ;$story_stats["sex_record_piss_drink"] 		+= temp_record_piss_drink		if $story_stats["Setup_UrineEffect"] >=1
temp_record_pussy_wash		= rand(2)+1    ;$story_stats["sex_record_pussy_wash"]		+= temp_record_pussy_wash		if $story_stats["Setup_UrineEffect"] >=1
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
## "_CumOutside", ##human only
"_CumInside",
"_CumInside_Overcum",
"_CumInside_Overcum_Peein",
"_CumInside_Peein"
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

#==========================================劇情FUCK區塊2====================================
#==========================================劇情FUCK區塊2====================================
#==========================================劇情FUCK區塊2====================================
#==========================================劇情FUCK區塊2====================================
if $story_stats["RapeLoopTorture"] == 1
	load_script("Data/Batch/common_MCtorture_End_Fish.rb")
	chcg_set_all_race("Fishkind")
elsif rand(100) >= 50
	temp_value = [
	"Data/HCGframes/UniqueEvent_VagNeedle.rb",
	"Data/HCGframes/UniqueEvent_AnalNeedle.rb",
	"Data/HCGframes/UniqueEvent_Piercing.rb"
	]
	load_script("#{temp_value[rand(temp_value.length)]}")
	chcg_set_all_race("Fishkind")
end
#若PREG LV1 且異族受孕 且SAT過低 則餵食 (50%)(RB)
check_over_event
check_half_over_event
#==========================================清稿設定====================================
whole_event_end
#$game_party.lost_humanoid_baby
$story_stats["DreamPTSD"] = "Fishkind" if $game_player.actor.mood <= -50
$story_stats["RapeLoopTorture"] = 0
