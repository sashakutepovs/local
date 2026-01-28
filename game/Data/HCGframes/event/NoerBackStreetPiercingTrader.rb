if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $game_player.actor.stat["SlaveBrand"] ==0
	call_msg("TagMapNoerBackStreet:Piercing/Begin")
else
	call_msg("TagMapNoerBackStreet:Piercing/Begin_slave")
end
tmpGotoTar = ""
tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]					,"Cancel"]
tmpTarList << [$game_text["commonNPC:commonNPC/About"]					,"About"]
tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]					,"Barter"]
#tmpTarList << [$game_text["commonNPC:commonNPC/Piercing"]				,"Piercing"]
cmd_sheet = tmpTarList
cmd_text =""
for i in 0...cmd_sheet.length
	cmd_text.concat(cmd_sheet[i].first+",")
end
call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
call_msg("\\optB[#{cmd_text}]")
$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
$game_temp.choice = -1



	case tmpPicked
		when "About"
			call_msg("TagMapNoerBackStreet:Piercing/about")
			
		when "Barter"
			manual_barters("NoerBackStreetPiercingTrader")
		
end #case

if $game_party.has_item_type("SurgeryCoupon")
	call_msg("TagMapNoerBackStreet:Piercing/piecing_start")
	chcg_background_color(0,0,0,0,7)
	call_msg("TagMapNoerBackStreet:Piercing/piecing_doing")
	chcg_background_color(255,255,255,-7)
	$game_party.force_use_item_type("SurgeryCoupon")
	$game_party.lost_item_type("SurgeryCoupon")
end

call_msg("TagMapNoerBackStreet:Piercing/end")


$story_stats["HiddenOPT1"] = "0" 
eventPlayEnd
