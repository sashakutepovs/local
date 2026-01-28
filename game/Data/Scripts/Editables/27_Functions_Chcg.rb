#common HCG frame page0


#這個模組被引用到Game_Interpreter中，主要負責CHCG相關內容的處理
#主要由繪師操作
module GIM_CHCG

#==========================================================BASIC EVENTS=======================================
	
	def pose_commonH_decider(pose="pose5",mood="",side="")
		case pose
			when "pose4"			; tmpExport =	"p4#{mood}"
			when "pose5"			; tmpExport =	"p5#{mood}"
			else 					; tmpExport = 	"p5#{mood}"
		end
		lona_mood(tmpExport)
	end
	def chcg_decider_basic(pose=@chcgPose)
		pose=rand(5)+1 if pose.nil?
		case pose
			when 1 ; @chcgPose="chcg1"
			when 2 ; @chcgPose="chcg2"
			when 3 ; @chcgPose="chcg3"
			when 4 ; @chcgPose="chcg4"
			when 5 ; @chcgPose="chcg5"
			#else @chcgPose="chcg4"
		end
		@chcgPose
		$game_actors[1].stat["pose"] = @chcgPose
	end
	
	def chcg_decider_basic_vag(pose=@chcgBasicVagPose)
		pose=rand(5)+1 if pose.nil?
		case pose
			when 1 ; @chcgBasicVagPose="chcg1"
			when 2 ; @chcgBasicVagPose="chcg2"
			when 3 ; @chcgBasicVagPose="chcg3"
			when 4 ; @chcgBasicVagPose="chcg4"
			when 5 ; @chcgBasicVagPose="chcg1" #chcg5 isnt support this    replace with chcg a random
			#else @chcgPose="chcg4"
		end
		@chcgBasicVagPose
		$game_actors[1].stat["pose"] = @chcgBasicVagPose
	end
	
	def chcg_decider_basic_anal(pose=@chcgBasicAnalPose)
		pose=rand(5)+1 if pose.nil?
		case pose
			when 1 ; @chcgBasicAnalPose="chcg2"
			when 2 ; @chcgBasicAnalPose="chcg2"
			when 3 ; @chcgBasicAnalPose="chcg3"
			when 4 ; @chcgBasicAnalPose="chcg4"
			when 5 ; @chcgBasicAnalPose="chcg3" #chcg5 isnt support this    replace with chcg a random
			#else @chcgPose="chcg4"
		end
		@chcgBasicAnalPose
		$game_actors[1].stat["pose"] = @chcgBasicAnalPose
	end
	
	def chcg_decider_basic_mouth(pose=@chcgBasicMouthPose)
	 pose=rand(5)+1 if pose.nil?
	 case pose
	 when 1 ; @chcgBasicMouthPose="chcg3"
	 when 2 ; @chcgBasicMouthPose="chcg2"
	 when 3 ; @chcgBasicMouthPose="chcg3"
	 when 4 ; @chcgBasicMouthPose="chcg5"
	 when 5 ; @chcgBasicMouthPose="chcg5"
	 #else @chcgPose="chcg4"
	 end
	 @chcgBasicMouthPose
	 $game_actors[1].stat["pose"] = @chcgBasicMouthPose
	end
	
	def chcg_decider_basic_fapper(pose=@chcgBasicFapperPose)
	 pose=rand(5)+1 if pose.nil?
	 case pose
	 when 1 ; @chcgBasicFapperPose="chcg1"
	 when 2 ; @chcgBasicFapperPose="chcg2"
	 when 3 ; @chcgBasicFapperPose="chcg3"
	 when 4 ; @chcgBasicFapperPose="chcg4"
	 when 5 ; @chcgBasicFapperPose="chcg5"
	 #else @chcgPose="chcg4"
	 end
	 @chcgBasicFapperPose
	 $game_actors[1].stat["pose"] = @chcgBasicFapperPose
	end
	
	def chcg_decider_basic_arousal(pose=@chcgBasicArousalPose)
	 pose=rand(5)+1 if pose.nil?
	 case pose
	 when 1 ; @chcgBasicArousalPose="chcg1"
	 when 2 ; @chcgBasicArousalPose="chcg2"
	 when 3 ; @chcgBasicArousalPose="chcg3"
	 when 4 ; @chcgBasicArousalPose="chcg4"
	 when 5 ; @chcgBasicArousalPose="chcg1" #chcg5 isnt support this    replace with chcg random
	 #else @chcgPose="chcg4"
	 end
	 @chcgBasicArousalPose
	 $game_actors[1].stat["pose"] = @chcgBasicArousalPose
	end
#==========================================================BASIC EVENT END=======================================
	
	def chcg_decider_peeon(pose=@chcgPeeonPose)
	pose=rand(2)+1 if pose.nil?
	#@chcgPose=rand(2)+1 if pose>=3
	 case pose
	 when 1 ; @chcgPeeonPose="chcg3"
	 when 2 ; @chcgPeeonPose="chcg4"
	 end
	 @chcgPeeonPose
	 $game_actors[1].stat["pose"] = @chcgPeeonPose
	end

	def chcg_decider_MilkSplash(pose=@chcgMilkSplashPose)
	pose=rand(3)+1 if pose.nil?
	#@chcgPose=rand(2)+1 if pose>=3
	 case pose
	 when 1 ; @chcgMilkSplashPose="chcg1"
	 when 2 ; @chcgMilkSplashPose="chcg4"
	 when 3 ; @chcgMilkSplashPose="chcg5"
	 end
	 @chcgMilkSplashPose
	 $game_actors[1].stat["pose"] = @chcgMilkSplashPose
	end
	
	def chcg_decider_scatoff(pose=@chcgScatPose)
	pose=rand(2)+1 if pose.nil?
	#@chcgPose=rand(2)+1 if pose>=3
	 case pose
	 when 1 ; @chcgScatPose="chcg2"
	 when 2 ; @chcgScatPose="chcg2" #CHCG3 ISNT GOOD FOR SCAT
	 end
	 @chcgScatPose
	 $game_actors[1].stat["pose"] = @chcgScatPose
	end

	def chcg_mood_decider
		if $game_player.actor.stat["persona"] == "slut"
			mood = "ahegao"
		else 
			mood ="normal"
		end
		mood
	end
	
	def chcg_shame_mood_decider
		if $game_player.actor.stat["persona"] == "slut"
			mood = "shame_ahegao"
		elsif $game_actors[1].arousal >=0.6* $game_actors[1].will
			mood ="shame"
		else
			mood ="shame_low"
		end
		mood
	end
	
	def chcg_cumming_mood_decider
		if $game_player.actor.stat["persona"] == "slut"
			mood = "cuming_ahegao"
		else 
			mood ="cuming"
		end
		mood
	end
	
	def pose_handjob_mood_decider
		case $game_player.actor.stat["persona"]
			when "typical"
				mood = ["shy","confused"].sample
			when "gloomy"
				mood = ["tired","sad"].sample
			when "tsundere"
				mood = ["sexhurt","hurt","pain"].sample
			when "slut"
				mood = ["lewd","triumph","pleased"].sample
		end
		mood
	end
	
	def pose_common_h_decider
		
	end
	
	def chcg_add_SemenWaste(event_race_key)
		return if $game_map.isOverMap
		if [true,false].sample
			case $game_player.actor.stat[event_race_key]
			when "Human" 		;EvLib.sum("WasteSemenHuman")
			when "Moot" 		;EvLib.sum("WasteSemenHuman")
			when "Orkind"		;EvLib.sum("WasteSemenOrcish")
			when "Goblin"		;EvLib.sum("WasteSemenOrcish")
			when "Abomination"	;EvLib.sum("WasteSemenAbomination")
			when "Deepone"		;EvLib.sum("WasteSemenHuman")
			when "Fishkind"		;EvLib.sum("WasteSemenFishkind")
			when "Troll"		;EvLib.sum("WasteSemenTroll")
			else ; EvLib.sum("WasteSemenOther")
			end
		else
			EvLib.sum("WasteSemen")
		end
	end
	
	def chcg_add_cums(event_race_key,target_part) #only when chcg frame, dont use in anywhere
		tarRace = $game_player.actor.stat[event_race_key]
		if !System_Settings::RACE_SEX_SETTING[tarRace].nil?
			tar_val = System_Settings::RACE_SEX_SETTING[tarRace][3]
		else
			tar_val = System_Settings::RACE_SEX_SETTING["Others"][3]
		end
		tar_val += rand((tar_val/3).to_i)
		$game_player.actor.addCums(target_part,tar_val,tarRace)
		chcg_add_SemenWaste(event_race_key)
		$game_player.actor.show_cums
	end
	
	def chcg_battle_sex_add_cums_to_player(temp_hole,tarRace,tar_val=0)
		p "add Cums= => #{temp_hole} #{tarRace}"
		case temp_hole
			when "vag"		;tar_part= ["CumsCreamPie"]
			when "anal"		;tar_part= ["CumsMoonPie"]
			when "mouth"	;tar_part= ["CumsMouth"]
			when "body"		;tar_part= ["CumsHead","CumsTop","CumsMid","CumsBot"]
		end
		race_val = 0
		if tar_val <= 0
			if !System_Settings::RACE_SEX_SETTING[tarRace].nil?
				race_val = System_Settings::RACE_SEX_SETTING[tarRace][3]
			else
				race_val = System_Settings::RACE_SEX_SETTING["Others"][3]
			end
		end
		tar_val = race_val+tar_val
		$game_player.actor.addCums((tar_part[rand(tar_part.length)]),tar_val,tarRace)
	end
	
	#for Groin CLearn
	def chcg_clearn_vag_semen_trans_to_event(tmpValue = 200)
		cums=$game_player.actor.vag_cums_race
		tmpRaceList = System_Settings::RACE_SEX_SETTING
		exportResult = [] #for export result
		tmpHash = Hash.new(0) #for save
		cums.each{|raceName,semenAMT|
			if tmpRaceList[raceName] #if can find race in roster
				tmpHash[tmpRaceList[raceName][2]] += semenAMT
			else
				tmpHash[tmpRaceList["Others"][2]] += semenAMT
			end
		}
		tmpHash.each{|itemID,semenAMT|
			exportResult << [itemID,(semenAMT/tmpValue).to_i] if semenAMT > 0 && (semenAMT/tmpValue).to_i >= 1
		}
		return exportResult
	end
	
	#for Groin CLearn
	def chcg_clearn_anal_semen_trans_to_event(tmpValue = 200)
		cums=$game_player.actor.cumsMeters["CumsMoonPie"]
		getItem= (cums/tmpValue).round
		tmpAry = []
		tmpAry += [["WasteSemenOther",getItem]]
		return tmpAry
	end
	def chcg_clearn_mouth_semen_trans_to_event(tmpValue = 200)
		cums=$game_player.actor.cumsMeters["CumsMouth"]
		getItem= (cums/tmpValue).round
		tmpAry = []
		tmpAry += [["WasteSemenOther",getItem]]
		return tmpAry
	end
	def chcg_clearn_mouth_semen_eat
		lona_mood "p5shame" ; $game_portraits.rprt.shake
		$cg = TempCG.new(["event_CumsSwallow"])
		temp_CumsMouth =$game_player.actor.cumsMeters["CumsMouth"]
		$game_player.actor.stat["SemenGulper"] == 1 ? tmpValue = 50 : tmpValue = 75
		tmpReward = []
		tmpReward += chcg_clearn_mouth_semen_trans_to_event(tmpValue)
		$game_player.actor.healCums("CumsMouth", ((temp_CumsMouth * 0.2).round)+$game_player.actor.constitution)
		$cg.erase
		p "total cums reward => #{tmpReward}"
		if !tmpReward.empty?
			tmpFinal = tmpReward.group_by{|x| x[0]}.map{|x| [x[0], x[1].sum{|x| x[1]}]}
			tmpFinal.each.each{
				|asd|
				p "item=#{asd[0]}   num=#{asd[1]}"
				asd[1].times{
					#$game_player.actor.itemUseBatch($data_items[asd[0]])
					$game_player.actor.itemUseBatch($data_ItemName[asd[0]])
				}
				SndLib.sound_eat
				$game_map.popup(0," #{asd[1]}",$data_ItemName[asd[0]].icon_index,-1)
				#$game_map.popup(0," #{asd[1]}",$data_items[asd[0]].icon_index,-1)
			}
		end
		temp_mouth_cums =$game_player.actor.cumsMeters["CumsMouth"]
		$game_player.actor.healCums("CumsMouth", temp_mouth_cums) #use =0 plz
		$story_stats["sex_record_semen_swallowed"]+= 1
	end
	def chcg_clearn_mouth_semen_trans_items
		SndLib.sound_chs_buchu
		lona_mood "p5shame" ; $game_portraits.rprt.shake
		temp_CumsMouth =$game_player.actor.cumsMeters["CumsMouth"]
		$game_player.actor.stat["SemenGulper"] == 1 ? tmpValue = 50 : tmpValue = 75
		tmpReward = []
		tmpReward += chcg_clearn_mouth_semen_trans_to_event(tmpValue)
		$game_player.actor.healCums("CumsMouth", ((temp_CumsMouth * 0.2).round)+$game_player.actor.constitution)
		p "total cums reward => #{tmpReward}"
		if !tmpReward.empty?
			tmpFinal = tmpReward.group_by{|x| x[0]}.map{|x| [x[0], x[1].sum{|x| x[1]}]}
			tmpFinal.each.each{
				|asd|
				p "item=#{asd[0]}   num=#{asd[1]}"
				optain_item(asd[0],asd[1])
				#optain_item($data_items[asd[0]],asd[1])
				wait(30)
			}
		end
		temp_mouth_cums = $game_actors[1].cumsMeters["CumsMouth"]
		$game_player.actor.healCums("CumsMouth", temp_mouth_cums)
	end

	def player_overkill_target
		case $game_player.actor.persona
			when "typical"	; $game_player.actor.mood +=20	
			when "gloomy"	; $game_player.actor.mood -=5	
			when "tsundere"	; $game_player.actor.mood +=10	
			when "slut"		; $game_player.actor.mood +=5	
		end
		$game_player.actor.sta +=6 if $game_player.actor.stat["BloodLust"] ==1 #blood lust
		$game_player.actor.sat +=3 if $game_player.actor.stat["BloodLust"] ==1 #blood lust
		lona_mood "overkill"
		lona.portrait.shake
	end

	def npc_talk_style
		return "_slave"			if $game_player.player_slave?
		return "_maggot"		if $game_player.actor.dirt >= 250
		return "_sexy"			if $game_player.actor.sexy >= 150
		return "_weaker"		if $game_player.actor.weak >= 150
		return "_moot"			if $game_player.actor.stat["moot"] ==1
		return "_lona"
	end

	def npc_talk_style_ext #use for guard gatekeeper
		return "_SexSlaveRuined"	if $game_player.actor.dirt >= 250 && $game_player.actor.sexy >= 150 && $game_player.actor.weak >= 150 && $game_player.player_slave?
		return "_SexSlave"			if $game_player.actor.sexy >= 150 && $game_player.actor.weak >= 150 && $game_player.player_slave?
		return "_SexyWeak"			if $game_player.actor.sexy >= 150 && $game_player.actor.weak >= 150
		return npc_talk_style
	end
	
	def npcFish_talk_style
		return "_slave"			if $game_player.player_slave?
		return "_sexy"			if $game_player.actor.weak >= 35
		return "_weaker"		if $game_player.actor.weak >= 25
		return "_maggot"		if $game_player.actor.dirt >= 250
		return "_moot"			if $game_player.actor.stat["moot"] ==1
		return "_lona"
	end

	def talk_style #temp
	#p $game_actors[1].talk_style
	return $game_player.actor.talk_style
	end
	
	def talk_persona
		return $game_player.actor.talk_persona
	end
	
	def check_fucker_mouth
		!$game_player.fucker_mouth.nil? && $game_player.fucker_mouth.actor && !$game_player.fucker_mouth.actor.nil? && $game_player.fucker_mouth.actor.fucker_target == $game_player
	end
	def check_fucker_anal
		!$game_player.fucker_anal.nil? && $game_player.fucker_anal.actor && !$game_player.fucker_anal.actor.nil? && $game_player.fucker_anal.actor.fucker_target == $game_player
	end
	def check_fucker_vag
		!$game_player.fucker_vag.nil? && $game_player.fucker_vag.actor && !$game_player.fucker_vag.actor.nil? && $game_player.fucker_vag.actor.fucker_target == $game_player
	end
	def common_SexServiceIngratiateHit(refreshPortrait=true)
		return if get_character(0).nil?
		return if get_character(0).summon_data.nil?
		return if get_character(0).summon_data[:target] != $game_player
		if get_character(0).summon_data[:prtMood] && refreshPortrait
			check_fucker_vag				 ? $game_player.actor.stat["EventVagRace"] 		= $game_player.fucker_vag.actor.race : $game_player.actor.stat["EventVagRace"] 		= nil
			check_fucker_anal				 ? $game_player.actor.stat["EventAnalRace"] 	= $game_player.fucker_anal.actor.race : $game_player.actor.stat["EventAnalRace"] 	= nil
			check_fucker_mouth				 ? $game_player.actor.stat["EventMouthRace"] 	= $game_player.fucker_mouth.actor.race : $game_player.actor.stat["EventMouthRace"] 	= nil
			#!$game_player.fucker_vag.nil? && $game_player.fucker_vag.actor		 ? $game_player.actor.stat["EventVagRace"] 		= $game_player.fucker_vag.actor.race : $game_player.actor.stat["EventVagRace"] 		= nil
			#!$game_player.fucker_anal.nil? && $game_player.fucker_anal.actor	 ? $game_player.actor.stat["EventAnalRace"] 	= $game_player.fucker_anal.actor.race : $game_player.actor.stat["EventAnalRace"] 	= nil
			#!$game_player.fucker_mouth.nil? && $game_player.fucker_mouth.actor	 ? $game_player.actor.stat["EventMouthRace"] 	= $game_player.fucker_mouth.actor.race : $game_player.actor.stat["EventMouthRace"] 	= nil
			$game_player.actor.stat["EventVag"] = 		pose_GenCommonPenisKey($game_player.actor.stat["EventVag"])
			$game_player.actor.stat["EventAnal"] = 		pose_GenCommonPenisKey($game_player.actor.stat["EventAnal"])
			$game_player.actor.stat["EventMouth"] = 	pose_GenCommonPenisKey($game_player.actor.stat["EventMouth"])
			lona_mood get_character(0).summon_data[:prtMood]
			$game_player.actor.portrait.shake
			return
		elsif get_character(0).summon_data[:evalData]
			eval(get_character(0).summon_data[:evalData])
			return
		end
	end
	
	def pose_GenCommonPenisKey(tmpSlotKey)
		return ["Common1","Common2"].sample if !tmpSlotKey
		if tmpSlotKey == "Common1"
			"Common2"
		else
			"Common1"
		end
	end
	
	def event_key_cleaner #tool
		$game_player.actor.event_key_cleaner #moved to 100_Game_Player_handle_on_move.rb
	end
	
	def event_key_cleaner_whore_work #tool
		$game_player.fuckers.clear
		$game_player.fappers.clear
		event_key_cleaner
	end
	
	def half_event_key_cleaner #tool
		$game_actors[1].stat["EventVag"] = nil
		$game_actors[1].stat["EventAnal"] = nil
		$game_actors[1].stat["EventMouth"] = nil
		$game_actors[1].stat["EventExt1"] = nil
		$game_actors[1].stat["EventExt2"] = nil
		$game_actors[1].stat["EventExt3"] = nil
		$game_actors[1].stat["EventExt4"] = nil
		$game_actors[1].stat["vagopen"] = 0 #if not puting any toy inside
		$game_actors[1].stat["analopen"] = 0 #if not puting any toy inside
		#sat + ($game_actors[1].mouth cums/2) 
		#clearn mouth cums
	end
	
	def player_sex_get_tar_key
		return if 	$game_player.manual_sex == true
		$game_actors[1].stat["EventExt1"] 			= "FapperCuming1" if !$game_player.fappers[0].nil?
		p "CHSH lona_stats autoset EventExt1       =  #{$game_actors[1].stat["EventExt1"]}"
		$game_actors[1].stat["EventExt2"] 			= "FapperCuming1" if !$game_player.fappers[1].nil?
		p "CHSH lona_stats autoset EventExt2       =  #{$game_actors[1].stat["EventExt2"]}"
		$game_actors[1].stat["EventExt3"] 			= "FapperCuming1" if !$game_player.fappers[2].nil?
		p "CHSH lona_stats autoset EventExt3       =  #{$game_actors[1].stat["EventExt3"]}"
		$game_actors[1].stat["EventExt4"] 			= "FapperCuming1" if !$game_player.fappers[3].nil?
		p "CHSH lona_stats autoset EventExt4       =  #{$game_actors[1].stat["EventExt4"]}"
		$game_actors[1].stat["EventExt1Race"]		= $game_player.fappers[0].actor.race if !$game_player.fappers[0].nil?
		p "CHSH lona_stats autoset EventExt1Race   =  #{$game_actors[1].stat["EventExt1Race"]}"
		$game_actors[1].stat["EventExt2Race"]		= $game_player.fappers[1].actor.race if !$game_player.fappers[1].nil?
		p "CHSH lona_stats autoset EventExt2Race   =  #{$game_actors[1].stat["EventExt2Race"]}"
		$game_actors[1].stat["EventExt3Race"]		= $game_player.fappers[2].actor.race if !$game_player.fappers[2].nil?
		p "CHSH lona_stats autoset EventExt3Race   =  #{$game_actors[1].stat["EventExt3Race"]}"
		$game_actors[1].stat["EventExt4Race"]		= $game_player.fappers[3].actor.race if !$game_player.fappers[3].nil?
		p "CHSH lona_stats autoset EventExt4Race   =  #{$game_actors[1].stat["EventExt4Race"]}"
		
		$game_actors[1].stat["EventVag"]				= "CumInside1" if !$game_player.fucker_vag.nil?
		p "CHSH lona_stats autoset EventVag        =  #{$game_actors[1].stat["EventVag"]}"
		$game_actors[1].stat["EventVagRace"]			= "#{$game_player.fucker_vag.actor.race}" if !$game_player.fucker_vag.nil?
		p "CHSH lona_stats autoset EventVagRace    =  #{$game_actors[1].stat["EventVagRace"]}"
		$game_actors[1].stat["EventAnal"]			= "CumInside1" if !$game_player.fucker_anal.nil?
		p "CHSH lona_stats autoset EventAnal       =  #{$game_actors[1].stat["EventAnal"]}"
		$game_actors[1].stat["EventAnalRace"]		= "#{$game_player.fucker_anal.actor.race}" if !$game_player.fucker_anal.nil?
		p "CHSH lona_stats autoset EventAnalRace   =  #{$game_actors[1].stat["EventAnalRace"]}"
		$game_actors[1].stat["EventMouth"]			= "CumInside1" if !$game_player.fucker_mouth.nil?
		p "CHSH lona_stats autoset EventMouth      =  #{$game_actors[1].stat["EventMouth"]}"
		$game_actors[1].stat["EventMouthRace"]		= "#{$game_player.fucker_mouth.actor.race}" if !$game_player.fucker_mouth.nil?
		p "CHSH lona_stats autoset EventMouthRace  =  #{$game_actors[1].stat["EventMouthRace"]}"
	end
	
	def whole_key_clearner	# no mood fix light ver
		event_key_cleaner
		$game_player.actor.stat["EventTargetPart"] = nil
		$game_player.actor.stat["AllowOgrasm"] = false
		$game_player.actor.stat["allow_ograsm_record"] = false
		$game_player.actor.stat["EventTargetPart"] = nil
	end
	def whole_event_end #所有事件都撥放完 回到遊戲前的清理器
		whole_key_clearner
		lona_mood "normal"
		chcg_background_color_off
	end
	
	def combat_event_end #所有事件都撥放完 回到遊戲前的清理器
		$game_player.actor.event_key_combat_end #moved to 100_Game_Player_handle_on_move.rb
	end
	
	def chcg_set_all_race(race)
		$game_player.actor.stat["EventVagRace"] =  "#{race}"
		$game_player.actor.stat["EventAnalRace"] = "#{race}"
		$game_player.actor.stat["EventMouthRace"] ="#{race}"
		$game_player.actor.stat["EventExt1Race"] = "#{race}"
		$game_player.actor.stat["EventExt2Race"] = "#{race}"
		$game_player.actor.stat["EventExt3Race"] = "#{race}"
		$game_player.actor.stat["EventExt4Race"] = "#{race}"
	end
	


	def chcg_cocona_bath_clearnUP
		$game_NPCLayerMain.stat["Cocona_Dress"] = cocona_maid? ? "Maid" : "Necro"
		$game_NPCLayerMain.stat["Cocona_dirt"] = 0
		$game_NPCLayerMain.stat["Cocona_Effect_CumButtR"] = 0
		$game_NPCLayerMain.stat["Cocona_Effect_CumButtL"] = 0
		$game_NPCLayerMain.stat["Cocona_Effect_CreamPie"] = 0
		$game_NPCLayerMain.stat["Cocona_Effect_Wet"] = 0
		$game_NPCLayerMain.portrait.update
	end
	def chcg_init_cocona
		$game_NPCLayerMain.stat["Cocona_Will"] = 800 						if !$game_NPCLayerMain.stat["Cocona_Will"]
		$game_NPCLayerMain.stat["Cocona_Arousal"] = 0 						if !$game_NPCLayerMain.stat["Cocona_Arousal"]
		$game_NPCLayerMain.stat["Cocona_Effect_Wet"] = 0 			if !$game_NPCLayerMain.stat["Cocona_Effect_Wet"]
		$game_NPCLayerMain.stat["Cocona_Effect_CumButtR"] = 0 	if !$game_NPCLayerMain.stat["Cocona_Effect_CumButtR"]
		$game_NPCLayerMain.stat["Cocona_Effect_CumButtL"] = 0 	if !$game_NPCLayerMain.stat["Cocona_Effect_CumButtL"]
		$game_NPCLayerMain.stat["Cocona_Effect_CreamPie"] = 0 	if !$game_NPCLayerMain.stat["Cocona_Effect_CreamPie"]
		$game_NPCLayerMain.stat["Cocona_VagOpen"] = 0 			if !$game_NPCLayerMain.stat["Cocona_VagOpen"]
		$game_NPCLayerMain.stat["Cocona_exp_vag"] = 0 						if !$game_NPCLayerMain.stat["Cocona_exp_vag"]
		$game_NPCLayerMain.stat["Cocona_Arousal"] = 0 						if !$game_NPCLayerMain.stat["Cocona_Arousal"]
		$game_NPCLayerMain.stat["Cocona_dirt"] = 0 						if !$game_NPCLayerMain.stat["Cocona_dirt"]
		$game_NPCLayerMain.stat["Cocona_lowerDamageVagLvlReq"] = 5 		if !$game_NPCLayerMain.stat["Cocona_lowerDamageVagLvlReq"]
	end

def IsChcg?
	["chcg1","chcg2","chcg3","chcg4","chcg5"].include?($game_actors[1].stat["pose"]) || $story_stats["ForceChcgMode"] ==1
end

#取代內建FADEIN OUT  以及撥放CHCG時改善被景色使用
def chcg_background_color(red=200,green=0,blue=200,opa=60,auto_fade=0)
	chcg_background_color_off if @chcg_background_color == true
	return if @chcg_background_color == true
	@ivp_chcg=Viewport.new
	@ivp_chcg.z=System_Settings::CHCG_BACKGROUND_Z
	@cover_chcg=Sprite.new(@ivp_chcg)
	@bmp_chcg=Bitmap.new(Graphics.width,Graphics.height)
	@bmp_chcg.fill_rect(@bmp_chcg.rect,Color.new(red,green,blue))
	@cover_chcg.opacity= opa
	@cover_chcg.bitmap=@bmp_chcg
	@chcg_background_color = true
		if auto_fade <=-1
			until @cover_chcg.opacity <= 10
				@cover_chcg.opacity += auto_fade
				@cover_chcg.opacity = 0 if @cover_chcg.opacity <=0
				$game_map.interpreter.wait(1)
			end
			chcg_background_color_off
		elsif auto_fade >=1
			until @cover_chcg.opacity >= 255
				@cover_chcg.opacity += auto_fade
				@cover_chcg.opacity = 255 if @cover_chcg.opacity >=255
				$game_map.interpreter.wait(1)
			end
		end
end

def get_chcg_background_opacity
	return 0 if !@cover_chcg
	@cover_chcg.opacity
end
def chcg_background_color_off
	@cover_chcg.visible = false if @chcg_background_color == true
	@chcg_background_color = false
end
def chcg_background_color?
	@chcg_background_color
end

#色調調整器  開發中 TODO 與內建VIEW PORT連結 避免影響到MENU Z軸須高於KHAS SHADOW 以改善整體色調
#於各地圖 BIOS中設定該地圖之特殊色調
def map_background_color(red=System_Settings::MAP_BG_RED,green=System_Settings::MAP_BG_GREEN,blue=System_Settings::MAP_BG_BLUE,opa=System_Settings::MAP_BG_OPACITY,b_type=System_Settings::MAP_BG_BLEND)
	$game_map.map_background_color=Color.new(red,green,blue)
	$game_map.map_background_color_blend=b_type
	$game_map.map_background_color_opacity=opa
	$game_map.map_background_changed=true
	$game_map.screen.brightness = 255
end
def map_background_color_export
	[
		$game_map.map_background_color.red.to_i,
		$game_map.map_background_color.green.to_i,
		$game_map.map_background_color.blue.to_i,
		$game_map.map_background_color_opacity,
		$game_map.map_background_color_blend
	]
end
	def map_background_color_off
	$game_map.map_background_changed=true
	$game_map.map_background_color=nil
	#@cover_map.visible = false if @map_background_color == true
	#@map_background_color = false
	end

	def lona_hud_shake
		$game_actors[1].portrait.shake
		#$game_map.interpreter.flash_screen(Color.new(255,0,rand(50+50),200),8,false) #this shit now on map_HUD
	end

	def portrait_hide
		$game_portraits.lprt.hide
		$game_portraits.rprt.hide
	end

	def portrait_focus
		$game_portraits.lprt.focus
		$game_portraits.rprt.focus
	end
	
	def portrait_fade
		$game_portraits.lprt.fade
		$game_portraits.rprt.fade
	end
	
	def portrait_off
		$game_portraits.setLprt("nil")
		$game_portraits.setRprt("nil")
	end

end

