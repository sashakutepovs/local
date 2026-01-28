tmpGirlX,tmpGirlY,tmpGirlID=$game_map.get_storypoint("Girl")
tmpManX,tmpManY,tmpManID=$game_map.get_storypoint("Man")
tmpHorse0X,tmpHorse0Y,tmpHorse0ID=$game_map.get_storypoint("horse0")
tmpHorse1X,tmpHorse1Y,tmpHorse1ID=$game_map.get_storypoint("horse1")
tmpHorse2X,tmpHorse2Y,tmpHorse2ID=$game_map.get_storypoint("horse2")
tmpGkX,tmpGkY,tmpGkID=$game_map.get_storypoint("GuardKiller")
tmpHkX,tmpHkY,tmpHkID=$game_map.get_storypoint("HorseKiller")
tmpMdX,tmpMdY,tmpMdID=$game_map.get_storypoint("MainDude")
tmpBotLeftX,tmpBotLeftY,tmpBotLeftID=$game_map.get_storypoint("BotLeftFire")
tmpRightCampX,tmpRightCampY,tmpRightCampD=$game_map.get_storypoint("RightCamp")
tmpMcX,tmpMcY,tmpMcID=$game_map.get_storypoint("MapCont")

if $story_stats["RecQuestGuideToDoomFort"] == 0
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$story_stats["RecQuestGuideToDoomFort"] = 1
		get_character(tmpGirlID).moveto(tmpGirlX,tmpGirlY)
		get_character(tmpManID).moveto(tmpManX,tmpManY)
		get_character(tmpGkID).moveto(tmpRightCampX-1,tmpRightCampY+1)
		get_character(tmpHkID).moveto(tmpBotLeftX-1,tmpBotLeftY)
		get_character(tmpMdID).moveto(tmpGirlX,tmpGirlY-2)
		get_character(tmpHorse0ID).moveto(tmpHorse0X,tmpHorse0Y)
		get_character(tmpHorse1ID).moveto(tmpHorse1X,tmpHorse1Y)
		get_character(tmpHorse2ID).moveto(tmpHorse2X,tmpHorse2Y)
		get_character(tmpGirlID).npc_story_mode(true)
		get_character(tmpManID).npc_story_mode(true)
		get_character(tmpHorse0ID).npc_story_mode(true)
		get_character(tmpGkID).npc_story_mode(true)
		get_character(tmpHkID).npc_story_mode(true)
		get_character(tmpMdID).npc_story_mode(true)
		call_msg("TagMapAbanHouse3:Start/begin_1")
		SndLib.sound_eat(90)
		wait(50+rand(20))
		SndLib.sound_eat(85)
		wait(50+rand(20))
		SndLib.sound_eat(90)
		wait(50+rand(20))
	chcg_background_color(0,0,0,255,-7)
	
	call_msg("TagMapAbanHouse3:Start/begin_2")
	get_character(tmpGirlID).direction = 6
	get_character(tmpManID).direction = 4
	call_msg("TagMapAbanHouse3:Start/begin_3")
	get_character(tmpGirlID).direction = 8
	get_character(tmpManID).direction = 8
	get_character(tmpManID).move_forward
	wait(30)
	get_character(tmpManID).direction = 4
	get_character(tmpManID).move_forward
	wait(30)
	get_character(tmpManID).direction = 8
	wait(30)
	get_character(tmpManID).animation = get_character(tmpManID).animation_atk_sh
	SndLib.sound_equip_armor
	call_msg("TagMapAbanHouse3:Start/begin_4")
	
	#殺馬
	get_character(tmpHkID).jump_to(tmpBotLeftX,tmpBotLeftY-1)
	get_character(tmpHkID).direction =8
	get_character(tmpHkID).direction =6
	get_character(tmpHkID).move_forward
	wait(60)
	get_character(tmpHkID).move_forward
	wait(50)
	get_character(tmpHkID).call_balloon(3)
	wait(60)
	get_character(tmpHkID).animation = get_character(tmpHkID).animation_atk_mh
	wait(20)
	SndLib.sound_combat_hit_gore
	get_character(tmpHkID).animation = get_character(tmpHkID).animation_atk_sh
	wait(30)
	SndLib.sound_combat_hit_gore
	get_character(tmpHorse0ID).animation = get_character(tmpHorse0ID).overkill_animation
	get_character(tmpHorse0ID).through = true
	get_character(tmpHorse0ID).priority_type = 0
	SndLib.horseDed(70)
	wait(60)
	get_character(tmpGirlID).direction = 2
	get_character(tmpManID).direction = 2
	
	#殺管家
	call_msg("TagMapAbanHouse3:Start/begin_5")
	get_character(tmpGirlID).direction = 8
	get_character(tmpManID).direction = 6
	get_character(tmpManID).move_forward
	wait(30)
	get_character(tmpGirlID).direction = 6
	get_character(tmpManID).direction = 2
	get_character(tmpManID).move_forward
	get_character(tmpGkID).move_forward
	wait(30)
	get_character(tmpManID).move_forward
	wait(2)
	get_character(tmpGkID).animation = get_character(tmpGkID).animation_atk_piercing
	SndLib.sound_whoosh
	wait(12)
	SndLib.sound_combat_hit_gore
	get_character(tmpManID).animation = get_character(tmpManID).animation_randomCHScropse
	get_character(tmpManID).through = true
	get_character(tmpManID).priority_type = 0
	SndLib.sound_MaleWarriorDed
	call_msg("TagMapAbanHouse3:Start/begin_5_1")
	get_character(tmpGirlID).direction = 4
	wait(30)
	#抓小姐
	call_msg("TagMapAbanHouse3:Start/begin_6")
	get_character(tmpMdID).move_forward
	wait(60)
	SndLib.sound_equip_armor
	get_character(tmpGirlID).animation = get_character(tmpGirlID).animation_grabbed_qte
	get_character(tmpMdID).animation = get_character(tmpMdID).animation_hold_shield
	get_character(tmpMdID).call_balloon(0)
	
	call_msg("TagMapAbanHouse3:Start/begin_7")
	get_character(tmpHkID).jump_to(tmpGirlX-1,tmpGirlY)
	get_character(tmpHkID).direction = 6
	call_msg("TagMapAbanHouse3:Start/begin_8")
	get_character(tmpGkID).move_forward
	call_msg("TagMapAbanHouse3:Start/begin_9")
	wait(60)
	
	
	$game_player.moveto(tmpGirlX,tmpGirlY+6)
	$game_player.direction = 8
	until $game_player.y == tmpGirlY+3
		$game_player.move_forward
		until !$game_player.moving?
			wait(1)
		end
	end
	call_msg("TagMapAbanHouse3:Start/begin_10")
	get_character(tmpGkID).direction = 2
	call_msg("TagMapAbanHouse3:Start/begin_11")
	get_character(tmpHkID).jump_to(tmpHorse0X+1,tmpHorse0Y)
	get_character(tmpGkID).direction = 2
	get_character(tmpMdID).direction = 2
	get_character(tmpHkID).direction = 2
	call_msg("TagMapAbanHouse3:Start/begin_12")
	$game_player.actor.wisdom_trait >= 15 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
	call_msg("TagMapAbanHouse3:Start/begin_13") #[我是大人,類獸人<r=HiddenOPT1>]
	if $game_temp.choice == 0
		call_msg("TagMapAbanHouse3:Start/begin_13_Adult")
	else
		call_msg("TagMapAbanHouse3:Start/begin_13_Orkind")
		optain_exp(5000*2)
		wait(30)
		mob_delete = true
	end
	
	get_character(tmpGirlID).animation = nil
	get_character(tmpGirlID).npc_story_mode(false)
	get_character(tmpManID).npc_story_mode(false)
	get_character(tmpHorse0ID).npc_story_mode(false)
	get_character(tmpGkID).npc_story_mode(false)
	get_character(tmpHkID).npc_story_mode(false)
	get_character(tmpMdID).npc_story_mode(false)
	
	if mob_delete
		chcg_background_color(0,0,0,0,7)
			get_character(tmpGirlID).direction = 2
			get_character(tmpGkID).delete
			get_character(tmpHkID).delete
			get_character(tmpMdID).delete
			SndLib.sys_StepChangeMap
			wait(40)
		chcg_background_color(0,0,0,255,-7)
	else
		$game_map.npcs.each{
		|event|
			next unless event.summon_data
			next unless event.summon_data[:WildnessNapEvent] == "BanditMobs"
			next if event.deleted?
			event.npc.killer_condition={"sex"=>[65535, "="]}
			event.npc.assaulter_condition={"health"=>[0, ">"]}
			event.set_manual_move_type(8)
			event.move_type = 8
		}
		SndLib.bgm_play("CB_Combat LOOP",70)
	end
	
	get_character(tmpGirlID).set_npc("NeutralHumanCommonF")
	get_character(tmpGirlID).trigger = -1
	get_character(tmpGirlID).set_manual_move_type(2)
	get_character(tmpGirlID).move_type = 2
	set_event_force_page(tmpMcID,4)
end
$story_stats["HiddenOPT1"] = "0"
cam_center(0)
portrait_hide
get_character(0).erase

