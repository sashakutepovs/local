if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $game_player.actor.dirt >= 150
	call_msg("TagMapNoerGoldenBar:vandor/Beigin_Dirt")
	return
end




if $game_player.actor.stat["SlaveBrand"] == 1 || $story_stats["Captured"] ==1

else # normal
	$story_stats["HiddenOPT0"] = "0"
	$story_stats["HiddenOPT1"] = "0"
	$story_stats["HiddenOPT0"] = "1" if $game_party.has_item?("ItemMilk")
	$story_stats["HiddenOPT1"] = "1" if $story_stats["#{map_id}DailyWorkAmt"] != $game_date.dateAmt && $game_player.actor.lactation_level >=1
	call_msg("TagMapNoerGoldenBar:vandor/Beigin") #\optB[算了,交易,販售乳汁<r=HiddenOPT0>,工作<r=HiddenOPT1>]
	
	case $game_temp.choice
		when 0,-1
		when 1 #trade
			manual_barters("NoerGoldenBarVandorMan")
		when 2 # sell milk
			call_msg("TagMapNoerGoldenBar:vandor/SellMilk")
			tmpTotalMilk = 0
			tmpValue = 150
			
			SceneManager.goto(Scene_ItemStorage)
			SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
			call_msg("TagMapNoerGoldenBar:vandor/SellMilk2")
			tmpTotalMilk = $game_boxes.itemOnBoxNum?(System_Settings::STORAGE_TEMP,"ItemMilk")
			$game_message.add("#{$game_text["TagMapNoerGoldenBar:vandor/SellMilk_cut0"]}#{tmpTotalMilk}#{$game_text["TagMapNoerGoldenBar:vandor/SellMilk_cut1"]}#{tmpValue}")
			$game_map.interpreter.wait_for_message
			optain_item_chain(tmpTotalMilk*tmpValue,["ItemCoin1","ItemCoin2","ItemCoin3"]) if tmpTotalMilk >0
			$game_boxes.box(System_Settings::STORAGE_TEMP).clear
		when 3 #work
		
			temp_work = 0
			$story_stats["HiddenOPT0"] = "1"
			$story_stats["HiddenOPT1"] = "0"
			$game_temp.choice = -1
			call_msg("TagMapNoerGoldenBar:vandor/optWork") #optB[算了,餵奶<r=HiddenOPT0>,榨乳<r=HiddenOPT1>]
			case $game_temp.choice
			when 1
				call_msg("TagMapNoerGoldenBar:vandor/optWork_braFeed")
					$game_temp.choice = -1
					call_msg("common:Lona/Decide_optB")
						case $game_temp.choice
							when 0,-1
							when 1
								temp_work = 1
								call_msg("TagMapNoerGoldenBar:vandor/optWork_braFeed_decide")
								$story_stats["#{map_id}DailyWorkAmt"] = $game_date.dateAmt
						end
			when 2
				
			end

		if temp_work == 1 #服務員
			get_character($game_map.get_storypoint("WaiterCount")[2]).start
		elsif temp_work ==2 #舞孃
			get_character($game_map.get_storypoint("DanceCount")[2]).start
		end

	end
end #if slave and captured

portrait_hide
$story_stats["HiddenOPT0"] = "0"
$story_stats["HiddenOPT1"] = "0"
$game_temp.choice = -1
