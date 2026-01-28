
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
tmpWakeUpJohnsonID = $game_map.get_storypoint("WakeUpJohnson")[2]
tmpDualBiosEV = get_character(tmpDualBiosID)
$game_map.interpreter.map_background_color(128,128,40,40)
SndLib.bgs_play("Cave/Cavern Sound effect_Short",50)
SndLib.bgm_play("Cave/Ambient Dungeon LOOP",73)
$game_map.set_fog("cave_fall")
fadeout=$story_stats["ReRollHalfEvents"] == 1
# wake up first rape by dirty johnson
if $story_stats["RecQuDirtyJohnson"] != -1 && (tmpDualBiosEV.summon_data[:DirtyJohnsonFirstTimeAggro] == true || tmpDualBiosEV.summon_data[:DirtyJohnsonSecondTimeAggro] == true) && !tmpDualBiosEV.summon_data[:DirtyJohnsonFirstTimeWakeRape]
	tmpDirtyJohnsonID = $game_map.get_storypoint("DirtyJohnson")[2]
	tmpJohnsonDoorX,tmpJohnsonDoorY = $game_map.get_storypoint("JohnsonDoor")
	tmpDualBiosEV.summon_data[:DirtyJohnsonFirstTimeWakeRape] = true
	enter_static_tag_map("WakeUpJohnson",false)
	tmpLonaSta = $game_player.actor.sta
	$game_player.actor.sta = -99
	tmpJohnsonX = get_character(tmpDirtyJohnsonID).x
	tmpJohnsonY = get_character(tmpDirtyJohnsonID).y
	tmpJohnsonD = get_character(tmpDirtyJohnsonID).direction
	get_character(tmpDirtyJohnsonID).moveto($game_player.x,$game_player.y+1)
	get_character(tmpDirtyJohnsonID).turn_toward_character($game_player)
	get_character(tmpDirtyJohnsonID).unset_chs_sex
	get_character(tmpDirtyJohnsonID).move_type = 0
	get_character(tmpDirtyJohnsonID).set_manual_move_type(0)
	get_character(tmpDirtyJohnsonID).npc_story_mode(true)

	if $story_stats["dialog_vag_virgin"] == 0
		$game_player.actor.add_state("EffectBleedVag")
		$story_stats["dialog_vag_virgin"] = 0
		$story_stats["sex_record_vaginal_count"] += 1
		$story_stats["sex_record_cumin_vaginal"] += 1
		$story_stats["sex_record_first_vag"] = ["DataNpcName:name/UniqueDirtyJohnson", "DataNpcName:part/penis"]
	end
	#if $story_stats["dialog_anal_virgin"] == 0
	#	$game_player.actor.add_state("EffectBleedAnal")
	#	$story_stats["dialog_anal_virgin"] = 0
	#	$story_stats["sex_record_anal_count"] += 1
	#	$story_stats["sex_record_cumin_anal"] += 1
	#	$story_stats["sex_record_first_anal"] = ["DataNpcName:name/UniqueDirtyJohnson", "DataNpcName:part/penis"]
	#end
	$story_stats["sex_record_coma_sex"] += 1


	get_character(tmpDirtyJohnsonID).set_event_fuck_a_target($game_player,temp_tar_slot="vag",forcePose=2,tmpAniStage=0)
	portrait_off
	5.times{
		SndLib.sound_chs_buchu(80)
		wait(45)
	}
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapHumanPrisonCave:DirtyJohnson/FirstWakeupRape0")
	portrait_hide
	7.times{
		SndLib.sound_chs_buchu(80)
		wait(45)
	}
	get_character(tmpDirtyJohnsonID).set_event_fuck_a_target($game_player,temp_tar_slot="vag",forcePose=2,tmpAniStage=1)
	call_msg("TagMapHumanPrisonCave:DirtyJohnson/FirstWakeupRape1")
	portrait_hide
	13.times{
		SndLib.sound_chs_buchu(80)
		wait(20)
	}
	get_character(tmpDirtyJohnsonID).set_event_fuck_a_target($game_player,temp_tar_slot="vag",forcePose=2,tmpAniStage=2)
	call_msg("TagMapHumanPrisonCave:DirtyJohnson/FirstWakeupRape2")
	portrait_hide
	3.times{
		SndLib.sound_chs_buchu(80)
		wait(60)
	}
	call_msg("TagMapHumanPrisonCave:DirtyJohnson/FirstWakeupRape3")
	$game_player.actor.stat["EventVagRace"] =  "Human"
	$game_player.actor.stat["EventVag"] = "CumInside1"
	load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	portrait_off
	#		["#{$game_text["menu:sex_stats/record_first_mouth"]} : ",		gen_sex_basic_hole_text($story_stats["sex_record_first_mouth"]),true],
	#		["#{$game_text["menu:sex_stats/record_first_vag"]} : ",			gen_sex_basic_hole_text($story_stats["sex_record_first_vag"]),true],
	#		["#{$game_text["menu:sex_stats/record_first_anal"]} : ",		gen_sex_basic_hole_text($story_stats["sex_record_first_anal"]),true],
	#		["#{$game_text["menu:sex_stats/record_last_mouth"]} : ",		gen_sex_basic_hole_text($story_stats["sex_record_last_mouth"]),true],
	#		["#{$game_text["menu:sex_stats/record_last_vag"]} : ",			gen_sex_basic_hole_text($story_stats["sex_record_last_vag"]),true],
	#		["#{$game_text["menu:sex_stats/record_last_anal"]} : ",			gen_sex_basic_hole_text($story_stats["sex_record_last_anal"]),true]
	#$story_stats["dialog_anal_virgin"] = 0
	#$story_stats["dialog_vag_virgin"] = 0
	#
	#$story_stats["sex_record_vaginal_count"] != 0
	#$story_stats["sex_record_anal_count"] != 0
	#if $story_stats["dialog_vag_virgin"]==1 && $story_stats["sex_record_vaginal_count"] != 0
	#if no sex exp. add blood, record first partner, remove vargin
	# add sleeping sex



	chcg_background_color(0,0,0,0,7)
	$game_player.unset_chs_sex
	get_character(tmpDirtyJohnsonID).unset_chs_sex
	get_character(tmpDirtyJohnsonID).npc_story_mode(false)
	$game_player.actor.sta = tmpLonaSta
	get_character(tmpDirtyJohnsonID).moveto(tmpJohnsonDoorX+1,tmpJohnsonDoorY)
	get_character(tmpDirtyJohnsonID).direction = 6
	get_character(tmpDirtyJohnsonID).summon_data[:DoorBlockMode] = true
	get_character(tmpDirtyJohnsonID).call_balloon(28,-1) if get_character(tmpDirtyJohnsonID).summon_data[:DoorBlockMode] == true
	enter_static_tag_map("WakeUpJohnson",true)

	call_msg("TagMapHumanPrisonCave:DirtyJohnson/FirstWakeupRape4")

	$game_player.actor.add_state("STD_WartVag")
	$game_player.actor.add_state("STD_HerpesVag")
	$game_player.actor.add_state("ParasitedPotWorm")
else
	enter_static_tag_map(nil,fadeout)
end
summon_companion

eventPlayEnd

$game_pause = false #to fix a unknow bug in this map
get_character(0).erase
