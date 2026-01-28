
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return portrait_hide
end
#tag list
#"Protein"
#"Meat"
#"MysticMeat"
#"HumanMysticMeat"
#"HumanMeat"
#"Plant"
#"Starch"
#"Cheese"
#"Milk"
#"Waste"
#"RedPotion"
#"ContraceptivePills"
#"HiPotionLV2"
#"HerbHi"
#"HerbHi_ParasiteFlower"
#"HerbContraceptive"
#"HerbSta"
#"HerbCure"
#"HerbRepellents"
#"medicine_Repellents"
#"medicine_Abortion"
#"Alcohol"
#"DryProtein"
#"Pee"
#"ArecaNut"
#"BombShockTrigger"
#"BombShockTimer"
#"BombShockPasstive"
#"BombFragTrigger"
#"BombFragTimer"
#"BombFragPasstive"
#"Phosphorus"
#"Saltpeter"
#"Carbon"
#"Oil"
#"Fat"
#"PubicHair"
#"Metal"
#"Wood"
#"Cloth"
get_character(0).call_balloon(0)
tmpList = Hash.new(0) #to record mixed data
tmpGetItemList = Hash.new(0) #to record items 
	$game_portraits.lprt.hide
	call_msg("commonCommands:Lona/DarkPot_begin")
	case $game_temp.choice
		when 1
		SceneManager.goto(Scene_ItemStorage)
		SceneManager.scene.prepare(System_Settings::STORAGE_PLAYER_POT)
		when 2
			if $game_player.actor.sta <= 0    # if no sta.  then u cant cook
				SndLib.sys_buzzer
				$game_map.popup(0,"QuickMsg:Lona/sta_too_low#{rand(2)}",0,0)
				return eventPlayEnd
			end
			totalCostSta = 0
			$game_boxes.box(System_Settings::STORAGE_PLAYER_POT).each{|item|
				totalCostSta += item[1] #how many items inside this pot
				next if !item[0].pot_data
				item[0].pot_data.each{|itemPotData|
					tmpList[itemPotData[0]] += itemPotData[1]*item[1] #pot name = PotNum*itemNum
				}
			}
			tmpList.each{|itemPotData|
				tmpList[itemPotData[0]] = itemPotData[1].to_i
			}
			#msgbox tmpList###################################
			$game_player.actor.sta -= totalCostSta
			$game_boxes.box(System_Settings::STORAGE_PLAYER_POT).clear
			
			
			
			tmpList,tmpGetItemList = darkPot_LetsCook(tmpList,tmpGetItemList) #29_Functions_DarkPot.rb
			

			############ PROCESS ITEM OUTPUT #############################################
			############ PROCESS ITEM OUTPUT #############################################
			############ PROCESS ITEM OUTPUT #############################################
			############ PROCESS ITEM OUTPUT #############################################
			############ PROCESS ITEM OUTPUT #############################################
			############ PROCESS ITEM OUTPUT #############################################
			tmpGetItemList.each{|item|
				next if !item
				next if !item[0] #"name"
				next if !item[1] || item[1] < 1 #howmany items
				itemName = item[0]
				itemAMT = item[1].round
				$game_boxes.box(System_Settings::STORAGE_PLAYER_POT)[$data_ItemName[itemName]] = itemAMT
				$story_stats["record_DarkPotCooked"] += itemAMT
			}
			
			call_msg("commonCommands:Lona/DarkPot_cooking")
			if !$game_boxes.box(System_Settings::STORAGE_PLAYER_POT).empty?
				SceneManager.goto(Scene_ItemStorage)
				SceneManager.scene.prepare(System_Settings::STORAGE_PLAYER_POT)
			else
				$game_player.actor.force_stun("Stun3")
				$game_map.reserve_summon_event("ProjectileCookFailed",get_character(0).x,get_character(0).y,-1,{:user=>$game_player})
			end
	end #choice

eventPlayEnd
