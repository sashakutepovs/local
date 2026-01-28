if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $story_stats["QuProgDF_Woodson"] == 1
	$story_stats["QuProgDF_Woodson"] = 2
	get_character(0).call_balloon(0)
	get_character(0).animation = nil
	call_msg("TagMapDoomFortress:QuProgDF_Woodson/prog1_Maid")
end

tmp_deleted = false
if $story_stats["QuProgDF_Woodson"] == 2
	get_character(0).call_balloon(0)
	get_character(0).animation = nil
	chkAboutYou = false
	$game_temp.choice = -3
	until [-1,0,1].include?($game_temp.choice)
		$story_stats["QuProgDF_Woodson"] == 2 && $story_stats["UniqueDoomFarmAMama"] == -1 && $story_stats["UniqueDoomFarmAPapa"] == -1 && $story_stats["UniqueDoomFarmASon"] == -1		? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		chkAboutYou																																										? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
		call_msg("TagMapDoomFortress:QuProgDF_Woodson/prog2_Maid") #[沒事,死光了<r=HiddenOPT1>,伍德森,關於妳,他們在哪<r=HiddenOPT2>]
		chkAboutYou = true if chkAboutYou == false && [2,3].include?($game_temp.choice) #伍德森,關於妳
		#msgbox chkAboutYou
		if $game_temp.choice == 2
			call_msg("TagMapDoomFortress:QuProgDF_Woodson/prog2_optWho")
			call_msg("TagMapDoomFortress:QuProgDF_Woodson/prog2_optWho_Gr") if ["UniqueGrayRat"].include?($game_player.record_companion_name_front)
		elsif $game_temp.choice == 3
			call_msg("TagMapDoomFortress:QuProgDF_Woodson/prog2_optYou")
		elsif $game_temp.choice == 4
			call_msg("TagMapDoomFortress:QuProgDF_Woodson/prog2_optWhere")
		end
	end
	if $game_temp.choice == 1 # 死光了
		call_msg("TagMapDoomFortress:QuProgDF_Woodson/prog2_optWin")
		$story_stats["QuProgDF_Woodson"] = 3
		chcg_background_color(0,0,0,0,7)
			get_character(0).delete
			tmp_deleted = true
			tmpID = $game_map.get_storypoint("InnEnter")[2]
			get_character(tmpID).call_balloon(28,-1)
		chcg_background_color(0,0,0,255,-7)
	end
else
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapNoerGoldenBar:GoldenSlave/Qmsg#{rand(3)}",get_character(0).id)
end




cam_center(0)
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
portrait_hide
$game_temp.choice = -1

return if tmp_deleted
########################## check balloon
get_character(0).call_balloon(0)
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgDF_Woodson"] == 1
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgDF_Woodson"] == 2 && $story_stats["UniqueDoomFarmAMama"] == -1 && $story_stats["UniqueDoomFarmAPapa"] == -1 && $story_stats["UniqueDoomFarmASon"] == -1
#return get_character(0).call_balloon(28,-1) if $story_stats["QuProgPB_DeeponeEyes"] == 1 && $game_party.item_number($data_items[115]) >=8
##########################
