
if !get_character(0).npc.master
	if $game_map.threat
		SndLib.sys_buzzer
		$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		return
	end
	call_msg("TagMapNFL_OrkCamp2:MercJoin/spear")
	get_character(0).set_this_event_companion_front_lite
	get_character(0).call_balloon(0)
elsif get_character(0).follower
	# he must be there
	# u, take the lead
	# wut  me?!
	# iznt u said u are passenby and gb2 home to take a look?
	# u can survival all those thing. why not a lead.
	#ugh... okay...   so whos the one u looking. what he looks.
	#he looks white, big nose, and with big ear.
	#white, big nose,  big ear.？
	#alright.... follow me.
	# TODO character selection
end