
class Game_Actor < Game_Battler

	#use in OverEvent_RebirthCheck.rb
	def build_inheritance_data(choosedRace)
		tmpLVL = self.level
		tmpEXP = self.exp
		tmpRB = $story_stats["record_Rebirth"]
		tmpTP = [1+tmpRB,5].min + $story_stats["GameOverGood"]
		tmpBank = $game_boxes.get_box(System_Settings::STORAGE_BANK)
		tmpEXP=(0.8*tmpEXP).to_i if $story_stats["GameOverGood"]==0
		tmpSexRecordHash={}
		$story_stats.data.each{|key, value|
			next unless key.start_with?("sex_record_")
			tmpSexRecordHash[key] = value
			}
		$inheritance = {
			"HairColor"			=> self.record_HairColor,
			"HairEquip"			=> self.equips[7],
			"ChoosedRace"		=> choosedRace,
			"Exp"				=> tmpEXP,
			"TraitPoint"		=> tmpTP,
			"RecRebirth"		=> tmpRB,
			"BankStorage"		=> tmpBank,
			"sex_record"		=> tmpSexRecordHash,
			
			"slot_RosterCurrent"		=> $game_player.slot_RosterCurrent,
			"slot_RosterArray"			=> $game_player.slot_RosterArray,
			"slot_skill_normal"			=> $game_player.slot_skill_normal,
			"slot_skill_heavy"			=> $game_player.slot_skill_heavy,
			"slot_skill_control"		=> $game_player.slot_skill_control,
			"slot_hotkey_0"				=> $game_player.slot_hotkey_0,
			"slot_hotkey_1"				=> $game_player.slot_hotkey_1,
			"slot_hotkey_2"				=> $game_player.slot_hotkey_2,
			"slot_hotkey_3"				=> $game_player.slot_hotkey_3,
			"slot_hotkey_4"				=> $game_player.slot_hotkey_4,
			"slot_hotkey_other"			=> $game_player.slot_hotkey_other,
			

			"Setup_ScatEffect"			=> $story_stats["Setup_ScatEffect"],
			"Setup_UrineEffect"			=> $story_stats["Setup_UrineEffect"],
			"Setup_Hardcore"			=> $story_stats["Setup_Hardcore"]
		}
		$inheritance["rebirthData"] = {}
		$inheritance["rebirthStateData"] = {}
		
	end
	def setup_inheritance(inheritance=nil)
		return if inheritance.nil?
		
		if inheritance["HairEquip"] && inheritance["HairEquip"].type_tag == "Hair"
			$game_party.gain_item_core(inheritance["HairEquip"], 1)
			self.change_equip(7, inheritance["HairEquip"])
		end


		self.record_HairColor = inheritance["HairColor"]									if inheritance["HairColor"]
		self.race = inheritance["ChoosedRace"]												if inheritance["ChoosedRace"]
		self.stat["RaceRecord"] = inheritance["ChoosedRace"]										if inheritance["ChoosedRace"]
#
		if $inheritance["sex_record"] && $inheritance["rebirthData"]["remember_sex_rec"]
			$inheritance["sex_record"].each{|key, value|
				next unless key
				$story_stats[key] = value
			}
		end

		#remove virgin if theres record from birth
		$story_stats["dialog_vag_virgin"] = 0 if $story_stats["sex_record_vaginal_count"] >= 1
		$story_stats["dialog_anal_virgin"] = 0 if $story_stats["sex_record_anal_count"] >= 1

		self.trait_point = inheritance["TraitPoint"]										if inheritance["TraitPoint"] && $inheritance["rebirthData"]["remember_exp"]
		self.gain_exp(inheritance["Exp"]) 													if inheritance["Exp"] && $inheritance["rebirthData"]["remember_exp"]

		self.reBirthSetRace(self.race)
		$game_map.interpreter.new_game_setup ##29_Functions_417
		$game_boxes.write_box(System_Settings::STORAGE_BANK,inheritance["BankStorage"])		if inheritance["BankStorage"] && $inheritance["rebirthData"]["remember_bank"]
		
		$story_stats["Setup_UrineEffect"] 	= inheritance["Setup_UrineEffect"]				if inheritance["Setup_UrineEffect"]
		$story_stats["Setup_ScatEffect"] 	= inheritance["Setup_ScatEffect"]				if inheritance["Setup_ScatEffect"]
		$story_stats["Setup_Hardcore"] 		= inheritance["Setup_Hardcore"]					if inheritance["Setup_Hardcore"]
		$story_stats["record_Rebirth"] 		= inheritance["RecRebirth"] +1					if inheritance["RecRebirth"]
		
		$story_stats["Setup_HardcoreAmt"] = [1772,3,1] if $story_stats["Setup_Hardcore"] >= 1
		$game_player.slot_RosterCurrent  = inheritance["slot_RosterCurrent"]				if inheritance["slot_RosterCurrent"]
		$game_player.slot_RosterArray    = inheritance["slot_RosterArray"]					if inheritance["slot_RosterArray"]
		$game_player.slot_skill_normal   = inheritance["slot_skill_normal"]					if inheritance["slot_skill_normal"]
		$game_player.slot_skill_heavy    = inheritance["slot_skill_heavy"]					if inheritance["slot_skill_heavy"]
		$game_player.slot_skill_control  = inheritance["slot_skill_control"]				if inheritance["slot_skill_control"]
		$game_player.slot_hotkey_0       = inheritance["slot_hotkey_0"]						if inheritance["slot_hotkey_0"]
		$game_player.slot_hotkey_1       = inheritance["slot_hotkey_1"]						if inheritance["slot_hotkey_1"]
		$game_player.slot_hotkey_2       = inheritance["slot_hotkey_2"]						if inheritance["slot_hotkey_2"]
		$game_player.slot_hotkey_3       = inheritance["slot_hotkey_3"]						if inheritance["slot_hotkey_3"]
		$game_player.slot_hotkey_4       = inheritance["slot_hotkey_4"]						if inheritance["slot_hotkey_4"]
		$game_player.slot_hotkey_other   = inheritance["slot_hotkey_other"]					if inheritance["slot_hotkey_other"]

		self.reBirthGenStates #to last because it need withdraw storystats
		
	end



		#module GetText def self.lona_race  #GUI usage
		#$game_player.actor.stat["RaceRecord"]
		#"Human"
		#"PreDeepone"
		#"Moot"
		#"TrueDeepone"
		#"Abomination"
		#"NoData"
	def reBirthSetRace(tmpRace)
		tmpRaceStateRemove=[
			"Tail",
			"AbomSickly",
			"TrueDeepone",
			"PreDeepone",
			"Moot"
		]
		tmpRaceStateRemove.each{|tmpState|
			self.erase_state(tmpState)
		}
		case tmpRace
			#when "Banshee"
			#	#todo fix eyes white color pat.
			#	#add mind control skill
			#	self.stat["RaceRecord"] = "Banshee"
			#	self.stat["Race"] = "Human"
			#	self.race = "Human"
			#	self.learn_skill("BasicMindControl") #72
			#	
			#when "Nibba"
			#	#TODO need Afro hair,
			#	#just nibba, nothing cool
			#	self.add_state("Moot")
			#	self.stat["RaceRecord"] = "Nibba"
			#	self.stat["Race"] = "Moot"
			#	self.race = "Moot"
				
				
			when "Moot"
				self.add_state("Moot")
				self.add_state("Tail")
				self.stat["RaceRecord"] = "Moot"
				self.stat["Race"] = "Moot"
				self.race = "Moot"
			when "TrueDeepone"
				self.add_state("TrueDeepone")
				self.stat["RaceRecord"] = "TrueDeepone"
				self.stat["Race"] = "Deepone"
				self.race = "Deepone"
			when "Deepone"
				self.add_state("PreDeepone")
				self.stat["RaceRecord"] = "PreDeepone"
				self.stat["Race"] = "Human"
				self.race = "Human"
			when "HumanAbomination"
				self.add_state("AbomSickly")
				self.stat["RaceRecord"] = "Abomination"
				self.stat["Race"] = "Human"
				self.race = "Human"
				$story_stats["DreamPTSD"] = "Abomination"
				$game_party.gain_item("ItemBluePotion",3)

				##Decide?   immune abom parasite?
				#$data_StateName.each{|name,state|
				#	next unless state
				#	next unless state.item_name
				#	next unless state.type == "STD_AbomParasite"
				#	$game_player.actor.immune_tgt_states << name
				#}
				#$game_player.actor.immune_tgt_states = $game_player.actor.original_immune_tgt_states.clone
			when "MootAbomination"
				self.add_state("AbomSickly")
				self.add_state("Moot")
				self.stat["RaceRecord"] = "Abomination"
				self.stat["Race"] = "Moot"
				self.race = "Moot"
				$story_stats["DreamPTSD"] = "Abomination"
				$game_party.gain_item("ItemBluePotion",3)
			else #Human
				self.stat["RaceRecord"] = "Human"
				self.stat["Race"] = "Human"
				self.race = "Human"
		end
	end #reBirthSetRace
	
	def reBirthGenStates
		$game_player.actor.pubicHair_Vag_GrowRate		= $inheritance["rebirthData"]["pubicHair_Vag_GrowRate"]
		$game_player.actor.pubicHair_Vag_GrowMAX		= $inheritance["rebirthData"]["pubicHair_Vag_GrowMAX"]
		$game_player.actor.pubicHair_Anal_GrowRate		= $inheritance["rebirthData"]["pubicHair_Anal_GrowRate"]
		$game_player.actor.pubicHair_Anal_GrowMAX		= $inheritance["rebirthData"]["pubicHair_Anal_GrowMAX"]
		
		$game_player.actor.sensitivity_basic_vag		= $inheritance["rebirthData"]["sensitivity_basic_vag"]
		$game_player.actor.sensitivity_basic_anal		= $inheritance["rebirthData"]["sensitivity_basic_anal"]
		$game_player.actor.sensitivity_basic_mouth		= $inheritance["rebirthData"]["sensitivity_basic_mouth"]
		$game_player.actor.sensitivity_basic_breast		= $inheritance["rebirthData"]["sensitivity_basic_breast"]
		$inheritance["rebirthStateData"].each{|state|
			$game_player.actor.setup_state(*state)
		}
	end
	
	def reBirthReroll_state
		$inheritance["rebirthData"]["pubicHair_Vag_GrowRate"]	= 3+rand(10) #howmany Nap to Grow a LVL
		$inheritance["rebirthData"]["pubicHair_Vag_GrowMAX"]	= 2+rand(3) #max Lvl
		$inheritance["rebirthData"]["pubicHair_Anal_GrowRate"]	= 3+rand(10)
		$inheritance["rebirthData"]["pubicHair_Anal_GrowMAX"]	= 2+rand(3)
		
		$inheritance["rebirthStateData"] = {}
		$inheritance["rebirthStateData"]["Freckle"] = 1 if [true,false].sample
		$inheritance["rebirthStateData"]["WeakBladder"] = 1 if rand(100) >= 80 && $story_stats["Setup_UrineEffect"] >= 1
		$inheritance["rebirthStateData"]["PubicHairVag"] = $inheritance["rebirthData"]["pubicHair_Vag_GrowMAX"] if [true,false].sample
		$inheritance["rebirthStateData"]["PubicHairAnal"] = $inheritance["rebirthData"]["pubicHair_Anal_GrowMAX"] if [true,false].sample
		$inheritance["rebirthStateData"]["NaturalVagGlandsLink"] = 1 if rand(100) >= 80
		$inheritance["rebirthStateData"]["ADHD"] = 1 if rand(100) >= 80
		$inheritance["rebirthStateData"]["WaveringResolve"] = 1 if rand(100) >= 80
		
		$inheritance["rebirthStateData"] = $inheritance["rebirthStateData"].keys.shuffle.each_with_object({}) { |key, h| h[key] = $inheritance["rebirthStateData"][key] }
		
		
	end
	
	def reBirthReroll_sensitivity
		# Randomly assign values to tmp_sen_v, tmp_sen_a, tmp_sen_m, and tmp_sen_b
		tmp_sen_v = (2..5).to_a.sample
		tmp_sen_a = (2..5).to_a.sample
		tmp_sen_m = (1..3).to_a.sample
		tmp_sen_b = (1..2).to_a.sample
		
		# Calculate the total
		total = tmp_sen_v + tmp_sen_a + tmp_sen_m + tmp_sen_b
		
		# Check if the total is equal to 10, if not, adjust values until the condition is met
		while total != 10
			tmp_sen_v = (2..5).to_a.sample
			tmp_sen_a = (2..5).to_a.sample
			tmp_sen_m = (1..3).to_a.sample
			tmp_sen_b = (1..2).to_a.sample
			
				total = tmp_sen_v + tmp_sen_a + tmp_sen_m + tmp_sen_b
		end	
		
		$inheritance["rebirthData"]["sensitivity_basic_vag"]		= tmp_sen_v
		$inheritance["rebirthData"]["sensitivity_basic_anal"]		= tmp_sen_a
		$inheritance["rebirthData"]["sensitivity_basic_mouth"]		= tmp_sen_m
		$inheritance["rebirthData"]["sensitivity_basic_breast"]		= tmp_sen_b
	end
end

