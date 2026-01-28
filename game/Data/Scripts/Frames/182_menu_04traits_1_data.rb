



module System_Settings
	module TRAIT
		BLANK_ID = 2
		tmp = BLANK_ID
		LIST=[
			[tmp,				"IronWill",			tmp,				tmp,				"WeakSoul",		tmp,			tmp,					"Nymph",		tmp],
			[tmp,				tmp,				tmp,				"Pessimist",		tmp,			tmp,			tmp,					"Prostitute",	"Exhibitionism"],
			[tmp,				tmp,				"BloodLust",		tmp,				tmp,			tmp,			tmp,					tmp,			tmp],
			["WeaponryKnowledge","HunterTraining",	"ManaKnowledge",	"ImproveThrowRock",	"Omnivore",		"IntoShadow",	"NunKnowledge",			"SemenGulper",	"Succubus"],
			[tmp,				tmp,				tmp,				tmp,				"Cannibal",		tmp,			tmp,					tmp,			tmp],
			[tmp,				tmp,				tmp,				tmp,				tmp,			tmp,			"SacredAegis",			tmp,			tmp],
			[tmp,				"TrapImprove",		tmp,				tmp,				"Hitchhiker",	tmp,			tmp,					"Masochist",	tmp],
			[tmp,				tmp,				tmp,				tmp,				tmp,			tmp,			"SaintFieldSupporter",	tmp,			tmp],
			[tmp,				"BloodyMess",		tmp,				tmp,				tmp,			"ShadowMaster",	tmp,					"Lilith",		tmp]
		]
		#LIST2=[
		#	tmp,				"IronWill",			tmp,				tmp,				"WeakSoul",		tmp,			tmp,					"Nymph",		tmp,
		#	tmp,				tmp,				tmp,				"Pessimist",		tmp,			tmp,			tmp,					"Prostitute",	"Exhibitionism",
		#	tmp,				tmp,				"BloodLust",		tmp,				tmp,			tmp,			tmp,					tmp,			tmp,
		#	"WeaponryKnowledge","HunterTraining",	"ManaKnowledge",	"ImproveThrowRock",	"Omnivore",		"IntoShadow",	"NunKnowledge",			"SemenGulper",	"Succubus",
		#	tmp,				tmp,				tmp,				tmp,				"Cannibal",		tmp,			tmp,					tmp,			tmp,
		#	tmp,				tmp,				tmp,				tmp,				tmp,			tmp,			tmp,					tmp,			tmp,
		#	tmp,				"TrapImprove",		tmp,				tmp,				"Hitchhiker",	tmp,			tmp,					"Masochist",	tmp,
		#	tmp,				tmp,				tmp,				tmp,				tmp,			tmp,			"SaintFieldSupporter",	tmp,			tmp,
		#	tmp,				"BloodyMess",		tmp,				tmp,				tmp,			"ShadowMaster",	tmp,					"Lilith",		tmp
		#]
	end
end


class Game_Actor < Game_Battler


	def basic_traits
		#[32xIcon_Index, DataItem:Name/, stat]
		[
			[25,"trait_Combat",self.combat_trait],
			[33,"trait_Scoutcraft",self.scoutcraft_trait],
			[41,"trait_Wisdom",self.wisdom_trait],
			[40,"trait_Survival",self.survival_trait],
			[48,"trait_Constitution",self.constitution_trait]
		]
	end
	
	
	def basic_trait_addable?(tmpVal)
		99 >= tmpVal
	end
	
	#state
	#current_selected =>[selected_gift_trait_id,selected_gift_trait_id,selected_gift_trait_id,selected_gift_trait_id,selected_gift_trait_id]
	#def gift_trait_addable?(trait_id,current_selected)
	#	#true: can add / false: cannot add
	#	case trait_id
	#		when "Nymph";				return trait_Nymph_addable?(current_selected)
	#		when "IronWill";			return trait_IronWill_addable?(current_selected);
	#		when "WeakSoul";			return trait_WeakSoul_addable?(current_selected);
	#		
	#		when "BloodLust";			return trait_bloodlust_addable?(current_selected);
	#		when "Masochist";			return trait_masochist_addable?(current_selected);
	#		when "Cannibal";			return trait_cannibal_addable?(current_selected);
	#		when "BloodyMess";			return trait_BloodyMess_addable?(current_selected);
	#		when "Exhibitionism";		return trait_exhibitionism_addable?(current_selected);
	#		when "HunterTraining";		return trait_HunterTraining_addable?(current_selected);
	#		when "Prostitute";			return trait_prostitute_addable?(current_selected);
	#		when "Omnivore";			return trait_omnivore_addable?(current_selected);
	#		when "SemenGulper";			return trait_semengulper_addable?(current_selected);
	#		when "ManaKnowledge";		return trait_ManaKnowledge_addable?(current_selected);
	#		when "WeaponryKnowledge";	return trait_WeaponryKnowledge_addable?(current_selected);
	#		#when "Alchemy";			return trait_Alchemy_addable?(current_selected);
	#		when "ImproveThrowRock";	return trait_ImproveThrowRock_addable?(current_selected);
	#		when "Succubus";			return trait_Succubus_addable?(current_selected);
	#		when "Lilith";				return trait_Lilith_addable?(current_selected);
	#		when "Hitchhiker";			return trait_Hitchhiker_addable?(current_selected);
	#		when "Pessimist";			return trait_Pessimist_addable?(current_selected);
	#		when "IntoShadow";			return trait_IntoShadow_addable?(current_selected);
	#		when "TrapImprove";			return trait_TrapImprove_addable?(current_selected);
	#		when "ShadowMaster";		return trait_ShadowMaster_addable?(current_selected);
	#		when "NunKnowledge";		return trait_NunKnowledge_addable?(current_selected);
	#		when "SaintFieldSupporter";	return trait_SaintFieldSupporter_addable?(current_selected);
	#		else; raise "what are you doing"
	#		#else; gift_trait_mod_addable?(trait_id,current_selected)
	#	end
	#end
	def gift_trait_addable_list(current_selected)
			#true: can add / false: cannot add
			{
				"Nymph"					=> trait_Nymph_addable?(current_selected),
				"IronWill"				=> trait_IronWill_addable?(current_selected),
				"WeakSoul"				=> trait_WeakSoul_addable?(current_selected),
				
				"BloodLust"				=> trait_bloodlust_addable?(current_selected),
				"Masochist"				=> trait_masochist_addable?(current_selected),
				"Cannibal"				=> trait_cannibal_addable?(current_selected),
				"BloodyMess"			=> trait_BloodyMess_addable?(current_selected),
				"Exhibitionism"			=> trait_exhibitionism_addable?(current_selected),
				"HunterTraining"		=> trait_HunterTraining_addable?(current_selected),
				"Prostitute"			=> trait_prostitute_addable?(current_selected),
				"Omnivore"				=> trait_omnivore_addable?(current_selected),
				"SemenGulper"			=> trait_semengulper_addable?(current_selected),
				"ManaKnowledge"			=> trait_ManaKnowledge_addable?(current_selected),
				"WeaponryKnowledge"		=> trait_WeaponryKnowledge_addable?(current_selected),
				#"Alchemy"				=> trait_Alchemy_addable?(current_selected),
				"ImproveThrowRock"		=> trait_ImproveThrowRock_addable?(current_selected),
				"Succubus"				=> trait_Succubus_addable?(current_selected),
				"Lilith"				=> trait_Lilith_addable?(current_selected),
				"Hitchhiker"			=> trait_Hitchhiker_addable?(current_selected),
				"Pessimist"				=> trait_Pessimist_addable?(current_selected),
				"IntoShadow"			=> trait_IntoShadow_addable?(current_selected),
				"TrapImprove"			=> trait_TrapImprove_addable?(current_selected),
				"ShadowMaster"			=> trait_ShadowMaster_addable?(current_selected),
				"NunKnowledge"			=> trait_NunKnowledge_addable?(current_selected),
				"SacredAegis"			=> trait_SacredAegis_addable?(current_selected),
				"SaintFieldSupporter"	=> trait_SaintFieldSupporter_addable?(current_selected)
			}
			
	end
	###  1 can take, but not yet,    2 blocked by trait      0 can take
	def trait_Nymph_addable?(current_selected) #115
		return 2 if current_selected.include?("IronWill") #trait_Nymph_addable
		return 2 if current_selected.include?("WeakSoul") #trait_WeakSoul_addable
		return 2 if current_selected.include?("ManaKnowledge") #trait_ManaKnowledge_addable
		return 2 if current_selected.include?("WeaponryKnowledge") #trait_WeaponryKnowledge_addable
		return 2 if state_stack("IronWill") == 1 #trait_IronWill_addable
		return 2 if state_stack("WeakSoul") == 1 #trait_WeakSoul_addable
		return 2 if state_stack("ManaKnowledge") == 1 #trait_ManaKnowledge_addable
		return 2 if state_stack("WeaponryKnowledge") == 1 #trait_WeaponryKnowledge_addable
		return 3 if state_stack("Nymph") == 1 #self
		return 0
	end
	
	def trait_IronWill_addable?(current_selected) #116
		return 2 if current_selected.include?("Nymph") #trait_Nymph_addable
		return 2 if current_selected.include?("WeakSoul") #WeakSoul
		return 2 if current_selected.include?("Omnivore") #trait_omnivore_addable
		return 2 if current_selected.include?("SemenGulper") #trait_semengulper_addable
		return 2 if current_selected.include?("ManaKnowledge") #trait_ManaKnowledge_addablege
		return 2 if current_selected.include?("Succubus") #Succubus
		return 2 if current_selected.include?("Lilith") #Lilith
		return 2 if state_stack("Nymph") == 1 #trait_Nymph_addable
		return 2 if state_stack("WeakSoul") == 1 #WeakSoul
		return 2 if state_stack("Omnivore") == 1 #trait_omnivore_addable
		return 2 if state_stack("SemenGulper") == 1 #trait_semengulper_addable
		return 2 if state_stack("ManaKnowledge") == 1 #trait_ManaKnowledge_addable
		return 2 if state_stack("Succubus") == 1 #Succubus
		return 2 if state_stack("Lilith") == 1 #trait_Lilith_addable
		return 3 if state_stack("IronWill") == 1 #self
		return 0
	end
	
	def trait_WeakSoul_addable?(current_selected) #117
		return 2 if current_selected.include?("Nymph") #Nymph
		return 2 if current_selected.include?("IronWill") #IronWill
		return 2 if current_selected.include?("Cannibal") #cannibal
		return 2 if current_selected.include?("WeaponryKnowledge") #WeaponryKnowledge
		return 2 if current_selected.include?("Succubus") #Succubus
		return 2 if current_selected.include?("BloodLust") #bloodlust
		return 2 if state_stack("Nymph") == 1 #Nymph
		return 2 if state_stack("IronWill") == 1 #IronWill
		return 2 if state_stack("WeaponryKnowledge") == 1 #WeaponryKnowledge
		return 2 if state_stack("Succubus") == 1 #Succubus
		return 2 if state_stack("BloodLust") == 1 #bloodlust
		return 3 if state_stack("WeakSoul") == 1 #self
		return 0
	end
	
	def trait_bloodlust_addable?(current_selected) #125 bloodlust
		return 2 if current_selected.include?("NunKnowledge") #NunKnowledge
		return 2 if current_selected.include?("WeakSoul") #_WeakSoul
		return 2 if state_stack("NunKnowledge") == 1 #NunKnowledge
		return 2 if state_stack("WeakSoul") == 1 #_WeakSoul
		return 3 if state_stack("BloodLust") == 1 #self
		return 1 if @level < 10
		return 0
	end

	def trait_masochist_addable?(current_selected) #126
		return 2 if current_selected.include?("Pessimist") #Pessimist
		return 2 if state_stack("Pessimist") == 1 #Pessimist
		return 3 if state_stack("Masochist") == 1 #self
		return 1 if @level < 30
		return 0
	end

	def trait_cannibal_addable?(current_selected) #127
		return 2 if current_selected.include?("NunKnowledge") #NunKnowledge
		return 2 if current_selected.include?("WeakSoul") #WeakSoul
		return 2 if state_stack("NunKnowledge") == 1 #NunKnowledge
		return 2 if state_stack("WeakSoul") == 1 #WeakSoul
		return 3 if state_stack("Cannibal") == 1 #self
		return 1 if @level < 20
		return 0
	end
	
	
	def trait_BloodyMess_addable?(current_selected) #128
		return 3 if state_stack("BloodyMess") == 1 #self
		return 1 if @level < 40
		return 0
	end
	
	def trait_exhibitionism_addable?(current_selected) #129
		return 3 if state_stack("Exhibitionism") == 1 #self
		return 1 if @level < 5
		return 0
	end
	
	def trait_HunterTraining_addable?(current_selected) #130
		return 3 if state_stack("HunterTraining") == 1 #self
		return 1 if @level < 15
		return 0
	end

	def trait_prostitute_addable?(current_selected) #131
		return 3 if state_stack("Prostitute") == 1 #self
		return 1 if @level < 5
		return 0
	end
	
	def trait_omnivore_addable?(current_selected) #132
		return 2 if current_selected.include?("IronWill") #IronWill
		return 2 if state_stack("IronWill") == 1 #IronWill
		return 3 if state_stack("Omnivore") == 1 #self
		return 1 if @level < 15
		return 0
	end

	def trait_semengulper_addable?(current_selected) #133
		return 2 if current_selected.include?("IronWill") #IronWill
		return 2 if state_stack("IronWill") == 1 #IronWill
		return 3 if state_stack("SemenGulper") == 1 #self
		return 1 if @level < 15
		return 0
	end

	def trait_ManaKnowledge_addable?(current_selected) #134
		return 2 if current_selected.include?("Nymph") #Nymph
		return 2 if current_selected.include?("IronWill") #IronWill
		return 2 if current_selected.include?("NunKnowledge") #NunKnowledge
		return 2 if state_stack("NunKnowledge") == 1 #NunKnowledge
		return 2 if state_stack("Nymph") == 1 #Nymph
		return 2 if state_stack("IronWill") == 1 #IronWill
		return 3 if state_stack("ManaKnowledge") == 1 #self
		return 1 if @level < 15
		return 0
	end
	
	def trait_WeaponryKnowledge_addable?(current_selected) #135
		return 2 if current_selected.include?("Nymph") #Nymph
		return 2 if current_selected.include?("WeakSoul") #IronWill
		return 2 if current_selected.include?("NunKnowledge") #NunKnowledge
		return 2 if state_stack("NunKnowledge") == 1 #NunKnowledge
		return 2 if state_stack("Nymph") == 1 #Nymph
		return 2 if state_stack("WeakSoul") == 1 #IronWill
		return 3 if state_stack("WeaponryKnowledge") == 1 #self
		return 1 if @level < 15
		return 0
	end

	def trait_NunKnowledge_addable?(current_selected) #145 #NunKnowledge
		return 2 if current_selected.include?("ManaKnowledge") #ManaKnowledge
		return 2 if current_selected.include?("WeaponryKnowledge") #WeaponryKnowledge
		return 2 if current_selected.include?("Cannibal") #cannibal
		return 2 if current_selected.include?("BloodLust") #bloodlust
		return 2 if state_stack("ManaKnowledge") == 1 #ManaKnowledge
		return 2 if state_stack("WeaponryKnowledge") == 1 #WeaponryKnowledge
		return 2 if state_stack("Cannibal") == 1 #cannibal
		return 2 if state_stack("BloodLust") == 1 #bloodlust
		return 3 if state_stack("NunKnowledge") == 1 #self
		return 1 if self.constitution_trait < 5 #CON
		return 1 if @level < 15
		return 0
	end
	
	def trait_SacredAegis_addable?(current_selected)
		return 2 if current_selected.include?("ManaKnowledge") #ManaKnowledge
		return 2 if current_selected.include?("WeaponryKnowledge") #WeaponryKnowledge
		return 2 if current_selected.include?("Cannibal") #cannibal
		return 2 if current_selected.include?("BloodLust") #bloodlust
		return 2 if state_stack("ManaKnowledge") == 1 #ManaKnowledge
		return 2 if state_stack("WeaponryKnowledge") == 1 #WeaponryKnowledge
		return 2 if state_stack("Cannibal") == 1 #cannibal
		return 2 if state_stack("BloodLust") == 1 #bloodlust
		return 3 if state_stack("SacredAegis") == 1 #self
		return 4 if current_selected.include?("NunKnowledge")
		return 1 if state_stack("NunKnowledge") != 1 #NunKnowledge
		return 1 if self.survival_trait < 5
		return 1 if @level < 25
		return 0
	end
	def trait_SaintFieldSupporter_addable?(current_selected) #146 #SaintFieldSupporter
		return 2 if current_selected.include?("ManaKnowledge") #ManaKnowledge
		return 2 if current_selected.include?("WeaponryKnowledge") #WeaponryKnowledge
		return 2 if current_selected.include?("Cannibal") #cannibal
		return 2 if current_selected.include?("BloodLust") #bloodlust
		return 2 if state_stack("ManaKnowledge") == 1 #ManaKnowledge
		return 2 if state_stack("WeaponryKnowledge") == 1 #WeaponryKnowledge
		return 2 if state_stack("Cannibal") == 1 #cannibal
		return 2 if state_stack("BloodLust") == 1 #bloodlust
		return 3 if state_stack("SaintFieldSupporter") == 1 #self
		return 4 if current_selected.include?("NunKnowledge")
		return 1 if state_stack("NunKnowledge") != 1 #NunKnowledge
		return 1 if self.constitution_trait < 10 #CON
		return 1 if @level < 35
		return 0
	end
	#def trait_Alchemy_addable?(current_selected) #136
	#	return 1 if self.survival_trait <10 #survival
	#	return 3 if state_stack(136) ==1 #self
	#	return 1 if @level < 10
	#	return 0
	#end
	
	def trait_ImproveThrowRock_addable?(current_selected) #137
		return 3 if state_stack("ImproveThrowRock") ==1 #self
		return 1 if @level < 15
		return 1 if self.scoutcraft_trait <10 #scoutcraft
		return 0
	end
	
	def trait_Succubus_addable?(current_selected) #138
		return 2 if current_selected.include?("IronWill") #ironwill
		return 2 if current_selected.include?("WeakSoul") #Weaksoul
		return 2 if state_stack("IronWill") == 1 #ironwill
		return 2 if state_stack("WeakSoul") == 1 #Weaksoul
		return 3 if state_stack("Succubus") == 1 #self
		return 4 if (current_selected.include?("Prostitute") || current_selected.include?("Nymph") ) && state_stack("Nymph") != 1 && state_stack("Prostitute") != 1 
		return 1 if @level < 15
		return 1 if state_stack("Prostitute") != 1 && state_stack("Nymph") != 1
		return 0
	end
	
	def trait_Lilith_addable?(current_selected) #139
		return 2 if current_selected.include?("IronWill") #ironwill
		return 2 if state_stack("IronWill") ==1 #ironwill
		return 3 if state_stack("Lilith") == 1 #self
		return 4 if current_selected.include?("Prostitute")
		return 1 if state_stack("Prostitute") != 1 #prostitute		
		return 1 if @level < 40
		return 0
	end	
	
	def trait_Hitchhiker_addable?(current_selected) #140
		return 3 if state_stack("Hitchhiker") ==1 #self
		return 1 if @level < 30
		return 1 if self.survival_trait <15 #survival
		return 0
	end
	
	def trait_Pessimist_addable?(current_selected) #141
		return 2 if current_selected.include?("Masochist") #masochist
		return 2 if state_stack("Masochist") ==1 #masochist
		return 3 if state_stack("Pessimist") ==1 #self
		return 1 if @level < 5
		return 0
	end
	
	def trait_IntoShadow_addable?(current_selected) #142
		return 3 if state_stack("IntoShadow") ==1 #self
		return 1 if @level < 15
		return 1 if self.scoutcraft_trait <10 #SCU
		return 0
	end
	
	def trait_ShadowMaster_addable?(current_selected) #144
		return 3 if state_stack("ShadowMaster") ==1 #self
		return 4 if current_selected.include?("IntoShadow")
		return 1 if @level < 40
		return 1 if self.scoutcraft_trait <20 #SCU
		return 1 if state_stack("IntoShadow") != 1 #IntoShadow
		return 0
	end
	
	def trait_TrapImprove_addable?(current_selected) #143
		return 3 if state_stack("TrapImprove") ==1 #self
		return 4 if current_selected.include?("HunterTraining")
		return 1 if @level < 30
		return 1 if self.survival_trait < 10 #survival
		return 1 if state_stack("HunterTraining") != 1 #HunterTraining
		return 0
	end
end
