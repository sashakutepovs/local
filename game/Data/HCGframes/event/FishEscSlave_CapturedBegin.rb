tmpMcID = $game_map.get_storypoint("MapCont")[2]
tmpCapX,tmpCapY,tmpCapID = $game_map.get_storypoint("Capture")
tmpGmX,tmpGmY,tmpGmID = $game_map.get_storypoint("GuardMas")
tmpCapAsFood = get_character(tmpMcID).summon_data[:CapAsFood]
tmp1stNAP = get_character(tmpMcID).summon_data[:FirstNAP]
if $story_stats["Captured"] == 1 && tmpCapAsFood == false && tmp1stNAP == false
	get_character(tmpMcID).summon_data[:FirstNAP] = true
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:slave]
		event.npc.fucker_condition={"sex"=>[65535, "="]}
		event.npc.killer_condition={"sex"=>[65535, "="]}
		event.npc.assaulter_condition={"sex"=>[65535, "="]}
	}
	get_character(tmpMcID).summon_data[:enemy] = false
	get_character(tmpMcID).summon_data[:talked] = true
	tmpGM_OD = get_character(tmpGmID).direction
	get_character(tmpGmID).moveto($game_player.x,$game_player.y+1)
	get_character(tmpGmID).direction = 8
	chcg_background_color(0,0,0,255,-7)
		$game_player.direction = 2
		call_msg("TagMapFishEscSlave:Nap/Friendly_wake0")
		get_character(tmpGmID).animation = get_character(tmpGmID).animation_atk_sh
		optain_item($data_items[137],1)
		call_msg("TagMapFishEscSlave:Nap/Friendly_wake1")
	chcg_background_color(0,0,0,0,7)
		get_character(tmpGmID).moveto(tmpGmX,tmpGmY)
		get_character(tmpGmID).direction = tmpGM_OD
	chcg_background_color(0,0,0,255,-7)
	
elsif $story_stats["Captured"] == 1 && tmpCapAsFood == true && tmp1stNAP == false
	get_character(tmpMcID).summon_data[:FirstNAP] = true
	$game_player.moveto(tmpCapX,tmpCapY)
	$game_player.transparent = true
	cam_follow(tmpCapID,0)
	get_character(tmpCapID).opacity = 255
	get_character(tmpCapID).force_update = true
	call_msg("TagMapFishEscSlave:Nap/Enemy_wake0")
	chcg_background_color(0,0,0,255,-7)
	
		call_msg("TagMapFishEscSlave:Nap/Enemy_wake1")
		tmpStruggle =0
		$game_temp.choice = -1
		until tmpStruggle == 3 || $game_temp.choice == 1
			call_msg("TagMapFishEscSlave:Nap/BondageStruggle_opt") #[掙扎,放棄]
			if $game_temp.choice == 0
				lona_mood "p5defence"
				tmpStruggle +=1
				$game_portraits.rprt.shake
				get_character(tmpCapID).jump_to(get_character(tmpCapID).x,get_character(tmpCapID).y)
				SndLib.sound_punch_hit(90,rand(10)+50)
				wait(60)
				call_msg("TagMapNoerCatacombB1:Lona/BondageStruggle2")
			else
				call_msg("TagMapFishEscSlave:Nap/Enemy_wake_giveUP")
				portrait_hide
				SndLib.bgm_stop
				SndLib.bgs_stop
				chcg_background_color(20,0,0,0,2)
				tmpSndLoop = 0
				4.times{
					$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
					SndLib.sound_gore(100)
					SndLib.sound_combat_hit_gore(70)
					wait(20+rand(20))
				}
				call_msg("TagMapFishEscSlave:gameOver/nap0")
				chcg_background_color(0,0,0,255)
				return load_script("Data/HCGframes/OverEvent_Death.rb")
			end
		end
		
		chcg_background_color(0,0,0,0,7)
			$game_player.transparent = false
			get_character(tmpCapID).opacity = 0
			$game_player.direction = 2
			$game_player.animation = nil
			get_character(tmpCapID).force_update = false
			cam_center(0)
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapNoerCatacombB1:Lona/BondageStruggle3")
end

if get_character(tmpMcID).summon_data[:talked] || tmp1stNAP
	return if get_character(tmpMcID).summon_data[:CapAsFood] && get_character(tmpMcID).summon_data[:enemy]
		get_character(tmpMcID).summon_data[:enemy] = false
		$game_map.npcs.each{|event|
			next unless event.summon_data
			next unless event.summon_data[:slave]
			next if event.deleted?
			next if event.npc.action_state == :death
			event.npc.fucker_condition={"sex"=>[65535, "="]}
			event.npc.killer_condition={"sex"=>[65535, "="]}
			event.npc.assaulter_condition={"sex"=>[65535, "="]}
			event.npc.process_target_lost
		}
end