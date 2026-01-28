

if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end



get_character(0).call_balloon(0)
call_msg("TagMapFishEscPT:Lona/sail_begin")
call_msg("common:Lona/Decide_optB")
if $game_temp.choice == 1
	wait(20)
	portrait_hide
	chcg_background_color(0,0,0,0,4)
	portrait_off
	SndLib.me_play("ME/SeaWaves")
	wait(40)
	call_msg("TagMapFishEscPT:Lona/sail0")
	wait(40)
	SndLib.me_play("ME/SeaWaves")
	call_msg("TagMapFishEscPT:Lona/sail1")
	# $story_stats["OverMapForceTrans"] = "SeaEscPT0"
	# $story_stats["OverMapForceTransStay"] = 1
	change_map_leave_tag_map
	#rape_loop_drop_item(false,false)
	combat_remove_random_equip(eqp_target=combat_hit_get_removable_slots,summon=false)
	combat_remove_random_equip(eqp_target=combat_hit_get_removable_slots,summon=false)
	data=["Key","Trait","Child"]
	$game_party.drop_items_and_summon(data,summon=false,tmpRngAMT=true)
else
	eventPlayEnd
end
