if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $story_stats["Captured"] != 1 && $story_stats["RecQuestDf_HeresyMomo"] == 2
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
		get_character(0).animation = nil
		tmpBlueBlueX,tmpBlueBlueY,tmpBlueBlueID = $game_map.get_storypoint("BlueBlue")
		get_character(0).moveto(tmpBlueBlueX,tmpBlueBlueY)
		$game_player.moveto(tmpBlueBlueX,tmpBlueBlueY-1)
		$game_player.direction = 2
		get_character(0).direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDfWaterCave:CommonerF/Rng#{rand(3)}")
	call_msg("TagMapDfWaterCave:Df_Heresy/4CommonerF_QuRng0_#{rand(3)}")
	call_msg("TagMapDfWaterCave:Df_Heresy4/BlueBlue0")
	call_msg("TagMapDfWaterCave:Df_Heresy4/BlueBlue1")
	call_msg("TagMapDfWaterCave:Df_Heresy4/BlueBlue2")
	
	set_comp = false
	if $game_player.record_companion_name_ext == nil
		set_comp = true
	elsif $game_player.record_companion_name_ext != nil
		$game_temp.choice = -1
		call_msg("commonComp:notice/ExtOverWrite")
		call_msg("common:Lona/Decide_optD")
		if $game_temp.choice ==1
		set_comp = true
		end
	end
	if set_comp
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			tmpBBguardID = $game_map.get_storypoint("BBguard")[2]
			tmpEV = get_character(0)
			tmpEV.set_this_event_companion_ext("Df_Heresy4CompExtConvoy",false,4+$game_date.dateAmt)
			EvLib.sum("Df_Heresy4CompExtConvoy",tmpEV.x,tmpEV.y,{:fadein=>false})
			tmpEV.set_this_event_follower_remove
			tmpEV.delete
			wait(3)
			get_character($game_player.get_followerID(-1)).moveto(tmpBlueBlueX,tmpBlueBlueY)
			get_character($game_player.get_followerID(-1)).direction = 8
			###################################### TODO  summon guard
			get_character(tmpBBguardID).moveto(tmpBlueBlueX-3,tmpBlueBlueY)
			get_character(tmpBBguardID).direction = 6
			get_character(tmpBBguardID).npc_story_mode(true)
			get_character(tmpBBguardID).opacity = 0
			get_character(tmpBBguardID).summon_data[:OutMap] = false
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapDfWaterCave:Df_Heresy4/BlueBlue3") ; portrait_hide
		get_character(tmpBBguardID).opacity = 255
		get_character(tmpBBguardID).move_forward_force ; wait(60)
		get_character(tmpBBguardID).move_forward_force ; wait(60)
		get_character($game_player.get_followerID(-1)).direction = 4
		get_character(0).direction = 4
		$game_player.actor.wisdom_trait >= 15 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		$game_player.actor.combat_trait >= 10 ? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
		call_msg("TagMapDfWaterCave:Df_Heresy4/BlueBlue4_opt") #[不理他,唬爛<r=HiddenOPT1>,威脅<r=HiddenOPT2>]
		portrait_hide
		case $game_temp.choice
		when 0,-1
			call_msg("TagMapDfWaterCave:Df_Heresy4/BlueBlue4_AGGRO")
			$game_map.npcs.each{
			|event|
				next unless event.summon_data
				next unless event.summon_data[:Heretic]
				next if event.deleted?
				next if event.npc.action_state == :death
				if event.npc.sex == 1
					#event.npc.fucker_condition={"weak"=>[50, ">"],"sex"=>[0, "="]}
					event.npc.fucker_condition={"sex"=>[65535, "="]}
					event.npc.killer_condition={"sex"=>[65535, "="]}
					event.npc.assaulter_condition={"health"=>[0, ">"]}
				end
				event.npc.fraction_mode = 4
				event.npc.set_fraction(15)
				event.npc.refresh
			}
			get_character(tmpBBguardID).npc_story_mode(false)
			SndLib.bgm_play("CB_Danger LOOP",70,100)
			call_msg("TagMapDfWaterCave:aggro/Cocona#{rand(2)}") if cocona_in_group?
			$game_player.call_balloon(19)
			
		when 1 #唬爛
			$game_player.move_speed = 3 ; $game_player.direction = 4 ; $game_player.move_forward_force ; wait(50)
			$game_player.direction = 2
			get_character(tmpBBguardID).direction = 8
			call_msg("TagMapDfWaterCave:Df_Heresy4/BlueBlue4_WIS0") ; portrait_hide
			cam_center(0)
			get_character(tmpBBguardID).direction = 4 ; get_character(tmpBBguardID).move_forward_force ; $game_player.turn_toward_character(get_character(tmpBBguardID)) ;wait(60)
			get_character(tmpBBguardID).direction = 8 ; get_character(tmpBBguardID).move_forward_force ; $game_player.turn_toward_character(get_character(tmpBBguardID)) ;wait(60)
			get_character(tmpBBguardID).direction = 4 ; get_character(tmpBBguardID).move_forward_force ; $game_player.turn_toward_character(get_character(tmpBBguardID)) ;wait(60)
			until get_character(tmpBBguardID).opacity <= 0
				get_character(tmpBBguardID).opacity -= 5
				wait(1)
			end
			get_character(tmpBBguardID).delete
			call_msg("TagMapDfWaterCave:Df_Heresy4/BlueBlue4_WIS1")
		when 2 #威脅
			$game_player.move_speed = 3 ; $game_player.direction = 4 ; $game_player.move_forward_force ; wait(60)
			$game_player.direction = 2
			wait(5)
			$game_player.actor.sta -= 2
			$game_player.animation = $game_player.animation_atk_mh
			wait(8)
			SndLib.sound_punch_hit(100)
			get_character(tmpBBguardID).npc_story_mode(true)
			get_character(tmpBBguardID).animation = get_character(tmpBBguardID).animation_stun
			SndLib.sound_MaleWarriorDed
			call_msg("TagMapDfWaterCave:Df_Heresy4/BlueBlue4_CB0")
			$game_player.direction = 6
			call_msg("TagMapDfWaterCave:Df_Heresy4/BlueBlue4_CB1")
			get_character(tmpBBguardID).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
			get_character(tmpBBguardID).actor.force_stun("Stun9") #stun9
			SndLib.bgm_play("CB_Danger LOOP",70,100)
			get_character(tmpBBguardID).npc_story_mode(false)
		end
		call_msg("TagMapDfWaterCave:Df_Heresy4/END")
	end
else
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapDfWaterCave:Fcommoner/Qmsg#{rand(3)}",get_character(0).id)
end

eventPlayEnd
