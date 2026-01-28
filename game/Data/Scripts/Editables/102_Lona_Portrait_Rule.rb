
#這個檔案專供動作編輯用，請勿在這個檔案裡面寫上任何無關或是牽涉更高層級的內容。

class Lona_Portrait 

	def exRULE_chcg_mouthBlock?
		return false if !$game_player.actor.stat["EventMouthRace"]
		["CumInside1",
		"CumInside2",
		"CumInsidePeein3",
		"CumInsidePeein4",
		"Common1",
		"Common2",
		"kissed",
		"DeepThroat2",
		"DeepThroat2",
		"DeepThroat3",
		"DeepThroat4",
		"DeepThroat5",
		"DeepThroat6",
		"DeepThroat7"
		].include?($game_player.actor.stat["EventMouth"])
	end

	def exRULE_pose5_mouthBlock?
		return false if !$game_player.actor.stat["EventMouthRace"]
		[
		"Common1",
		"Common2",
		"kissed"
		].include?($game_player.actor.stat["EventMouth"]) 
	end
	
	
	#更新任何額外規則
	def updateExtra()
		return if @prt_vp.nil?
		tmpLona = $game_player.actor
		#p "updateExtra Portrait Extra"  if $debug_portrait
		#超越性規則 p1 s2 二級懷孕以上轉p3
		case tmpLona.stat["pose"]
			when "pose1"
				tmpLona.stat["subpose"] = 3 if tmpLona.stat["subpose"] == 2 && tmpLona.stat["preg"] >= 2
				tmpLona.stat["subpose"] = 3 if [1, 2].include?(tmpLona.stat["subpose"]) && ["ChainCuffTopExtra", "CuffTopExtra"].include?(tmpLona.stat["MainArm"]) #超越性規則 上銬轉p3
				
			when "pose4"
			
				#mouthblock if pose4 and mouth isnt nil
				["Common1","Common2"].include?(tmpLona.stat["EventMouth"]) && tmpLona.stat["EventMouthRace"]	? tmpLona.mouth_block = 1 : tmpLona.mouth_block = 0
				
				#chk slot On off
				["Common1","Common2"].include?(tmpLona.stat["EventVag"]) && tmpLona.stat["EventVagRace"]		? tmpLona.stat["vagopen"] = 1 : tmpLona.stat["vagopen"] = 0
				["Common1","Common2"].include?(tmpLona.stat["EventAnal"]) && tmpLona.stat["EventAnalRace"]	? tmpLona.stat["analopen"] = 1 : tmpLona.stat["analopen"] = 0
				
			when "pose5"
				#mouthblock if pose4 and mouth isnt nil
				exRULE_pose5_mouthBlock? ? tmpLona.mouth_block =1 : tmpLona.mouth_block =0
				
			when "chcg1"
				tmpLona.stat["subpose"] =2 if["ChainCuffTopExtra", "CuffTopExtra"].include?(tmpLona.stat["MainArm"]) #超越性規則 上銬轉p2
				exRULE_chcg_mouthBlock? ? tmpLona.mouth_block =1 : tmpLona.mouth_block =0
			when "chcg2","chcg3","chcg4","chcg5","chcg6"
				exRULE_chcg_mouthBlock? ? tmpLona.mouth_block =1 : tmpLona.mouth_block =0
		end
		#anal vag ruined overwrite
		#tmpLona.stat["analopen"] = 1 if tmpLona.stat["chcg1_SphincterDamaged"] == 1 #bug
		tmpLona.stat["analopen"] = 1 if tmpLona.stat["SphincterDamaged"] == 1
		tmpLona.stat["vagopen"] = 1 if tmpLona.stat["VaginalDamaged"] == 1
		
		#Race找不到的情況則 Race= "Others"
		tmpLona.stat["EventExt1Race"] = "Others" if 	tmpLona.stat["EventExt1Race"] 	&& System_Settings::RACE_SEX_SETTING[tmpLona.stat["EventExt1Race"]].nil?
		tmpLona.stat["EventExt2Race"] = "Others" if 	tmpLona.stat["EventExt2Race"] 	&& System_Settings::RACE_SEX_SETTING[tmpLona.stat["EventExt2Race"]].nil?
		tmpLona.stat["EventExt3Race"] = "Others" if 	tmpLona.stat["EventExt3Race"] 	&& System_Settings::RACE_SEX_SETTING[tmpLona.stat["EventExt3Race"]].nil?
		tmpLona.stat["EventExt4Race"] = "Others" if 	tmpLona.stat["EventExt4Race"] 	&& System_Settings::RACE_SEX_SETTING[tmpLona.stat["EventExt4Race"]].nil?
		tmpLona.stat["EventAnalRace"] = "Others" if 	tmpLona.stat["EventAnalRace"] 	&& System_Settings::RACE_SEX_SETTING[tmpLona.stat["EventAnalRace"]].nil?
		tmpLona.stat["EventVagRace"] = "Others" if 		tmpLona.stat["EventVagRace"] 	&& System_Settings::RACE_SEX_SETTING[tmpLona.stat["EventVagRace"]].nil?
		tmpLona.stat["EventMouthRace"] = "Others" if 	tmpLona.stat["EventMouthRace"] 	&& System_Settings::RACE_SEX_SETTING[tmpLona.stat["EventMouthRace"]].nil?
		
		#給予空的髮型 BASIC
		tmpLona.stat["equip_hair"] = "Basic" if tmpLona.stat["equip_hair"] == nil
		
		
		
		#PORTRAIT Z軸與TEMP CG的關係控制
		#if ["chcg1","chcg2","chcg3","chcg4","chcg5"].include?(tmpLona.stat["pose"]) || $story_stats["ForceChcgMode"] ==1
		if SceneManager.scene_is?(Scene_Menu)
			@prt_vp.z = System_Settings::SCENE_PORTRAIT_MENU_Z
			#elsif $game_message.busy? || $story_stats["ForceChcgMode"] ==1
		elsif !$game_player.movable? || $story_stats["ForceChcgMode"] == 1 || $game_map.interpreter.IsChcg? || $game_map.interpreter.chcg_background_color?
			@prt_vp.z = System_Settings::PORTRAIT_CHCG_Z
		else
			@prt_vp.z = System_Settings::PORTRAIT_MAP_Z
		end
		
	end
end



