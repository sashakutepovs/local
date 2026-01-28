p "Playing HCGframe : Action_BuildCamp.rb"

$game_portraits.lprt.hide

if $story_stats["Captured"] !=1
		if !$game_map.threat
				$game_message.add("\\t[commonCommands:Lona/CampActionBuildCamp1]")
				$game_map.interpreter.wait_for_message
				$game_message.visible;screen.start_fadeout(30)
				$game_message.add("\\t[commonCommands:Lona/CampActionBuildCamp2]")
				$game_map.interpreter.wait_for_message
				
				$game_party.lose_item($data_items[55],3)
				$game_actors[1].sta -= 25-($game_actors[1].survival/4).round
				
				temp_tar=get_character(0)
				$game_map.reserve_summon_event("PlayerBed",temp_tar.x,temp_tar.y,-1)
				#$game_map.reserve_summon_event("PlayerCampFire",$game_player.x,$game_player.y+1,-1) if !$game_map.isOverMap
				
				$game_message.visible;screen.start_fadein(30)
				$game_message.add("\\t[commonCommands:Lona/CampActionBuildCamp3]")
				$game_map.interpreter.wait_for_message

		else #combat
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		end  #combat
else #cattureed
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/captured#{rand(2)}",0,0)

end  #captured