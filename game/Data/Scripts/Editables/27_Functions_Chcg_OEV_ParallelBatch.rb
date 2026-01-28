#batch for event character in EvLib


class Game_Event < Game_Character
	def batch_checkOev_setup
		$game_player.actor.event_key_combat_end
		@summon_data = {} if !@summon_data
		@tmpRound = 0
		@tmpStartRound = 0
		@seenByNPC = false
		@wait_count = 30
		moveto(1,1)
		if $game_player.actor.stat["AllowOgrasm"] == true
			$game_player.actor.stat["allow_ograsm_record"] = true
		else 
			$game_player.actor.stat["allow_ograsm_record"] = false
		end
	end

	def process_prostitution_inputs
		unless $game_map.interpreter.running?
			$game_player.cancel_crosshair
			return self.delete_crosshair
		end
		@updateCount = 0 if !@updateCount
		@updateSndCount = 0 if !@updateSndCount
		@pressCount = 0 if !@pressCount
		return if @summon_data[:passive]
		return if !@summon_data[:plus]
		return if !@summon_data[:target]
		return if $game_message.busy?
		plus = @summon_data[:plus]
		p "SexEventTotalScore #{$game_player.actor.stat["SexEventTotalScore"]}"
		p "SexEventScore #{$game_player.actor.stat["SexEventScore"]}"
		p "updateCount #{@updateCount}"
		@updateCount += 1
		@updateSndCount += 1
		if Input.trigger?($game_player.hotkey_skill_normal)
			tmpPressed = true
			$game_player.actor.stat["SexEventInput"] = "vag"
		elsif Input.trigger?($game_player.hotkey_skill_heavy)
			tmpPressed = true
			$game_player.actor.stat["SexEventInput"] = "anal"
		elsif Input.trigger?($game_player.hotkey_skill_control)
			tmpPressed = true
			$game_player.actor.stat["SexEventInput"] = "mouth"
		elsif Input.trigger?($game_player.skill_hotkey_0)
			tmpPressed = true
			$game_player.actor.stat["SexEventInput"] = "fapper"
		else
			tmpPressed = false
		end
		if tmpPressed
			return if @updateCount < 2
			if $game_player.actor.stat["SexEventInput"] == @summon_data[:target]
				$game_player.jump_to_low($game_player.x,$game_player.y)
				@pressCount += 1
				@pressCount = [@pressCount,10].max
				SndLib.sound_chs_buchu(100,100)
				@updateCount = 0
				if @pressCount < 12
					tmpVal=25
					tmpVal = (tmpVal*plus).round
					$game_player.actor.stat["SexEventScore"] += tmpVal
					$game_map.popup(0,tmpVal,812,1)
					#$game_party.gain_gold(tmpVal)
					#SndLib.sys_Gain(100,200)
				end
				$game_map.interpreter.flash_screen(Color.new(125,20,125,50),8,false)
				$game_map.interpreter.screen.start_shake(10,15,6)
				case $game_player.actor.stat["SexEventInput"]
					when "vag"
						$game_map.interpreter.lona_mood "p4shame"
						$game_player.actor.stat["EventVag"] = 		$game_map.interpreter.pose_GenCommonPenisKey($game_player.actor.stat["EventVag"])
					when "anal"
						$game_map.interpreter.lona_mood "p4shame"
						$game_player.actor.stat["EventAnal"] = 		$game_map.interpreter.pose_GenCommonPenisKey($game_player.actor.stat["EventAnal"])
					when "mouth"
						$game_map.interpreter.lona_mood "p5shame"
						$game_player.actor.stat["EventMouth"] = 	$game_map.interpreter.pose_GenCommonPenisKey($game_player.actor.stat["EventMouth"])
					when "fapper"
						$game_map.interpreter.lona_mood($game_map.interpreter.pose_handjob_mood_decider)
				end
			else
				tmpVal = 50
				tmpVal = (tmpVal*plus).round
				#$game_party.lose_gold(tmpVal)
				$game_player.actor.stat["SexEventScore"] -= tmpVal
				$game_player.actor.stat["SexEventScore"] = [0,$game_player.actor.stat["SexEventScore"]].max
				$game_map.popup(0,tmpVal,812,-1)
				#$game_player.actor.stat["SexEventScore"] -= 50
				SndLib.sys_buzzer(70,150)
			end
		end
	end
end


	
module GIM_OVC
	def parallel_overEvent_clearner
		#check_over_event(parallel=true)
		withDrugEV = false
		withOverEV = false
		$game_map.events.each{|event| 
			next if event[1] == get_character(0)
			next unless event[1].summon_data
			next unless event[1].summon_data[:DrugEFX] || event[1].summon_data[:OevEFX]
			withDrugEV = true if event[1].summon_data[:DrugEFX]
			withOverEV = true if event[1].summon_data[:OevEFX]
		}
		if !withDrugEV && !withOverEV
			$game_player.cannot_trigger = false
			$game_player.cannot_change_map = false
		end
		if !withOverEV
			$game_player.actor.stat["EventTargetPart"] = nil
			if $game_player.actor.stat["allow_ograsm_record"] == false
				$game_player.actor.stat["AllowOgrasm"] = false
			end
		end
	end
	def parallel_overEvent_popupMsg(tmpData)
		case tmpData
			when "Pee"
				if $game_player.actor.stat["ParasitedPotWorm"] >=1
					$game_map.popup(0,"commonH:Lona/Qmsg_OgrasmPolypWorm#{rand(3)}",0,0)
				else
					$game_map.popup(0,"commonH:Lona/Qmsg_pee#{rand(5)}",0,0)
				end
			when "Poo"
				if $game_player.actor.stat["ParasitedMoonWorm"] >=1
					$game_map.popup(0,"commonH:Lona/Qmsg_OgrasmPolypWorm#{rand(3)}",0,0)
				else
					$game_map.popup(0,"commonH:Lona/Qmsg_poo#{rand(5)}",0,0)
				end
			when "Milk" ; $game_map.popup(0,"commonH:Lona/Qmsg_MilkSpray#{rand(5)}",0,0)
			when "Itch" ; $game_map.popup(0,"commonH:Lona/Qmsg_MilkSpray#{rand(5)}",0,0)
			when "Vomit"
				if $game_player.actor.stat["ParasitedHookWorm"] >=1
					$game_map.popup(0,"commonH:Lona/Qmsg_OgrasmPolypWorm#{rand(3)}",0,0)
				else
					$game_map.popup(0,"commonH:Lona/Qmsg_beaten#{rand(10)}",0,0)
				end
			when "ArousalCumming"
				if $game_player.actor.stat["ParasitedPolypWorm"] >=1
					$game_map.popup(0,"commonH:Lona/Qmsg_OgrasmPolypWorm#{rand(3)}",0,0)
				else
					$game_map.popup(0,"commonH:Lona/Qmsg_cumming_normal#{rand(11)}",0,0)
				end
			when "ArousalOverCumming"
				if $game_player.actor.stat["ParasitedPolypWorm"] >=1
					$game_map.popup(0,"commonH:Lona/Qmsg_OgrasmPolypWorm#{rand(3)}",0,0)
				else
					$game_map.popup(0,"commonH:Lona/Qmsg_over_cumming_normal#{rand(11)}",0,0)
				end
			when "Madness" ; $game_map.popup(0,"QuickMsg:Lona/MadnessMode#{rand(10)}",0,0)
			when "LewdCrazy" ; $game_map.popup(0,"QuickMsg:Lona/MadnessMode#{rand(10)}",0,0)
			#when "Preg2" ; $game_map.popup(0,"QuickMsg:Lona/MadnessMode#{rand(10)}",0,0)
			when "Preg3Pain" ; $game_map.popup(0,"commonH:Lona/Qmsg_beaten#{rand(10)}",0,0)
			when "Preg4Pain" ; $game_map.popup(0,"commonH:Lona/Qmsg_beaten#{rand(10)}",0,0)
			else ; $game_map.popup(0,"......",0,0)
		end
	end
end #module


############################################################################################################################## Pee PEE
############################################################################################################################## Pee PEE
############################################################################################################################## Pee PEE
############################################################################################################################## Pee PEE
############################################################################################################################## Pee PEE
class Game_Event < Game_Character
	def batch_checkOev_setup_Pee
		SndLib.sound_QuickDialog
		$game_map.popup(0,"commonH:Lona/Qmsg_Oev_Pee",0,0)
		$game_player.actor.stat["AllowOgrasm"] = true if $game_player.actor.state_stack(105) !=0
		$game_player.actor.stat["AllowOgrasm"]=true if $game_player.actor.stat["AsVulva_Urethra"]==1
		$game_player.actor.stat["EventTargetPart"] = "Pee"
		$game_portraits.lprt.hide
		$game_player.actor.urinary_level =0
		$game_player.actor.add_state(28)

		@temp_1st_worm = rand(100)
		
		$game_player.cannot_trigger = "Pee"
		$game_player.cannot_change_map = true
	end

	def batch_checkOev_Pee_start
		case @tmpStartRound
			when 0
				$game_player.actor.add_state("Slow3") #slow3
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4shame" : "shy"
			when 1
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4shame" : "shy"
			when 2
				$game_player.call_balloon(1)
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "hurt"
				$game_player.actor.portrait.shake
			when 3
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4health_damage" : "pain"
				$game_player.actor.portrait.shake
			when 4
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4crit_damage" : "bereft"
				$game_player.actor.portrait.shake
		end
		@tmpStartRound += 1
		SndLib.sound_Heartbeat(70,110)
		$game_map.interpreter.flash_screen(Color.new(255,255,0,20),4,false)
		@wait_count = 28+rand(8)
	end
	def batch_checkOev_Pee_out
		@tmpRound += 1
		$game_player.actor.add_state("Slow3") #slow3
		$game_player.actor.force_shock("Stun1") if !$game_player.action_state_parallel_block? && $game_player.actor.action_state != :stun
		$game_player.actor.stat["EffectPee"] = 1
		$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4pee" : "p5pee"
		load_script("Data/Batch/pee_control.rb")
		$game_map.popup(0,"commonH:Lona/Qmsg_pee#{rand(5)}",0,0)
		if !@seenByNPC && $game_player.innocent_spotted?
			@seenByNPC = true
			$story_stats["sex_record_seen_peeing"] +=1
		end
		if $game_player.actor.state_stack("ParasitedPotWorm") !=0 #控制寄生蟲
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPotWorm") >=1 && @tmpRound == 1 && @temp_1st_worm >= 50
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPotWorm") >=2 && rand(100) >=50 && @tmpRound == 2
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPotWorm") >=3 && rand(100) >=50 && @tmpRound == 3
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPotWorm") >=4 && rand(100) >=50 && @tmpRound == 4
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPotWorm") >=5 && rand(100) >=50 && @tmpRound == 5
			if needPlayParasiteDialog
				EvLib.sum("PlayerAbominationPotWorm",$game_player.x,$game_player.y)
				$game_player.actor.urinary_damage += 150
				$story_stats["sex_record_birth_PotWorm"] +=1
				if rand(100)>= 70
					SndLib.sound_chs_dopyu
					$game_map.interpreter.parallel_overEvent_popupMsg($game_player.cannot_trigger)
				end
				SndLib.sound_QuickDialog
			end
		end
		@wait_count = 28+rand(8)
	end
end #class

module GIM_OVC
	def parallel_Oev_Pee_clearner
		$game_player.actor.stat["EffectPee"] = 0
		$story_stats["sex_record_peed"] +=1
		EvLib.sum("ProjectilePee",$game_player.x,$game_player.y)
		parallel_overEvent_clearner
	end
end #module



############################################################################################################################## PooPoo
############################################################################################################################## PooPoo
############################################################################################################################## PooPoo
############################################################################################################################## PooPoo
############################################################################################################################## PooPoo
class Game_Event < Game_Character
	def batch_checkOev_setup_Poo
		SndLib.sound_QuickDialog
		$game_map.popup(0,"commonH:Lona/Qmsg_Oev_Poo",0,0)
		$game_player.actor.stat["AllowOgrasm"] = true if $game_actors[1].state_stack(105) !=0
		$game_player.actor.stat["AllowOgrasm"] = true if $game_player.actor.stat["AsVulva_Anal"] ==1
		$game_player.actor.stat["EventTargetPart"] = "Poo"
		$game_portraits.lprt.hide
		$game_player.actor.defecate_level =0
		@temp_1st_worm = rand(100)
		$game_player.cannot_trigger = "Poo"
		$game_player.cannot_change_map = true
	end

	def batch_checkOev_Poo_start
		case @tmpStartRound
			when 0
				$game_player.actor.add_state("Slow3") #slow3
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4shame" : "shy"
			when 1
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4shame" : "shy"
			when 2
				$game_player.call_balloon(1)
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "hurt"
				$game_player.actor.portrait.shake
			when 3
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4health_damage" : "pain"
				$game_player.actor.portrait.shake
			when 4
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4crit_damage" : "bereft"
				$game_player.actor.portrait.shake
		end
		@tmpStartRound += 1
		SndLib.sound_Heartbeat(70,110)
		SndLib.sound_chs_dopyu(80,50+rand(15))
		$game_map.interpreter.flash_screen(Color.new(173,96,20,20),4,false)
		@wait_count = 28+rand(8)
	end
	
	def batch_checkOev_Poo_out
		@tmpRound += 1
		$game_player.actor.add_state("Slow3") #slow3
		$game_player.actor.force_shock("Stun1") if !$game_player.action_state_parallel_block? && $game_player.actor.action_state != :stun
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent"
		$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "p5sta_damage"
		load_script("Data/Batch/poo_control.rb")
		$game_map.popup(0,"commonH:Lona/Qmsg_poo#{rand(5)}",0,0)
		$game_player.actor.add_state("EffectScat") if $game_player.actor.stat["EffectScat"] < 1
		if !@seenByNPC && $game_player.innocent_spotted?
			@seenByNPC = true
			$story_stats["sex_record_seen_shat"] +=1
		end
		if $game_player.actor.state_stack("ParasitedMoonWorm") !=0 #控制寄生蟲
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedMoonWorm") >=1 && @tmpRound == 1 && @temp_1st_worm >= 50
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedMoonWorm") >=2 && rand(100) >=50 && @tmpRound == 2
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedMoonWorm") >=3 && rand(100) >=50 && @tmpRound == 3
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedMoonWorm") >=4 && rand(100) >=50 && @tmpRound == 4
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedMoonWorm") >=5 && rand(100) >=50 && @tmpRound == 5
			if needPlayParasiteDialog
				EvLib.sum("PlayerAbominationMoonWorm",$game_player.x,$game_player.y)
				$game_player.actor.anal_damage += 150
				$story_stats["sex_record_birth_MoonWorm"] +=1
				if rand(100)>= 70
					SndLib.sound_chs_dopyu
					$game_map.interpreter.parallel_overEvent_popupMsg($game_player.cannot_trigger)
				end
				SndLib.sound_QuickDialog
			end
		end
		@wait_count = 28+rand(8)
	end
	
end #Class

module GIM_OVC
	def parallel_Oev_Poo_clearner
		temp_Cums =$game_player.actor.cumsMeters["CumsMoonPie"]
		$game_player.actor.healCums("CumsMoonPie", ((temp_Cums * 0.5).round)+$game_player.actor.constitution)
		$game_player.actor.stat["EventAnal"] = nil
		$story_stats["sex_record_shat"] +=1
		EvLib.sum("ProjectilePoo",$game_player.x,$game_player.y)
		parallel_overEvent_clearner
	end
end #module


############################################################################################################################## Milk
############################################################################################################################## Milk
############################################################################################################################## Milk
############################################################################################################################## Milk
############################################################################################################################## Milk
class Game_Event < Game_Character
	def batch_checkOev_setup_Milk
		SndLib.sound_QuickDialog
		$game_map.popup(0,"commonH:Lona/Qmsg_Oev_Milk",0,0)
		$game_player.actor.stat["AllowOgrasm"] = true if $game_player.actor.stat["AsVulva_MilkGland"] ==1 || $game_player.actor.stat["AsVulva_Skin"] ==1
		$game_player.actor.stat["EventTargetPart"] = "Milking"
		$game_portraits.lprt.hide
		$game_player.cannot_trigger = "Milk"
		$game_player.cannot_change_map = true
		@tmpRoundMax = 0
		until $game_player.actor.lactation_level <=500
			$game_player.actor.lactation_level -= 100+rand(100)
			@tmpRoundMax += 1
		end
	end

	def batch_checkOev_Milk_start
		case @tmpStartRound
			when 0
				$game_player.actor.add_state("Slow3") #slow3
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4shame" : "shy"
			when 1
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4shame" : "shy"
			when 2
				$game_player.call_balloon(1)
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "hurt"
				$game_player.actor.portrait.shake
			when 3
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "hurt"
				$game_player.actor.portrait.shake
			when 4
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4health_damage" : "pain"
				$game_player.actor.portrait.shake
		end
		@tmpStartRound += 1
		SndLib.sound_Heartbeat(70,110)
		$game_map.interpreter.flash_screen(Color.new(255,255,255,20),4,false)
		@wait_count = 28+rand(8)
	end
	
	def batch_checkOev_Milk_out
		@tmpRound += 1
		$game_player.actor.force_shock("Stun1") if !$game_player.action_state_parallel_block? && $game_player.actor.action_state != :stun
		$game_player.actor.stat["MilkSplash"] = 1
		$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4pee" : "p5pee"
		load_script("Data/Batch/MilkSplash_control.rb")
		$game_map.interpreter.parallel_overEvent_popupMsg($game_player.cannot_trigger)
		@wait_count = 28+rand(8)
	end
end #module


module GIM_OVC
	def parallel_Oev_Milk_clearner
		$game_player.actor.stat["MilkSplash"] = 0
		$story_stats["sex_record_MilkSplash"] +=1
		EvLib.sum("WasteMilk",$game_player.x,$game_player.y)
		parallel_overEvent_clearner
	end
end #module


############################################################################################################################## Itch
############################################################################################################################## Itch
############################################################################################################################## Itch
############################################################################################################################## Itch
############################################################################################################################## Itch

class Game_Event < Game_Character
	def batch_checkOev_setup_Itch
		SndLib.sound_QuickDialog
		$game_map.popup(0,"common:Lona/Qmsg_Oev_Itch#{rand(3)}",0,0)
		$game_player.actor.stat["AllowOgrasm"] = true if $game_player.actor.stat["Mod_VagGlandsLink"] ==1 || $game_player.actor.stat["AsVulva_Anal"] ==1
		$game_player.actor.stat["EventTargetPart"] = ["Vag","Anal"].sample
		$game_portraits.lprt.hide
		@temp_EventMouth = $game_player.actor.stat["EventMouth"]
		$game_player.cannot_trigger = "Itch"
		$game_player.cannot_change_map = true
	end
	
	def batch_checkOev_Itch_start
		case @tmpStartRound
			when 0
				$game_player.actor.add_state("Slow3") #slow3
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4defence" : "p5defence"
			when 1
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4defence" : "p5defence"
			when 2
				$game_player.call_balloon(1)
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4defence" : "p5defence"
				$game_player.actor.portrait.shake
			when 3
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "p5sta_damage"
				$game_player.actor.portrait.shake
			when 4
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "p5sta_damage"
				$game_player.actor.portrait.shake
		end
		SndLib.sound_Heartbeat(70,110)
		$game_map.interpreter.flash_screen(Color.new(207,255,20,20),4,false)
		@wait_count = 28+rand(8)
	end
	
	def batch_checkOev_Itch_out
		@tmpRound += 1
		$game_player.actor.force_cuming("Stun1") if !$game_player.action_state_parallel_block? && $game_player.actor.action_state != :stun
		$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "p5sta_damage"
		load_script("Data/Batch/itch_control.rb")
		$game_map.interpreter.parallel_overEvent_popupMsg($game_player.cannot_trigger)
		@wait_count = 28+rand(8)
	end
end #module

module GIM_OVC
	def parallel_Oev_Itch_clearner
		$game_map.interpreter.lona_mood "tired"
		$game_player.actor.stat["EventMouth"] = @temp_EventMouth
		parallel_overEvent_clearner
	end
end #module


############################################################################################################################## Vomit
############################################################################################################################## Vomit
############################################################################################################################## Vomit
############################################################################################################################## Vomit
############################################################################################################################## Vomit
class Game_Event < Game_Character
	def batch_checkOev_setup_Vomit
		SndLib.sound_QuickDialog
		$game_map.popup(0,"common:Lona/Qmsg_Oev_Puke",0,0)
		$game_player.actor.stat["AllowOgrasm"] = true if $game_player.actor.stat["AsVulva_Esophageal"] ==1
		$game_player.actor.stat["EventTargetPart"] = "Torture" if $game_player.actor.state_stack(106) !=0
		$game_portraits.lprt.hide
		@temp_EventMouth = $game_player.actor.stat["EventMouth"]
		$game_player.cannot_trigger = "Vomit"
		$game_player.cannot_change_map = true
		@temp_1st_worm = rand(100)
	end
	def batch_checkOev_Vomit_start
			case @tmpStartRound
				when 0
					$game_player.actor.add_state("Slow3") #slow3
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4defence" : "hurt"
				when 1
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4defence" : "pain"
				when 2
					$game_player.call_balloon(1)
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4defence" : "bereft"
					$game_player.actor.portrait.shake
				when 3
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "p5sta_damage"
					$game_player.actor.portrait.shake
				when 4
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "p5sta_damage"
					$game_player.actor.portrait.shake
			end
		SndLib.sound_Heartbeat(70,110)
		$game_map.interpreter.flash_screen(Color.new(207,255,20,20),4,false)
		@wait_count = 28+rand(8)
	end
	def batch_checkOev_Vomit_out
		@tmpRound += 1
		$game_player.actor.force_shock("Stun1") if !$game_player.action_state_parallel_block? && $game_player.actor.action_state != :stun
		$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4puke" : "p5puke"
		load_script("Data/Batch/puke_value_control.rb")
		$game_map.popup(0,"commonH:Lona/Qmsg_beaten#{rand(10)}",0,0)
		if $game_player.actor.state_stack("ParasitedHookWorm") !=0 #控制寄生蟲
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedHookWorm") >=1 && @tmpRound == 1 && @temp_1st_worm >= 50
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedHookWorm") >=2 && rand(100) >=50 && @tmpRound == 2
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedHookWorm") >=3 && rand(100) >=50 && @tmpRound == 3
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedHookWorm") >=4 && rand(100) >=50 && @tmpRound == 4
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedHookWorm") >=5 && rand(100) >=50 && @tmpRound == 5
			if needPlayParasiteDialog
				EvLib.sum("PlayerAbomCreatureMeatHookworm",$game_player.x,$game_player.y)
				$game_player.actor.anal_damage += 150
				$story_stats["sex_record_birth_HookWorm"] +=1
				if rand(100)>= 70
					SndLib.sound_chs_dopyu
					$game_map.interpreter.parallel_overEvent_popupMsg($game_player.cannot_trigger)
				end
				SndLib.sound_QuickDialog
			end
		end
		@wait_count = 28+rand(8)
	end
end #module

module GIM_OVC
	def parallel_Oev_Vomit_clearner
		#$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4puke" : "p5puke"
		$game_map.interpreter.lona_mood "tired"
		$game_player.actor.stat["EventMouth"] = @temp_EventMouth
		parallel_overEvent_clearner
	end
end #module

############################################################################################################################## ArousalWet
############################################################################################################################## ArousalWet
############################################################################################################################## ArousalWet
############################################################################################################################## ArousalWet
############################################################################################################################## ArousalWet
class Game_Event < Game_Character
	def batch_checkOev_setup_ArousalWet
		#SndLib.sound_Heartbeat(70,110)
		#$game_map.interpreter.flash_screen(Color.new(255,0,255,20),12,false)
		$game_player.actor.add_state("EffectWet") #add wet
		if $game_player.actor.stat["pose"] == "pose4"
			$game_map.interpreter.lona_mood "p4_#{$game_map.interpreter.chcg_shame_mood_decider}"
		else
			$game_map.interpreter.lona_mood "shy"  if $game_player.actor.stat["persona"] != "slut"
			$game_map.interpreter.lona_mood "lewd" if $game_player.actor.stat["persona"] == "slut"
		end
	end

	def batch_checkOev_ArousalWet_start
			case @tmpStartRound
				when 0
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_#{$game_map.interpreter.chcg_shame_mood_decider}" : "shy"
				when 1
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_#{$game_map.interpreter.chcg_shame_mood_decider}" : "shy"
				when 2
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_#{$game_map.interpreter.chcg_shame_mood_decider}" : "shy"
				when 3
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_#{$game_map.interpreter.chcg_shame_mood_decider}" : "shy"
				when 4
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_#{$game_map.interpreter.chcg_shame_mood_decider}" : "shy"
			end
		if @tmpStartRound == 4
			SndLib.sound_QuickDialog
			$game_player.actor.gain_exp(rand(65)+$game_player.actor.level)
			$game_map.popup(0,"commonH:Lona/Qmsg_wet#{$game_map.interpreter.talk_style}#{rand(3)}",0,0)
		end
		EvLib.sum("WasteWet",$game_player.x,$game_player.y)
		@tmpStartRound += 1
		SndLib.sound_Heartbeat(70,110)
		$game_map.interpreter.flash_screen(Color.new(255,0,255,20),12,false)
		@wait_count = 28+rand(8)
	end
end #module


############################################################################################################################## ArousalCumming
############################################################################################################################## ArousalCumming
############################################################################################################################## ArousalCumming
############################################################################################################################## ArousalCumming
############################################################################################################################## ArousalCumming

class Game_Event < Game_Character
	def batch_checkOev_setup_ArousalCumming
		SndLib.sound_QuickDialog
		$game_map.popup(0,"commonH:Lona/orgasm_begin",0,0)
		$game_portraits.lprt.hide
		$game_player.cannot_trigger = "ArousalCumming"
		$game_player.cannot_change_map = true
		@summon_data[:OevEFXCumming] = true
		@temp_1st_worm = rand(100)
	end
	def batch_checkOev_ArousalCumming_start
			case @tmpStartRound
				when 0
					$game_player.call_balloon(1)
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_#{$game_map.interpreter.chcg_shame_mood_decider}" : "hurt"
					$game_player.actor.portrait.shake
				when 1
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_#{$game_map.interpreter.chcg_shame_mood_decider}" : "pain"
					$game_player.actor.portrait.shake
				when 2
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_#{$game_map.interpreter.chcg_shame_mood_decider}" : "bereft"
					$game_player.actor.portrait.shake
			end
		SndLib.sound_Heartbeat(70,110)
		$game_map.interpreter.flash_screen(Color.new(255,0,255,20),12,false)
		@wait_count = 28+rand(8)
	end
	def batch_checkOev_ArousalCumming_out
		@tmpRound += 1
		$game_player.actor.force_cuming("Stun1") if !$game_player.action_state_parallel_block? && $game_player.actor.action_state != :stun
		$game_player.actor.stat["EffectPee"] = 2
		$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_#{$game_map.interpreter.chcg_shame_mood_decider}" : "p5_#{$game_map.interpreter.chcg_cumming_mood_decider}"
		$game_map.popup(0,"commonH:Lona/Qmsg_cumming#{$game_map.interpreter.talk_style}#{rand(10)}",0,0) if rand(100)>= 70
		load_script("Data/Batch/cuming_control.rb")
		EvLib.sum("WasteWet",$game_player.x,$game_player.y)
		if $game_player.actor.state_stack("ParasitedPolypWorm") !=0 #控制寄生蟲
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPolypWorm") >=1 && @tmpRound == 1 && @temp_1st_worm >= 50
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPolypWorm") >=2 && rand(100) >=50 && @tmpRound == 2
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPolypWorm") >=3 && rand(100) >=50 && @tmpRound == 3
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPolypWorm") >=4 && rand(100) >=50 && @tmpRound == 4
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPolypWorm") >=5 && rand(100) >=50 && @tmpRound == 5
			if needPlayParasiteDialog
				EvLib.sum("AbomPolypWormBaby",$game_player.x,$game_player.y,{:user=>$game_player})
				$game_player.actor.vag_damage += 150
				$story_stats["sex_record_birth_PolypWorm"] +=1
				if rand(100)>= 70
					SndLib.sound_chs_dopyu
					$game_map.interpreter.parallel_overEvent_popupMsg($game_player.cannot_trigger) if rand(100)>= 70
				end
				SndLib.sound_QuickDialog
			end
		end
		@wait_count = 28+rand(8)
	end
end #module


module GIM_OVC
	def parallel_Oev_ArousalCumming_clearner
		$game_player.actor.add_state("Cummed") #add just cummed
		$game_player.actor.add_state("EffectWet") if $game_player.actor.stat["EffectWet"] ==0  #add wet
		case $game_player.actor.stat["EventTargetPart"]
			when nil 		;	p "Unknow Ograsm"
			when "Mouth"	;	$story_stats["sex_record_orgasm_Mouth"]		+=1
			when "Torture"	;	$story_stats["sex_record_orgasm_Torture"]	+=1
			when "Vag"		;	$story_stats["sex_record_orgasm_Vag"]		+=1
			when "Milking"	;	$story_stats["sex_record_orgasm_Milking"]	+=1
			when "Pee"		;	$story_stats["sex_record_orgasm_Pee"]		+=1
			when "Poo"		;	$story_stats["sex_record_orgasm_Poo"]		+=1
			when "Birth"	;	$story_stats["sex_record_orgasm_Birth"]		+=1
			when "Anal"		;	$story_stats["sex_record_orgasm_Anal"]		+=1
			when "Semen"	;	$story_stats["sex_record_orgasm_Semen"]		+=1
			when "Breast"	;	$story_stats["sex_record_orgasm_Breast"]	+=1
			when "Shame"	;	$story_stats["sex_record_orgasm_Shame"]		+=1
		end
		#$game_map.popup(0,"commonH:Lona/orgasm_end",0,0)
		$story_stats["sex_record_orgasm"] +=1
		$game_player.actor.stat["EffectPee"] = 0
		parallel_overEvent_clearner
	end
end #module


############################################################################################################################## Arousal OVER Cumming
############################################################################################################################## Arousal OVER Cumming
############################################################################################################################## Arousal OVER Cumming
############################################################################################################################## Arousal OVER Cumming
############################################################################################################################## Arousal OVER Cumming
class Game_Event < Game_Character
	def batch_checkOev_setup_ArousalOverCumming
		SndLib.sound_QuickDialog
		$game_map.popup(0,"commonH:Lona/over_orgasm_begin",0,0)
		$game_portraits.lprt.hide
		$game_player.cannot_trigger = "ArousalOverCumming"
		$game_player.cannot_change_map = true
		@summon_data[:OevEFXCumming] = true
		@temp_1st_worm = rand(100)
	end
	def batch_checkOev_ArousalOverCumming_start
			case @tmpStartRound
				when 0
					$game_player.call_balloon(1)
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_#{$game_map.interpreter.chcg_shame_mood_decider}" : "hurt"
					$game_player.actor.portrait.shake
				when 1
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_#{$game_map.interpreter.chcg_shame_mood_decider}" : "pain"
					$game_player.actor.portrait.shake
				when 2
					$game_player.call_balloon(6)
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_cuming_ahegao" : "pain"
					$game_player.actor.portrait.shake
			end
		SndLib.sound_Heartbeat(70,110)
		$game_map.interpreter.flash_screen(Color.new(255,0,255,20),12,false)
		@wait_count = 28+rand(8)
	end
	def batch_checkOev_ArousalOverCumming_out
		@tmpRound += 1
		$game_player.actor.force_pindown("Stun1") if !$game_player.action_state_parallel_block? && $game_player.actor.action_state != :stun
		$game_player.actor.stat["EffectPee"] = 2
		$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4_#{$game_map.interpreter.chcg_shame_mood_decider}" : "p5_#{$game_map.interpreter.chcg_cumming_mood_decider}"
		$game_map.popup(0,"commonH:Lona/Qmsg_over_cumming#{$game_map.interpreter.talk_style}#{rand(10)}",0,0) if rand(100)>= 70
		load_script("Data/Batch/overcuming_control.rb")
		EvLib.sum("WasteWet",$game_player.x,$game_player.y)
		if $game_player.actor.state_stack("ParasitedPolypWorm") !=0 #控制寄生蟲
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPolypWorm") >=1 && @tmpRound == 1 && @temp_1st_worm >= 50
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPolypWorm") >=2 && rand(100) >=50 && @tmpRound == 2
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPolypWorm") >=3 && rand(100) >=50 && @tmpRound == 3
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPolypWorm") >=4 && rand(100) >=50 && @tmpRound == 4
			needPlayParasiteDialog = true if $game_player.actor.state_stack("ParasitedPolypWorm") >=5 && rand(100) >=50 && @tmpRound == 5
			if needPlayParasiteDialog
				EvLib.sum("AbomPolypWormBaby",$game_player.x,$game_player.y,{:user=>$game_player})
				$game_player.actor.vag_damage += 150
				$story_stats["sex_record_birth_PolypWorm"] +=1
				if rand(100)>= 70
					SndLib.sound_chs_dopyu
					$game_map.interpreter.parallel_overEvent_popupMsg($game_player.cannot_trigger) if rand(100)>= 70
				end
				SndLib.sound_QuickDialog
			end
		end
		@wait_count = 28+rand(8)
	end
end #module


module GIM_OVC
	def parallel_Oev_ArousalOverCumming_clearner
		$game_player.actor.add_state("Cummed")
		$game_player.actor.add_state("OverCummed")
		$game_player.actor.add_state("EffectWet") if $game_player.actor.stat["EffectWet"] == 0
		case $game_player.actor.stat["EventTargetPart"]
			when nil 		;	p "Unknow Ograsm"
			when "Mouth"	;	$story_stats["sex_record_orgasm_Mouth"]		+=1
			when "Torture"	;	$story_stats["sex_record_orgasm_Torture"]	+=1
			when "Vag"		;	$story_stats["sex_record_orgasm_Vag"]		+=1
			when "Milking"	;	$story_stats["sex_record_orgasm_Milking"]	+=1
			when "Pee"		;	$story_stats["sex_record_orgasm_Pee"]		+=1
			when "Poo"		;	$story_stats["sex_record_orgasm_Poo"]		+=1
			when "Birth"	;	$story_stats["sex_record_orgasm_Birth"]		+=1
			when "Anal"		;	$story_stats["sex_record_orgasm_Anal"]		+=1
			when "Semen"	;	$story_stats["sex_record_orgasm_Semen"]		+=1
			when "Breast"	;	$story_stats["sex_record_orgasm_Breast"]	+=1
			when "Shame"	;	$story_stats["sex_record_orgasm_Shame"]		+=1
		end
		#$game_map.popup(0,"commonH:Lona/orgasm_end",0,0)
		$story_stats["sex_record_orgasm"] +=1
		$story_stats["sex_record_mindbreak"] +=1
		$game_player.actor.stat["EffectPee"] = 0
		parallel_overEvent_clearner
	end
end #module





############################################################################################################################## preg 
############################################################################################################################## preg 
############################################################################################################################## preg 
############################################################################################################################## preg 
############################################################################################################################## preg 
########################################################################### Preg1 Vomit
########################################################################### Preg1 Vomit
########################################################################### Preg1 Vomit
########################################################################### Preg1 Vomit
########################################################################### get most function from vomit
class Game_Event < Game_Character
	def batch_checkOev_Vomit_PregLv1Msg
		@pregCount = 0 if !@pregCount
		return if !@summon_data[:PregModeExped]
		case @pregCount
			when 0
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,255,20),12,false)
				return @wait_count = 60
			when 1
				@pregCount += 1
				$game_map.interpreter.lona_mood "sad" if $game_player.actor.stat["pose"] != "pose4"
				$game_map.popup(0,"common:Lona/preglv1_Qmsg_puke_exped0",0,0)
				SndLib.sound_QuickDialog
				$game_portraits.rprt.focus
				return @wait_count = 10
			when 2
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,255,20),12,false)
				return @wait_count = 120
			when 3
				@pregCount += 1
				$game_map.interpreter.lona_mood "confused" if $game_player.actor.stat["pose"] != "pose4"
				$game_map.popup(0,"common:Lona/preglv1_Qmsg_puke_exped1",0,0)
				SndLib.sound_QuickDialog
				$game_portraits.rprt.focus
				return @wait_count = 10
				
		end
	end
end #module
########################################################################### Preg2 begin
########################################################################### Preg2 begin
########################################################################### Preg2 begin
########################################################################### Preg2 begin
class Game_Event < Game_Character
	def batch_checkOev_setup_PregLv2Begin
		SndLib.sound_QuickDialog
		$game_map.popup(0,"common:Lona/preg_lv2_Qmsg",0,0)
		$game_portraits.lprt.hide
		$game_player.cannot_trigger = "Preg2"
		$game_player.cannot_change_map = true
	end
	def batch_checkOev_PregLv2Begin_start
		case @tmpStartRound
			when 0
				$game_map.interpreter.lona_mood "shy" if $game_player.actor.stat["pose"] != "pose4"
			when 1
				$game_map.interpreter.lona_mood "sad" if $game_player.actor.stat["pose"] != "pose4"
			when 2
				$game_map.interpreter.lona_mood "sad" if $game_player.actor.stat["pose"] != "pose4"
			when 3
				$game_map.interpreter.lona_mood "tired" if $game_player.actor.stat["pose"] != "pose4"
			when 4
				$game_map.interpreter.lona_mood "tired" if $game_player.actor.stat["pose"] != "pose4"
		end
		@tmpStartRound += 1
		SndLib.sound_Heartbeat(70,110)
		$game_map.interpreter.flash_screen(Color.new(255,0,255,20),12,false)
		@wait_count = 28+rand(8)
	end

	def batch_checkOev_PregLv2BeginMsg
		@pregCount = 0 if !@pregCount
		case @pregCount
			when 0
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,255,20),12,false)
				return @wait_count = 60
			when 1
				@pregCount += 1
				$game_map.interpreter.lona_mood "confused" if $game_player.actor.stat["pose"] != "pose4"
				$game_map.popup(0,"common:Lona/preg_lv2_Qmsg",0,0)
				SndLib.sound_QuickDialog
				$game_portraits.rprt.focus
				return @wait_count = 10
		end
		return if !@summon_data[:PregModeExped]
		case @pregCount
			when 2
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,255,20),12,false)
				return @wait_count = 120
			when 3
				@pregCount += 1
				$game_map.interpreter.lona_mood "shy" if $game_player.actor.stat["pose"] != "pose4"
				$game_map.popup(0,"common:Lona/preg_lv2_exped_Qmsg0",0,0)
				SndLib.sound_QuickDialog
				$game_portraits.rprt.focus
				return @wait_count = 10
			when 4
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,255,20),12,false)
				return @wait_count = 120
			when 5
				@pregCount += 1
				$game_map.interpreter.lona_mood "fear" if $game_player.actor.stat["pose"] != "pose4"
				$game_map.popup(0,"common:Lona/preg_lv2_exped_Qmsg1",0,0)
				SndLib.sound_QuickDialog
				$game_portraits.rprt.focus
				return @wait_count = 10
				
		end
	end
end #module
module GIM_OVC
	def parallel_Oev_PregLv2Begin_clearner
		$game_map.interpreter.lona_mood "tired" if $game_player.actor.stat["pose"] != "pose4"
		parallel_overEvent_clearner
	end
end #module
########################################################################### Preg2 Vomit
########################################################################### Preg2 Vomit
########################################################################### Preg2 Vomit
########################################################################### Preg2 Vomit
########################################################################### get most function from vomit
class Game_Event < Game_Character
	def batch_checkOev_setup_Vomit_PregLv2
		$game_map.popup(0,"common:Lona/preglv2_Qmsg_puke",0,0)
	end
end #module
########################################################################### Preg3 begin
########################################################################### Preg3 begin
########################################################################### Preg3 begin
########################################################################### Preg3 begin
########################################################################### get most function from preg2begin
class Game_Event < Game_Character

	def batch_checkOev_setup_PregLv3Begin
		$game_player.cannot_trigger = "Preg3"
		$game_player.cannot_change_map = true
	end
	def batch_checkOev_PregLv3BeginMsg
		@pregCount = 0 if !@pregCount
		case @pregCount
			when 0
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,255,20),12,false)
				return @wait_count = 60
			when 1
				@pregCount += 1
				$game_map.interpreter.lona_mood "shocked" if $game_player.actor.stat["pose"] != "pose4"
				$game_map.popup(0,"common:Lona/preglv3_Qmsg0",0,0)
				SndLib.sound_QuickDialog
				$game_player.actor.portrait.shake
				return @wait_count = 10
			when 2
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,255,20),12,false)
				return @wait_count = 120
			when 3
				@pregCount += 1
				$game_map.interpreter.lona_mood "fear" if $game_player.actor.stat["pose"] != "pose4"
				$game_map.popup(0,"common:Lona/preglv3_Qmsg1",0,0)
				SndLib.sound_QuickDialog
				$game_portraits.rprt.focus
				return @wait_count = 10
		end
	end
end #module
########################################################################### Preg3 pain
########################################################################### Preg3 pain
########################################################################### Preg3 pain
########################################################################### Preg3 pain
class Game_Event < Game_Character
	def batch_checkOev_setup_PregLv3Pain
		$game_map.interpreter.lona_mood "pain" if $game_player.actor.stat["pose"] != "pose4"
		SndLib.sound_QuickDialog
		$game_map.popup(0,"common:Lona/preglv3_Qmsg_pain0",0,0)
		$game_portraits.lprt.hide
		$game_player.cannot_trigger = "Preg3Pain"
		$game_player.cannot_change_map = true
	end
	def batch_checkOev_PregLv3Pain_start
		case @tmpStartRound
			when 0
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4defence" : "hurt"
			when 1
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4defence" : "pain"
			when 2
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4defence" : "bereft"
			when 3
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "p5sta_damage"
			when 4
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "p5sta_damage"
		end
		@tmpStartRound += 1
		$game_player.actor.add_state("Slow3") #slow3
		$game_player.actor.portrait.shake
		SndLib.sound_Heartbeat(70,110)
		$game_map.interpreter.flash_screen(Color.new(255,0,0,20),4,false)
		@wait_count = 28+rand(8)
	end
	def batch_checkOev_PregLv3Pain_out
		@tmpRound += 1
		$game_player.actor.force_stun("Stun1") if !$game_player.action_state_parallel_block? && $game_player.actor.action_state != :stun
		load_script("Data/Batch/common_stats_damage_sta.rb")
		$game_map.popup(0,"commonH:Lona/Qmsg_beaten#{rand(10)}",0,0)
		@wait_count = 80
	end
end #module
module GIM_OVC
	def parallel_Oev_PregLv3Pain_clearner
		SndLib.sound_QuickDialog
		$game_map.popup(0,"common:Lona/preglv3_Qmsg_pain1",0,0)
		$game_map.interpreter.lona_mood "tired" if $game_player.actor.stat["pose"] != "pose4"
		parallel_overEvent_clearner
	end
end #module
########################################################################### Preg4 begin
########################################################################### Preg4 begin
########################################################################### Preg4 begin
########################################################################### Preg4 begin
class Game_Event < Game_Character
	def batch_checkOev_PregLv4BeginMsg
		@pregCount = 0 if !@pregCount
		case @pregCount
			when 0
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,0,20),12,false)
				return @wait_count = 60
			when 1
				@pregCount += 1
				$game_map.interpreter.lona_mood "pain" if $game_player.actor.stat["pose"] != "pose4"
				$game_map.popup(0,"common:Lona/preglv4_Qmsg0",0,0)
				SndLib.sound_QuickDialog
				$game_portraits.rprt.focus
				return @wait_count = 10
			when 2
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,0,20),12,false)
				return @wait_count = 120
			when 3
				@pregCount += 1
				$game_map.interpreter.lona_mood "fear" if $game_player.actor.stat["pose"] != "pose4"
				$game_map.popup(0,"common:Lona/preglv4_Qmsg1",0,0)
				SndLib.sound_QuickDialog
				$game_portraits.rprt.focus
				return @wait_count = 10
		end
		return if !@summon_data[:PregModeWeak]
		case @pregCount
			when 4
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,0,20),12,false)
				return @wait_count = 120
			when 5
				@pregCount += 1
				$game_map.interpreter.lona_mood "shy" if $game_player.actor.stat["pose"] != "pose4"
				$game_map.popup(0,"common:Lona/preglv4_Qmsg_weak0",0,0)
				SndLib.sound_QuickDialog
				$game_portraits.rprt.focus
				return @wait_count = 10
			when 6
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,0,20),12,false)
				return @wait_count = 120
			when 7
				@pregCount += 1
				$game_map.interpreter.lona_mood "bereft" if $game_player.actor.stat["pose"] != "pose4"
				$game_map.popup(0,"common:Lona/preglv4_Qmsg_weak1",0,0)
				SndLib.sound_QuickDialog
				$game_portraits.rprt.focus
				return @wait_count = 10
				
		end
	end
end #module



########################################################################### Preg4 pain
########################################################################### Preg4 pain
########################################################################### Preg4 pain
########################################################################### Preg4 pain
class Game_Event < Game_Character
	def batch_checkOev_setup_PregLv4Pain
		$game_map.interpreter.lona_mood "sad" if $game_player.actor.stat["pose"] != "pose4"
		SndLib.sound_QuickDialog
		$game_map.popup(0,"common:Lona/preglv4_pain_Qmsg0",0,0)
		$game_portraits.lprt.hide
		$game_player.cannot_trigger = "Preg4Pain"
		$game_player.cannot_change_map = true
	end
	
	
	def batch_checkOev_PregLv4Pain_out
		@tmpRound += 1
		#stun2
		$game_player.actor.force_stun("Stun2") if !$game_player.action_state_parallel_block? && $game_player.actor.action_state != :stun
		load_script("Data/Batch/common_stats_damage_sta.rb")
		$game_map.popup(0,"commonH:Lona/Qmsg_beaten#{rand(10)}",0,0)
		@wait_count = 140
	end
	
	
	def batch_checkOev_Vomit_PregLv4Pain_msg
		@pregCount = 0 if !@pregCount
		case @pregCount
			when 0
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,0,20),12,false)
				return @wait_count = 60
			when 1
				@pregCount += 1
				$game_map.interpreter.lona_mood "tired" if $game_player.actor.stat["pose"] != "pose4"
				$game_map.popup(0,"common:Lona/preglv4_pain_Qmsg1",0,0)
				SndLib.sound_QuickDialog
				$game_portraits.rprt.focus
				return @wait_count = 10
			when 2
				@pregCount += 1
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,0,0,20),12,false)
				return @wait_count = 120
			when 3
				@pregCount += 1
				$game_map.interpreter.lona_mood "confused"
				$game_map.popup(0,"common:Lona/preglv4_pain_Qmsg2",0,0)
				SndLib.sound_QuickDialog
				$game_portraits.rprt.focus
				return @wait_count = 40
				
		end
	end
end #module

module GIM_OVC
	def parallel_Oev_PregLv4Pain_clearner
		$game_map.interpreter.lona_mood "tired"
		parallel_overEvent_clearner
	end
end #module
