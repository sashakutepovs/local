#this is for gateKeeper check answer bluff
check = npc_talk_style_ext
case check
	when "_SexSlaveRuined"	; call_msg("OvermapNoer:GateGuard/enter_wisdom_win#{check}1")
	when "_SexSlave"		; call_msg("OvermapNoer:GateGuard/enter_wisdom_win#{check}1")
	when "_SexyWeak"		; call_msg("OvermapNoer:GateGuard/enter_wisdom_win#{check}1")
	when "_slave"			; call_msg("OvermapNoer:GateGuard/enter_wisdom_win#{check}1")
	when "_maggot"			; call_msg("OvermapNoer:GateGuard/enter_wisdom_win#{check}") ; return
	when "_sexy"			; call_msg("OvermapNoer:GateGuard/enter_wisdom_win#{check}") ; return
	when "_weaker"			; call_msg("OvermapNoer:GateGuard/enter_wisdom_win#{check}") ; return
	when "_moot"			; call_msg("OvermapNoer:GateGuard/enter_wisdom_win#{check}") ; return
	else 					; call_msg("OvermapNoer:GateGuard/enter_wisdom_win#{check}") ; return #_lona
end




$game_player.actor.stat["EventVagRace"] =  "Human"
$game_player.actor.stat["EventAnalRace"] = "Human"
$game_player.actor.stat["EventExt1Race"] = "Human"
portrait_hide
chcg_background_color(0,0,0,0,14)
	harassTimes = 1+rand(3)
	harassTimes.times{
		case rand(3)
			when 0
				load_script("Data/HCGframes/Grab_EventAnal_AnalTouch.rb")
				call_msg("commonH:Lona/MilkSpray#{rand(5)}")
				half_event_key_cleaner

			when 1
				load_script("Data/HCGframes/Grab_EventVag_VagTouch.rb")
				call_msg("commonH:Lona/MilkSpray#{rand(5)}")
				half_event_key_cleaner

			when 2
				load_script("Data/HCGframes/Grab_EventExt1_BoobTouch.rb")
				call_msg("commonH:Lona/MilkSpray#{rand(5)}")
				half_event_key_cleaner
		end
	}
chcg_background_color(0,0,0,255,-14)

check_half_over_event
whole_event_end


$game_portraits.setLprt($game_portraits.prevLprt)
portrait_focus
call_msg("OvermapNoer:GateGuard/enter_wisdom_win#{check}2")
portrait_hide
wait(5)
