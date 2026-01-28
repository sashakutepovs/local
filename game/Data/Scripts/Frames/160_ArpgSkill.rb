#==============================================================================
# This script is created by Kslander 
#==============================================================================
#=============================================================================================
# 讀取並且處理Skill的JSON內容。主要由戰鬥系統使用。
#
#=============================================================================================
#ARPG用的系統的技能資料
class SkillData
	attr_accessor	:hold_animation
	attr_accessor	:chs_animation
	attr_accessor	:name
	attr_accessor	:wait_hit_frame				#wait skill effect until hit frame 
	attr_accessor	:hit_cancel_mode 				#true false
	attr_accessor	:hit_cancel_req_last_skill 	#"String"  skill name 
	attr_accessor	:hit_cancel_req_a_tgt 
									 
	attr_accessor	:cost
	attr_accessor	:effect #陣列，這個既能對目標造成的影響
	attr_accessor	:add_state #
	attr_accessor	:summon_user
	attr_accessor	:summon_hit
	attr_accessor	:add_state
	attr_accessor	:hit_frame	#第幾frame計算被攻擊目標的傷害
	attr_accessor	:back_stab  #背刺時的放大倍率，整數或浮點數，一般攻擊設定為1
	attr_reader		:ai_value
	attr_accessor	:hold_type
	attr_accessor	:stealth
	attr_accessor	:effect_since #投射物從哪一格開始有效 ， 投射物狀態均會處理此狀況
	attr_accessor	:projectile_type #是否為投射物，以及為何種投射物 0 :不是投射物，一般技能， 1 : 直射 , 2:曲射
	attr_accessor	:hit_detection
	attr_accessor	:range  #這個技能屬於遠攻還是近戰技能 :distant or :close_quarter
	attr_accessor	:summon_hold
	attr_accessor	:launch_since
	attr_accessor	:launch_max
	attr_accessor	:skill_id #對應到F9的技能
	attr_accessor	:no_dodge #不可被閃躲
	attr_accessor	:no_parry #破防
	attr_accessor	:hit_DecreaseDamage #多HIT減低傷害
	attr_accessor	:ignore_shieldEV #
	attr_accessor	:no_aggro #不會導致被目標aggro
	attr_accessor	:no_action_change #不會影響目標動作
	attr_accessor	:no_interrupt #技能不會受HIT影響 Unused
	attr_accessor	:no_interrupt_LonaOnly #技能不會受HIT影響 Unused
	attr_accessor	:ai_hold_to_max #AI hold技能HOLD至最大值
	attr_accessor	:is_support#屬於支援技能、如上buff、解除狀況
	#attr_accessor	:is_sex_skill# for all sex skills
	
	attr_accessor	:icon_index
	attr_accessor	:is_mind_control_usable #for npc control mode
	attr_accessor	:effect_launched #if skill effect launch
	attr_accessor	:dmg_type # spec check.  ex summon spec effect when killed by it.
	
	attr_accessor	:sap
	
	def initialize
		@wait_hit_frame=true
		@hit_cancel_mode= false
	end
	
	def wait_hit_frame=(wait=nil)
		wait.nil? ? @wait_hit_frame =true : @wait_hit_frame = wait
	end
	
	
	def range_type=(range_type)
		range_type.eql?("distant") ? @range_type=:distant :@range_type=:close_quarter
	end
	
	def ai_value=(aidata)
		@ai_value={}
		@ai_value[:assaulter] = aidata["assulter"].to_i
		@ai_value[:fucker] = aidata["fucker"].to_i
		@ai_value[:killer] = aidata["killer"].to_i
	end
	
	def hitbox=(hitbox)
		@hitbox=hitbox.eql?("box")
	end
	
	def hitbox?
		@hitbox
	end
	

	def is_projectile?
		@projectile_type ==1 || @projectile_type  ==2
	end

	def self.make_stat(effUnit)
		case effUnit["attribute_type"]
			when "BTmin";		attr_type=ActorStat::BUFF_TMIN
			when "BTmax";		attr_type=ActorStat::BUFF_TMAX
			when "max";			attr_type=ActorStat::MAX_STAT
			when "Tmax";		attr_type=ActorStat::MAX_TRUE
			when "Tmin";		attr_type=ActorStat::MIN_STAT
			when "min";			attr_type=ActorStat::MIN_TRUE
			when "current";		attr_type=ActorStat::CURRENT_STAT
		end
		lowest_req=effUnit["lowest_req"]
		highest_req=effUnit["highest_req"]
		lowest_req= lowest_req.nil? ? -66535 : lowest_req.to_i
		highest_req= highest_req.nil? ? 65535 : highest_req.to_i
		tmpSkillEffectData = [
			effUnit["attribute_name"],
			attr_type,
			effUnit["adjustor"],
			effUnit["adjustment"].to_f,
			effUnit["stats_key"],
			effUnit["stats_value"],
			effUnit["stats_filter"],
			lowest_req,
			highest_req
		]
		SkillEffect.new(*tmpSkillEffectData)
	end
	
	
	def self.make_compare(jsonData)
		compare=Array.new(jsonData.length){
			|index|
			SkillCompare.new(make_stat(jsonData[index]["base"]),make_stat(jsonData[index]["compare"]))
		}
		compare
	end	
	
	def self.make_effect_compare(jsonData)
			compare=Array.new(jsonData.length){|index|
			tmpSkillCompareData= [
				make_stat(jsonData[index]["base"]),
				make_stat(jsonData[index]["compare"]),
				make_stat(jsonData[index]["damage"]),
				jsonData[index]["popup_type"],
				jsonData[index]["race_only"],
				jsonData[index]["race_skip"]
			]
			SkillCompare.new(*tmpSkillCompareData)
		}
		compare
	end	
	
	#def add_state=(jsonData) #old
	#	@add_state=Array.new(jsonData.length){|index|
	#		data=jsonData[index]
	#		states_ids=Array.new(data["states"].length){|state_index|
	#			state_id=$data_states.index{|state|
	#				next if state.nil?
	#				state.item_name.eql?(data["states"][state_index])
	#			}
	#			state_id
	#		}
	#		SkillAddState.new(data["popup_type"],states_ids,data["chance"])
	#	}
	#end
	def add_state=(jsonData) #state name ver
		@add_state=Array.new(jsonData.length){|index|
			data=jsonData[index]
			SkillAddState.new(data["popup_type"],data["states"],data["chance"])
		}
	end
	
	def hold_type=(jsonData)
		case jsonData
			when "none";@hold_type = 0;	#一般攻擊，沒有holding
			when "holding";@hold_type = 1; #舉著一個東西啥事都沒有
			when "blocking";@hold_type = 2; #舉盾
			when "energizing";@hold_type = 3; #蓄力攻擊
			else @hold_type = 0;
		end
	end
	def hit_cancel_mode=(jsonData)
		case jsonData
			when "Always";@hit_cancel_mode = 0; 		#skill always cancel after hit frame
			when "Differen";@hit_cancel_mode = 1;	#skill cancel when hit and must not == last_skill 
			when "Last";@hit_cancel_mode = 2; 		#skill cancel when hit and hit_cancel_req_last_skill == last_skill.name
			else @hit_cancel_mode = false;			
		end
	end
	
	def holding?
		@hold_type == 1 || @hold_type == 2 || @hold_type == 3
	end
	
	def simply_holding?
		@hold_type == 1
	end
	
	def blocking?
		@hold_type == 2
	end	
	
	def energizing?
		@hold_type == 3
	end
	
	def matching_frame?
		@cooldown== -1
	end
	
	def sap?
		@sap
	end
	def ai_hold_to_max?
		@ai_hold_to_max
	end
	
	
	
	def self.load_from_json(jsonHash)
		skd=self.new
		#skd.name					= jsonHash["name"] if jsonHash["name"]
		skd.name					= jsonHash["item_name"] #if jsonHash["item_name"]
		skd.dmg_type				= jsonHash["dmg_type"]
		skd.hold_type				= jsonHash["hold_type"]
		skd.hold_animation			= jsonHash["hold_animation"].nil? || jsonHash["hold_animation"]=="animation_nil" ? nil : jsonHash["hold_animation"]
		skd.chs_animation			= jsonHash["CHS_animation"].nil? || jsonHash["CHS_animation"]=="animation_nil" ? nil : jsonHash["CHS_animation"]
		skd.wait_hit_frame			= jsonHash["wait_hit_frame"]
		skd.hit_cancel_mode			= jsonHash["hit_cancel_mode"]
		skd.hit_cancel_req_last_skill= jsonHash["hit_cancel_req_last_skill"]
		skd.hit_cancel_req_a_tgt	= jsonHash["hit_cancel_req_a_tgt"]
		skd.cost					= make_compare(jsonHash["cost"])
		skd.effect					= make_effect_compare(jsonHash["effect"])
		skd.hit_frame				= jsonHash["hit_frame"]
		skd.add_state				= jsonHash["add_state"]
		skd.ai_value				= jsonHash["ai_value"]
		skd.range					= jsonHash["range"]
		skd.hitbox					= jsonHash["hitbox"]
		skd.back_stab				= jsonHash["back_stab"]
		skd.hit_detection			= eval("Sensors::#{jsonHash["hit_detection"]}")
		skd.summon_user				= jsonHash["summon_user"]
		skd.stealth					= jsonHash["stealth"]
		skd.summon_hit				= jsonHash["summon_hit"]
		skd.effect_since			= jsonHash["effect_since"].to_i
		skd.projectile_type			= jsonHash["projectile_type"].to_i
		skd.summon_hold				= jsonHash["summon_hold"]
		skd.launch_since			= jsonHash["launch_since"]
		skd.no_dodge				= jsonHash["no_dodge"]
		skd.no_parry				= jsonHash["no_parry"]
		skd.hit_DecreaseDamage		= jsonHash["hit_DecreaseDamage"]
		skd.no_aggro				= jsonHash["no_aggro"].nil? ? false : jsonHash["no_aggro"]
		skd.ai_hold_to_max			= jsonHash["ai_hold_to_max"].nil? ? false : jsonHash["ai_hold_to_max"]
		skd.no_interrupt			= jsonHash["no_interrupt"].nil? ? false : jsonHash["no_interrupt"]
		skd.no_interrupt_LonaOnly	= jsonHash["no_interrupt_LonaOnly"].nil? ? false : jsonHash["no_interrupt_LonaOnly"]
		skd.no_action_change		= jsonHash["no_action_change"].nil? ? false : jsonHash["no_action_change"]
		skd.launch_max				= jsonHash["launch_max"]
		skd.sap						= jsonHash["sap"]
		skd.is_support				= jsonHash["is_support"].nil? ? false : jsonHash["is_support"]
		skd.ignore_shieldEV			= jsonHash["ignore_shieldEV"].nil? ? false : jsonHash["ignore_shieldEV"]
		#skd.is_sex_skill			= jsonHash["is_sex_skill"]
		skd.icon_index				= jsonHash["icon_index"]
		skd.is_mind_control_usable	= jsonHash["is_mind_control_usable"]
		
		
		skd
	end
	
	#Struct.new("SkillCompare",:base,:compare,:damage,:popup_type)
	#Struct.new("SkillEffect",:attr,:attr_type,:type,:adjust,:stats_key,:stats_value,:stats_filter,:lowest_req,:highest_req)
	
	class SkillCompare
		attr_reader :base
		attr_reader :compare
		attr_reader :damage
		attr_reader :popup_type
		attr_reader :race_only
		attr_reader :race_skip
		def initialize(base=nil,compare=nil,damage=nil,popup_type=nil,race_only=nil,race_skip=nil)
			@base		= base
			@compare	= compare
			@damage		= damage
			@race_only	= race_only
			@race_skip	= race_skip
			#@popup_type  = popup_type
			set_popup_type(popup_type)
		end
		
		def set_popup_type(type)
			case type
				when "None"; @popup_type = 0
				when "Health"; @popup_type = 1
				when "Sta"; @popup_type = 2
				when "Arousal"; @popup_type = 3
				when "PlusHealth"; @popup_type = 10
				when "PlusSta"; @popup_type = 11
			end
		end
	end
	
	
	def listCost
		resultExport = ""
		self.cost.each{|skillCost|
			next if !skillCost.base.attr
			resultExport += "\\C[1]#{skillCost.base.attr}#{skillCost.base.type}#{skillCost.base.adjust}\n"
		}
		resultExport
	end
	
	class SkillEffect
		attr_reader :attr   #attribute_name
		attr_reader :attr_type   #attr_type   max min tmax currretn blahbalbh
		attr_reader :type   ##adjustor + - x /
		attr_reader :adjust #["adjustment"].to_f, NUM  result
		attr_reader :stats_key #
		attr_reader :stats_value
		attr_reader :stats_filter
		attr_reader :lowest_req
		attr_reader :highest_req
		attr_reader :compare_race
		attr_reader :compare_race_ignore
		def initialize(attr,attr_type,type,adjust,stats_key,stats_value,stats_filter,lowest_req,highest_req)
			@attr			= attr
			@attr_type	    = attr_type
			@type	        = type
			@adjust	        = adjust
			@stats_key	    = stats_key
			@stats_value	= stats_value
			@stats_filter	= stats_filter
			@lowest_req	    = lowest_req
			@highest_req	= highest_req
		end
	end
	
	class SkillAddState
		attr_reader :popup_type
		attr_reader :states
		attr_reader :chance
		def initialize(popup_type,states,chance)
			@popup_type=popup_type.eql?("State") ? 4 : 0
			@states	   =states
			@chance    =chance
		end
	end
	
	
end



