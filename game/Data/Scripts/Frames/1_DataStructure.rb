#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#============================================================================================================
#這個腳本專門用來處理資料結構類型物件的惡搞，如裝在額外的模組、增加功能等。
#============================================================================================================
############################################## default RGSSmodule RPG
#module RPG
#	class System
#		def initialize
#			@game_title = ''
#			@version_id = 0
#			@japanese = true
#			@party_members = [1]
#			@currency_unit = ''
#			@elements = [nil, '']
#			@skill_types = [nil, '']
#			@weapon_types = [nil, '']
#			@armor_types = [nil, '']
#			@switches = [nil, '']
#			@variables = [nil, '']
#			@boat = RPG::System::Vehicle.new
#			@ship = RPG::System::Vehicle.new
#			@airship = RPG::System::Vehicle.new
#			@title1_name = ''
#			@title2_name = ''
#			@opt_draw_title = true
#			@opt_use_midi = false
#			@opt_transparent = false
#			@opt_followers = true
#			@opt_slip_death = false
#			@opt_floor_death = false
#			@opt_display_tp = true
#			@opt_extra_exp = false
#			@window_tone = Tone.new(0,0,0)
#			@title_bgm = RPG::BGM.new
#			@battle_bgm = RPG::BGM.new
#			@battle_end_me = RPG::ME.new
#			@gameover_me = RPG::ME.new
#			@sounds = Array.new(24) { RPG::SE.new }
#			@test_battlers = []
#			@test_troop_id = 1
#			@start_map_id = 1
#			@start_x = 0
#			@start_y = 0
#			@terms = RPG::System::Terms.new
#			@battleback1_name = ''
#			@battleback2_name = ''
#			@battler_name = ''
#			@battler_hue = 0
#			@edit_map_id = 1
#		end
#		attr_accessor :game_title
#		attr_accessor :version_id
#		attr_accessor :japanese
#		attr_accessor :party_members
#		attr_accessor :currency_unit
#		attr_accessor :skill_types
#		attr_accessor :weapon_types
#		attr_accessor :armor_types
#		attr_accessor :elements
#		attr_accessor :switches
#		attr_accessor :variables
#		attr_accessor :boat
#		attr_accessor :ship
#		attr_accessor :airship
#		attr_accessor :title1_name
#		attr_accessor :title2_name
#		attr_accessor :opt_draw_title
#		attr_accessor :opt_use_midi
#		attr_accessor :opt_transparent
#		attr_accessor :opt_followers
#		attr_accessor :opt_slip_death
#		attr_accessor :opt_floor_death
#		attr_accessor :opt_display_tp
#		attr_accessor :opt_extra_exp
#		attr_accessor :window_tone
#		attr_accessor :title_bgm
#		attr_accessor :battle_bgm
#		attr_accessor :battle_end_me
#		attr_accessor :gameover_me
#		attr_accessor :sounds
#		attr_accessor :test_battlers
#		attr_accessor :test_troop_id
#		attr_accessor :start_map_id
#		attr_accessor :start_x
#		attr_accessor :start_y
#		attr_accessor :terms
#		attr_accessor :battleback1_name
#		attr_accessor :battleback2_name
#		attr_accessor :battler_name
#		attr_accessor :battler_hue
#		attr_accessor :edit_map_id
#	end
#end
#
#
#module RPG
#	class System
#		class Terms
#			def initialize
#				@basic = Array.new(8) {''}
#				@params = Array.new(8) {''}
#				@etypes = Array.new(5) {''}
#				@commands = Array.new(23) {''}
#			end
#			attr_accessor :basic
#			attr_accessor :params
#			attr_accessor :etypes
#			attr_accessor :commands
#		end
#	end
#end
#module RPG
#	class System
#		class Vehicle
#			#def initialize
#			#	@character_name = ''
#			#	@character_index = 0
#			#	@bgm = RPG::BGM.new
#			#	@start_map_id = 0
#			#	@start_x = 0
#			#	@start_y = 0
#			#end
#			#attr_accessor :character_name
#			#attr_accessor :character_index
#			#attr_accessor :bgm
#			#attr_accessor :start_map_id
#			#attr_accessor :start_x
#			#attr_accessor :start_y
#		end
#	end
#end
#module RPG
#	class System
#		class TestBattler
#			#def initialize
#			#	@actor_id = 1
#			#	@level = 1
#			#	@equips #end= [0,0,0,0,0]
#			#end
#			#attr_accessor :actor_id
#			#attr_accessor :level
#			#attr_accessor :equips
#		end
#	end
#end

#############################################
#class RPG::System
#	attr_accessor :game_title
#	attr_accessor :version_id
#	attr_accessor :start_x
#	attr_accessor :start_y
#	attr_accessor :edit_map_id
#	attr_accessor :party_members
#	attr_accessor :start_map_id
#	attr_accessor :switches
#	attr_accessor :weapon_types
#	attr_accessor :armor_types
#	def initialize
#		originalRgssData=load_data("Data/System.rvdata2")
#		jsonData = FileGetter.load_system_term_configs
#		@start_x = originalRgssData.start_x
#		@start_y = originalRgssData.start_y
#		@edit_map_id = originalRgssData.edit_map_id
#		@party_members = originalRgssData.party_members
#		@start_map_id = originalRgssData.start_map_id
#		@switches = originalRgssData.switches
#		@game_title = originalRgssData.game_title #$GameINI["Game"]["Title"]
#		@version_id = originalRgssData.version_id#$GameINI["Game"]["CreationDate"]
#		@weapon_types = jsonData[weapon_types] if jsonData[weapon_types]
#		@armor_types = jsonData[armor_types] if jsonData[armor_types]
#
#		#data.each do |hashName,hashData|
#		#	p "overwrite $data_system #{hashName}"
#		#	eval("$data_system.#{hashName} = hashData")
#		#end
#	end
#end
class RPG::Tileset
	attr_accessor :tileset_names
end
class RPG::CommonEvent
	include ItemConfigs #module/ItemConfigs.rb
	attr_accessor :item_name
	attr_accessor :trigger
	attr_accessor :switch_id
	attr_accessor :name
	def autorun?
		@trigger == 1
	end
	def parallel?
		@trigger == 2
	end
end
class RPG::MapInfo
	attr_accessor :filename
	attr_accessor :id
end
class RPG::BaseItem

	attr_accessor :description
	attr_accessor :name
	attr_accessor :item_name
	attr_accessor :configured
	attr_accessor :type_tag
	attr_accessor :type
	attr_accessor :sell_price
	attr_accessor :addData
	attr_accessor :dmg_multiplier
	attr_accessor :weight
	attr_accessor :player_nap_state_control
	attr_accessor :player_nap_get_state_when
	attr_accessor :is_combat_state
	attr_accessor :is_daily_state
	attr_accessor :pot_data
	attr_accessor :rot_progress
	attr_accessor :raw_date
	attr_accessor :player_add_state_SndLib
	attr_accessor :equip_part_covered
	attr_accessor :player_item_usage_manage_state
	attr_accessor :player_item_remove_equip
	attr_accessor :player_item_usage_event_summon
	attr_accessor :player_item_usage_eval
	attr_accessor :menu_hide_lvl
	attr_accessor :base_equip_slots
	attr_accessor :fixed_equip_type
	attr_accessor :fixed_hard_equip_type
	attr_accessor :sealed_equip_type
	attr_accessor :etype_id
	attr_accessor :wtype_id
	attr_accessor :itype_id
	attr_accessor :atype_id
	attr_accessor :stype_id
	attr_accessor :wtype_seal
	attr_accessor :atype_seal
	attr_accessor :added_skills
	attr_accessor :skill_sealed
	attr_accessor :wtype_ok
	attr_accessor :atype_ok
	attr_accessor :max_stacks
	attr_accessor :lona_effect
	attr_accessor :use_item_effect
	attr_accessor :lonaStat_json_hash
	attr_accessor :item_ext_SkillName
	attr_accessor :item_ext_CostAfterLaunch
	attr_accessor :item_ext_DirectUsage
	attr_accessor :force_key_item
	attr_accessor :consumable
	attr_accessor :spread_when_sex
	attr_accessor :common_tags
	attr_accessor :key_item
	attr_accessor :part_key_blacklist
	attr_accessor :banned_receiver_holes
	attr_accessor :hud_trace_icon
	
	def key_item?
		@type == "Key" || @type_tag == "Key" || @key_item
	end
	#def get_wtype_seal
	#	@wtype_seal
	#end
	#def get_atype_seal
	#	@atype_seal
	#end
	#def wtype_seal(id)
	#	return @wtype_seal.include?(id)
	#end
	#def atype_seal(id)
	#	return @atype_seal.include?(id)
	#end
	def wtype_okay(id)
		return @wtype_ok.include?(id)
	end
	def atype_okay(id)
		return @atype_ok.include?(id)
	end
	def load_notetags_aee
		@base_equip_slots = [] if !@base_equip_slots
		@fixed_equip_type = [] if !@fixed_equip_type
		@fixed_hard_equip_type = [] if !@fixed_hard_equip_type
		@sealed_equip_type = [] if !@sealed_equip_type
		@wtype_seal = [] if !@wtype_seal
		@atype_seal = [] if !@atype_seal
		@wtype_ok = [] if !@wtype_ok
		@atype_ok = [] if !@atype_ok
		@added_skills = [] if !@added_skills
		@skill_sealed = [] if !@skill_sealed
	end
end

class RPG::Actor
	include LonaStatAdapter #module/LonaState.rb
	include ItemConfigs #module/ItemConfigs.rb
	attr_accessor 		:chs_configured
	def configured_item?(addData)
		return false if addData.nil? || addData=={}
		return true
	end
	def get_category
		"DataActor"
	end
	
	def base_folder
		"Data/Effects/_Sys_Actor"
	end
	def load_notetags_aee
		super
		@base_equip_slots = $data_system.equip_type.keys if @base_equip_slots.empty?
	end
end
class RPG::Class
	include LonaStatAdapter #module/LonaState.rb
	include ItemConfigs #module/ItemConfigs.rb
	
	def configured_item?(addData)
		return false if addData.nil? || addData=={}
		return true
	end
	def get_category
		"DataClass"
	end
	
	def base_folder
		"Data/Effects/_Sys_Class"
	end
	
	def load_notetags_aee
		super
		@base_equip_slots = $data_system.equip_type.keys if @base_equip_slots.empty?
	end
end



class RPG::Skill
	include LonaStatAdapter #module/LonaState.rb
	include ItemConfigs #module/ItemConfigs.rb
	
	def load_notetags_aee
		remove_instance_variable(:@required_wtype_id1)	if @required_wtype_id1
		remove_instance_variable(:@required_wtype_id2)	if @required_wtype_id2
		remove_instance_variable(:@damage)				if @damage
		remove_instance_variable(:@mp_cost)				if @mp_cost
		remove_instance_variable(:@speed)				if @speed
		remove_instance_variable(:@features)			if @features
		remove_instance_variable(:@effects)				if @effects
		remove_instance_variable(:@element_id)			if @element_id
		remove_instance_variable(:@formula)				if @formula
		remove_instance_variable(:@variance)			if @variance
		remove_instance_variable(:@animation_id)		if @animation_id
		remove_instance_variable(:@scope)				if @scope
		remove_instance_variable(:@occasion)			if @occasion
		remove_instance_variable(:@message1)			if @message1
		remove_instance_variable(:@success_rate)		if @success_rate
		remove_instance_variable(:@critical)			if @critical
		remove_instance_variable(:@hit_type)			if @hit_type
		remove_instance_variable(:@tp_cost)				if @tp_cost
		remove_instance_variable(:@repeats)				if @repeats
		remove_instance_variable(:@tp_gain)				if @tp_gain
	end
	
	def get_category
		"DataSkill"
	end
	def base_folder
		"Data/Effects/Skill"
	end
end


class RPG::State
	include LonaStatAdapter #module/LonaState.rb
	include ItemConfigs #module/ItemConfigs.rb
	
	def load_notetags_aee
		super
		@max_stacks = 1 if !@max_stacks
		remove_instance_variable(:@message1)				if @message1
		remove_instance_variable(:@message3)				if @message3
		remove_instance_variable(:@message2)				if @message2
		remove_instance_variable(:@message4)				if @message4
		remove_instance_variable(:@remove_at_battle_end)	if @remove_at_battle_end
		#remove_instance_variable(:@features)				if @features
		#remove_instance_variable(:@restriction)			if @restriction
		#remove_instance_variable(:@priority)				if @priority
		#remove_instance_variable(:@release_by_damage)		if @release_by_damage
	end
	def get_category
		"DataState"
	end
	
	def base_folder
		"Data/Effects/States"
	end
	def stun?
		@restriction == 4
	end
end

class RPG::Item
	include LonaStatAdapter #module/LonaState.rb
	include ItemConfigs #module/ItemConfigs.rb
	def get_category
		"DataItem"
	end
	
	def base_folder
		"Data/Effects/Items"
	end
	
	def load_notetags_aee
		@weight = 0.0
		@dmg_multiplier = 1
		@itype_id = 1
		@common_tags = {}
		remove_instance_variable(:@occasion)				if @occasion
		remove_instance_variable(:@scope)					if @scope
		remove_instance_variable(:@animation_id)			if @animation_id
		remove_instance_variable(:@speed)					if @speed
		remove_instance_variable(:@features)				if @features
		remove_instance_variable(:@effects)					if @effects
		remove_instance_variable(:@damage)					if @damage
		remove_instance_variable(:@success_rate)			if @success_rate
		remove_instance_variable(:@hit_type)				if @hit_type
		remove_instance_variable(:@repeats)					if @repeats
		remove_instance_variable(:@tp_gain)					if @tp_gain
	end
	#def consumable
	#	@consumable
	#end
	def key_item?
		return super
	end
	
end

class RPG::System
	attr_accessor :equip_type
	attr_accessor :equip_type_name
	attr_accessor :weapon_slots
	attr_accessor :starting_equip
	attr_accessor :gear_stats_update_flow
end
class RPG::Weapon
	include LonaStatAdapter #module/LonaState.rb
	include ItemConfigs #module/ItemConfigs.rb
	def get_category
		"DataEquip"
	end
	
	def base_folder
		"Data/Effects/Weapons"
	end
	
	def load_notetags_aee
		super
		@weight = 0.0
		@dmg_multiplier = 1
		@common_tags = {}
	end
	def key_item?
		return super
	end
end

class RPG::Armor
	include LonaStatAdapter #module/LonaState.rb
	include ItemConfigs #module/ItemConfigs.rb
	def get_category
		"DataEquip"
	end
	
	def base_folder
		"Data/Effects/Armors"
	end
	def load_notetags_aee
		super
		@weight = 0.0
		@dmg_multiplier = 1
		@common_tags = {}
	end
	def key_item?
		return super
	end
end
