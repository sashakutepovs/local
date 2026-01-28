if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)
tmpQcX,tmpQcY,tmpQcID=$game_map.get_storypoint("QuestCount")
tmpDoX,tmpDoY,tmpDoID=$game_map.get_storypoint("DedOne")

load_script("Data/HCGframes/event/CompDedOneCheckUniqueDialog.rb")

if $story_stats["QuProgPB_MassGrave"] == 1
	$game_player.actor.wisdom_trait >= 20 ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
	$game_temp.choice = -1
	call_msg("CompDedOne:DedOne/MassGrave_1")
	case $game_temp.choice
		when 0
			call_msg("CompDedOne:DedOne/MassGrave_optCB")
			
			$game_map.events.each{|event|
			next if !event[1].summon_data
			next if event[1].summon_data[:Blocker] != true
			p "Found tar Ev name => #{event[1].name}"
			set_event_force_page(event[0],1)
			}
			call_timer(30,60)
			set_event_force_page(tmpQcID,3)
			get_character(tmpDoID).npc.set_fraction(10)
			get_character(tmpDoID).npc.death_event = "DedNil"
			get_character(tmpDoID).npc.immune_damage = true
			wait(5)
			$game_map.interpreter.screen.start_shake(5,10,60)
			SndLib.sound_FlameCast(100,70)
			call_msg("CompDedOne:DedOne/MassGrave_optCB2")
			SndLib.bgm_play("CB_Danger LOOP",80,110)
		
		when 1
			call_msg("CompDedOne:DedOne/MassGrave_optPASS")
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				get_character(0).delete
				$story_stats["QuProgPB_MassGrave"] = 2
			chcg_background_color(0,0,0,255,-7)
			call_msg("CompDedOne:DedOne/MassGrave_optPASS2")
			$story_stats["HiddenOPT0"] = "0"
			$game_temp.choice = -1
			portrait_hide
			cam_center(0)
			return
		end
end

###########################check balloon
get_character(0).call_balloon(28,-1) if [1].include?($story_stats["QuProgPB_MassGrave"])
##############################
$story_stats["HiddenOPT0"] = "0"
$game_temp.choice = -1
portrait_hide
cam_center(0)