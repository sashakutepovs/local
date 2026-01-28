#######################################HCG FRAME 撥放API#####################################################
######所有PLAYLIST逼應結束後需下列兩個指令
#event_key_cleaner
#whole_event_end


#######################################Grab######################################################
#########################所有GRAB結束後記得用event_key_cleaner清KEY
module GIM_CHCG

def event_Grab_Grab(race)
$game_player.actor.stat["EventExt1Race"] = "#{race}"
load_script("Data/HCGframes/Grab_eventExt1_Grab.rb")
end
 
def event_Grab_Kissed(race)
$game_player.actor.stat["EventMouthRace"] = "#{race}"
load_script("Data/HCGframes/Grab_EventMouth_kissed.rb")
end
 
def event_Grab_BoobTouch(race)
$game_player.actor.stat["EventExt1Race"] = "#{race}"
load_script("Data/HCGframes/Grab_EventExt1_BoobTouch.rb")
end
def event_Grab_AnalTouch(race)
$game_player.actor.stat["EventAnalRace"] = "#{race}"
load_script("Data/HCGframes/Grab_eventAnal_AnalTouch.rb")
end
   
def event_Grab_VagTouch(race)
$game_player.actor.stat["EventVagRace"] = "#{race}"
load_script("Data/HCGframes/Grab_eventVag_VagTouch.rb")
end
 
def event_Grab_Punch(race)
$game_player.actor.stat["EventVagRace"] = "#{race}"
load_script("Data/HCGframes/Grab_eventVag_Punch.rb")
end

def event_Grab_VagLick(race)
$game_player.actor.stat["EventVagRace"] = "#{race}"
load_script("Data/HCGframes/Grab_eventVag_VagLick.rb")
end

def event_Grab_Feeding(race)
$game_player.actor.stat["EventMouthRace"] = "#{race}"
load_script("Data/HCGframes/Grab_eventMouth_Feeding.rb")
end

def random_grab_event(race,eqp_diff=0,hardcore_lv=0)
	combat_remove_random_equip if eqp_diff >= rand(100)
	tmp_event = [rand(hardcore_lv),6].min
	case tmp_event
		when 0;event_Grab_AnalTouch(race)		;$game_player.actor.add_state("DoormatUp20")#slow #doormat
		when 1;event_Grab_VagTouch(race)		;$game_player.actor.add_state("DoormatUp20")#slow #doormat
		when 2;event_Grab_Grab(race)			;$game_player.actor.add_state(159) ;$game_player.actor.add_state("DoormatUp20")#slow #doormat
		when 3;event_Grab_BoobTouch(race)		;$game_player.actor.add_state(159) ;$game_player.actor.add_state("DoormatUp20")#slow #doormat
		when 4;event_Grab_Kissed(race)			;$game_player.actor.add_state(159) ;$game_player.actor.add_state("DoormatUp20")#slow #doormat
		when 5;event_Grab_VagLick(race)			;$game_player.actor.add_state(159) ;$game_player.actor.add_state("DoormatUp20")#slow #doormat
		when 6;event_Grab_Punch(race)			;$game_player.actor.force_stun("Stun3");$game_player.actor.add_state("DoormatUp20")#stun3 #doormat
	end
end

#########################################前戲系列#######################################
#########################所有前戲結束後記得用event_key_cleaner清KEY
def unique_event_AbomBellyPara(race)
$game_player.actor.stat["EventExt3"] =race
load_script("Data/HCGframes/UniqueEvent_AbomBellyPara.rb")
end

def unique_event_SuckDick(race)
$game_player.actor.stat["EventMouthRace"] =race
load_script("Data/HCGframes/UniqueEvent_SuckDick.rb")
end

def unique_event_Piercing(race)
$game_player.actor.stat["EventVagRace"] =race
load_script("Data/HCGframes/UniqueEvent_Piercing.rb")
end

def unique_event_VagDilatation(race)
$game_player.actor.stat["EventVagRace"] =race
load_script("Data/HCGframes/UniqueEvent_VagDilatation.rb")
end

def unique_event_UrinaryDilatation(race)
$game_player.actor.stat["EventVagRace"] =race
load_script("Data/HCGframes/UniqueEvent_UrinaryDilatation.rb")
end

def unique_event_AnalDilatation(race)
$game_player.actor.stat["EventAnalRace"] =race
load_script("Data/HCGframes/UniqueEvent_AnalDilatation.rb")
end

def unique_event_Enema(race)
$game_player.actor.stat["EventAnalRace"] =race
load_script("Data/HCGframes/UniqueEvent_Enema.rb")
end

def unique_event_BellyPunch(race=nil)
$game_player.actor.stat["EventMouthRace"] =race
load_script("Data/HCGframes/UniqueEvent_BellyPunch.rb")
end

def unique_event_AnalBeads(race)
$game_player.actor.stat["EventAnalRace"] =race
load_script("Data/HCGframes/UniqueEvent_AnalBeads.rb")
end

def unique_event_DeepThroat(race)
$game_player.actor.stat["EventMouthRace"] =race
load_script("Data/HCGframes/UniqueEvent_DeepThroat.rb")
end

def unique_event_ButtSlap(race=nil)
$game_player.actor.stat["EventAnalRace"] =race
load_script("Data/HCGframes/UniqueEvent_ButtSlap.rb")
end

def unique_event_FacePunch(race)
$game_player.actor.stat["EventMouthRace"] =race
load_script("Data/HCGframes/UniqueEvent_FacePunch.rb")
end

def UniqueEvent_SuckDick(race)
$game_player.actor.stat["EventMouthRace"] =race
load_script("Data/HCGframes/UniqueEvent_SuckDick.rb")
end

#########################################通用系列#######################################
######################### 前尾皆可使用所有尾戲結束後記得用event_key_cleaner清KEY
def unique_event_VagNeedle(race=nil)
$game_player.actor.stat["EventVagRace"] =race
load_script("Data/HCGframes/UniqueEvent_VagNeedle.rb")
end

def unique_event_AnalNeedle(race=nil)
$game_player.actor.stat["EventAnalRace"] =race
load_script("Data/HCGframes/UniqueEvent_AnalNeedle.rb")
end

#########################################尾戲系列#######################################
def unique_event_FloorClearnScat(race)
$game_player.actor.stat["EventMouthRace"] =race
load_script("Data/HCGframes/UniqueEvent_FloorClearnScat.rb")
end

def unique_event_FloorClearnPee(race)
$game_player.actor.stat["EventMouthRace"] =race
load_script("Data/HCGframes/UniqueEvent_FloorClearnPee.rb")
end

def unique_event_FloorClearnCums(race)
$game_player.actor.stat["EventMouthRace"] =race
load_script("Data/HCGframes/UniqueEvent_FloorClearnCums.rb")
end

#########################################尾戲系列  特殊#######################################
#########################################下列尾戲與正戲要求相同的KEY 輸入(需與CHSH相同) 放尿系事件當前不支援前戲#######################################
def unique_event_Peeon(evSlotData)
	$game_player.actor.stat["EventVagRace"]     =evSlotData[0]
	$game_player.actor.stat["EventAnalRace"]    =evSlotData[1]
	$game_player.actor.stat["EventMouthRace"]   =evSlotData[2]
	$game_player.actor.stat["EventExt1Race"]    =evSlotData[3]
	$game_player.actor.stat["EventExt2Race"]    =evSlotData[4]
	$game_player.actor.stat["EventExt3Race"]    =evSlotData[5]
	$game_player.actor.stat["EventExt4Race"]    =evSlotData[6]
	load_script("Data/HCGframes/UniqueEvent_Peeon.rb")
end

def unique_event_PeeonHead(evSlotData)
	$game_player.actor.stat["EventVagRace"]     =evSlotData[0]
	$game_player.actor.stat["EventAnalRace"]    =evSlotData[1]
	$game_player.actor.stat["EventMouthRace"]   =evSlotData[2]
	$game_player.actor.stat["EventExt1Race"]    =evSlotData[3]
	$game_player.actor.stat["EventExt2Race"]    =evSlotData[4]
	$game_player.actor.stat["EventExt3Race"]    =evSlotData[5]
	$game_player.actor.stat["EventExt4Race"]    =evSlotData[6]
	load_script("Data/HCGframes/UniqueEvent_PeeonHead.rb")
end

#########################################正戲######################################
############################################################################################################################################################################
############################################################################################################################################################################
############################################################################################################################################################################
####################################################################### 								###################################################################
####################################################################### 	Battle SEx Runner 			###################################################################
####################################################################### 	Battle SEx Runner			###################################################################
####################################################################### 								###################################################################
############################################################################################################################################################################
############################################################################################################################################################################
############################################################################################################################################################################

def launch_auto_chcg_event_appetizer #前戲 自動執行器
	p "launch_auto_chcg_event_appetizer"
	#return 
	return if  $TEST && !$debug_chcg_appetizer
	#half_event_key_cleaner

	#ev_fuckers=get_character(0).summon_data[:fuckers]
	ev_fuckers=get_character(0).summon_data[:fuckers][0] #Game_Event
	ev_holes=get_character(0).summon_data[:holes]
	ev_fappers=get_character(0).summon_data[:fappers]
	randomRace=ev_fuckers.actor.npc.race
	temp_fetish=ev_fuckers.actor.npc.sex_taste["sex_fetish_appetizer"].sample
	case temp_fetish
		when "unique_event_VagDilatation"					;unique_event_VagDilatation(randomRace)
		when "unique_event_UrinaryDilatation"				;unique_event_UrinaryDilatation(randomRace)
		when "unique_event_AnalDilatation"					;unique_event_AnalDilatation(randomRace)
		when "unique_event_Enema"							;unique_event_Enema(randomRace)
		when "unique_event_BellyPunch"						;unique_event_BellyPunch(randomRace)
		when "unique_event_AnalBeads"						;unique_event_AnalBeads(randomRace)
		when "unique_event_DeepThroat"						;unique_event_DeepThroat(randomRace)
		when "unique_event_ButtSlap"						;unique_event_ButtSlap(randomRace)
		when "unique_event_FacePunch"						;unique_event_FacePunch(randomRace)
		when "unique_event_SuckDick"						;unique_event_SuckDick(randomRace)
		when "unique_event_Piercing"						;unique_event_Piercing(randomRace)
	
		when "unique_event_VagNeedle"						;unique_event_VagNeedle(randomRace)
		when "unique_event_AnalNeedle"						;unique_event_AnalNeedle(randomRace)
		when "unique_event_FloorClearnScat"					;unique_event_FloorClearnScat(randomRace)
		when "unique_event_FloorClearnPee"					;unique_event_FloorClearnPee(randomRace)
		when "unique_event_FloorClearnCums"					;unique_event_FloorClearnCums(randomRace)
	end
	#unique_event_DeepThroat(randomRace)
	whole_event_end
end

def launch_auto_chcg_event_main(temp_hole="all") # 正戲 尾戲 自動執行器
	#return


	#return whole_event_end if $TEST && !$debug_chcg_hevent
	return whole_event_end if !get_character(0).summon_data
	tgtFuckers=$game_player.fuckers
	run_STD_check = $game_player.sex_receiver?
	half_event_key_cleaner
	p "launch_auto_chcg_event_main1"
	#取得各穴的NPC的RACE 並填入KEY
	ev_fuckers=get_character(0).summon_data[:fuckers]
	ev_holes=get_character(0).summon_data[:holes]
	ev_fappers=get_character(0).summon_data[:fappers]
	#msgbox "fappers.length =.#{ev_fappers.length}"
	
	return whole_event_end if ev_fuckers.nil?
	return whole_event_end if ev_holes.nil?
	p "launch_auto_chcg_event_main2"
	#CHCG設定初始化
	#!ev_fappers[0].nil? ? $game_player.actor.stat["EventExt1"] = "FapperCuming1" : $game_player.actor.stat["EventExt1"] = nil
	#!ev_fappers[1].nil? ? $game_player.actor.stat["EventExt1"] = "FapperCuming1" : $game_player.actor.stat["EventExt1"] = nil
	#!ev_fappers[2].nil? ? $game_player.actor.stat["EventExt1"] = "FapperCuming1" : $game_player.actor.stat["EventExt1"] = nil
	#!ev_fappers[3].nil? ? $game_player.actor.stat["EventExt1"] = "FapperCuming1" : $game_player.actor.stat["EventExt1"] = nil
	#
	#!ev_fappers[0].nil? ? $game_player.actor.stat["EventExt1Race"] = ev_fappers[0].actor.race : $game_player.actor.stat["EventExt1Race"] = nil
	#!ev_fappers[1].nil? ? $game_player.actor.stat["EventExt2Race"] = ev_fappers[1].actor.race : $game_player.actor.stat["EventExt2Race"] = nil
	#!ev_fappers[2].nil? ? $game_player.actor.stat["EventExt3Race"] = ev_fappers[2].actor.race : $game_player.actor.stat["EventExt3Race"] = nil
	#!ev_fappers[3].nil? ? $game_player.actor.stat["EventExt4Race"] = ev_fappers[3].actor.race : $game_player.actor.stat["EventExt4Race"] = nil
	$game_player.actor.stat["EventExt1"] = "FapperCuming1" if !ev_fappers[0].nil?
	$game_player.actor.stat["EventExt2"] = "FapperCuming1" if !ev_fappers[1].nil?
	$game_player.actor.stat["EventExt3"] = "FapperCuming1" if !ev_fappers[2].nil?
	$game_player.actor.stat["EventExt4"] = "FapperCuming1" if !ev_fappers[3].nil?
	$game_player.actor.stat["EventExt1Race"] = ev_fappers[0].actor.race if !ev_fappers[0].nil?
	$game_player.actor.stat["EventExt2Race"] = ev_fappers[1].actor.race if !ev_fappers[1].nil?
	$game_player.actor.stat["EventExt3Race"] = ev_fappers[2].actor.race if !ev_fappers[2].nil?
	$game_player.actor.stat["EventExt4Race"] = ev_fappers[3].actor.race if !ev_fappers[3].nil?
	p "launch_auto_chcg_event_main3"
	for i in 0...ev_holes.length 									#get_race 
			raise "launch_auto_chcg_event_main, NPC =>#{$data_npcs[ev_holes[i][2]].name} sex_taste not found" if !$data_npcs[ev_holes[i][2]].sex_taste
			case ev_holes[i][0]
				when "vag";
					$game_player.actor.stat["EventVag"] = "CumInside1"
					$game_player.actor.stat["EventVagRace"] =ev_holes[i][1]
					strength_vag=rand($data_npcs[ev_holes[i][2]].sex_taste["sex_strength"]["vag"])
				when "anal";
					$game_player.actor.stat["EventAnal"] = "CumInside1"
					$game_player.actor.stat["EventAnalRace"] =ev_holes[i][1]
					strength_anal=rand($data_npcs[ev_holes[i][2]].sex_taste["sex_strength"]["anal"])
				when "mouth";
					$game_player.actor.stat["EventMouth"] = "CumInside1"
					$game_player.actor.stat["EventMouthRace"] = ev_holes[i][1]
					strength_mouth=rand($data_npcs[ev_holes[i][2]].sex_taste["sex_strength"]["mouth"])
			end
	end

	#設定強度
	basic_event_Setup_Strength(strength_vag,strength_anal,strength_mouth)

	#執行 MAIN EVENT
	p "launch_auto_chcg_event_main4"
	case temp_hole
		when "all"
			run_basic_event
			
			grabbed_by_lona=ev_fuckers.any?{
			|fker|
			fker.grabber == $game_player
			}
			#return whole_event_end if grabbed_by_lona

			#抓取尾戲的長度  抓取誰執行尾戲  填入RACE 並執行之
			all_group_ev=ev_fuckers.concat(ev_fappers)
			all_events=Array.new
			fapper_race=Array.new
			for ga in 0...all_group_ev.length
				all_events = all_events.concat(all_group_ev[ga].actor.npc.sex_taste["sex_fetish_ending"])
				fapper_race = all_group_ev[ga].actor.race
			end
			randomRace=all_group_ev.sample.actor.race
			grabbed_by_lona ? ending_ev= "none" : ending_ev=all_events.sample
			tmpEvSlotData = [
				$game_player.actor.stat["EventVagRace"],
				$game_player.actor.stat["EventAnalRace"],
				$game_player.actor.stat["EventMouthRace"],
				$game_player.actor.stat["EventExt1Race"],
				$game_player.actor.stat["EventExt2Race"],
				$game_player.actor.stat["EventExt3Race"],
				$game_player.actor.stat["EventExt4Race"]
				]

			case ending_ev
				when "unique_event_VagDilatation"					;unique_event_VagDilatation(randomRace)
				when "unique_event_UrinaryDilatation"				;unique_event_UrinaryDilatation(randomRace)
				when "unique_event_AnalDilatation"					;unique_event_AnalDilatation(randomRace)
				when "unique_event_Enema"							;unique_event_Enema(randomRace)
				when "unique_event_BellyPunch"						;unique_event_BellyPunch(randomRace)
				when "unique_event_AnalBeads"						;unique_event_AnalBeads(randomRace)
				when "unique_event_DeepThroat"						;unique_event_DeepThroat(randomRace)
				when "unique_event_ButtSlap"						;unique_event_ButtSlap(randomRace)
				when "unique_event_FacePunch"						;unique_event_FacePunch(randomRace)
				when "unique_event_SuckDick"						;unique_event_SuckDick(randomRace)
				when "unique_event_Piercing"						;unique_event_Piercing(randomRace)
				
				when "unique_event_Peeon"							;unique_event_Peeon(tmpEvSlotData)
				when "unique_event_PeeonHead"						;unique_event_PeeonHead(tmpEvSlotData)
				when "unique_event_VagNeedle"						;unique_event_VagNeedle(randomRace)
				when "unique_event_AnalNeedle"						;unique_event_AnalNeedle(randomRace)
				when "unique_event_FloorClearnScat"					;unique_event_FloorClearnScat(randomRace)
				when "unique_event_FloorClearnPee"					;unique_event_FloorClearnPee(randomRace)
				when "unique_event_FloorClearnCums"					;unique_event_FloorClearnCums(randomRace)
			end 
		when "vag";run_basic_event("vag")
		when "anal";run_basic_event("anal")
		when "mouth";run_basic_event("mouth")
		when "fapper_all";run_basic_event("fapper_all")
		when "fapper1";run_basic_event("fapper1")
		when "fapper2";run_basic_event("fapper2")
		when "fapper3";run_basic_event("fapper3")
		when "fapper4";run_basic_event("fapper4")
	end #main case
	whole_event_end
	$game_player.state_sex_spread_to_reciver(tgtFuckers) if run_STD_check
end


	def batch_GeneralCHCGLauncher
		$game_player.sex_event_playing=true
		launch_auto_chcg_event_main
		$game_player.sex_event_playing=false
		whole_event_end
	end
def basic_event_Setup_Strength(vag=0,anal=0,mouth=0)
	vag = 0 if  vag.nil?
	anal = 0 if  anal.nil?
	mouth = 0 if  mouth.nil?
	$game_temp.basic_event_vag_str=vag
	$game_temp.basic_event_anal_str=anal
	$game_temp.basic_event_mouth_str=mouth
end

def run_basic_event(temp_hole="all")
	suffix=["_CumOutside","_CumInside","_CumInside_Overcum","_CumInside_Peein","_CumInside_Overcum_Peein"]
	chcg_background_color
	chcg_decider_basic_arousal(pose=rand(5+1))
	case temp_hole
	when "all"
		hole_events=[
			["Data/HCGframes/eventVag#{suffix[$game_temp.basic_event_vag_str]}.rb",:chcg_decider_basic_vag,rand(100),$game_player.actor.stat["EventVagRace"]],
			["Data/HCGframes/eventAnal#{suffix[$game_temp.basic_event_anal_str]}.rb",:chcg_decider_basic_anal,rand(100),$game_player.actor.stat["EventAnalRace"]],
			["Data/HCGframes/eventMouth#{suffix[$game_temp.basic_event_mouth_str]}.rb",:chcg_decider_basic_mouth,rand(100),$game_player.actor.stat["EventMouthRace"]]
		]
		hole_events.sort{
			|rb1,rb2|
			rb1[2] <=> rb2[2]
		}
		for i in 0...hole_events.length
			next if hole_events[i][3].nil?
			send(hole_events[i][1],pose=rand(5+1))
			load_script(hole_events[i][0])
		end
		chcg_decider_basic_fapper(pose=rand(5+1))	
		load_script("Data/HCGframes/Ext1_Fapper.rb")                if $game_player.actor.stat["EventExt1Race"] != nil
		load_script("Data/HCGframes/Ext2_Fapper.rb")                if $game_player.actor.stat["EventExt2Race"] != nil
		load_script("Data/HCGframes/Ext3_Fapper.rb")                if $game_player.actor.stat["EventExt3Race"] != nil
		load_script("Data/HCGframes/Ext4_Fapper.rb")                if $game_player.actor.stat["EventExt4Race"] != nil
	when "vag"
		chcg_decider_basic_vag
		load_script("Data/HCGframes/eventVag#{suffix[$game_temp.basic_event_vag_str]}.rb")
	when "anal"
		chcg_decider_basic_anal
		load_script("Data/HCGframes/eventanal#{suffix[$game_temp.basic_event_anal_str]}.rb")
	when "mouth"
		chcg_decider_basic_mouth
		load_script("Data/HCGframes/eventmouth#{suffix[$game_temp.basic_event_mouth_str]}.rb")
	when "fapper_all"
		chcg_decider_basic_fapper(pose=rand(5+1))	
		load_script("Data/HCGframes/Ext1_Fapper.rb")                if $game_player.actor.stat["EventExt1Race"] != nil
		load_script("Data/HCGframes/Ext2_Fapper.rb")                if $game_player.actor.stat["EventExt2Race"] != nil
		load_script("Data/HCGframes/Ext3_Fapper.rb")                if $game_player.actor.stat["EventExt3Race"] != nil
		load_script("Data/HCGframes/Ext4_Fapper.rb")                if $game_player.actor.stat["EventExt4Race"] != nil
	when "fapper1"
		chcg_decider_basic_fapper(pose=rand(5+1))	
		load_script("Data/HCGframes/Ext1_Fapper.rb")                if $game_player.actor.stat["EventExt1Race"] != nil
	when "fapper2"
		chcg_decider_basic_fapper(pose=rand(5+1))	
		load_script("Data/HCGframes/Ext2_Fapper.rb")                if $game_player.actor.stat["EventExt2Race"] != nil
	when "fapper3"
		chcg_decider_basic_fapper(pose=rand(5+1))	
		load_script("Data/HCGframes/Ext3_Fapper.rb")                if $game_player.actor.stat["EventExt3Race"] != nil
	when "fapper4"
		chcg_decider_basic_fapper(pose=rand(5+1))	
		load_script("Data/HCGframes/Ext4_Fapper.rb")                if $game_player.actor.stat["EventExt4Race"] != nil
	end #case
	half_event_key_cleaner
end

#############################################################################################################################################################
#############################################################################################################################################################
######################################################		SEX SERVICE			##############################################################################
#############################################################################################################################################################
#############################################################################################################################################################
#############################################################################################################################################################
	def npc_sex_service_main(ev_target=get_character(0),tmpReciver=$game_player,temp_tar_slot="rand",forcePose=nil,tmpAniStage=0)
		ev_target.set_event_fuck_a_target(tmpReciver,temp_tar_slot,forcePose,tmpAniStage)
	end


	def play_sex_service_menu(ev_target=get_character(0),plus=-1,sex_point=nil,tmp_auto=false,fetishLVL=rand(5),forceCumIn=nil,noRefuse=false,noCumInOPT=false) #種族,獎勵倍率,傳送點設定
		if plus > 0
			result_plus = plus + ((rand(30)-15)*0.01)+ (($game_player.actor.sexy * 0.001) - 0.05)
			result_plus = result_plus.round(3)
		else
			result_plus = 0
		end
		event_key_cleaner_whore_work
		temp_race=ev_target.actor.race
		tmpCumIn = forceCumIn
		$game_player.manual_sex = true
		$game_player.actor.stat["SexEventScore"] = 0
		$game_player.actor.stat["SexEventLast"] =0
		$game_player.actor.stat["SexEventTotalScore"] = 0
		$game_player.call_balloon(0)
		temp_npc_x = ev_target.x
		temp_npc_y = ev_target.y
		temp_move_type = ev_target.move_type
		ev_target.moveto(ev_target.x,ev_target.y)
		ev_target.npc_story_mode(true,false)
		ev_target.move_type = 0
		goto_sex_point_with_character(ev_target,sex_point,tmpMoveToCharAtEnd=false)
		if $game_player.actor.sta > 0 && !tmp_auto
			tmpPicked = ""
			tmpBreak = false
			tmpForceAll = false
			tmpFristLoop = true
			tmpCoconaEV = ["Human","Moot"].include?(ev_target.actor.race) && get_coconaEV
			tmpNymphOPT = $game_player.actor.stat["Nymph"] == 1
			tmpWisdomOPT = $game_player.actor.wisdom_trait >= 10
			tmpVirginOPT = $story_stats["dialog_vag_virgin"]==1 && $story_stats["sex_record_vaginal_count"] ==0
			tmpFetishCumOutside = nil #dude with cum outside fetish
			wisdom_plus = [$game_player.actor.wisdom * 0.5 ,20].min
			tmpMood = 100
			case fetishLVL
				when 0,"Handjob"	; tmpFetish = ["Handjob",0]
				when 1,"Blowjob"	; tmpFetish = ["Blowjob",1]
				when 2,"Anal"		; tmpFetish = ["Anal",2]
				when 3,"Vaginal"	; tmpFetish = ["Vaginal",3]
				when 4,"Full"		; tmpFetish = ["Full",4]
				else   ; tmpFetish = [["Handjob",0],["Blowjob",1],["Anal",2],["Vaginal",3],["Full",4]].sample
			end

			if forceCumIn == true
				tmpCumIn = true
			else
				tmpCumIn = [true,false].sample
				#when !forceCumIn && !tmpCumIn, and when they can be with cuming outside fetish
				if !forceCumIn && !tmpCumIn
					tmpFetishCumOutside = rand(100) >= 90
				end
			end


			tmpCumInOPT = true
			tmpLockHandjob	=false
			tmpLockBlowjob	=false
			tmpLockAnal		=false
			tmpLockVaginal	=false
			tmpLockFull		=false
			tmpAggro = false
			tmpForceAggro = false
			tmpAnySlotBanned = !$game_player.actor.banned_receiver_holes.empty?
			tmpBannedAnal = $game_player.actor.banned_receiver_holes.include?("anal")
			tmpBannedVag = $game_player.actor.banned_receiver_holes.include?("vag")
			tmpBannedMouth = $game_player.actor.banned_receiver_holes.include?("mouth")
			until tmpBreak
				#handjob ,  disble cumingside
				if tmpFetish[0] == "Handjob"
					tmpCumDialog = ""
				else
					tmpCumDialog = $game_text["commonNPC:prostituation/CustomerPick2_CumInside"] if tmpCumIn == true
					tmpCumDialog = $game_text["commonNPC:prostituation/CustomerPick2_CumOutside"] if tmpCumIn == false
				end
			
				tmpWisEffect0 = (tmpFetish[1] == 0 && tmpWisdomOPT)
				tmpWisEffect1 = (tmpFetish[1] == 1 && tmpWisdomOPT)
				tmpWisEffect2 = (tmpFetish[1] == 2 && tmpWisdomOPT)
				tmpWisEffect3 = (tmpFetish[1] == 3 && tmpWisdomOPT)
				tmpWisEffect4 = (tmpFetish[1] >= 4 && tmpWisdomOPT)
				tmpWisEffect4 = (tmpFetish[1] >= 4 && tmpWisdomOPT)

				tmpQuestList = []
				tmpQuestList << [$game_text["commonNPC:prostituation/Wisdom"]			,"Wisdom",false]		if tmpWisdomOPT
				tmpQuestList << [$game_text["commonNPC:prostituation/Nymph"]			,"Nymph",false]			if tmpNymphOPT
				tmpQuestList << [$game_text["CompCocona:prostituation/CoconaVag"]		,"CoconaVag",true]		if tmpCoconaEV && $story_stats["RecQuestCoconaVagTaken"] >= 3
				tmpQuestList << [$game_text["commonNPC:prostituation/CumOutside"]		,"CumOutside",false]	if tmpCumIn == true && tmpCumInOPT && !noCumInOPT && tmpFetish != ["Handjob",0]
				tmpQuestList << [$game_text["commonNPC:prostituation/CumInside"]		,"CumInside",false]		if tmpCumIn == false && tmpCumInOPT && !noCumInOPT && tmpFetish != ["Handjob",0]
				tmpQuestList << [$game_text["commonNPC:prostituation/Virgin"]			,"Virgin",false]		if tmpVirginOPT
				tmpQuestList << [$game_text["commonNPC:prostituation/Handjob"]			,"Handjob",true]		if (tmpFetish[0] == "Handjob" 	|| tmpForceAll || tmpWisEffect0) && tmpLockHandjob == false
				tmpQuestList << [$game_text["commonNPC:prostituation/Blowjob"]			,"Blowjob",true]		if (tmpFetish[0] == "Blowjob" 	|| tmpForceAll || tmpWisEffect1) && tmpLockBlowjob == false
				tmpQuestList << [$game_text["commonNPC:prostituation/Anal"]				,"Anal",true]			if (tmpFetish[0] == "Anal" 		|| tmpForceAll || tmpWisEffect2) && tmpLockAnal	 == false
				tmpQuestList << [$game_text["commonNPC:prostituation/Vaginal"]			,"Vaginal",true]		if (tmpFetish[0] == "Vaginal" 	|| tmpForceAll || tmpWisEffect3) && tmpLockVaginal == false
				tmpQuestList << [$game_text["commonNPC:prostituation/SemiAuto"]			,"SemiAuto",true]		if (tmpFetish[0] == "Full" 		|| tmpForceAll || tmpWisEffect4) && tmpLockFull	 == false
				tmpQuestList << [$game_text["commonNPC:prostituation/FullAuto"]			,"FullAuto",true]		if (tmpFetish[0] == "Full" 		|| tmpForceAll || tmpWisEffect4) && tmpLockFull	 == false
				tmpQuestList << [$game_text["commonNPC:prostituation/Repent"]			,"Repent",true]			if !noRefuse
						cmd_sheet = tmpQuestList
						cmd_text =""
						for i in 0...cmd_sheet.length
							cmd_text.concat(cmd_sheet[i].first+",")
							p cmd_text
						end
						call_msg("\\narr #{$game_text["commonNPC:prostituation/CustomerPick0"]}#{$game_text["commonNPC:prostituation/#{tmpFetish[0]}"]}#{$game_text["commonNPC:prostituation/CustomerPick1"]}#{tmpCumDialog}")
						call_msg("\\narr #{$game_text["commonNPC:prostituation/reward0"]}#{result_plus.round(3)}#{$game_text["commonNPC:prostituation/reward1"]}") if plus > 0 && result_plus > 0
						call_msg("commonNPC:prostituation/Wisdom_dialog_angry") if tmpAggro
						call_msg("commonNPC:RandomNpc/WhoreWork_win_opt_win",0,2,0)
						call_msg("\\optD[#{cmd_text}]")
				
				$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
				$game_temp.choice == -1 ? tmpBreak = true : tmpBreak = cmd_sheet[$game_temp.choice][2]
				$game_temp.choice = -1
				
				tmpFristLoop =false
				# if banned slot.  make aggro
				bannedAggro = nil
				bannedAggro = true if ["SemiAuto","FullAuto"].include?(tmpPicked) && tmpAnySlotBanned
				bannedAggro = true if ["Anal"].include?(tmpPicked) && tmpBannedAnal
				bannedAggro = true if ["Vaginal"].include?(tmpPicked) && tmpBannedVag
				bannedAggro = true if ["Blowjob"].include?(tmpPicked) && tmpBannedMouth
				if bannedAggro && !noRefuse # !noRefuse because its mosyly used in story mode. should block by spec events.
					tmpAggro = true
					call_msg("commonNPC:prostituation/Repent_blocked_slot")
					play_sex_service_break(ev_target,temp_npc_x,temp_npc_y,temp_move_type,sex_point,tmpAggro)
					portrait_hide
					return "Repent"
				end
				#非break區
				case tmpPicked
					when "Wisdom"
						if tmpFetish[1] >= 4
							call_msg("commonNPC:prostituation/Wisdom_dialog_more")
							result_plus += (rand(wisdom_plus/2))*0.01
							tmpMood -= 25+rand(50)-rand(wisdom_plus)
						else
							tmpFetish[1] += 1
							call_msg("commonNPC:prostituation/Wisdom_dialog")
							result_plus += (5+rand(wisdom_plus))*0.01
							tmpMood -= 25+rand(50)-rand(wisdom_plus)
						end
						
					when "Nymph"
						tmpNymphOPT = false
						tmpForceAll = true
						tmpWisdomOPT = false
						tmpMood = 100
						result_plus = result_plus * 0
						call_msg("commonNPC:prostituation/Nymph_dialog")
						
					when "CumOutside"
						tmpCumInOPT = false
						if tmpFetishCumOutside
							tmpCumIn = false
							result_plus += (5+rand(wisdom_plus))*0.01
							tmpMood += 25+rand(50)-rand(wisdom_plus)
							call_msg("commonNPC:prostituation/CumInside_dialog#{$game_player.actor.talk_persona}")
							ev_target.call_balloon(3)
							call_msg("commonNPC:prostituation/CumOutside_dialog_CustomerHappy")
						else
							tmpCumIn = false
							result_plus -= (5+rand(10))*0.01
							tmpMood -= 25+rand(50)-rand(wisdom_plus)
							call_msg("commonNPC:prostituation/CumOutside_dialog#{$game_player.actor.talk_persona}")
						end
					when "CumInside"
						tmpCumInOPT = false
						if tmpFetishCumOutside
							tmpCumIn = true
							result_plus -= (5+rand(10))*0.01
							tmpMood -= 25+rand(50)-rand(wisdom_plus)
							call_msg("commonNPC:prostituation/CumInside_dialog#{$game_player.actor.talk_persona}")
							ev_target.call_balloon(7)
							call_msg("commonNPC:prostituation/CumOutside_dialog_CustomerMad")
						else
							tmpCumIn = true
							result_plus += (5+rand(wisdom_plus))*0.01
							tmpMood += 25+rand(50)-rand(wisdom_plus)
							call_msg("commonNPC:prostituation/CumInside_dialog#{$game_player.actor.talk_persona}")
						end
						
					when "Virgin"
						call_msg("commonNPC:prostituation/Virgin_dialog#{$game_player.actor.talk_persona}")
						tmpForceAggro = true
						tmpVirginOPT = false
						tmpWisdomOPT = false
						tmpForceAll = true
						
						if rand(100) >= 1
							tmpLockHandjob	=true
							tmpLockBlowjob	=true
							tmpLockAnal		=true
							tmpLockVaginal	=false
							tmpLockFull		=true
							tmpCumInOPT		=true
							if forceCumIn == true
								tmpCumIn = true
							else
								tmpCumIn = [true,false].sample if tmpCumIn == nil
							end
							tmpFetish = ["Vaginal",3]
							
							
							result_plus += result_plus*10
							tmpMood = [tmpMood*2,100].min
							call_msg("commonNPC:prostituation/Virgin_dialog_ans")
						else
							tmpLockHandjob	=false
							tmpLockBlowjob	=false
							tmpLockAnal		=false
							tmpLockVaginal	=true
							tmpLockFull		=true
							call_msg("commonNPC:prostituation/Virgin_dialog_faggot")
						end
				end # case tmpPicked
				
				# ckeck if they anger
				tmpMood <= 50 ? tmpAggro = true : tmpAggro = false
				tmpAggro = true if tmpForceAggro
				if tmpMood <= rand(25)
					tmpPicked = "Repent"
					tmpBreak = true
					result_plus = 0
					play_sex_service_break(ev_target,temp_npc_x,temp_npc_y,temp_move_type,sex_point,tmpAggro)
					call_msg("commonNPC:prostituation/Aggro")
					#get_coconaEV.opacity = 255 if tmpCoconaEV 
					portrait_hide
					return "Repent"
				end
		
			end #until
			case tmpPicked
				when "Handjob"
					ev_target.call_balloon(4)
					play_sex_service_move_to_player(ev_target,tmpMood)
					get_character(0).forced_z = -3
					play_sex_service_main(ev_target,"fapper",false,tmpCumIn=nil,forcePose=nil,tmpAniStage=0,plus=plus)
					tmpLastMovementData = play_sex_service_main(ev_target,"fapper",false,tmpCumIn=nil,forcePose=nil,tmpAniStage=0,plus=plus)
					tmpLastMovementData[5] =3 #tmpAniStage
					tmpLastMovementData[7] =true #Loop
					play_sex_service_main(*tmpLastMovementData)
					play_sex_service_chcg(ev_target)
					play_sex_service_get_reward(result_plus*0.7) if plus > 0
					get_character(0).forced_z = 0
				
				when "Blowjob"
					ev_target.call_balloon(4)
					play_sex_service_move_to_player(ev_target,tmpMood)
					play_sex_service_main(ev_target,"mouth",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					play_sex_service_main(ev_target,"mouth",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					play_sex_service_get_reward(result_plus*0.8) if plus > 0
					tmpLastMovementData = play_sex_service_main(ev_target,"mouth",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					tmpLastMovementData[5] =3 #tmpAniStage
					tmpLastMovementData[7] =true #Loop
					play_sex_service_main(*tmpLastMovementData)
					play_sex_service_chcg(ev_target,tmpCumIn)
					play_sex_service_get_reward(result_plus*0.8) if plus > 0
				
				when "Anal"
					ev_target.call_balloon(4)
					play_sex_service_move_to_player(ev_target,tmpMood)
					play_sex_service_main(ev_target,"anal",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					play_sex_service_main(ev_target,"anal",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					play_sex_service_get_reward(result_plus*0.9)
					tmpLastMovementData = play_sex_service_main(ev_target,"anal",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					tmpLastMovementData[5] =3 #tmpAniStage
					tmpLastMovementData[7] =true #Loop
					play_sex_service_main(*tmpLastMovementData)
					play_sex_service_chcg(ev_target,tmpCumIn)
					play_sex_service_get_reward(result_plus*0.9)
				
				when "Vaginal"
					ev_target.call_balloon(4)
					play_sex_service_move_to_player(ev_target,tmpMood)
					play_sex_service_main(ev_target,"vag",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					play_sex_service_main(ev_target,"vag",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					play_sex_service_get_reward(result_plus) if plus > 0
					tmpLastMovementData = play_sex_service_main(ev_target,"vag",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					tmpLastMovementData[5] =3 #tmpAniStage
					tmpLastMovementData[7] =true #Loop
					play_sex_service_main(*tmpLastMovementData)
					play_sex_service_chcg(ev_target,tmpCumIn)
					play_sex_service_get_reward(result_plus) if plus > 0
				
				when "SemiAuto"
					ev_target.call_balloon(4)
					play_sex_service_move_to_player(ev_target,tmpMood)
					play_sex_service_main(ev_target,"rand",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					play_sex_service_get_reward(result_plus) if plus > 0
					play_sex_service_main(ev_target,"rand",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					play_sex_service_get_reward(result_plus) if plus > 0
					play_sex_service_main(ev_target,"rand",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					play_sex_service_get_reward(result_plus) if plus > 0
					tmpLastMovementData = play_sex_service_main(ev_target,"rand",false,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					tmpLastMovementData[5] =3 #tmpAniStage
					tmpLastMovementData[7] =true #Loop
					play_sex_service_main(*tmpLastMovementData)
					play_sex_service_chcg(ev_target,tmpCumIn)
					play_sex_service_get_reward(result_plus) if plus > 0
				
				when "FullAuto"
					ev_target.call_balloon(4)
					play_sex_service_move_to_player(ev_target,tmpMood)
					ev_target.npc.stat.set_stat("mood",50)
					play_sex_service_main(ev_target,"rand",passive=true,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					play_sex_service_get_reward(result_plus*0.9) if plus > 0
					play_sex_service_main(ev_target,"rand",passive=true,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					play_sex_service_get_reward(result_plus*0.9) if plus > 0
					play_sex_service_main(ev_target,"rand",passive=true,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					play_sex_service_get_reward(result_plus*0.9) if plus > 0
					tmpLastMovementData = play_sex_service_main(ev_target,"rand",passive=true,tmpCumIn,forcePose=nil,tmpAniStage=rand(3),plus=plus)
					tmpLastMovementData[5] =3 #tmpAniStage
					tmpLastMovementData[7] =true #Loop
					play_sex_service_main(*tmpLastMovementData)
					play_sex_service_chcg(ev_target,tmpCumIn)
					play_sex_service_get_reward(result_plus*0.9) if plus > 0
					
				when "Repent"
					ev_target.call_balloon(2)
					plus = 0
					#get_coconaEV.opacity = 255 if tmpCoconaEV 
					call_msg("commonNPC:prostituation/Repent_dialog")
					call_msg("commonNPC:prostituation/Repent_dialog_aggro") if tmpAggro
					play_sex_service_break(ev_target,temp_npc_x,temp_npc_y,temp_move_type,sex_point,tmpAggro)
					portrait_hide
					return "Repent"
					
				when "CoconaVag"
					play_CoconaWhoreEV(ev_target)
					$game_player.actor.stat["SexEventScore"] += [400 + 100*$game_NPCLayerMain.stat["Cocona_exp_vag"],1000].min
					play_sex_service_get_reward(plus=1)
			end
	
		
		else # sta too low or auto    		reward = basic
			case fetishLVL
				when 0; temp_tar_slot = "fapper"
				when 1; temp_tar_slot = "mouth"
				when 1; temp_tar_slot = "anal"
				when 3; temp_tar_slot = "vag"
				else ; temp_tar_slot = "rand"
			end
			play_sex_service_main(ev_target,temp_tar_slot,passive=true,tmpCumIn=nil,forcePose=nil,tmpAniStage=rand(3),plus=plus)
			play_sex_service_get_reward(result_plus) if plus > 0
			play_sex_service_main(ev_target,temp_tar_slot,passive=true,tmpCumIn=nil,forcePose=nil,tmpAniStage=rand(3),plus=plus)
			play_sex_service_get_reward(result_plus) if plus > 0
			play_sex_service_main(ev_target,temp_tar_slot,passive=true,tmpCumIn=nil,forcePose=nil,tmpAniStage=rand(3),plus=plus)
			play_sex_service_get_reward(result_plus) if plus > 0
			tmpLastMovementData = play_sex_service_main(ev_target,temp_tar_slot,passive=true,tmpCumIn=nil,forcePose=nil,tmpAniStage=rand(3),plus=plus)
			tmpLastMovementData[5] =3 #tmpAniStage
			tmpLastMovementData[7] =true #Loop
			play_sex_service_main(*tmpLastMovementData)
			
			play_sex_service_chcg(ev_target)
			play_sex_service_get_reward(result_plus) if plus > 0
		end
		
		tmpDid = !tmpBreak || tmpPicked != "Repent"
		#get_coconaEV.opacity = 255 if !tmpDid && tmpCoconaEV && get_coconaEV
		play_CoconaWhoreEV(ev_target) if $story_stats["RecQuestCoconaVagTaken"] == 2 && tmpDid && tmpCoconaEV && get_coconaEV############################### COCONA EV FiRST TIME
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			$game_player.target = nil if tmpDid #so follower wont attack customer
			$game_player.actor.target = nil if tmpDid #so follower wont attack customer
			$game_player.actor.stat["SexEventScore"] = 0
			$game_player.actor.stat["SexEventTotalScore"] = 0
			$game_player.actor.stat["SexEventInput"] = 0
			$game_player.actor.stat["SexEventLast"] = 0
			$game_player.actor.set_action_state(:none)
			$game_player.unset_event_chs_sex
			
			ev_target.unset_event_chs_sex
			#$game_player.event_input = false
			$game_player.manual_sex = false
			ev_target.unset_event_chs_sex
			ev_target.npc_story_mode(false,false)
			ev_target.npc.refresh
			if ev_target.npc.action_state != :death
				ev_target.move_type = temp_move_type
				if sex_point != nil
					ev_target.moveto(temp_npc_x,temp_npc_y)
				else
					tmpTGT = ev_target.get_item_jump_xy
					ev_target.moveto(*tmpTGT)
					ev_target.turn_toward_character($game_player)
				end
				ev_target.direction = ev_target.original_direction
			end
			$game_temp.choice = nil
			event_key_cleaner_whore_work
			$game_player.actor.prtmood("normal")
			portrait_hide
		chcg_background_color(0,0,0,255,-7)
		return "CoconaVag" if tmpPicked == "CoconaVag"
		return "Repent" if tmpPicked == "Repent"
		#msgbox "tmpBreak #{tmpBreak }"
		#msgbox "tmpPicked #{tmpPicked }"
		#msgbox "tmpDid #{tmpDid }"
		return "Break" if tmpBreak && !tmpDid
		return "Success" #回報結果
	end

	def play_sex_service_break(ev_target,temp_npc_x,temp_npc_y,temp_move_type,sex_point,tmpAggro=false)
		ev_target.move_type = temp_move_type
		ev_target.moveto(temp_npc_x,temp_npc_y) if sex_point != nil
		ev_target.setup_audience
		saved_move_type = ev_target.move_type # another save because ,   between setup_audience and npc_story_mode off will have a free time to make npc update its move route
		ev_target.move_type = 0
		ev_target.moveto($game_player.x,$game_player.y)
		ev_target.move_forward_passable_dir
		ev_target.jump_to_low(ev_target.x,ev_target.y)
		until !ev_target.moving?
			wait(1)
		end
		if tmpAggro
			ev_target.call_balloon(15)
			wait(30)
			ev_target.turn_toward_character($game_player)
			wait(20)
			ev_target.npc_story_mode(false,false)
			ev_target.move_type = saved_move_type
			ev_target.npc.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
		else
			ev_target.call_balloon(7)
			ev_target.npc_story_mode(false,false)
			ev_target.move_type = saved_move_type
			ev_target.npc.refresh
			ev_target.actor.process_target_lost if ev_target.npc.action_state != :death
		end
	end
	
	
	def play_sex_service_move_to_player(ev_target,tmpMood)
		$game_player.fuckers.push(ev_target)
		ev_target.npc.stat.set_stat("mood",tmpMood)
		ev_target.moveto($game_player.x,$game_player.y)
	end
	############################################################################# COCONA EV
	############################################################################# COCONA EV
	############################################################################# COCONA EV
	def play_CoconaWhoreEV(ev_target)
		return if !["Human","Moot"].include?(ev_target.actor.race)
		portrait_off
		coconaEV = get_coconaEV
		prev_move_type = coconaEV.move_type
		coconaEV.npc_story_mode(true)
		coconaEV.effects=["FadeIn",0,false,nil,nil,nil]
		coconaEV.move_type = 0
		ev_target.unset_event_chs_sex
		$game_player.unset_event_chs_sex
		tmpXY = coconaEV.get_item_jump_xy
		coconaEV.move_goto_xy(*tmpXY)
		ev_target.move_goto_xy(coconaEV.x,coconaEV.y)
		ev_target.turn_toward_character(coconaEV)
		coconaEV.turn_toward_character(ev_target)
		$game_player.turn_toward_character(coconaEV)
		until !ev_target.moving?
			wait(1)
		end
		tmpXY = ev_target.get_item_jump_xy
		ev_target.move_goto_xy(*tmpXY)
		ev_target.turn_toward_character(coconaEV)
		coconaEV.turn_toward_character(ev_target)
		$game_player.turn_toward_character(coconaEV)
		until !ev_target.moving?
			wait(1)
		end
		#coconaEV.item_jump_to
		#ev_target.jump_to(coconaEV.x,coconaEV.y)
		#ev_target.item_jump_to
		#$game_player.item_jump_to
		ev_target.turn_toward_character(coconaEV)
		coconaEV.turn_toward_character(ev_target)
		$game_player.turn_toward_character(coconaEV)
		if $story_stats["RecQuestCoconaVagTaken"] == 2
			call_msg("CompCocona:WhoreEV/first_begin0")
			call_msg("CompCocona:WhoreEV/first_begin0_1")
			call_msg("CompCocona:WhoreEV/first_begin1")
			call_msg("CompCocona:WhoreEV/first_begin_opt") #[算了,教可可娜賣春]
			if $game_temp.choice != 1
				portrait_hide
				coconaEV.move_type = prev_move_type
				coconaEV.npc_story_mode(false)
				return call_msg("CompCocona:WhoreEV/first_begin_opt_yes")
			end
			call_msg("CompCocona:WhoreEV/first_begin_opt_yes")
			call_msg("CompCocona:WhoreEV/first_begin2")
		else
			call_msg("CompCocona:prostituation/vag_success")
		end
		if rand(100) >= 99
			portrait_hide
			ev_target.call_balloon(8)
			wait(60)
			coconaEV.move_type = prev_move_type
			coconaEV.npc_story_mode(false)
			return call_msg("CompCocona:WhoreEV/failed")
		end
		ev_target.moveto(coconaEV.x,coconaEV.y)
		ev_target.call_balloon(4)
		npc_sex_service_main(ev_target,coconaEV,"vag",0,0)
		$story_stats["tmpData"]={}
		$story_stats["tmpData"][:race] = ev_target.actor.race
		$story_stats["tmpData"][:recRoomMode] = false
		load_script("Data/HCGframes/UniqueEvent_CoconaVag.rb")
		$story_stats["tmpData"]={}
		coconaEV.unset_event_chs_sex
		ev_target.unset_event_chs_sex
		coconaEV.move_type = prev_move_type
		coconaEV.npc_story_mode(false)
		call_msg("CompCocona:WhoreEV/first_end0") if $story_stats["RecQuestCoconaVagTaken"] == 2
		$story_stats["RecQuestCoconaVagTaken"] += 1
	end
	
	def goto_cocona_sex_point(ev_target)
		return if !["Human","Moot"].include?(ev_target.actor.race)
		return if $story_stats["RecQuestCoconaVagTaken"] < 2
		coconaEV = get_coconaEV
		return if !coconaEV
		#return if !follower_in_range?(0,5)
		#prev_move_type = coconaEV.move_type
		#coconaEV.move_type = 0
		coconaEV.moveto(coconaEV.x,coconaEV.y)
		#coconaEV.npc_story_mode(true)
		coconaEV.moveto(ev_target.x,ev_target.y)
		if $story_stats["RecQuestCoconaVagTaken"] == 2
			tmpTGT = coconaEV.get_item_jump_xy
			coconaEV.moveto(*tmpTGT)
			tmpTGT = coconaEV.get_item_jump_xy
			coconaEV.moveto(*tmpTGT)
			coconaEV.turn_toward_character($game_player)
		else
			#coconaEV.opacity = 0
			tmpTGT = coconaEV.get_item_jump_xy
			coconaEV.moveto(*tmpTGT)
			coconaEV.turn_toward_character($game_player)
		end
		
		#coconaEV.move_type = prev_move_type
	end
	
	def get_coconaEV
		return nil if !["UniqueCoconaMaid","UniqueCocona"].include?($game_player.record_companion_name_back)
		return nil if !get_character($game_player.get_followerID(0))
		coconaEV = get_character($game_player.get_followerID(0))
		return nil if coconaEV.actor.target
		coconaEV
	end
	############################################################################# COCONA EV END
	############################################################################# COCONA EV END
	############################################################################# COCONA EV END
	
def goto_sex_point_with_character(ev_target,sex_point=nil,tmpMoveToCharAtEnd=true)
	return goto_cocona_sex_point(ev_target) if sex_point==nil
	chcg_background_color(0,0,0,255)
	#call_msg("commonNPC:RandomNpc/WhoreWork_GotoPoint")
	case sex_point
		when "closest"
			hashA = $game_map.list_storypoints
			tmpPointArrayList = []
			sex_points = hashA.select { |key, _| key.include?("SexPoint") }
			sex_points.each{|name,tar|
				p "Found SexPoint #{name} X#{tar[0]} Y#{tar[1]} ID#{tar[2]}"
				tmp_report_range = get_character(tar[2]).report_range
				tmpPointArrayList << [name,tmp_report_range]
			}
			min_sub_array = tmpPointArrayList.min_by { |sub_array| sub_array[1] }
			tgtPoint= min_sub_array[0]
			st_x,st_y,st_id=$game_map.get_storypoint(tgtPoint)
			$game_player.moveto(st_x,st_y)
		when "rand"
			st_x,st_y,st_id=$game_map.get_storypoint("SexPoint#{rand(3)+1}")
			$game_player.moveto(st_x,st_y)
		else
			st_x,st_y,st_id=$game_map.get_storypoint(sex_point)
			$game_player.moveto(st_x,st_y)
	end
	ev_target.moveto($game_player.x,$game_player.y)
	tmpTGT = ev_target.get_item_jump_xy
	ev_target.moveto(*tmpTGT)
	ev_target.turn_toward_character($game_player)
	$game_player.turn_toward_character(ev_target)
	temp_npc_x = ev_target.x
	temp_npc_y = ev_target.y
	temp_player_cur_x= get_character(st_id).x
	temp_player_cur_y= get_character(st_id).y
		if 	get_character(st_id).passable?(get_character(st_id).x,get_character(st_id).y,2)
			temp_npc_goto_x = temp_player_cur_x
			temp_npc_goto_y = temp_player_cur_y +1
		elsif  get_character(st_id).passable?(get_character(st_id).x,get_character(st_id).y,4)
			temp_npc_goto_x = temp_player_cur_x -1
			temp_npc_goto_y = temp_player_cur_y
		elsif  get_character(st_id).passable?(get_character(st_id).x,get_character(st_id).y,6)
			temp_npc_goto_x = temp_player_cur_x +1
			temp_npc_goto_y = temp_player_cur_y
		elsif  get_character(st_id).passable?(get_character(st_id).x,get_character(st_id).y,8)
			temp_npc_goto_x = temp_player_cur_x 
			temp_npc_goto_y = temp_player_cur_y -1
		else
			temp_npc_goto_x = temp_player_cur_x
			temp_npc_goto_y = temp_player_cur_y
		end
	#ev_target.move_away_from_character($game_player)
	#ev_target.moveto(ev_target.x,ev_target.y)
	ev_target.turn_toward_character($game_player)
	$game_player.turn_toward_character(ev_target)
	goto_cocona_sex_point(ev_target)
	chcg_background_color(0,0,0,255,-7)
	call_msg("commonNPC:RandomNpc/choosed")
	ev_target.moveto($game_player.x,$game_player.y) if tmpMoveToCharAtEnd
end

def play_sex_service_get_reward(plus=1)
	event_key_cleaner_whore_work
	return if plus <= 0
	result = ($game_player.actor.stat["SexEventScore"]*plus).round
	$game_party.gain_gold(result)
	SndLib.sys_Gain
	$game_map.popup(0,result,812,1)
	$game_player.actor.stat["SexEventTotalScore"] += result
	$game_player.actor.stat["SexEventScore"] = 0
end

def play_sex_service_items(ev_target=get_character(0),goods=["ItemCoin1","ItemCoin2","ItemCoin3"],prev_gold=0,summon=nil)
	if ev_target == nil || ev_target.npc.stat.get_stat("mood",0) >=75 && summon == nil
		summon = false
	else
		summon = true
	end
	cur_vol= $game_party.gold
	return if cur_vol == prev_gold
	decrese_gold = (cur_vol - prev_gold)
	decrese_gold = 0 if decrese_gold <= 0
	event_key_cleaner_whore_work
	SndLib.sound_step_chain
	optain_item_chain(decrese_gold,goods,summon)
	$game_party.lose_gold(decrese_gold)
end

def play_sex_service_main(ev_target=get_character(0),temp_tar_slot="rand",passive=false,tmpCumIn=nil,forcePose=nil,tmpAniStage=0,plus=1,loopAniMode=false)
	$cg.erase
	$bg.erase
	event_key_cleaner_whore_work
	$game_player.actor.stat["SexEventScore"] = 0 if $game_player.actor.stat["SexEventScore"].nil?
	temp_loop = 0
	temp_tar_slot = ["vag","anal","mouth","fapper"].sample if temp_tar_slot ==  "rand"
	if temp_tar_slot != "fapper"
		
		$game_player.fuckers.push(ev_target)
		defini=$game_player.chs_definition
		temp_pose=defini.get_pos_by_holename(temp_tar_slot,1)
		fker_defini=ev_target.chs_definition
		poses=Array.new
		for i in 0...temp_pose.length
			tgt_hole_index=defini.get_position_index(temp_pose[i],temp_tar_slot)
			next if tgt_hole_index.nil?	
			next if fker_defini.supported_fucker[temp_pose[i]].index(tgt_hole_index+1).nil?
			poses << temp_pose[i]
		end
	
		forcePose.nil? ? pose = poses.sample : pose = forcePose
		fker_posi = defini.get_position_index(pose,temp_tar_slot)+1
		$game_player.actor.set_action_state(:sex)
		#$game_player.event_input = true
		$game_player.set_event_chs_sex(pose,0)
		case tmpAniStage
			when 0 ; $game_player.animation = $game_player.animation_event_sex($game_player,pose)
			when 1 ; $game_player.animation = $game_player.animation_event_sex_fast($game_player,pose)
			when 2 ; $game_player.animation = $game_player.animation_event_sex_cumming($game_player,pose)
			when 3 ; $game_player.animation = $game_player.animation_event_sex_cumming_eject($game_player,pose)
			else   ; $game_player.animation = $game_player.animation_event_sex($game_player,pose)
		end
		ev_target.set_event_chs_sex(pose,fker_posi)
		case tmpAniStage
			when 0 ; ev_target.animation = ev_target.animation_event_sex($game_player,pose)
			when 1 ; ev_target.animation = ev_target.animation_event_sex_fast($game_player,pose)
			when 2 ; ev_target.animation = ev_target.animation_event_sex_cumming($game_player,pose)
			when 3 ; ev_target.animation = ev_target.animation_event_sex_cumming_eject($game_player,pose)
			else   ; ev_target.animation = ev_target.animation_event_sex($game_player,pose)
		end
	elsif temp_tar_slot == "fapper"
		$game_player.unset_event_chs_sex
		ev_target.unset_event_chs_sex
		$game_player.actor.set_action_state(:sex)
		#$game_player.event_input = true
		case tmpAniStage
			when 0 ; $game_player.animation = $game_player.animation_handjob_giver(ev_target)
			when 1 ; $game_player.animation = $game_player.animation_handjob_giver_fast(ev_target)
			when 2 ; $game_player.animation = $game_player.animation_handjob_giver_fast_cumming(ev_target)
			when 3 ; $game_player.animation = $game_player.animation_handjob_giver_fast_cumming_eject(ev_target)
			else   ; game_player.animation = $game_player.animation_handjob_giver(ev_target)
		end
		case tmpAniStage
			when 0 ; ev_target.animation = ev_target.animation = ev_target.animation_handjob_target
			when 1 ; ev_target.animation = ev_target.animation = ev_target.animation_handjob_target_fast
			when 2 ; ev_target.animation = ev_target.animation = ev_target.animation_handjob_target_fast_cumming
			when 3 ; ev_target.animation = ev_target.animation = ev_target.animation_handjob_target_fast_cumming_eject
			else   ; ev_target.animation = ev_target.animation = ev_target.animation_handjob_target
		end
		#$game_player.animation = $game_player.animation_handjob_giver(ev_target)
		#ev_target.animation = ev_target.animation_handjob_target
	end #if temp_tar_slot != "fapper"
	return [ev_target,temp_tar_slot,passive,tmpCumIn,pose,tmpAniStage,plus,loopAniMode] if loopAniMode
	tmpData = {
		:user=>$game_player,
		:target=>ev_target,
		:plus=>plus,
		:passive => passive
	}
	EvLib.sum("ProstitutionEventInput",1,1,tmpData)
	$game_player.force_update = false
	ev_target.force_update = false
	wait(60)
	$game_player.force_update = true
	ev_target.force_update = true
	$game_player.crosshair.summon_data[:target] = temp_tar_slot
	case temp_tar_slot #even basic score
		when "vag"; 		$game_player.actor.stat["SexEventScore"] += $game_player.actor.sex_vag_atk+45+rand(80)
							$story_stats["sex_record_vaginal_count"] +=1
							$game_player.actor.stat["vagopen"] = 1
							$game_player.actor.stat["EventVagRace"] = ev_target.actor.race
							$game_player.actor.stat["EventVag"] = "CumInside1"
							$story_stats.sex_record_vag(["DataNpcName:race/#{ev_target.actor.race}" , "DataNpcName:name/#{ev_target.actor.npc_name}" , "DataNpcName:part/penis"])
							6.times{
								case tmpAniStage
									when 0 ; wait(30)
									when 1 ; wait(15)
									when 2 ; wait(40)
								end
								lona_mood "p4shame"
								$game_player.actor.stat["EventVag"] = pose_GenCommonPenisKey($game_player.actor.stat["EventVag"]) if !IsChcg?
								load_script("Data/Batch/chcg_whorework_frame_vag.rb")
								check_over_event
								$game_player.actor.stat["SexEventLast"] = "Vag"
							}
		when "anal"; 		$game_player.actor.stat["SexEventScore"] += $game_player.actor.sex_anal_atk+45+rand(80)
							$story_stats["sex_record_anal_count"] +=1
							$game_player.actor.stat["analopen"] = 1
							$game_player.actor.stat["EventAnalRace"] = ev_target.actor.race
							$game_player.actor.stat["EventAnal"] = "CumInside1"
							$story_stats.sex_record_anal(["DataNpcName:race/#{ev_target.actor.race}" , "DataNpcName:name/#{ev_target.actor.npc_name}" , "DataNpcName:part/penis"])
							6.times{
								case tmpAniStage
									when 0 ; wait(30)
									when 1 ; wait(15)
									when 2 ; wait(40)
								end
								lona_mood "p4shame"
								$game_player.actor.stat["EventAnal"] = pose_GenCommonPenisKey($game_player.actor.stat["EventAnal"]) if !IsChcg?
								load_script("Data/Batch/chcg_whorework_frame_anal.rb")
								check_over_event
								$game_player.actor.stat["SexEventLast"] = "Anal"
							}
		when "mouth"; 		$game_player.actor.stat["SexEventScore"] += $game_player.actor.sex_mouth_atk+30+rand(50)
							$story_stats["sex_record_mouth_count"] +=1
							$game_player.actor.stat["EventMouthRace"] = ev_target.actor.race
							$game_player.actor.stat["EventMouth"] = "CumInside1" if IsChcg?
							$story_stats.sex_record_mouth(["DataNpcName:race/#{ev_target.actor.race}" , "DataNpcName:name/#{ev_target.actor.npc_name}" , "DataNpcName:part/penis"])
							mouth_plus = 0 if $game_temp.choice !=1
							mouth_plus = 4 if $game_temp.choice ==1
							(6+mouth_plus).times{
								case tmpAniStage
									when 0 ; wait(30)
									when 1 ; wait(15)
									when 2 ; wait(40)
								end
								lona_mood "p5shame"
								$game_player.actor.stat["EventMouth"] =  pose_GenCommonPenisKey($game_player.actor.stat["EventMouth"]) if !IsChcg?
								load_script("Data/Batch/chcg_whorework_frame_mouth.rb")
								check_over_event
								$game_player.actor.stat["SexEventLast"] = "Mouth"
							}
		when "fapper"; 		$game_player.actor.stat["SexEventScore"] += $game_player.actor.sex_limbs_atk+20+rand(40)
							$story_stats["sex_record_handjob_count"] +=1
							6.times{
								wait(30)
								lona_mood pose_handjob_mood_decider
								load_script("Data/Batch/chcg_whorework_frame_fapper.rb")
								check_over_event
								$game_player.actor.stat["SexEventLast"] = "Fapper"
							}
	end
	tmpCumIn = [true,false].sample if $story_stats["Setup_Hardcore"] <= 0 && tmpCumIn == nil
	if $game_player.actor.stat["SexEventInput"] == temp_tar_slot && !passive #win
		case temp_tar_slot #skill plus score
			when "vag"; 		damage = ($game_player.actor.sex_vag_atk+45+rand(80))
								$game_player.actor.stat["SexEventScore"] += damage
								ev_target.npc.stat.set_stat("arousal",ev_target.npc.stat.get_stat("arousal",0)+damage*2)
								if ev_target.actor.battle_stat.get_stat("arousal") > ev_target.actor.battle_stat.get_stat("will")
									ev_target.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicWhoreSexService_vag_crit"])
									tmpCumIn ? tmpCumDecide = "vag" : tmpCumDecide = "body"
									$game_map.interpreter.chcg_battle_sex_add_cums_to_player(tmpCumDecide,ev_target.actor.race)
									ev_target.actor.battle_stat.set_stat("arousal",0)
									ev_target.call_balloon(25)
								else
									ev_target.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicWhoreSexService_vag"])
								end
								
			when "anal"; 		damage = ($game_player.actor.sex_anal_atk+45+rand(80))
								$game_player.actor.stat["SexEventScore"] += damage
								ev_target.npc.stat.set_stat("arousal",ev_target.npc.stat.get_stat("arousal",0)+damage*2)
								if ev_target.actor.battle_stat.get_stat("arousal") > ev_target.actor.battle_stat.get_stat("will")
									ev_target.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicWhoreSexService_anal_crit"])
									tmpCumIn ? tmpCumDecide = "anal" : tmpCumDecide = "body"
									$game_map.interpreter.chcg_battle_sex_add_cums_to_player(tmpCumDecide,ev_target.actor.race)
									ev_target.actor.battle_stat.set_stat("arousal",0)
									ev_target.call_balloon(25)
								else
									ev_target.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicWhoreSexService_anal"])
								end
								
			when "mouth"; 		
								damage = ($game_player.actor.sex_mouth_atk+30+rand(50))
								$game_player.actor.stat["SexEventScore"] += damage
								ev_target.npc.stat.set_stat("arousal",ev_target.npc.stat.get_stat("arousal",0)+damage*2)
								if ev_target.actor.battle_stat.get_stat("arousal") > ev_target.actor.battle_stat.get_stat("will")
									ev_target.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicWhoreSexService_mouth_crit"])
									tmpCumIn ? tmpCumDecide = "mouth" : tmpCumDecide = "body"
									$game_map.interpreter.chcg_battle_sex_add_cums_to_player(tmpCumDecide,ev_target.actor.race)
									ev_target.actor.battle_stat.set_stat("arousal",0)
									ev_target.call_balloon(25)
								else
									ev_target.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicWhoreSexService_mouth"])
								end
								
			when "fapper"; 		damage = ($game_player.actor.sex_limbs_atk+20+rand(40))
								$game_player.actor.stat["SexEventScore"] += damage
								ev_target.npc.stat.set_stat("arousal",ev_target.npc.stat.get_stat("arousal",0)+damage*2)
								if ev_target.actor.battle_stat.get_stat("arousal") > ev_target.actor.battle_stat.get_stat("will")
									$story_stats["sex_record_frottage"] +=1
									tmpPartDmg = $data_arpgskills["BasicWhoreSexService_limbs_crit"]
									ev_target.actor.take_skill_effect($game_player.actor,tmpPartDmg)
									$game_map.interpreter.chcg_battle_sex_add_cums_to_player("body",ev_target.actor.race)
									ev_target.actor.battle_stat.set_stat("arousal",0)
									ev_target.call_balloon(25)
								else
									tmpPartDmg = $data_arpgskills["BasicWhoreSexService_limbs"]
									ev_target.actor.take_skill_effect($game_player.actor,tmpPartDmg)
								end
								
		end
		ev_target.npc.stat.set_stat("mood",100)
		SndLib.sys_Gain if !passive
		if passive != true && ev_target.balloon_id == 0
			ev_target.call_balloon(rand(2)+3)
		end
	else
		#LOSE
		ev_target.npc.stat.set_stat("mood",50)
		SndLib.sys_buzzer if !passive
		if passive != true && ev_target.balloon_id == 0
			ev_target.call_balloon(7)
		end
	end
	$game_player.crosshair.delete_crosshair if $game_player.crosshair
	$game_player.cancel_crosshair
	$game_player.state_sex_spread_to_fucker([ev_target]) if ev_target.actor
	$game_player.state_sex_spread_to_reciver([ev_target]) if ev_target.actor && [true,false].sample
	event_key_cleaner_whore_work
	return [ev_target,temp_tar_slot,passive,tmpCumIn,pose,tmpAniStage,plus,loopAniMode]
end

	def play_sex_service_chcg(ev_target,tmpCumIn=nil)
		race= ev_target.actor.race
		ev_target.actor.play_sound(:sound_death,100,110)
		wait(60)
		event_key_cleaner_whore_work
		if $game_player.actor.stat["SexEventLast"] != "Fapper"
			$game_player.actor.stat["Event#{$game_player.actor.stat["SexEventLast"]}Race"] = race
			$game_player.actor.stat["Event#{$game_player.actor.stat["SexEventLast"]}"] = "CumInside1"
			
			if tmpCumIn == true
				case $game_player.actor.stat["SexEventTotalScore"]
					when 0..100		; temp_score = "_CumInside"
					when 101..200	; temp_score = "_CumInside"
					when 201..400	; temp_score = "_CumInside_Overcum"
					when 401..800	; temp_score = "_CumInside_Peein"
					else 			; temp_score = "_CumInside_Overcum_Peein"
				end
			elsif tmpCumIn == false
				case $game_player.actor.stat["SexEventTotalScore"]
					when 0..100		; temp_score = "_CumOutside"
					when 101..200	; temp_score = "_CumOutside"
					when 201..400	; temp_score = "_CumOutside"
					when 401..800	; temp_score = "_CumOutside"
					else 			; temp_score = "_CumOutside"
				end
			else
				case $game_player.actor.stat["SexEventTotalScore"]
					when 0..100		; temp_score = "_CumInside"
					when 101..200	; temp_score = "_CumOutside"
					when 201..400	; temp_score = "_CumInside_Overcum"
					when 401..800	; temp_score = "_CumInside_Peein"
					else 			; temp_score = "_CumInside_Overcum_Peein"
				end
			end
	
			load_script("Data/HCGframes/Event#{$game_player.actor.stat["SexEventLast"]}#{temp_score}.rb")
		elsif $game_player.actor.stat["SexEventLast"] == "Fapper"
			temp_slot= rand(4)+1
			$game_player.actor.stat["EventExt#{temp_slot}"] = "FapperCuming1"
			$game_player.actor.stat["EventExt#{temp_slot}Race"] = race
			load_script("Data/HCGframes/Ext#{temp_slot}_Fapper.rb")
		end
		event_key_cleaner_whore_work
	end




end #module
