

#417個人化延伸批次
#主要為中斷器的新功能
module GIM_ADDON

	def commonEV_drop_items
		return if $story_stats.data["record_dropped_items"].nil?
		return $story_stats.data["record_dropped_items"].clear if $game_map.isOverMap
		$story_stats.data["record_dropped_items"].each{|items|
			#[items,召喚腳色]
			items[0].each{|item|
				EvLib.sum(item,items[1].x,items[1].y,{:user=>$game_player})
			}
		}
		$story_stats.data["record_dropped_items"]=nil
	end

	def manual_barters(tmpTradeID)
		tmpImportData = $data_barters[tmpTradeID]
		msgbox "def manual_barters #{tmpTradeID}, cannot find TradeID" if !$data_barters[tmpTradeID]
		noBuy = tmpImportData["noBuy"]
		noSell = tmpImportData["noSell"]

		prp "manual_barters build shopNerf"
		shopNerf = ([([$story_stats["WorldDifficulty"].round,100].min)-0,0].max*0.001)
		shopNerf = eval(tmpImportData["shopNerf"]) if tmpImportData["shopNerf"].is_a?(String)
		shopNerf = tmpImportData["shopNerf"] if tmpImportData["shopNerf"].is_a?(Numeric)
		#shopNerf = ([([$story_stats["WorldDifficulty"].round,100].min)-0,0].max*0.001) if tmpImportData["shopNerf"] == true

		prp "manual_barters build shopBuff"
		shopBuff = ([([$game_player.actor.weak.round,125].min)-25,0].max*0.001)
		shopBuff = eval(tmpImportData["shopBuff"]) if tmpImportData["shopBuff"].is_a?(String)
		shopBuff = tmpImportData["shopBuff"] if tmpImportData["shopBuff"].is_a?(Numeric)
		#shopBuff = ([([$game_player.actor.weak.round,125].min)-25,0].max*0.001) if tmpImportData["shopBuff"] == true

		prp "manual_barters import basicExtData"  #data make shopNerf, shopBuff can import to eval
		basicExtData = "
			shopNerf = #{shopNerf};
			shopBuff = #{shopBuff};
			dateAmt = #{$game_date.dateAmt};
		"

		prp "manual_barters build charStoreTP"
		charStoreTP = eval(basicExtData + tmpImportData["charStoreTP"]).round if tmpImportData["charStoreTP"].is_a?(String)
		charStoreTP = tmpImportData["charStoreTP"].round if tmpImportData["charStoreTP"].is_a?(Numeric)
		prp "manual_barters export charStoreTP to basicExtData"
		basicExtData = basicExtData + "charStoreTP = #{charStoreTP};"

		prp "manual_barters build charStoreHashName"
		charStoreHashName = "#{@map_id}_#{get_character(0).id}".to_sym if tmpImportData["charStoreHashName"] == true
		charStoreHashName = tmpImportData["charStoreHashName"] if tmpImportData["charStoreHashName"] != true
		charStoreExpireDate = tmpImportData["charStoreExpireDate"] if tmpImportData["charStoreExpireDate"].is_a?(Numeric)

		prp "manual_barters build charStoreExpireDate"
		charStoreExpireDate = eval(basicExtData + tmpImportData["charStoreExpireDate"]).round if tmpImportData["charStoreExpireDate"].is_a?(String)
		charStoreExpireDate = $game_date.dateAmt+1+rand(4+$story_stats["Setup_Hardcore"]) if tmpImportData["charStoreExpireDate"] == true
		good = {}
		tmpImportData["items"].each{|tmpJsonItemData|
			item_name =  tmpJsonItemData["item_name"]
			prp "manual_barters build #{item_name}"
			msgbox "def manual_barters #{tmpTradeID}, cannot find item_name=>#{item_name}" if !$data_ItemName[item_name]
			itemPriceExt = "itemPrice = #{$data_ItemName[tmpJsonItemData["item_name"]].price};"
			itemExtData = basicExtData + itemPriceExt

			prp "manual_barters build #{item_name} price"
			tgtItem_price = eval(itemExtData + tmpJsonItemData["price"]) if tmpJsonItemData["price"].is_a?(String)
			tgtItem_price = tmpJsonItemData["price"] if tmpJsonItemData["price"].is_a?(Numeric)
			tgtItem_price = $data_ItemName[tmpJsonItemData["item_name"]].price if tmpJsonItemData["price"].nil?

			prp "manual_barters build #{item_name} amount"
			tgtItem_amt = eval(itemExtData + tmpJsonItemData["amount"]) if tmpJsonItemData["amount"].is_a?(String)
			tgtItem_amt = tmpJsonItemData["amount"] if tmpJsonItemData["amount"].is_a?(Numeric)
			tgtItem_amt = 1 if tmpJsonItemData["amount"].nil?

			prp "manual_barters build #{item_name} condition"
			tgtItem_Condition = tmpJsonItemData["condition"] if tmpJsonItemData["condition"].is_a?(String)
			tgtItem_Condition = tmpJsonItemData["condition"] if tmpJsonItemData["condition"] == false
			tgtItem_Condition = tmpJsonItemData["condition"] if tmpJsonItemData["condition"] == true

			prp "manual_barters build #{item_name} done"
			next if tgtItem_Condition == false
			next if (tgtItem_Condition && tgtItem_Condition.is_a?(String) && !eval(tgtItem_Condition)) && tgtItem_Condition != true
			next if tgtItem_amt <= 0
			good[tmpJsonItemData["item_name"]] = Hash.new
			good[tmpJsonItemData["item_name"]]["price"] = tgtItem_price.round
			good[tmpJsonItemData["item_name"]]["amount"] = tgtItem_amt
		}
		npcPersonalData = nil #todo.  make item with spec buy /sell price or  not buy/sell spec items
		build_manual_store(good,charStoreTP,charStoreExpireDate,charStoreHashName,noSell,noBuy,npcPersonalData)
	end
	def build_manual_store(good,charStoreTP=0,charStoreExpireDate=nil,charStoreHashName=nil,noSell=false,noBuy=false,npcPersonalData=nil)
		tmpStoreData = [good,charStoreTP,charStoreExpireDate]
		if charStoreHashName #limited in game store
			if !$story_stats["CharacterItems"][charStoreHashName]
				charStoreTP = 0 if !charStoreTP || charStoreTP < 0
				$story_stats["CharacterItems"][charStoreHashName] = tmpStoreData
			end
			$game_boxes.buildBarter(System_Settings::STORAGE_TEMP,$story_stats["CharacterItems"][charStoreHashName][0],$story_stats["CharacterItems"][charStoreHashName][1])
		else #Store, debug mode
			$game_boxes.buildBarter(System_Settings::STORAGE_TEMP,good,charStoreTP)
		end
		SceneManager.goto(Scene_TradeStorage)
		if charStoreHashName #limited in game store
			SceneManager.scene.prepare(System_Settings::STORAGE_TEMP,noSell,noBuy,$story_stats["CharacterItems"][charStoreHashName])
		else
			SceneManager.scene.prepare(System_Settings::STORAGE_TEMP,noSell,noBuy,tmpStoreData)
		end
		wait(1)
		$story_stats["CharacterItems"].delete(charStoreHashName) if charStoreExpireDate.nil? && charStoreHashName
		$game_boxes.box(System_Settings::STORAGE_TEMP).clear

	end
	#charStoreTP = 3000
	#charStoreExpireDate = $game_date.dateAmt+1+rand(4)
	#charStoreHashName = "#{@map_id}_#{get_character(0).id}".to_sym
	def manual_trade(good,charStoreHashName=nil,charStoreTP=0,charStoreExpireDate=nil,noSell=false,noBuy=false)  #unused outdated
		tmpStoreData = [good,charStoreTP,charStoreExpireDate]
		if charStoreHashName #limited in game store
			if !$story_stats["CharacterItems"][charStoreHashName]
				charStoreTP = 0 if !charStoreTP || charStoreTP < 0
				$story_stats["CharacterItems"][charStoreHashName] = tmpStoreData
			end
			$game_boxes.buildStore(System_Settings::STORAGE_TEMP,$story_stats["CharacterItems"][charStoreHashName][0],$story_stats["CharacterItems"][charStoreHashName][1])
		else #Store, debug mode
			$game_boxes.buildStore(System_Settings::STORAGE_TEMP,good,charStoreTP)
		end
		SceneManager.goto(Scene_TradeStorage)
		if charStoreHashName #limited in game store
			SceneManager.scene.prepare(System_Settings::STORAGE_TEMP,noSell,noBuy,$story_stats["CharacterItems"][charStoreHashName])
		else
			SceneManager.scene.prepare(System_Settings::STORAGE_TEMP,noSell,noBuy,tmpStoreData)
		end
		wait(1)
		$story_stats["CharacterItems"].delete(charStoreHashName) if charStoreExpireDate.nil? && charStoreHashName
		$game_boxes.box(System_Settings::STORAGE_TEMP).clear
	end
	def eventPlayStart
		$game_player.actor.holding_efx.transparent = true if $game_player.actor.holding_efx
		$game_player.actor.cancel_holding
		$game_player.actor.take_skill_cancel($data_arpgskills["BasicNormal"])
	end

	def eventPlayEnd
		cam_center(0)
		portrait_hide
		$game_temp.choice = -1
		chcg_background_color_off
		$cg.erase
	end

	def call_timer(sec=120,rate=1)
		$game_timer.start(sec * rate)
		$game_system.timer_prev = $game_timer.count - 60
		$game_system.timer_prev = 1 if $game_timer.count <= 0
	end

def call_timerCHK(chkTarget)
	#use this to set custom counter max,
	#you need manual update $game_timer.count in event to update counter current
	#ex $game_timer.count = get_character(0).summon_data[:asd]
	$game_timer.startChkMode(chkTarget)
	$game_system.timer_prev = $game_timer.count - 60
	$game_system.timer_prev = 1 if $game_timer.count <= 0
end

def call_timer_off
	$game_timer.off
end


	def call_commonOPT(tmpCanCancel=true)
		tmpGotoTar = ""
		tmpTarList = []
		tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
		tmpTarList << [$game_text["menu:traits/accept"]						,"Confirm"]
		cmd_sheet = tmpTarList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
		end
		call_msg("common:Lona/CompCommand",0,2,0)
		if tmpCanCancel
			call_msg("\\optB[#{cmd_text}]")
		else
			call_msg("\\optD[#{cmd_text}]")
		end
		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1
		tmpPicked
	end

def call_msg(msg,bg=0,pos=2,wait_pull=1) #teller mode = 1:2 #opmode = 1:1 #default = 0,2
	$game_message.background =bg
	$game_message.position =pos
	$game_message.add("\\t[#{msg}]")
	$game_map.interpreter.wait_for_message if wait_pull ==1
end

def call_msg_dim(msg,bg=1,pos=1,wait_pull=1) #teller mode = 1:2 #opmode = 1:1 #default = 0,2
$game_message.background =bg
$game_message.position =pos
$game_message.add("\\t[#{msg}]")
$game_map.interpreter.wait_for_message if wait_pull ==1
end

def call_msg_popup(msg,id=0,icon=0,val=0)
$game_map.popup(id,"#{msg}",icon,val)
end

def call_snd_popup(msg,id=0,icon=0,val=0)
SndLib.sound_QuickDialog
$game_map.popup(id,"#{msg}",icon,val)
end

def follower_goto(goto_x=$game_player.x,goto_y=$game_player.y,temp_jump=false)
	$game_map.npcs.each do |event|
		next if !event.npc?
		next if event.npc.master != $game_player
		next if event.npc.action_state != :none && event.npc.action_state != nil
		next unless event.follower[0] == 1 && event.super_near_the_player? # event.switch1_id !=2改為問死了沒 必須為 ALIVE
				event.moveto(goto_x,goto_y) if temp_jump==false
				event.jump_to(goto_x,goto_y) if temp_jump==true
				event.set_original_xy(event.x,event.y)
				event.follower[1] = 1 #event.start 跟隨狀態 若不是跟隨 則設為跟隨
	end

end

def player_force_update
	$game_player.actor.update_state_frames
	$game_player.update
	$game_player.actor.portrait.update
	$game_player.refresh_chs
end



def moveto_teleportWaterPoint(point_name)
	if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
		SndLib.sys_buzzer
		$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	else
		SndLib.WaterIn(100)
		tmpTar = $game_player
		$game_player.transparent = true
		$game_map.reserve_summon_event("EffectWaterNil",tmpTar.x,tmpTar.y)
		moveto_teleport_point(point_name)
		$game_player.transparent = false
		tmpTar = $game_player
		$game_player.jump_to($game_player.x,$game_player.y,13)
		$game_map.reserve_summon_event("EffectWaterNil",tmpTar.x,tmpTar.y)
		SndLib.WaterOut(100)
	end
end
#Input.press?(:SHIFT)

	def set_SFX_to_indoor_SFX
	 	SndLib.bgm_play(RPG::BGM.last.name, RPG::BGM.last.volume ,RPG::BGM.last.pitch, RPG::BGM.last.pos) if RPG::BGM.last.name && File.exists?("Audio/BGM/#{RPG::BGM.last.name}.ogg")
	 	SndLib.bgs_play(RPG::BGS.last.name, RPG::BGS.last.volume-20, RPG::BGS.last.pitch-10 ,RPG::BGS.last.pos) if RPG::BGS.last.name && File.exists?("Audio/BGS/#{RPG::BGS.last.name}.ogg")
	end
 #tmpData = [120,90,50,150, #shadow
 #nil, #Fog
 #nil,nil,nil, #weather
 #128,128,40,60,0, #MAP BG
 #nil,nil,nil,nil, #BGM name volume pitch pos
 #nil,nil,nil,nil] #BGS
 #moveto_teleport_point("HouseIN",tmpData,8)
def set_BG_EFX_data(tmpData)
	$game_map.set_underground_light													if tmpData[0] == "UnderGround"
	$game_map.shadows.set_color(tmpData[0], tmpData[1], tmpData[2])					if tmpData[0] && tmpData[0] != "UnderGround"
	$game_map.shadows.set_opacity(tmpData[3])										if tmpData[3] && tmpData[0] != "UnderGround"
	$game_map.set_fog(tmpData[4])
	tmpData[5] ? $game_map.interpreter.weather(tmpData[5], tmpData[6], tmpData[7]) : weather_stop
	map_background_color(tmpData[8],tmpData[9],tmpData[10],tmpData[11],tmpData[12]) if tmpData[8]

	SndLib.bgm_stop if tmpData[13]
	SndLib.bgm_play(tmpData[13],tmpData[14] ? tmpData[14] : 80,tmpData[15] ? tmpData[15] : 100,tmpData[16] ? tmpData[16] : 1) if tmpData[13]

	SndLib.bgs_stop if tmpData[17]
	SndLib.bgs_play(tmpData[17],tmpData[18] ? tmpData[18] : 80,tmpData[19] ? tmpData[19] : 100,tmpData[20] ? tmpData[20] : 1) if tmpData[17]
end

def get_BG_EFX_data
	tmpRGB = $game_map.shadows.getRGB
	tmpWeather = $game_system.weather
	tmpRGB = Array.new if !tmpRGB
	tmpWeather =  Array.new if !tmpWeather
	bg_color = map_background_color_export
	tmpData = [
	tmpRGB[0],tmpRGB[1],tmpRGB[2],$game_map.shadows.opacity,
	$game_map.fog,
	tmpWeather[0],tmpWeather[1],tmpWeather[2],
	bg_color[0],bg_color[1],bg_color[2],bg_color[3],bg_color[4],
	RPG::BGM.last.name, RPG::BGM.last.volume, RPG::BGM.last.pitch, RPG::BGM.last.pos,
	RPG::BGS.last.name, RPG::BGS.last.volume, RPG::BGS.last.pitch ,RPG::BGS.last.pos
	]
	tmpData
end

def get_BG_EFX_data_Indoor
	tmpRGB = $game_map.shadows.getRGB
	tmpWeather = $game_system.weather
	tmpRGB = Array.new if !tmpRGB
	tmpWeather =  Array.new if !tmpWeather
	bg_color = map_background_color_export
	tmpData = [
	tmpRGB[0],tmpRGB[1],tmpRGB[2],$game_map.shadows.opacity,
	$game_map.fog,
	tmpWeather[0],tmpWeather[1],tmpWeather[2],
	bg_color[0],bg_color[1],bg_color[2],bg_color[3],bg_color[4],
	nil, nil, nil, nil,
	RPG::BGS.last.name, nil, RPG::BGS.last.pitch ,nil
	]
	tmpData
end

def get_BG_EFX_data_Observe
	tmpRGB = $game_map.shadows.getRGB
	tmpWeather = $game_system.weather
	tmpRGB = Array.new if !tmpRGB
	tmpWeather =  Array.new if !tmpWeather
	bg_color = map_background_color_export
	tmpData = [
	tmpRGB[0],tmpRGB[1],tmpRGB[2],$game_map.shadows.opacity,
	$game_map.fog,
	tmpWeather[0],tmpWeather[1],tmpWeather[2],
	bg_color[0],bg_color[1],bg_color[2],bg_color[3],bg_color[4],
	nil, nil, nil, nil,
	nil, nil, nil, nil
	]
	tmpData
end

def player_group_goto(temp_x,temp_y,temp_jump=false)
	if temp_jump == false
		follower_goto(temp_x,temp_y)
		$game_player.moveto(temp_x,temp_y)
	elsif temp_jump == true
		follower_goto(temp_x,temp_y,true)
		$game_player.jump_to(temp_x,temp_y)
	end
end

def put_map_items_into_box(tmpStorageID=System_Settings::STORAGE_TEMP_MAP)
	$game_map.events.each{|event|
		next if !event[1].summon_data
		next unless event[1].summon_data[:isItem] || event[1].summon_data[:isEquip]
		if !$data_ItemName[event[1].name].nil?
			prp "Item=>#{event[1].name} putted into StorageID=>#{tmpStorageID}"
			tmpItem=$data_ItemName[event[1].name]
			if $game_boxes.box(tmpStorageID)[tmpItem] && $game_boxes.box(tmpStorageID)[tmpItem] >= 1
				$game_boxes.box(tmpStorageID)[tmpItem] += 1
			else
				$game_boxes.box(tmpStorageID)[tmpItem] = 1
			end
			event[1].delete
		end
	}
end

#do blah with popup
def optain_exp(temp_exp)
	SndLib.sys_LvUp
	$game_map.popup(0,"EXP+#{temp_exp}",0,0)
	$game_player.actor.gain_exp(temp_exp)
end

def optain_morality(temp_mori=0)
	temp_mori > 0 ? SndLib.sys_LvUp : SndLib.sys_buzzer
	temp_mori > 0 ? temp_sym = "+" : temp_sym = ""
	temp_mori > 0 ? temp_spd = 1 : temp_spd = -1
	$game_map.popup(0,"#{$game_text["menu:equip/mori"]}#{temp_sym}#{temp_mori}",0,temp_spd)
	#$game_map.popup(0,"#{$game_text["menu:equip/mori"]}#{$game_player.actor.morality_lona}#{temp_sym}#{temp_mori}",0,temp_spd)
	$game_player.actor.morality_lona += temp_mori
end

def optain_lose_item(item,temp_num=1)
	item = $data_ItemName[item] if item.is_a?(String)
	return if !item
	SndLib.sound_equip_armor
	$game_map.popup(0,"#{temp_num}",item.icon_index,-1)
	#$game_map.popup(0,"#{$game_party.item_number(item)}-#{temp_num}",item.icon_index,-1)
	$game_party.lose_item(item,temp_num)
end

def optain_state(stateID,stateLVL)
	return if stateLVL <=0
	 if stateID.is_a?(String)
		state = $data_StateName[stateID]
	 else
		state = $data_states[stateID]
	 end
	return if !stateID
	SndLib.sys_Gain
	$game_map.popup(0,"#{stateLVL}",state.icon_index,1)
	stateLVL.times{
		$game_player.actor.add_state(stateID)
	}
end

def optain_item(item,temp_num=1)
	return if temp_num <=0
	item = $data_ItemName[item] if item.is_a?(String)
	return if !item
	SndLib.sound_equip_armor
	$game_party.gain_item(item,temp_num)
	$game_map.popup(0,"#{temp_num}",item.icon_index,1)
	#$game_map.popup(0,"#{$game_party.item_number(item)}+#{temp_num}",item.icon_index,1)
end


def optain_gold(num)
	event_key_cleaner_whore_work
	$game_party.gain_gold(num)
	SndLib.sys_Gain
	$game_map.popup(0,num,812,1)
end

def optain_lose_gold(num)
	event_key_cleaner_whore_work
	num = num * -1
	$game_party.gain_gold(num)
	SndLib.sound_equip_armor
	$game_map.popup(0,num,812,-1)
end

def optain_item_chain(cur_vol=1,good=["ItemCoin1","ItemCoin2","ItemCoin3"],summon=false)
	tmpRoster = $game_party.gain_items_by_price(cur_vol,good,summon)
	return if tmpRoster.empty? || summon
	tmpRoster.each do |tar_item|
		SndLib.sound_equip_armor
		$game_map.popup(0,tar_item[1],tar_item[0],1)
		wait(30)
	end
end

	def player_cancel_nap
		$game_player.call_balloon(0)
		$game_player.animation = nil
		$game_player.actor.add_state("DoormatUp20")
		$game_player.actor.add_state("DoormatUp20")
		$game_player.actor.cancel_holding
		$game_player.actor.reset_skill(true)
	end

	def show_npc_info(tar_char,extra_info=false,tmp_dialog="common:Lona/Decide_optB")
		tmpChar = tar_char

		tmpCharW = tmpChar.char_block_width
		tmpCharH = tmpChar.char_block_height
		tmpGW = Graphics.width
		tmpGH = Graphics.height
		tmpLimitY = tmpGH/3
		tmpForceY = tmpLimitY - tmpCharH*2
		tmpStatBoxH=100

		tmpSprite	=Sprite.new
		tmpSprite.bitmap	=Bitmap.new(tmpCharW*2,tmpCharH*2)
		tmpSprite.x = ((tmpGW/2) - (tmpCharW*2)/2)
		tmpSprite.y = tmpForceY
		tmpSprite.z = System_Settings::COMPANION_UI_Z
		if tar_char.use_chs?
			tmpY_plus = $chs_data[tar_char.chs_type].cell_y_adjust
			tmpSprite.bitmap.stretch_blt(Rect.new(0, 0, tmpCharW*2, tmpCharH*2),Cache.chs_character(tmpChar,true),Rect.new(tmpCharW,-tmpY_plus,tmpCharW,tmpCharH))
		end
		tmpInfoL =Sprite.new
		tmpLineL=tmpStatBoxH/5
		tmpInfoL.bitmap	=Bitmap.new(100,tmpLimitY+50)
		tmpInfoL.x = (tmpGW/2) - tmpCharW*1.6
		tmpInfoL.x = 224 if tmpInfoL.x > 224
		tmpInfoL.x = 175 if tmpInfoL.x < 175
		tmpInfoL.y = 12
		tmpInfoL.bitmap.font.size = 16
		tmpInfoL.bitmap.font.bold = true
		tmpInfoL.bitmap.font.outline = false
		tmpInfoL.bitmap.font.color=Color.new(60,255,0,255)
		tmpInfoL.z = System_Settings::COMPANION_UI_Z
		tmpInfoL.opacity = 255
		#tmpInfoL.bitmap.fill_rect(tmpInfoL.bitmap.rect,Color.new(90,255,12))
		tmpInfoL.bitmap.draw_text(0,5				,98,25,	$game_text["menu:core_stats/hp"],0)
		tmpInfoL.bitmap.draw_text(0,5+tmpLineL*1	,98,25,	$game_text["menu:core_stats/sta"],0)
		tmpInfoL.bitmap.draw_text(0,5+tmpLineL*2	,98,25,	$game_text["menu:equip/spd"],0)
		tmpInfoL.bitmap.draw_text(0,5+tmpLineL*3	,98,25,	$game_text["menu:equip/mood"],0)
		if tmpChar.npc.master == $game_player
			tmpInfoL.bitmap.draw_text(0,5+tmpLineL*4	,98,25,	$game_text["menu:core_stats/TimeLeft"],0)
		else
			tmpInfoL.bitmap.draw_text(0,5+tmpLineL*4	,98,25,	$game_text["menu:equip/mori"],0)
		end
		tmpInfoL.bitmap.draw_text(0,5+tmpLineL*5	,98,25,	$game_text["menu:equip/sexy"],0) if extra_info
		#tmpInfoL.bitmap.draw_text(18,5			,	25,25,	":",1)
		#tmpInfoL.bitmap.draw_text(18,5+tmpLineL*1	,25,25,	":",1)
		#tmpInfoL.bitmap.draw_text(18,5+tmpLineL*2	,25,25,	":",1)
		#tmpInfoL.bitmap.draw_text(18,5+tmpLineL*3	,25,25,	":",1)
		#tmpInfoL.bitmap.draw_text(18,5+tmpLineL*4	,25,25,	":",1)
		tmpInfoL.bitmap.draw_text(38,5			,	98,25,	tmpChar.actor.battle_stat.get_stat("health").to_i,0)
		tmpInfoL.bitmap.draw_text(38,5+tmpLineL*1	,98,25,	tmpChar.actor.battle_stat.get_stat("sta").to_i,0)
		tmpInfoL.bitmap.draw_text(38,5+tmpLineL*2	,98,25,	tmpChar.actor.battle_stat.get_stat("move_speed").round(1),0)
		tmpInfoL.bitmap.draw_text(38,5+tmpLineL*3	,98,25,	tmpChar.actor.battle_stat.get_stat("mood").to_i,0)
		tmpCharIsFollower = tmpChar.summon_data && (tmpChar.summon_data[:followerFRONT] || tmpChar.summon_data[:followerBACK] || tmpChar.summon_data[:followerEXT])
		if tmpChar.npc.master == $game_player && tmpCharIsFollower #[-1,0,1].include?(tmpChar.follower[2])

			if tmpChar.summon_data[:followerFRONT] && !$game_player.record_companion_front_date.nil?
				tmpDateLeft = ([$game_player.record_companion_front_date - $game_date.dateAmt,0].max)*0.5
				tmpDateLeft = tmpDateLeft.round(1)
			elsif tmpChar.summon_data[:followerBACK] && !$game_player.record_companion_back_date.nil?
				tmpDateLeft = ([$game_player.record_companion_back_date - $game_date.dateAmt,0].max)*0.5
				tmpDateLeft = tmpDateLeft.round(1)
			elsif tmpChar.summon_data[:followerEXT] && !$game_player.record_companion_ext_date.nil?
				tmpDateLeft = ([$game_player.record_companion_ext_date - $game_date.dateAmt,0].max)*0.5
				tmpDateLeft = tmpDateLeft.round(1)
			else
				tmpDateLeft = "NIL"
			end
			tmpInfoL.bitmap.draw_text(38,5+tmpLineL*4	,98,25,	tmpDateLeft,0)
		else
			tmpInfoL.bitmap.draw_text(38,5+tmpLineL*4	,98,25,	tmpChar.actor.battle_stat.get_stat("morality").to_i,0)
		end
		tmpInfoL.bitmap.draw_text(38,5+tmpLineL*5	,98,25,	tmpChar.actor.battle_stat.get_stat("sexy").to_i,0) if extra_info




		tmpInfoR =Sprite.new
		tmpLineR=tmpStatBoxH/5
		tmpInfoR.bitmap	=Bitmap.new(tmpStatBoxH,tmpLimitY+50)
		tmpInfoR.x = ((tmpGW/2) + tmpCharW*1.6)-tmpStatBoxH
		tmpInfoR.x = 316 if tmpInfoR.x < 316
		tmpInfoR.x = 365 if tmpInfoR.x > 365
		tmpInfoR.y = 12
		tmpInfoR.bitmap.font.size = 15
		tmpInfoR.bitmap.font.bold = true
		tmpInfoR.bitmap.font.outline = false
		tmpInfoR.bitmap.font.color=Color.new(60,255,0,255)
		tmpInfoR.z = System_Settings::COMPANION_UI_Z
		tmpInfoR.opacity = 255
		#tmpInfoR.bitmap.fill_rect(tmpInfoR.bitmap.rect,Color.new(255,160,12))
		tmpInfoR.bitmap.draw_text(2,5				,95,25,	$game_text["menu:equip/atk"],2)
		tmpInfoR.bitmap.draw_text(2,5+tmpLineR*1	,95,25,	$game_text["menu:equip/def"],2)
		tmpInfoR.bitmap.draw_text(2,5+tmpLineR*2	,95,25,	$game_text["menu:equip/wis"],2)
		tmpInfoR.bitmap.draw_text(2,5+tmpLineR*3	,95,25,	$game_text["menu:equip/sur"],2)
		tmpInfoR.bitmap.draw_text(2,5+tmpLineR*4	,95,25,	$game_text["menu:equip/con"],2)
		tmpInfoR.bitmap.draw_text(2,5+tmpLineR*5	,95,25,	$game_text["menu:equip/weak"],2) if extra_info
		#tmpInfoR.bitmap.draw_text(2+55,5			,25,25,	":",1)
		#tmpInfoR.bitmap.draw_text(2+55,5+tmpLineR*1	,25,25,	":",1)
		#tmpInfoR.bitmap.draw_text(2+55,5+tmpLineR*2	,25,25,	":",1)
		#tmpInfoR.bitmap.draw_text(2+55,5+tmpLineR*3	,25,25,	":",1)
		#tmpInfoR.bitmap.draw_text(2+55,5+tmpLineR*4	,25,25,	":",1)
		tmpInfoR.bitmap.draw_text(2-38,5			,95,25,	tmpChar.actor.battle_stat.get_stat("atk").round(1),2)
		tmpInfoR.bitmap.draw_text(2-38,5+tmpLineR*1	,95,25,	tmpChar.actor.battle_stat.get_stat("def").round(1),2)
		tmpInfoR.bitmap.draw_text(2-38,5+tmpLineR*2	,95,25,	tmpChar.actor.battle_stat.get_stat("wisdom").round(1),2)
		tmpInfoR.bitmap.draw_text(2-38,5+tmpLineR*3	,95,25,	tmpChar.actor.battle_stat.get_stat("survival").round(1),2)
		tmpInfoR.bitmap.draw_text(2-38,5+tmpLineR*4	,95,25,	tmpChar.actor.battle_stat.get_stat("constitution").round(1),2)
		tmpInfoR.bitmap.draw_text(2-38,5+tmpLineR*5	,95,25,	tmpChar.actor.battle_stat.get_stat("weak"),2) if extra_info


		if extra_info
			tmpState_icons = Sprite.new
			tmpState_icons.z = tmpInfoR.z+2
			tmpState_icons.y = (Graphics.height-Graphics.height/2).round
			tmpState_icons.x = 0
			iconWindowPosW = 1+tar_char.actor.feature_objects.uniq.size*27
			window_size = [Graphics.width, Graphics.height]
			obj_size = [iconWindowPosW, 60]
			center_x = window_size[0] / 2
			center_y = window_size[1] / 2
			tmpState_icons.bitmap = Bitmap.new(iconWindowPosW,60)
			tmpState_icons.x = center_x - obj_size[0] / 2

			sort_index = 0
			tar_char.actor.feature_objects.uniq.each{|state|
				next unless state.is_a?(RPG::State)
				next if state.type_tag == "combat"
				icon_index = state.icon_index
				tmpLVL = tar_char.actor.state_stack(state.item_name)
				p "state name => #{state.item_name}"
				tmpLVL = 9 if tmpLVL >9
				if icon_index.is_a?(String)
					cachedBitmapICON = Cache.normal_bitmap(state.icon_index)
				else
					cachedBitmapICON = Cache.system("Iconset")
				end
				numIcon = Graphics.width + tmpLVL
				icon_src_rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
				tmpState_icons.bitmap.blt(sort_index * 27 , 0 ,cachedBitmapICON , icon_src_rect) if icon_index !=-1
				if tmpLVL >= 2
					icon_src_rect = Rect.new(numIcon % 16 * 24, numIcon / 16 * 24, 24, 24)
					tmpState_icons.bitmap.blt(sort_index * 27 , 0 ,cachedBitmapICON , icon_src_rect)
				end
				sort_index += 1
			}
		end
		call_msg(tmp_dialog)
		tmpState_icons.dispose if extra_info
		tmpSprite.dispose
		tmpInfoL.dispose
		tmpInfoR.dispose
	end #companion_command

	def reward_item_roster
		tmpList = [
			"ItemMhShortSword",
			"ItemMhWoodenClub",
			"Item2MhWoodenSpear",
			"Item2MhLongBow",
			"Item2MhManCatcher",
			"Item2MhHalberd",
			"ItemMhWhip",
			"Item2MhMetalSpear",
			"ItemMhSickle",
			"ItemMhPickAxe",
			"Item2MhRake",
			"ItemMhFireStaff",
			"ItemMhWaterStaff",
			"ItemMhSabar",
			"ItemMhTeslaStaff",
			"ItemCuff",
			"ItemChainCuff",
			"ItemMhChainMace",
			"ItemPantyVag",
			"ItemAdvTop",
			"ItemRagTop",
			"ItemSurTop",
			"ItemAdvMid",
			"ItemRagMid",
			"ItemSexyMid",
			"ItemSurMid",
			"ItemSexyBot",
			"ItemRagVag",
			"ItemRagBot",
			"ItemAdvBot",
			"ItemSurBot",
			"ItemAdvMidExtra",
			"ItemRagMidExtra",
			"ItemSurMidExtra",
			"ItemCollar",
			"ItemChainCollar",
			"ItemBucketHelmet",
			"ItemHoodCloakTop",
			"ItemHairTwinBraid",
			"ItemHairPony",
			"ItemHairShortMessy",
			"ItemHairDancer",
			"ItemHairMessy",
			"ItemSexyHeadEquip",
			"ItemStarterGlass",
			"ItemShDagger",
			"ItemShWoodenShield",
			"ItemShLantern",
			"ItemShBoneShield",
			"ItemShMetalShield",
			"ItemShFireBook",
			"ItemShWaterBook",
			"ItemShTeslaBook",
			"ItemShSaintProtect",
			"ItemShSaintPurge",
			"ItemSlaveMid",
			"ItemSlaveMidExtra",
			"ItemNeckleBelt",
			"ItemNeckleAtoner",
			"ItemApple",
			"ItemBread",
			"ItemCheese",
			"ItemMushroom",
			"ItemSausage",
			"ItemGrapes",
			"ItemOrange",
			"ItemNuts",
			"ItemOnion",
			"ItemPepper",
			"ItemBlueBerry",
			"ItemFish",
			"ItemCarrot",
			"AnimalRattus",
			"ItemTomato",
			"ItemCherry",
			"ItemMilk",
			"ItemPotato",
			"ItemSmokedMeat",
			"ItemDryFood",
			"ItemRedPotion",
			"ItemBluePotion",
			"ItemContraceptivePills",
			"ItemHiPotionLV2",
			"ItemHiPotionLV5",
			"ItemHerbCure",
			"ItemHerbSta",
			"ItemHerbContraceptive",
			"ItemHerbHi",
			"ItemHerbRepellents",
			"ItemRepellents",
			"ItemAbortion",
			"ItemFruitWine",
			"WasteSemenOther",
			"WasteSemenHuman",
			"WasteSemenOrcish",
			"WasteSemenAbomination",
			"WasteSemenFishkind",
			"WastePoo0",
			"WasteVomit0",
			"ItemSopMeat",
			"ItemMutantFlesh",
			"ItemHumpshroom",
			"ItemHumanoidFlesh",
			"ItemRawMeat",
			"ItemSopPlant",
			"AnimalRoach",
			"ItemSopGood",
			"ItemCoin1",
			"ItemCoin2",
			"ItemCoin3",
			"ItemRock",
			"ItemBeer",
			"ItemBottledBeer",
			"ItemBottledPee",
			"ItemHumanoidBrain",
			"ItemHolyWater",
			"ItemHumanFlesh",
			"ItemSopMeatHuman",
			"ItemSopGoodHuman",
			"ItemSmokedMeatHuman",
			"ItemMilk",
			"ItemSopMeatMystery",
			"ItemSopGoodMystery",
			"ItemSmokedMeatMystery",
			"ItemDryProtein",
			"ItemDreg",
			"ItemJunkFood",
			"ItemBanana",
			"ItemArecaNut",
			"ItemNoerTea",
			"ItemThrowingKnivesI",
			"ItemFlameBottle",
			"ItemSaltpeter",
			"ItemCarbon",
			"ItemOil",
			"ItemPhosphorus",
			"ItemBombFragTimer",
			"ItemBombFragPasstive",
			"ItemBombFragTrigger",
			"ItemBombShockTimer",
			"ItemBombShockPasstive",
			"ItemBombShockTrigger"
		]
		tmpList << "ItemMhBoneStaff"			if $story_stats["RecQuest_Df_TellerSide"] >= 4 #ItemMhBoneStaff
		tmpList << "ItemShAbominationTotem"		if $story_stats["RecQuest_Df_TellerSide"] >= 4 #ItemShAbominationTotem
		tmpList << "ItemDancerHeadEquip"		if $story_stats["RecQuestDancerSetReturned"] >= 1 #ItemDancerHeadEquip
		tmpList << "ItemDancerTop"				if $story_stats["RecQuestDancerSetReturned"] >= 1 #ItemDancerTop
		tmpList << "ItemDancerMid"				if $story_stats["RecQuestDancerSetReturned"] >= 1 #ItemDancerMid
		tmpList << "ItemDancerBot"				if $story_stats["RecQuestDancerSetReturned"] >= 1 #ItemDancerBot
		tmpList << "Item2MhMusket"				if $story_stats["RecQuestAdam"] >=6 #Item2MhMusket
		tmpList << "ItemNunSexyMid"				if $story_stats["RecQuestCocona"] >= 21
		tmpList << "ItemNunMidExtra"			if $story_stats["RecQuestCocona"] >= 21
		tmpList << "ItemNunVeilHeadEquip"		if $story_stats["RecQuestCocona"] >= 21

		tmpList
	end
	def debug_item_roster
		itemSortedHash = {}
		good = {}
		itemSortedHash = $data_ItemName.sort_by{|name,item|
			item.class <=> item.item_name
		}
		itemSortedHash.each{|name,item|
			next if !item
			next if !item.item_name
			next if item.item_name == ""
			next if !item.weight
			next if item.type == "SurgeryCoupon"
			next if item.type_tag == "Trait"
			next if item.type_tag == "SurgeryTricket"
			next if item.key_item?
			good[item.item_name] = Hash.new
			good[item.item_name]["price"] = 0
			good[item.item_name]["amount"] = 999
		}
		return good
	end

	def reward_item_to_storage
		tmpReward = reward_item_roster.sample
		$data_ItemName[tmpReward]
	end
	def reward_returned_hostage
		call_msg("HostageSavedRich")
		if $story_stats["HostageSaved"]["HostageSavedRich"] >= 1
			optain_morality(2*$story_stats["HostageSaved"]["HostageSavedRich"])
			wait(30)
			optain_item_chain(4000*$story_stats["HostageSaved"]["HostageSavedRich"],good=["ItemCoin1","ItemCoin2","ItemCoin3"],summon=false)
			optain_exp(5000*$story_stats["HostageSaved"]["HostageSavedRich"])
			$story_stats["RecQuestHostageReturned"]+= $story_stats["HostageSaved"]["HostageSavedRich"]
			$story_stats["HostageSaved"]["HostageSavedRich"] = 0
			wait(30)
		end
		call_msg("HostageSavedCommoner")
		if $story_stats["HostageSaved"]["HostageSavedCommoner"] >= 1
			optain_morality(1*$story_stats["HostageSaved"]["HostageSavedCommoner"])
			wait(30)
			optain_item_chain(1200*$story_stats["HostageSaved"]["HostageSavedCommoner"],good=["ItemCoin1","ItemCoin2","ItemCoin3"],summon=false)
			optain_exp(5000*$story_stats["HostageSaved"]["HostageSavedCommoner"])
			$story_stats["RecQuestHostageReturned"] += $story_stats["HostageSaved"]["HostageSavedCommoner"]
			$story_stats["HostageSaved"]["HostageSavedCommoner"] = 0
			wait(30)
		end
		call_msg("HostageSavedMoot")
		if $story_stats["HostageSaved"]["HostageSavedMoot"] >= 1
			optain_morality(1*$story_stats["HostageSaved"]["HostageSavedMoot"])
			wait(30)
			optain_exp(5000*$story_stats["HostageSaved"]["HostageSavedMoot"])
			$story_stats["RecQuestHostageReturned"] += $story_stats["HostageSaved"]["HostageSavedMoot"]
			$story_stats["HostageSaved"]["HostageSavedMoot"] = 0
			wait(30)
		end
		achCheckVictim
	end
	def rape_loop_drop_item(tmpEquip=false,tmpSummon=true,lostItem=true,keepInBox=true)
		tmpPlayerEQPs = $game_player.actor.equips
		$game_party.lose_gold($game_party.gold)
		slotList = $data_system.equip_type_name
		dropped_equip=Array.new
		if equip_slot_removetable?("Top") && rand(100) >=85
			eqp=tmpPlayerEQPs[slotList["Top"]].item_name
			$game_player.actor.change_equip(slotList["Top"], nil)
			dropped_equip.concat([eqp])
		end
		if equip_slot_removetable?("Mid") && rand(100) >=50
			eqp=tmpPlayerEQPs[slotList["Mid"]].item_name
			$game_player.actor.change_equip(slotList["Mid"], nil)
			dropped_equip.concat([eqp])
		end
		dropped_equip.concat([
			!equip_slot_removetable?("SH") ? nil : tmpPlayerEQPs[slotList["SH"]].item_name,
			!equip_slot_removetable?("Bot") ? nil : tmpPlayerEQPs[slotList["Bot"]].item_name,
			!equip_slot_removetable?("Vag") ? nil : tmpPlayerEQPs[slotList["Vag"]].item_name,
			!equip_slot_removetable?("Anal") ? nil : tmpPlayerEQPs[slotList["Anal"]].item_name,
			!equip_slot_removetable?("MidExt") ? nil : tmpPlayerEQPs[slotList["MidExt"]].item_name,
			!equip_slot_removetable?("Head") ? nil : tmpPlayerEQPs[slotList["Head"]].item_name,
			!equip_slot_removetable?("Neck") ? nil : tmpPlayerEQPs[slotList["Neck"]].item_name
			]
		)

		if equip_slot_removetable?(0)
			dropped_equip.push(tmpPlayerEQPs[0].item_name)
			$game_player.actor.change_equip(0, nil)
		end

		if equip_slot_removetable?(5)
			dropped_equip.push(tmpPlayerEQPs[5].item_name)
			$game_player.actor.change_equip(5, nil)
		end

		$game_player.actor.change_equip(slotList["SH"], nil) if !tmpPlayerEQPs[slotList["SH"]].nil? && !tmpPlayerEQPs[slotList["SH"]].type_tag.eql?("Bondage")
		$game_player.actor.change_equip(slotList["Bot"], nil) if !tmpPlayerEQPs[slotList["Bot"]].nil? && !tmpPlayerEQPs[slotList["Bot"]].type_tag.eql?("Bondage")
		$game_player.actor.change_equip(slotList["Vag"], nil) if !tmpPlayerEQPs[slotList["Vag"]].nil? && !tmpPlayerEQPs[slotList["Vag"]].type_tag.eql?("Bondage")
		$game_player.actor.change_equip(slotList["Anal"], nil) if !tmpPlayerEQPs[slotList["Anal"]].nil? && !tmpPlayerEQPs[slotList["Anal"]].type_tag.eql?("Bondage")
		$game_player.actor.change_equip(slotList["MidExt"], nil) if !tmpPlayerEQPs[slotList["MidExt"]].nil? && !tmpPlayerEQPs[slotList["MidExt"]].type_tag.eql?("Bondage")
		$game_player.actor.change_equip(slotList["Head"], nil) if !tmpPlayerEQPs[slotList["Head"]].nil? && !tmpPlayerEQPs[slotList["Head"]].type_tag.eql?("Bondage")
		$game_player.actor.change_equip(slotList["Neck"], nil) if !tmpPlayerEQPs[slotList["Neck"]].nil? && !tmpPlayerEQPs[slotList["Neck"]].type_tag.eql?("Bondage")
		dropped_equip=dropped_equip.reject{|item| item.nil?}
		if keepInBox
			$game_party.drop_all_items_to_storage(tmpEquip,System_Settings::STORAGE_TEMP_MAP,["Key","Bondage","Hair","Trait", "Child"],skipfrist=lostItem)
			$game_party.drop_all_items_to_storage(false,System_Settings::STORAGE_TEMP_MAP,["Key","Bondage","Trait", "Child"],skipfrist=lostItem)
		else
			$game_party.drop_all_items_and_summon(tmpEquip,["Key","Bondage","Hair","Trait", "Child"],tmpSummon) #包含裝備  不包含哪些TAG
			$game_party.lost_item_tag("Hair")
		end
	end

	def common_pickup_item(item,forceSkip=!Input.press?(:SHIFT))
		item = $data_ItemName[item] if item.is_a?(String)
		eqpSlot = item.etype_id
		forceSkip=true if forceSkip == false && !Input.press?(:SHIFT)
		$game_player.animation = $game_player.animation_mc_pick_up
		optain_item(item,1)
		return if forceSkip
		return if item.type_tag && item.type_tag.eql?("Bondage")
		if !item.etype_id && item.type && ["FoodBad","Food","Medicine","RawPlant"].include?(item.type) #consume
			SndLib.sound_eat
			$game_map.popup(0,"1",item.icon_index,-1)
			$game_player.actor.itemUseBatch(item)
			return
		end
		return if !item.etype_id
		return if !$game_player.actor.common_equippable?(item)
		if item.etype_id && !($game_player.actor.equips[eqpSlot] && $game_player.actor.equips[eqpSlot].type_tag.eql?("Bondage"))
			if item.etype_id == 0 && [1].include?(item.sealed_equip_type) #2h
				combat_remove_random_equip(1)
			elsif item.etype_id == 1 && !$game_player.actor.equips[0].nil? && $game_player.actor.equips[0].etype_id == 0 && [1].include?($game_player.actor.equips[0].sealed_equip_type) #sh
				combat_remove_random_equip(0)
			elsif !$game_player.actor.equips[eqpSlot].nil?
				combat_remove_random_equip(eqpSlot)
			end
		end
		if !$game_player.actor.equips[eqpSlot].nil?
			combat_remove_random_equip(eqpSlot)
			$game_player.actor.change_equip(eqpSlot, item)
			$game_player.actor.update_state_frames
			$game_player.update
		elsif $game_player.actor.equips[eqpSlot].nil?
			$game_player.actor.change_equip(eqpSlot, item)
			$game_player.actor.update_state_frames
			$game_player.update
		end

	end
	def batch_harvest_plants_cost
		if $game_player.actor.equips[0] == $data_ItemName["ItemMhSickle"]
			$game_player.actor.sta -= 1
		elsif
			$game_player.actor.sta -= 3
		end

	end


	def call_StoryHevent(tmpDataName,tmpRBname)
			if DataManager.get_rec_constant(tmpDataName) == 1
			$game_temp.choice = -1
			call_msg("common:Lona/SkipEv")
				case $game_temp.choice
					when 0
					$game_temp.choice = -1
					when 1
					$game_temp.choice = -1
					load_script("Data/HCGframes/event/#{tmpRBname}.rb")
				end
			else
				load_script("Data/HCGframes/event/#{tmpRBname}.rb")
			end
	end

	def chk_force_aggro_around_player(tmpIgnoreRace=["Human","Deepone"],tmpInRange=5,tmpChkFriendly=false,tmpSensorStr=15,tmpAggroTime=300)
		$game_map.npcs.each do |event|
			next if !tmpIgnoreRace.include?(event.actor.race)
			next if !event.near_the_target?($game_player,tmpInRange)
			next if event.opacity != 255
			next if !tmpChkFriendly && event.actor.friendly?($game_player)
			next if event.actor.action_state != nil && event.actor.action_state !=:none
			next if !event.actor.target.nil?
			next if event.actor.sensors[0].get_signal(event,$game_player)[2] <= tmpSensorStr #[target,distance,signal_strength,sensortype]
			event.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],tmpAggroTime)
		end
	end

	def doorEV_setup(tmpID=0,tmpPG=1,tmpTG=4,tmpSnd="openDoor",tmpXY=[0,0])
		tmpEV = $game_map.events[tmpID]
		if !tmpEV.through #if closed u can open
			eventBlock = false
		else #if opened and npc stand on.  u cant close.
			eventBlock = $game_map.events_xy(tmpEV.x,tmpEV.y).any?{|event|
				next if !event.npc?
				next if event.npc.npc_name == "SkillDummy" && event.through
				event.item_move_to if event.npc.action_state != :death
				next event.npc.action_state != :death
				true
			}
		end
		return eval("SndLib.#{tmpSnd}") if eventBlock
		eval("SndLib.#{tmpSnd}")
		$game_map.events[tmpID].forced_x=tmpXY[0]
		$game_map.events[tmpID].forced_y=tmpXY[1]
		set_event_force_page(tmpID,tmpPG,tmpTG)
	end

	def dungeon_ChestLoot(capture = $story_stats["Captured"] >= 1,openPattern=0)
		if $game_map.threat
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
			return
		elsif !capture && get_character(0).summon_data && get_character(0).summon_data[:lockedCost]
			$story_stats["HiddenOPT1"] = get_character(0).summon_data[:lockedCost]
			call_msg("common:Lona/PickLock")
			call_msg("common:Lona/Decide_optB") #[算了,決定]
			if $game_temp.choice == 1
				if $game_player.actor.sta >= get_character(0).summon_data[:lockedCost]
					$game_player.actor.sta -= get_character(0).summon_data[:lockedCost]
					get_character(0).summon_data[:lockedCost] = nil
					SndLib.sound_step_chain(100)
					$game_player.balloon(3)
					call_msg("QuickMsg:Lona/Success")
				else
					SndLib.sys_buzzer
					$game_map.popup(0,"QuickMsg:Lona/sta_too_low#{rand(2)}",0,0)
				end
			end
			$story_stats["HiddenOPT1"] = 0
			return if get_character(0).summon_data[:lockedCost] != nil
		end
		get_character(0).direction = 8 #opened face up
		get_character(0).prelock_direction = 8 #opened face up
		get_character(0).pattern = openPattern
		SceneManager.goto(Scene_ItemStorage)
		SceneManager.scene.prepare(System_Settings::STORAGE_TEMP_MAP)
		$story_stats["RapeLoopTorture"] = 1 if capture
	end

	def disarmTrap(to_inventory=false)
		if $game_player.player_cuffed?
			#SndLib.sys_buzzer
			#$game_map.popup(0,"QuickMsg:Lona/cuffed#{rand(2)}",0,0)
			return SndLib.sys_trigger
		elsif $game_player.actor.sta <=0
			#SndLib.sys_ChangeMapFailed(80,80)
			#$game_map.popup(0,"QuickMsg:Lona/sta_too_low#{rand(2)}",0,0)
			return SndLib.sys_trigger
		elsif $game_player.actor.survival_trait < 3
			#SndLib.sys_buzzer
			#$game_map.popup(0,"QuickMsg:Lona/survival_too_low",0,0)
			return SndLib.sys_trigger
		#elsif get_character(0).opacity < 180
		#	get_character(0).call_balloon(1)
		#	get_character(0).opacity = 180
		#	$game_player.call_balloon(2)
		#	$game_player.actor.sta -= 1
		#	return SndLib.sys_trigger
		end
		tar_atk = get_character(0).npc.battle_stat.get_stat("atk")
		tar_num = tar_atk
		if 20+$game_player.actor.survival_trait >= tar_num || (get_character(0).summon_data && get_character(0).summon_data[:user] == $game_player)
			tar_x=$game_player.x
			tar_y=$game_player.y
			$game_player.animation = $game_player.animation_mc_pick_up
			$game_player.actor.sta -= 3
			SndLib.sound_Reload
			if get_character(0).summon_data && get_character(0).summon_data[:ItemName]
				summonTar = get_character(0).summon_data[:ItemName].sample
				if to_inventory
					optain_item(summonTar)
				else
					EvLib.sum(summonTar,tar_x,tar_y)
				end
			else
				tmpItem = [
							"ItemMhWoodenClub",
							"ItemRock"
							]
				EvLib.sum(tmpItem.sample,tar_x,tar_y)
			end
			get_character(0).delete
		else
			#SndLib.sys_buzzer
			#$game_map.popup(0,"QuickMsg:Lona/survival_too_low",0,0)
			return SndLib.sys_trigger
			#get_character(0).moveto(tar_x,tar_y)
			#get_character(0).npc.battle_stat.set_stat_m("health",-1)
		end
	end

	def disarmHideTrap(tmpSum="ProjectileDisarmTrap",tmpDel=false,skillReq=10)
		if $game_player.player_cuffed?
			#SndLib.sys_buzzer
			#$game_map.popup(0,"QuickMsg:Lona/cuffed#{rand(2)}",0,0)
			return SndLib.sys_trigger
		elsif $game_player.actor.sta <=0
			#SndLib.sys_ChangeMapFailed(80,80)
			#$game_map.popup(0,"QuickMsg:Lona/sta_too_low#{rand(2)}",0,0)
			return SndLib.sys_trigger
		elsif $game_player.actor.survival_trait < 3
			#SndLib.sys_buzzer
			#$game_map.popup(0,"QuickMsg:Lona/survival_too_low",0,0)
			return SndLib.sys_trigger
		#elsif get_character(0).opacity < 180
		#	get_character(0).call_balloon(1)
		#	get_character(0).opacity = 180
		#	$game_player.call_balloon(2)
		#	$game_player.actor.sta -= 1
		#	return SndLib.sys_trigger
		end
		$game_player.animation = $game_player.animation_mc_pick_up
		$game_player.actor.sta -= 3
		tmpTar = get_character(0)
		EvLib.sum(tmpSum,tmpTar.x,tmpTar.y)
		return get_character(0).delete if tmpDel
		get_character(0).npc.battle_stat.set_stat_m("health",-1)
		get_character(0).npc.refresh
	end

	def set_this_event_force_page(page_id,terran_tag=nil)
		$game_map.events[@event_id].custom_page = page_id
		$game_map.events[@event_id].set_event_terrain_tag(terran_tag) if terran_tag != nil
		$game_map.events[@event_id].refresh
	end

	def set_event_force_page(tarEVid,page_id,terran_tag=nil)
		$game_map.events[tarEVid].custom_page = page_id
		$game_map.events[tarEVid].set_event_terrain_tag(terran_tag) if terran_tag != nil
		$game_map.events[tarEVid].refresh
	end #end def


	def cocona_maid?
		return true if $story_stats["RecQuestCocona"] >= 10 && $game_map.add_data["event"] == "NoerTavern"
		return false if $game_player.record_companion_name_back == "UniqueCocona"
		return true  if $game_player.record_companion_name_back == "UniqueCoconaMaid"
		$story_stats["RecQuestCocona"] >= 10
	end

	def cocona_in_group?
		tmpARY = ["UniqueCocona","UniqueCoconaMaid"]
		tmpARY.include?($game_player.record_companion_name_back)
	end

	def check_pick_tiny_npc
	end

	def check_pick_small_npc(tmpItemName,reqStun=false)
		return SndLib.sys_trigger if !tmpItemName
		tmpEV = $game_map.events[@event_id]
		return SndLib.sys_trigger if !tmpEV
		return SndLib.sys_trigger if !tmpEV.npc?
		return SndLib.sys_trigger unless [nil,:none,:stun].include?(tmpEV.actor.action_state)
		return SndLib.sys_trigger if reqStun && tmpEV.actor.action_state != :stun
		if $game_player.player_cuffed?
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/cuffed#{rand(2)}",0,0)
			return
		end
		if $game_player.actor.sta < 1
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/sta_too_low#{rand(2)}",0,0)
		end
		common_pickup_item(tmpItemName)
		tmpEV.delete
	end
	def annoyed_npc_punch(tmpTgtTxt="")
		get_character(0).animation = [get_character(0).animation_atk_mh,get_character(0).animation_atk_sh].sample
		get_character(0).call_balloon([15,7,5].sample)
		SndLib.sound_punch_hit(100)
		lona_mood "p5crit_damage"
		$game_player.actor.portrait.shake
		$game_player.actor.force_stun("Stun1")
		call_msg_popup(tmpTgtTxt,get_character(0).id)
	end
end #module

