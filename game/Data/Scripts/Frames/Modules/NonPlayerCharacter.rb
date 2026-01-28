#==============================================================================
# This script is created by Kslander 
#==============================================================================
module NonPlayerCharacter	
	

	class Data_NPC
		
		attr_accessor :name        
		attr_accessor :race        
		attr_accessor :sex			
		attr_accessor :kinsey		
		attr_accessor :health      
		attr_accessor :sta		    
		attr_accessor :sexy        
		attr_accessor :weak        
		attr_accessor :arousal     
		attr_accessor :will     
		attr_accessor :morality    
		attr_accessor :wisdom    
		attr_accessor :survival    

		attr_accessor :move_speed  
		attr_accessor :ai        	
		attr_accessor :aggro_killer
		attr_accessor :scoutcraft	
		attr_accessor :scoutcraft_basic
		attr_accessor :sensors		
		attr_accessor :sex_fetish				
		attr_reader	  :tri_state   			
		attr_reader   :drop_list					
		attr_accessor :fraction					
		attr_accessor :fraction_mode					
		attr_reader	  :sound					
		attr_accessor :drop_list_overkill
		attr_accessor :drop_amt
		attr_accessor :is_object
		attr_accessor :is_boss
		attr_accessor :is_tiny
		attr_accessor :is_small
		attr_accessor :is_flyer
		attr_accessor :receiver_type
		attr_accessor :skills_killer
		attr_accessor :skills_assaulter
		attr_accessor :skills_fucker
		attr_accessor :skills_support
		attr_accessor :skill_death
		attr_accessor :exp_when_killed
		attr_accessor :sensor_freq_base
		attr_accessor :sensor_freq_rand
		attr_accessor :friendly_fire #當攻擊/範圍攻擊時射線上有友軍時是否仍會開火...
		attr_accessor :friendly_aggro #遭到friendly fire 時有多少機率aggro友軍
		attr_accessor :delete_when_death #死亡後多少frame將事件刪除，非self_destruct型事件使用
		attr_accessor :delete_when_frame 
		attr_accessor :safe_distance
		
		attr_accessor :ignore_projectile
		attr_accessor :immune_mind_control
		attr_accessor :immune_state_effect #immune all state
		attr_accessor :immune_tgt_states #immune target state
		attr_accessor :immune_tgt_state_type #immune target state
		attr_accessor :immune_damage 
		attr_accessor :sat
		attr_accessor :constitution
		attr_accessor :survival	 
		attr_accessor :wisdom	
		attr_accessor :combat
		attr_accessor :mood
		attr_accessor :sex_taste
		attr_accessor :ranged
		
	    attr_accessor :death_event
	    attr_accessor :sensor_work_mode
		attr_accessor :fated_enemy
		attr_accessor :default_state
	    
		attr_reader :killer_condition
		attr_reader :fucker_condition
		attr_reader :assaulter_condition
		
		attr_accessor :atk    
		attr_accessor :def    
		attr_accessor :event
		               			
		def initialize
			@atk=0
			@def=0
		end
		
		
		def tri_state=(json_data)
			
		end

		def self.load_from_json(jsonHash)
			npc=self.new
			npc.name					=jsonHash["name"]
			npc.race					=jsonHash["race"]
			npc.sex						=jsonHash["sex"].to_i
			npc.kinsey					=jsonHash["kinsey"].to_i
			npc.health					=jsonHash["health"].to_i
			npc.sta						=jsonHash["sta"].to_i
			npc.sexy					=jsonHash["sexy"].to_i
			npc.weak					=jsonHash["weak"].to_i
			npc.arousal					=jsonHash["arousal"].to_i
			npc.will					=jsonHash["will"].to_i
			npc.morality				=jsonHash["morality"].to_i
			npc.atk						=jsonHash["atk"].to_i
			npc.def						=jsonHash["def"].to_i
			npc.move_speed				=jsonHash["move_speed"].to_f
			npc.ai						=jsonHash["ai"]
			npc.aggro_killer			=jsonHash["aggro_killer"].to_i
			npc.scoutcraft				=jsonHash["scoutcraft"].to_i
			npc.scoutcraft_basic		=jsonHash["scoutcraft_basic"].nil? ? rand(4)+3 : jsonHash["scoutcraft_basic"]
			npc.sensors					=Array.new(jsonHash["sensors"].length){|index|
											eval("Sensors::#{jsonHash["sensors"][index]}")
										}
			npc.sensor_work_mode		= jsonHash["sensor_work_mode"].nil? ? 0 :jsonHash["sensor_work_mode"]
			npc.fated_enemy				= jsonHash["fated_enemy"].nil? ? [] : jsonHash["fated_enemy"]
			npc.constitution			= jsonHash["constitution"]
			npc.survival				= jsonHash["survival"]
			npc.wisdom					= jsonHash["wisdom"]								
			npc.combat					= jsonHash["combat"]								
			npc.sat						= jsonHash["sat"]	
			npc.mood					= jsonHash["mood"]
			npc.ranged					= jsonHash["ranged"]

			npc.drop_list				=jsonHash["drop_list"]
			npc.drop_list_overkill		=jsonHash["drop_list_overkill"]
			npc.drop_amt				=jsonHash["drop_amt"]
			npc.skills_killer			=jsonHash["skills_killer"]
			npc.skills_assaulter		=jsonHash["skills_assaulter"]
			npc.skills_fucker			=jsonHash["skills_fucker"]
			npc.skills_support			=jsonHash["skills_support"]
			npc.sex_fetish				=jsonHash["sex_fetish"].nil? ? Array.new : jsonHash["sex_fetish"]
			npc.tri_state				=jsonHash["tri_state"]
			npc.sound					=jsonHash["sound"]
			npc.is_object				=jsonHash["is_object"]
			npc.is_boss					=jsonHash["is_boss"]
			npc.is_tiny					=jsonHash["is_tiny"]
			npc.is_small				=jsonHash["is_small"]
			npc.is_flyer				=jsonHash["is_flyer"]
			npc.exp_when_killed			=jsonHash["exp_when_killed"]
			npc.receiver_type			=jsonHash["receiver_type"].nil? ? 0 : jsonHash["receiver_type"]
			npc.fraction				=jsonHash["fraction"]
			npc.death_event				=jsonHash["death_event"]
			npc.safe_distance			=jsonHash["safe_distance"]
			npc.delete_when_death		=jsonHash["delete_when_death"].nil? ? -1 : jsonHash["delete_when_death"].to_i
			npc.delete_when_frame		=jsonHash["delete_when_frame"].nil? ? -1 : jsonHash["delete_when_frame"].to_i
			npc.sensor_freq_base		=jsonHash["sensor_freq_base"].nil? ? 1 : jsonHash["sensor_freq_base"].to_i
			npc.sensor_freq_rand		=jsonHash["sensor_freq_rand"].nil? ? 7 : jsonHash["sensor_freq_rand"].to_i
			npc.friendly_fire			=jsonHash["friendly_fire"]
			npc.friendly_aggro			=jsonHash["friendly_aggro"]
			npc.killer_condition		=jsonHash["tri_state"]["killer"]
			npc.fucker_condition		=jsonHash["tri_state"]["fucker"]
			npc.assaulter_condition		=jsonHash["tri_state"]["assaulter"]
			npc.ignore_projectile		=jsonHash["ignore_projectile"]
			npc.immune_state_effect 	=jsonHash["immune_state_effect"]
			npc.immune_tgt_states		=jsonHash["immune_tgt_states"].nil?		? [] : jsonHash["immune_tgt_states"]
			npc.immune_tgt_state_type	=jsonHash["immune_tgt_state_type"].nil?	? [] : jsonHash["immune_tgt_state_type"]
			npc.immune_damage			=jsonHash["immune_damage"]
			npc.immune_mind_control		=jsonHash["immune_mind_control"]
			npc.fraction_mode 			=jsonHash["fraction_mode"]
			npc.sex_taste 				=jsonHash["sex_taste"]
			npc.default_state 			=jsonHash["default_state"]
			npc
		end
		
		
		def killer_condition=(json_data)
			return @killer_condition=[] if json_data.nil?
			@killer_condition=json_data
			@killer_condition.keys.each{
				|key|
				@killer_condition[key][0]=@killer_condition[key][0].to_i
			}
		end
		
		def fucker_condition=(json_data)
			return @fucker_condition=[] if json_data.nil?
			@fucker_condition=json_data
			@fucker_condition.keys.each{
				|key|
				@fucker_condition[key][0]=@fucker_condition[key][0].to_i
			}
		
		end
		
		def assaulter_condition=(json_data)
			return @assaulter_condition=[] if json_data.nil?
			@assaulter_condition=json_data
			@assaulter_condition.keys.each{
				|key|
				@assaulter_condition[key][0]=@assaulter_condition[key][0].to_i
			}
		end 
		
		
		def sound=(json_data)
			@sound = Hash.new
			json_data.each{
				|key,value|
				@sound[key.to_sym] = value.empty? ? nil : value
			}
		end
		
		
		
		
		
		
		
		def drop_list=(json_data)
			@drop_list=Array.new
			return if json_data.nil?
			json_data.each{
				|data|
				@drop_list.concat(Array.new(data["chance"].to_i,data["name"]))
			}
		end

		

		
		def get_npc(host=nil)
			eval(@ai).new(@name)
		end
		
		

	
		
	end
	
	
end



