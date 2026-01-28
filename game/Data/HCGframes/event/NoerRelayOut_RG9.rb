return get_character(0).erase if $story_stats["UniqueCharUniqueGrayRat"] == -1
return get_character(0).erase if $story_stats["UniqueCharUniqueCecily"] == -1
return get_character(0).erase if ![13,14].include?($story_stats["QuProgSaveCecily"])
return get_character(0).erase if $game_player.getComB_Name != "UniqueCecily"

tmpPotX,tmpPotY,tmpPotID=$game_map.get_storypoint("pot")
tmpMapContX,tmpMapContY,tmpMapContID=$game_map.get_storypoint("MapCont")
tmpNur1X,tmpNur1Y,tmpNur1ID=$game_map.get_storypoint("Nur1")
tmpNur2X,tmpNur2Y,tmpNur2ID=$game_map.get_storypoint("Nur2")
tmpRufC14M1X,tmpRufC14M1Y,tmpRufC14M1ID=$game_map.get_storypoint("RufC14M1")
tmpRufC14M2X,tmpRufC14M2Y,tmpRufC14M2ID=$game_map.get_storypoint("RufC14M2")
tmpRufC14M3X,tmpRufC14M3Y,tmpRufC14M3ID=$game_map.get_storypoint("RufC14M3")

get_character(tmpPotID).call_balloon(0)
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character($game_player.get_companion_id(1)).npc_story_mode(true)
	get_character($game_player.get_companion_id(0)).npc_story_mode(true)
	tmpBmove_type = get_character($game_player.get_companion_id(1)).move_type
	tmpFmove_type = get_character($game_player.get_companion_id(0)).move_type
	get_character($game_player.get_companion_id(1)).move_type = 0
	get_character($game_player.get_companion_id(0)).move_type = 0
	get_character($game_player.get_companion_id(1)).direction = 6
	get_character($game_player.get_companion_id(0)).direction = 6
	$game_player.direction = 6
	
	
	get_character($game_player.get_companion_id(1)).moveto(tmpPotX-11,tmpPotY)
	get_character($game_player.get_companion_id(0)).moveto(tmpPotX-10,tmpPotY)
	$game_player.moveto(tmpPotX-9,tmpPotY)
	cam_follow(tmpPotID,0)
	#set all bagger into enemy
	$game_map.events.each do |event| 
		next unless event[1].summon_data
		next unless event[1].summon_data[:CecilyQu14]
		event[1].opacity = 255
		if event[1].summon_data[:CecilyQu14Saint]
			event[1].set_npc("NeutralHumanCommonF")
			event[1].npc.set_fraction(12)
			event[1].npc.fated_enemy = [5,8,9,10]
			event[1].npc.fraction_mode = 4
			event[1].npc.fated_enemy = [7]
			
		
		elsif event[1].summon_data[:CecilyQu14M]
			event[1].set_npc("NeutralHumanCommonHoboM")
			
			
		elsif event[1].summon_data[:CecilyQu14F]
			event[1].set_npc("NeutralHumanCommonHoboF")
		end
		
	end
chcg_background_color(0,0,0,255,-7)
#######################################################################################    Wa;lIn
tmpMS1 = get_character($game_player.get_companion_id(1)).move_speed
tmpMS2 = get_character($game_player.get_companion_id(0)).move_speed
tmpMS3 = $game_player.move_speed
4.times{
	get_character($game_player.get_companion_id(1)).move_speed = 3
	get_character($game_player.get_companion_id(0)).move_speed = 3
	$game_player.move_speed = 3
	get_character($game_player.get_companion_id(1)).move_forward_force
	get_character($game_player.get_companion_id(0)).move_forward_force
	$game_player.move_forward_force
	wait(35)
}
get_character($game_player.get_companion_id(1)).move_speed = 3
get_character($game_player.get_companion_id(0)).move_speed = 3
get_character($game_player.get_companion_id(1)).direction = 6; get_character($game_player.get_companion_id(1)).move_forward_force
get_character($game_player.get_companion_id(0)).direction = 8; get_character($game_player.get_companion_id(0)).move_forward_force
wait(35)
get_character($game_player.get_companion_id(0)).move_speed = 3
get_character($game_player.get_companion_id(0)).direction = 6; get_character($game_player.get_companion_id(0)).move_forward_force
wait(35)
	
call_msg("CompCecily:Cecily/QuestHikack14_1")
get_character(tmpRufC14M1ID).npc_story_mode(true)
get_character(tmpRufC14M3ID).npc_story_mode(true)
get_character($game_player.get_companion_id(0)).call_balloon(8)
wait(60)
call_msg("CompCecily:Cecily/QuestHikack14_1CECtoLona") ; portrait_hide
call_msg("CompCecily:Cecily/QuestHikack14_2")
get_character(tmpNur1ID).direction = 2
call_msg("CompCecily:Cecily/QuestHikack14_2_1")
get_character(tmpNur1ID).direction = 4
get_character(tmpRufC14M3ID).direction = 8
get_character(tmpRufC14M3ID).call_balloon(8)
call_msg("CompCecily:Cecily/QuestHikack14_2_2")
get_character(tmpRufC14M3ID).animation = get_character(tmpRufC14M3ID).animation_grabber_qte(get_character(tmpRufC14M1ID))
get_character(tmpRufC14M1ID).animation = get_character(tmpRufC14M1ID).animation_grabbed_qte
SndLib.sound_equip_armor(100)
call_msg("CompCecily:Cecily/QuestHikack14_2_2_1")

		#######################################################################################    Lona try to stop it.
		call_msg("CompCecily:Cecily/QuestHikack14_2_Stop0") ; portrait_hide
		$game_map.npcs.each{|event| 
			next unless event.summon_data
			next unless event.summon_data[:CecilyQu14Mob]
			event.direction = 4
		}
		$game_temp.choice = 0
		call_msg("CompCecily:Cecily/QuestHikack14_2_Stop1") ; portrait_hide
		
		$game_player.actor.wisdom_trait >= 15 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		call_msg("CompCecily:Cecily/QuestHikack14_WisOPT")  #[Kill,Wisdom]
		#######################################################################################    Lona try to stop it.

#######################################################################################    WIS OPT
if $game_temp.choice == 1
	call_msg("CompCecily:Cecily/QuestHikack14_WisOPTend0")
	call_msg("CompCecily:Cecily/QuestHikack14_WisOPTend1")
	get_character(tmpRufC14M1ID).animation = nil
	get_character(tmpRufC14M3ID).animation = nil
	get_character(tmpRufC14M3ID).direction = 4
	call_msg("CompCecily:Cecily/QuestHikack14_WisOPTend2")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$game_map.npcs.each{|event|
			next unless event.summon_data
			next unless event.summon_data[:CecilyQu14Mob]
			event.delete
		}
		
		$game_map.npcs.each{|event|
			next unless event.summon_data
			next unless event.summon_data[:CecilyQu14Saint]
			event.summon_data[:CanGetReward] = true
		}
		
	get_character(tmpMapContID).summon_data[:WisWay] = true
	chcg_background_color(0,0,0,255,-7)
	
else
	SndLib.bgm_play("CB_Combat LOOP",80,100)
	call_msg("CompCecily:Cecily/QuestHikack14_2_3")
	get_character(tmpRufC14M3ID).direction = 8
	get_character(tmpRufC14M3ID).animation = get_character(tmpRufC14M3ID).animation_atk_mh
	wait(5)
	SndLib.sound_punch_hit(100)
	wait(20)
	get_character(tmpRufC14M3ID).animation = get_character(tmpRufC14M3ID).animation_atk_sh
	wait(5)
	SndLib.sound_punch_hit(100)
	SndLib.sound_MaleWarriorDed(80)
	$game_map.delete_npc(get_character(tmpRufC14M1ID))
	get_character(tmpRufC14M1ID).jump_to(tmpRufC14M3X,tmpRufC14M3Y)
	get_character(tmpRufC14M1ID).animation = get_character(tmpRufC14M3ID).animation_corpsen
	get_character(tmpRufC14M1ID).through = true
	get_character(tmpRufC14M1ID).priority_type = 0
	get_character(tmpRufC14M1ID).trigger = -1
	call_msg("CompCecily:Cecily/QuestHikack14_2_4")
	call_msg("CompCecily:Cecily/QuestHikack14_KillWay1") ; portrait_hide
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:CecilyQu14Mob]
		event.direction = 6
		event.set_manual_move_type(1)
		event.move_type = 1
		if event.summon_data[:CecilyQu14F]
			event.summon_data[:CecilyQu14Mob] = nil
			event.npc.set_fraction(12)
			
		else
			event.npc.fucker_condition={"sex"=>[65535, "="]}
			event.npc.killer_condition={"sex"=>[65535, "="]}
			event.npc.assaulter_condition={"health"=>[1, ">"], "weak"=>[19, ">"], "sex"=>[0, "="]}
			event.npc.set_fraction(7)
			event.npc.remove_skill("killer","NpcMarkMoralityDown")
			event.npc.remove_skill("assaulter","NpcMarkMoralityDown")
		end
		event.npc.death_event = "EffectCharDed"
		event.npc.refresh
	}
end

get_character(tmpRufC14M1ID).npc_story_mode(false)
get_character(tmpRufC14M3ID).npc_story_mode(false)
get_character($game_player.get_companion_id(1)).move_speed = tmpMS1
get_character($game_player.get_companion_id(0)).move_speed = tmpMS2
$game_player.move_speed = tmpMS3
get_character($game_player.get_companion_id(1)).move_type = tmpBmove_type
get_character($game_player.get_companion_id(0)).move_type = tmpFmove_type
get_character($game_player.get_companion_id(1)).npc_story_mode(false)
get_character($game_player.get_companion_id(0)).npc_story_mode(false)
set_event_force_page(tmpMapContID,3)
eventPlayEnd
get_character(0).erase

