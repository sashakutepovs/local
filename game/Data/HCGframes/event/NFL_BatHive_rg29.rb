if $story_stats["NFL_BatHive_helpHunter"] == 0
	tmpFightPTX,tmpFightPTY,tmpFightPTID=$game_map.get_storypoint("FightPT")
	tmpFightRunPtX,tmpFightRunPtY,tmpFightRunPtID=$game_map.get_storypoint("FightRunPt")
	tmpDaHunterX,tmpDaHunterY,tmpDaHunterID=$game_map.get_storypoint("DaHunter")
	tmpBat1TX,tmpBat1Y,tmpBat1ID=$game_map.get_storypoint("Bat1")
	tmpBat2TX,tmpBat2Y,tmpBat2ID=$game_map.get_storypoint("Bat2")
	$story_stats["NFL_BatHive_helpHunter"] = 1
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_follow(tmpFightPTID,0)
		get_character(tmpDaHunterID).moveto(tmpFightRunPtX,tmpFightRunPtY)
		get_character(tmpBat1ID).moveto(tmpFightPTX-2,tmpFightPTY)
		get_character(tmpBat2ID).moveto(tmpFightPTX+2,tmpFightPTY)
		get_character(tmpDaHunterID).npc_story_mode(true)
		get_character(tmpBat1ID).moveto(get_character(tmpBat1ID).x,get_character(tmpBat1ID).y-10)
		get_character(tmpBat1ID).npc_story_mode(true)
		get_character(tmpBat2ID).npc_story_mode(true)
	chcg_background_color(0,0,0,255,-7)
	30.times{
		get_character(tmpDaHunterID).direction = 6 ; get_character(tmpDaHunterID).move_toward_TargetSmartAI(get_character(tmpFightPTID))
		get_character(tmpDaHunterID).move_speed = 3.5
		until !get_character(tmpDaHunterID).moving? ; wait(1) end
	}
	get_character(tmpDaHunterID).jump_to(get_character(tmpDaHunterID).x,get_character(tmpDaHunterID).y)
	SndLib.AbomBatSpot
	get_character(tmpBat2ID).call_balloon(5)
	wait(60)
	call_msg("TagMapNFL_BatHive:rg29/begin1")
	get_character(tmpDaHunterID).direction = 6
	get_character(tmpDaHunterID).call_balloon(6)
	wait(60)
	get_character(tmpDaHunterID).animation = get_character(tmpDaHunterID).animation_atk_piercing
	SndLib.sound_whoosh
	wait(5)
	SndLib.sound_combat_hit_gore
	wait(5)
	SndLib.AbomBatDed
	get_character(tmpBat2ID).animation = get_character(tmpBat2ID).overkill_animation
	wait(60)
	call_msg("TagMapNFL_BatHive:rg29/begin2")
	get_character(tmpBat1ID).jump_to(tmpFightPTX-1,tmpFightPTY)
	wait(60)
	get_character(tmpBat1ID).turn_toward_character(get_character(tmpDaHunterID))
	SndLib.AbomBatSpot
	wait(60)
	get_character(tmpBat1ID).animation = get_character(tmpBat1ID).animation_atk_piercing
	SndLib.AbomBatSpot
	wait(5)
	get_character(tmpDaHunterID).direction = 4
	wait(5)
	SndLib.sound_combat_hit_gore
	wait(5)
	get_character(tmpDaHunterID).character_index = 3
	wait(5)
	call_msg("TagMapNFL_BatHive:rg29/begin4")
	get_character(tmpDaHunterID).npc_story_mode(false)
	get_character(tmpBat1ID).npc_story_mode(false)
	get_character(tmpBat2ID).npc_story_mode(false)
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_center(0)
		get_character(tmpBat1ID).set_npc("AbomCreatureBat")
		get_character(tmpDaHunterID).move_type = 3
		get_character(tmpDaHunterID).manual_move_type = 3
		#get_character(tmpDaHunterID).set_npc("HumanSpear")
		get_character(tmpDaHunterID).npc.stat.set_stat("sta",0)
		#get_character(tmpDaHunterID).npc.death_event = "EffectRefugeeCharDed"
		#get_character(tmpDaHunterID).npc.fucker_condition={"sex"=>[65535, "="]}
		#get_character(tmpDaHunterID).npc.killer_condition={"morality"=>[0, "<"]}
		#get_character(tmpDaHunterID).npc.assaulter_condition={"morality"=>[0, "<"]}
	chcg_background_color(0,0,0,255,-7)
	eventPlayEnd
end
get_character(0).erase

