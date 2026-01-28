$game_portraits.lprt.hide
if !$game_map.threat
		$game_player.animation = $game_player.animation_stun
		$game_player.call_balloon(12,-1)
		$game_message.add("......")
		$game_map.interpreter.wait_for_message
			if $game_actors[1].preg_level ==5
			load_script("Data/Batch/birth_trigger.rb")
			end
		$game_map.napEventId.nil? ?  handleNap : $game_map.call_nap_event
else
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
end

