portrait_hide
tmpMCid=$game_map.get_storypoint("MapCount")[2]
################################################################### 贏了  但LONA在最後場景倒下了 用於被毒品或出產等事件卡死
if $story_stats["RecQuestCoconaDefeatBossMama"] == 1
	portrait_off
	SndLib.bgm_stop
	$game_player.animation = $game_player.animation_stun
	wait(60)
	chcg_background_color(0,0,0,0,7)
	$story_stats["RecQuestCocona"] = 26
	tmpMaidText = $game_map.interpreter.cocona_maid? ? "Maid" : ""
	tmpMaidText = "UniqueCocona#{tmpMaidText}"
	$game_player.record_companion_name_back = tmpMaidText
		$story_stats["TagSubTrans"] = "StartPointArena"
		$story_stats["TagSubForceDir"] = 2
		change_map_enter_tagSub("NoerArena")
	$game_player.actor.mood = 100
	$game_player.actor.sta = 1
	call_msg("CompCocona:DualMama/lose_and_win")
	portrait_off
###################################################################敗了 但大闆娘決定宰了洛娜
elsif $story_stats["RecQuestCoconaVagTaken"] >= 3
	portrait_off
	SndLib.bgm_stop
	$game_player.animation = $game_player.animation_stun
	wait(60)
	chcg_background_color(0,0,0,0,7)
	if get_character(tmpMCid).summon_data[:TierRec] == 2
		call_msg("CompCocona:T2start/3_CoconaWhore")
	else
		call_msg("CompCocona:T1start/3_CoconaWhore")
	end
	call_msg("CompCocona:DualMama/lose_but_progress4") ; portrait_hide
	6.times{
		#if [true,false].sample
		#	SndLib.sound_NecroBoom(80)
		#else
			$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
			SndLib.sound_gore(100)
			SndLib.sound_combat_hit_gore(70)
		#end
		wait(20+rand(20))
	}
	wait(15)
	call_msg("CompCocona:DualMama/lose_die") ; portrait_hide
	SndLib.sound_NecroBoom(80)
	wait(60)
	SndLib.sound_UndeadSurprise(80)
	wait(5)
	SndLib.sound_NecroBoom(80)
	wait(55)
	SndLib.sound_combat_sword_hit_sword(80)
	wait(15)
	SndLib.sound_NecroBoom(80)
	wait(30)
	SndLib.sound_NecroBoom(80)
	wait(90)
	return load_script("Data/HCGframes/OverEvent_Death.rb")
	
###################################################################敗了 T1 在挑戰
elsif get_character(tmpMCid).summon_data[:TierRec] == 1
	SndLib.bgm_stop
	portrait_off
	chcg_background_color(0,0,0,0,14)
		$story_stats["TagSubTrans"] = "StartPointArena"
		$story_stats["TagSubForceDir"] = 2
		change_map_enter_tagSub("NoerArena")
	call_msg("CompCocona:DualMama/lose_t1_0")
	portrait_off
##### TODO
###################################################################敗了 T2 但劇情還會繼續
elsif get_character(tmpMCid).summon_data[:TierRec] == 2
	$game_player.animation = $game_player.animation_stun
	tmpCoconaID=$game_map.get_storypoint("Cocona")[2]
	tmpCoconaID=$game_map.get_storypoint("Cocona")[2]
	tmpCoconaID=$game_map.get_storypoint("Cocona")[2]
	tmpMamaEV=$game_map.npcs.select{|ev| 
		next unless ev.summon_data
		next unless ev.summon_data[:BossMamaT2] || ev.summon_data[:BossMamaT1]
		next if ev.npc.action_state == :death
		ev
	}
	
	if tmpMamaEV && get_character(tmpMamaEV[0].id).npc?
		tmpMamaID = tmpMamaEV[0].id
		realMamaX = get_character(tmpMamaID).x
		realMamaY = get_character(tmpMamaID).y
		get_character(tmpMamaID).opacity = 0
		get_character(tmpMamaID).delete
		tmpMamaID = $game_map.get_storypoint("MamaStoryEV")[2] #replace with story ev.
		coMissileID=$game_map.get_storypoint("CoMissile")[2]
		coconaID=$game_map.get_storypoint("Cocona")[2]
		tmpGateLEid = $game_map.get_storypoint("ExitPT2")[2]
		tmpGateREid = $game_map.get_storypoint("ExitPT1")[2]
		get_character(tmpMamaID).moveto(realMamaX,realMamaY)
		get_character(tmpMamaID).turn_toward_character($game_player)
		$game_map.delete_npc(get_character(tmpMamaID))
		get_character(tmpMamaID).set_manual_move_type(0)
		get_character(tmpMamaID).move_type = 0
		#get_character(tmpMamaID).npc.action_state = :none
		get_character(tmpMamaID).npc_story_mode(true)
		get_character(coconaID).npc_story_mode(true)
		call_msg("CompCocona:DualMama/lose_but_progress0")
		cam_follow(tmpMamaID,0)
		get_character(tmpMamaID).turn_toward_character($game_player)
		get_character(tmpMamaID).call_balloon(20)
		call_msg("CompCocona:DualMama/lose_but_progress1")
		cam_follow(tmpMamaID,0)
		get_character(tmpMamaID).turn_toward_character($game_player)
		get_character(tmpMamaID).call_balloon(20)
		call_msg("CompCocona:DualMama/lose_but_progress2") ; portrait_hide
			get_character(coconaID).animation = get_character(coconaID).animation_casting_mh
			SndLib.sound_FlameCast(80)
			wait(20)
			get_character(coMissileID).summon_data[:user] = get_character(coconaID)
			get_character(coMissileID).summon_data[:tarX] = get_character(tmpMamaID).x
			get_character(coMissileID).summon_data[:tarY] = get_character(tmpMamaID).y
			get_character(coconaID).npc_story_mode(true)
			get_character(coconaID).turn_toward_character(get_character(tmpMamaID))
			set_event_force_page(coMissileID,2)
		wait(10)
		get_character(tmpMamaID).call_balloon(1)
		get_character(tmpMamaID).item_jump_to
		get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_dodge
		SndLib.sound_step(80)
		get_character(tmpMamaID).turn_toward_character(get_character(coconaID))
		until !get_character(tmpMamaID).moving? && !get_character(coMissileID).moving?
			wait(1)
		end
		wait(30)
		SndLib.bgm_stop
		call_msg("CompCocona:DualMama/lose_but_progress3")
		call_msg("CompCocona:DualMama/lose_but_progress4") ; portrait_hide
			get_character(coconaID).animation = get_character(coconaID).animation_casting_mh
			SndLib.sound_FlameCast(80)
			wait(20)
			get_character(coMissileID).summon_data[:user] = get_character(coconaID)
			get_character(coMissileID).summon_data[:tarX] = get_character(tmpMamaID).x
			get_character(coMissileID).summon_data[:tarY] = get_character(tmpMamaID).y
			get_character(coconaID).npc_story_mode(true)
			get_character(coconaID).turn_toward_character(get_character(tmpMamaID))
			set_event_force_page(coMissileID,2)
		wait(10)
		get_character(tmpMamaID).call_balloon(6)
		get_character(tmpMamaID).item_jump_to
		get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_dodge
		SndLib.sound_step(80)
		get_character(tmpMamaID).turn_toward_character(get_character(coconaID))
		until !get_character(tmpMamaID).moving? && !get_character(coMissileID).moving?
			wait(1)
		end
		wait(30)
		call_msg("CompCocona:DualMama/lose_but_progress5") ; portrait_hide
			get_character(coconaID).animation = get_character(coconaID).animation_casting_mh
			SndLib.sound_FlameCast(80)
			wait(20)
			get_character(coMissileID).summon_data[:user] = get_character(coconaID)
			get_character(coMissileID).summon_data[:tarX] = get_character(tmpMamaID).x
			get_character(coMissileID).summon_data[:tarY] = get_character(tmpMamaID).y
			get_character(coconaID).npc_story_mode(true)
			get_character(coconaID).turn_toward_character(get_character(tmpMamaID))
			set_event_force_page(coMissileID,2)
		wait(10)
		cam_follow(tmpMamaID,0)
		get_character(tmpMamaID).call_balloon(6)
		get_character(tmpMamaID).item_jump_to
		get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_dodge
		SndLib.sound_step(80)
		get_character(tmpMamaID).turn_toward_character(get_character(coconaID))
		until !get_character(tmpMamaID).moving? && !get_character(coMissileID).moving?
			wait(1)
		end
		wait(60)
		call_msg("CompCocona:DualMama/lose_but_progress6")
		call_msg("CompCocona:DualMama/lose_but_progress7") ; portrait_hide
			get_character(coconaID).animation = get_character(coconaID).animation_casting_mh
			SndLib.sound_FlameCast(80)
			wait(20)
			get_character(coMissileID).summon_data[:user] = get_character(coconaID)
			get_character(coMissileID).summon_data[:tarX] = get_character(tmpMamaID).x
			get_character(coMissileID).summon_data[:tarY] = get_character(tmpMamaID).y
			get_character(coconaID).npc_story_mode(true)
			get_character(coconaID).turn_toward_character(get_character(tmpMamaID))
			set_event_force_page(coMissileID,2)
		wait(10)
		cam_follow(tmpMamaID,0)
		get_character(tmpMamaID).call_balloon(8)
		get_character(tmpMamaID).item_jump_to
		get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_dodge
		SndLib.sound_step(80)
		get_character(tmpMamaID).turn_toward_character(get_character(coconaID))
		until !get_character(tmpMamaID).moving? && !get_character(coMissileID).moving?
			wait(1)
		end
		wait(60)
		get_character(tmpMamaID).character_index = 3
		call_msg("CompCocona:DualMama/lose_but_progress8")
		cam_follow(tmpMamaID,0)
		get_character(tmpMamaID).call_balloon(6)
		rangeLE = get_character(tmpGateLEid).report_range(get_character(tmpMamaID))
		rangeRE = get_character(tmpGateLEid).report_range(get_character(tmpMamaID))
		if rangeRE > rangeLE
			tarGateID = tmpGateLEid
		else
			tarGateID = tmpGateREid
		end
		cam_follow(tmpMamaID,0)
		get_character(tmpMamaID).call_balloon(6)
		call_msg("CompCocona:DualMama/lose_but_progress9")
		call_msg("CompCocona:DualMama/lose_but_progress10")
		cam_follow(tmpMamaID,0)
		get_character(tmpMamaID).call_balloon(8)
		call_msg("CompCocona:DualMama/lose_but_progress8") ; portrait_hide
		get_character(tmpMamaID).turn_toward_character(get_character(tarGateID))
		get_character(coMissileID).opacity = 0
		get_character(coMissileID).moveto(get_character(tmpMamaID).x,get_character(tmpMamaID).y)
		cam_follow(coMissileID,0)
		5.times{
			get_character(tmpMamaID).direction = 2 ; get_character(tmpMamaID).move_toward_TargetSmartAI(get_character(tarGateID))
			get_character(tmpMamaID).move_speed = 2.8
			until !get_character(tmpMamaID).moving? ; wait(1) end
		}
		until get_character(tmpMamaID).opacity <= 0
			get_character(0).opacity -= 5
			get_character(tmpMamaID).opacity -= 5
			wait(1)
		end
	end
	portrait_off
	$story_stats["RecQuestCocona"] = 26
	$story_stats["RecQuestCoconaDefeatBossMama"] = -1
	tmpMaidText = $game_map.interpreter.cocona_maid? ? "Maid" : ""
	tmpMaidText = "UniqueCocona#{tmpMaidText}"
	$game_player.record_companion_name_back = tmpMaidText
	eventPlayEnd
	chcg_background_color(0,0,0,0,14)
		cam_center(0)
		$story_stats["TagSubTrans"] = "StartPointArena"
		$story_stats["TagSubForceDir"] = 2
		change_map_enter_tagSub("NoerArena")
	$game_player.actor.mood = 100
	$game_player.actor.sta = 1
	call_msg("CompCocona:DualMama/lose_and_win")
	portrait_off
end