#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================

#==============================================================================
# ** Game_Actor
#------------------------------------------------------------------------------
#  This class handles actors. It is used within the Game_Actors class
# ($game_actors) and is also referenced from the Game_Party class ($game_party).
#==============================================================================

class Game_Actor < Game_Battler
  include Moods
  include Cums
  include Reproduction
  include Battle_System
	#--------------------------------------------------------------------------
	# * Public Instance Variables
	#--------------------------------------------------------------------------
	attr_accessor 		:name                     # Name
	attr_accessor 		:nickname                 # Nickname
	attr_reader   		:character_name           # character graphic filename
	attr_reader   		:character_index          # character graphic index
	attr_reader   		:face_name                # face graphic filename
	attr_reader   		:face_index               # face graphic index
	attr_accessor   	:class_id                 # class ID
	attr_accessor   	:level                    # level
	attr_accessor   	:action_input_index       # action number being input
	attr_accessor   	:last_skill               # For cursor memorization:  Skill
	attr_accessor 		:statMap					#????(???PORTRAIT???)????canvas????LonaPortrait??
	attr_accessor		:equips

	attr_accessor 		:immune_damage
	attr_accessor 		:immune_state_effect
	attr_accessor 		:immune_tgt_states #player immune those state
	attr_accessor 		:immune_tgt_state_type #player immune those state
	attr_accessor 		:original_immune_tgt_states #original immune state
	attr_accessor		:hit_LinkToMaster
	attr_accessor		:master
	attr_accessor 		:shieldEV
	attr_accessor 		:is_object
	attr_accessor 		:is_a_ProtectShield
	attr_accessor		:is_tiny
	attr_accessor		:is_small
	attr_accessor		:is_flyer
	attr_accessor		:is_boss

	attr_reader 		:weight_carried
	attr_accessor		:chs_configured
	attr_accessor		:stat_changed #verb req update LonaCHS and portrait
	attr_accessor 		:skill_changed
	attr_reader 		:actStat
	attr_reader 		:receiver_type
	attr_reader 		:state_steps
	attr_reader 		:state_frames
	attr_accessor		:user_redirect
	attr_accessor		:ext_items
	attr_accessor		:fucker_target   #???????????????grab????????????
	attr_accessor		:prev_health
	attr_accessor		:prev_sta
	attr_accessor		:equip_part_covered
	attr_accessor		:pubicHair_Vag_GrowCount
	attr_accessor		:pubicHair_Vag_GrowRate
	attr_accessor		:pubicHair_Vag_GrowMAX
	attr_accessor		:pubicHair_Anal_GrowCount
	attr_accessor		:pubicHair_Anal_GrowRate
	attr_accessor		:pubicHair_Anal_GrowMAX
	attr_accessor		:part_key_blacklist

  #from STAT_SETTINGS, STAT_SETTING???Editables/94...rb ? Editables/96...rb??
	STATMAP_INITIALIZED="-"
	STAT_CHANGED=7
	BUFF_TMIN=6
	BUFF_TMAX=5
	MIN_TRUE=4
	MAX_TRUE=3
	MAX_STAT=2
	MIN_STAT=1
	CURRENT_STAT=0
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
	def initialize(actor_id)
		super()
		setup(actor_id)
		@last_skill = Game_BaseItem.new
		@action_state=:none
		@skill_changed=true
		@user_redirect=false
		@receiver_type = 5
		@fucker_target=nil
	end
  #--------------------------------------------------------------------------
  # * Setup
  #--------------------------------------------------------------------------
	def init_statMap
		@statMap={"char_name" =>"Lona",
				"canvas"=>System_Settings::LONA_PORTRAIT_CANVAS_SETTING,
					"pose"=>"pose1"

				}
		self.stat["pose"]=@statMap["pose"]
	end
	#def lona_gears
	#	["equip_head","equip_TopExtra","equip_hair","equip_Top","equip_MidExtra","equip_Mid","equip_Bot","SecondArm","MainArm"]
	#end

	def setup(actor_id)
		p "actor setup actor_id=>#{actor_id}"
		@actor_id = actor_id
		@name = actor.name
		@nickname = actor.nickname
		init_graphics
		@class_id = actor.class_id
		@level = actor.initial_level
		@exp = {}
		@ext_items = [nil,nil,nil,nil,nil]
		@equips = []
		@hom_effects_data = []
		@immune_tgt_states = []
		@original_immune_tgt_states = []
		@immune_tgt_state_type = []
		@equip_part_covered = []
		@part_key_blacklist = []
		#@add_specs=Note.get_data(actor.note)
		#@chs_configured=@add_specs["chs_config"] #old data  we dont need it anymore?
		@debug_attribute=false
		@mouth_block=0
		@weigth_carried=0 #?????????
		@max_stats=Hash.new
		@hit_LinkToMaster = false
		@is_object = false
		@immune_state_effect = false
		@immune_damage = false
		@master = nil

		@actStat=LonaActorStat.new #??????????????stat??????????????????????????????
		@actStat.npc_name="Lona"
		@state_frames={}
		@name_order = $data_lona_portrait[0]
		init_exp
		init_lonaStat #??????@stat???????portrait?????@prt_stat??
		init_statMap
		initialize_battle_system
		stat["Race"] = "Human"
		stat["always"]="on"
		stat["persona"]="typical"
		stat["sex_pos"]=-1
		init_cums
		clear_param_plus
		clear_states
		init_rec_stats #96_Game_Actor_Attribute.rb
		@prev_health = self.health
		@prev_sta = self.sta
		@actStat.check_stat_old
		@actStat.actor = self
	end
	# called in DataManager.setup_new_game
	def post_setup
		init_equips(actor.equips)
		init_skills
		init_code_in_editable #???Editable
		setup_first_cycle
		update_lonaStat_tera
	end


	def init_lonaStat
		#portrait?configuration
		@prt_stat=Hash.new
		#state
		for x in 0..$data_states.length
			next if $data_states[x].nil?
			next if $data_states[x].note.eql? "" && !$data_states[x].lonaStat_json_hash
			next unless note=$data_states[x].note || $data_states[x].lonaStat_json_hash
			$data_states[x].lonaStat_json_hash ? statHash=$data_states[x].lonaStat_json_hash : statHash=Note.get_data(note)
			$data_states[x].createLonaState(statHash) if !$data_states[x].lonaStat
			statName=statHash["stat"]
			next if !statName
			if(statHash["type"].eql?("numeric"))
				statInitial=statHash["initial"].to_i
			else
				statInitial=statHash["initial"]
			end
			@prt_stat[statName]=statInitial
		end


		#???????????????
		for u in 0..$data_weapons.length
			next if $data_weapons[u].nil?
			next if $data_weapons[u].note.eql?("") && !$data_weapons[u].lonaStat_json_hash
			$data_weapons[u].lonaStat_json_hash ? statHash=$data_weapons[u].lonaStat_json_hash : statHash=Note.get_data($data_weapons[u].note)
			$data_weapons[u].createLonaState(statHash) if !$data_weapons[u].lonaStat
			$data_weapons[u].lonaStat_json_hash = nil
			@prt_stat[statHash["stat"]]=""
		end

		#???????????????
		for e in 0..$data_armors.length
			next if $data_armors[e].nil?
			next if $data_armors[e].note.eql?("") && !$data_armors[e].lonaStat_json_hash
			$data_armors[e].lonaStat_json_hash ? statHash=$data_armors[e].lonaStat_json_hash : statHash=Note.get_data($data_armors[e].note)
			$data_armors[e].createLonaState(statHash) if !$data_armors[e].lonaStat
			$data_armors[e].lonaStat_json_hash = nil
			@prt_stat[statHash["stat"]]=""
		end
		@prt_stat["head"]="head"
		@prt_stat["subpose"]=1
		@prt_stat["dirt"]=0
		@prt_stat["preg"]=0
		@prt_stat["always"]="on"
		@prt_stat["persona"]="typical"
		@prt_stat["sex_pos"]=-1
	end



  #--------------------------------------------------------------------------
  # * Get Actor Object
  #--------------------------------------------------------------------------
  def actor
    $data_actors[@actor_id]
  end
  #--------------------------------------------------------------------------
  # * Initialize Graphics
  #--------------------------------------------------------------------------
  def init_graphics
    @character_name = actor.character_name
    @character_index = actor.character_index
    #@face_name = actor.face_name
    #@face_index = actor.face_index
  end


	def charName
		@name
	end

	def portrait
		$game_portraits.getPortrait(@name)
	end

  #??STA
  #STA????TerrainTag???????Game_Player??????Game_Map??
  def deduct_sta(value)
    @sta-=value
    #output p "sta : "+@sta.to_s+"src = Game_Actor"
    check_sta_event
  end

  #??sta???????????????
  def check_sta_event
    check_day_night
    check_tired
  end

  #????????
  def check_day_night
    #if(@sta<@napThreshold)
    #    $game_map.day_night_switch
   # end
  end

  #???????????????????
  def check_tired

  end

	def setup_state(state_id,target_stack)  #?????STATE???
		state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		return prp "max_state_stack? #{state_id} not found",1 if !state_id
		cur_state_count= state_stack(state_id)
		actionCount=target_stack-cur_state_count
		return if actionCount>=0 and max_state_stack?(state_id)
		actCount=actionCount.abs
		return if actCount==0
		for c in 0...actCount
			if(actionCount>0)
				add_state(state_id)
			else
				remove_state_stack(state_id)
			end
		end
	end

  #--------------------------------------------------------------------------
  # * Get Total EXP Required for Rising to Specified Level
  #--------------------------------------------------------------------------
  def exp_for_level(level)
    self.class.exp_for_level(level)
  end
  #--------------------------------------------------------------------------
  # * Initialize EXP
  #--------------------------------------------------------------------------
  def init_exp
    @exp[@class_id] = current_level_exp
  end
  #--------------------------------------------------------------------------
  # * Get Experience
  #--------------------------------------------------------------------------
  def exp
    @exp[@class_id]
  end
  #--------------------------------------------------------------------------
  # * Get Minimum EXP for Current Level
  #--------------------------------------------------------------------------
  def current_level_exp
    exp_for_level(@level)
  end
  #--------------------------------------------------------------------------
  # * Get EXP for Next Level
  #--------------------------------------------------------------------------
  def next_level_exp
    exp_for_level(@level + 1)
  end
  #--------------------------------------------------------------------------
  def max_exp
    exp_for_level(self.max_level + 2)
  end
  #--------------------------------------------------------------------------
  # * Maximum Level
  #--------------------------------------------------------------------------
	def max_level
		actor.max_level
	end
  #--------------------------------------------------------------------------
  # * Determine Maximum Level
  #--------------------------------------------------------------------------
	def max_level?
		@level >= max_level
	end
  #--------------------------------------------------------------------------
  # * Initialize Skills
  #--------------------------------------------------------------------------
  def init_skills
    @skills = []
    self.class.learnings.each do |learning|
      learn_skill(learning.skill_id) if learning.level <= @level
    end
  end
  #--------------------------------------------------------------------------
  # * Initialize Equipment
  #     equips:  An array of initial equipment
  #--------------------------------------------------------------------------
	#def init_equips(equips)
	#	@equips = Array.new(equip_slots.size) { Game_BaseItem.new }
	#	equips.each_with_index do |item_id, i|
	#	etype_id = index_to_etype_id(i)
	#	slot_id = empty_slot(etype_id)
	#	@equips[slot_id].set_equip(etype_id == 0, item_id) if slot_id
	#	end
	#	refresh
	#	equip_extra_starting_equips
	#end

	#init_equip calls refresh before everything is setup for update_lonaStat.
	def init_equips(equips)
		@equips = Array.new(equip_slots.size) { Game_BaseItem.new }
		equips.each_with_index do |item_id, i|
			#etype_id = index_to_etype_id(i)
			etype_id = i
			slot_id = empty_slot(etype_id)
			report_portrait_stat(@equips[slot_id].object.lonaStat.statName, nil) if !@equips[slot_id].object.nil?
			is_weapon = $data_system.weapon_slots.include?(etype_id)
			@equips[slot_id].set_equip(is_weapon, item_id) if slot_id #########<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<, is weapon?
			report_portrait_stat(@equips[slot_id].object.lonaStat.statName, @equips[slot_id].object.lonaStat.affectValue) if !@equips[slot_id].object.nil?
		end
		#refresh # not everything is set up for update_lonaStat at this point. So refresh will come later.

		#from 119_ACE_Equip.rb equip_extra_starting_equips
		for equip_name in $data_system.starting_equip["NoerNormal"]
			tgt_gear = $data_ItemName[equip_name]
			next if tgt_gear.nil?
			etype_id = tgt_gear.etype_id
			next unless equip_slots.include?(etype_id)
			slot_id = empty_slot(etype_id)
			report_portrait_stat(@equips[slot_id].object.lonaStat.statName, nil) if !@equips[slot_id].object.nil?
			is_weapon =  $data_system.weapon_slots.include?(etype_id)
			@equips[slot_id].set_equip(is_weapon, tgt_gear.id)  #########<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<, is weapon?
			report_portrait_stat(@equips[slot_id].object.lonaStat.statName, @equips[slot_id].object.lonaStat.affectValue) if !@equips[slot_id].object.nil?
		end
		#refresh # It also calls refresh. And later yet again.
		refresh_equip_effects #update_lonaStat will be called soon and it needs carryWeight
	end
  #--------------------------------------------------------------------------
  # * Convert Index Set by Editor to Equipment Type ID
  #--------------------------------------------------------------------------
#  def index_to_etype_id(index)
#		index
#  end
  #--------------------------------------------------------------------------
  # * Convert from Equipment Type to List of Slot IDs
  #--------------------------------------------------------------------------
  def slot_list(etype_id)
    result = []
    equip_slots.each_with_index {|e, i| result.push(i) if e == etype_id }
    result
  end
  #--------------------------------------------------------------------------
  # * Convert from Equipment Type to Slot ID (Empty Take Precedence)
  #--------------------------------------------------------------------------
  def empty_slot(etype_id)
    list = slot_list(etype_id)
    list.find {|i| @equips[i].is_nil? } || list[0]
  end
  #--------------------------------------------------------------------------
  # overwrite method: equip_slots
  #--------------------------------------------------------------------------
  def equip_slots
	  #return equip_slots_dual if dual_wield?
	  return equip_slots_normal
  end

  #--------------------------------------------------------------------------
  # new method: equip_slots_normal
  #--------------------------------------------------------------------------
  def equip_slots_normal
	  return self.actor.base_equip_slots if self.actor.base_equip_slots != []
	  return self.class.base_equip_slots
  end
  #--------------------------------------------------------------------------
  # * Get Weapon Object Array
  #--------------------------------------------------------------------------
  def weapons
    @equips.select {|item| item.is_weapon? }.collect {|item| item.object }
  end
  #--------------------------------------------------------------------------
  # * Get Armor Object Array
  #--------------------------------------------------------------------------
  def armors
    @equips.select {|item| item.is_armor? }.collect {|item| item.object }
  end
  #--------------------------------------------------------------------------
  # * Get Equipped Item Object Array
  #--------------------------------------------------------------------------
	def equips
		@equips.collect {|item| item.object }
	end
  #--------------------------------------------------------------------------
  # * Determine if Equipment Change Possible
  #     slot_id:  Equipment slot ID
  #--------------------------------------------------------------------------
	def equip_change_ok?(slot_id)
		slot_id = $data_system.equip_type_name[slot_id] if slot_id.is_a?(String)
		return false if equip_slot_fixed?(equip_slots[slot_id])
		return false if equip_slot_sealed?(equip_slots[slot_id])
		return true
	end
  #--------------------------------------------------------------------------
  # * Change Equipment
  #     slot_id:  Equipment slot ID
  #     item:    Weapon/armor (remove equipment if nil)
  #--------------------------------------------------------------------------
	def change_equip(slot_id, item)
		slot_id = $data_system.equip_type_name[slot_id] if slot_id.is_a?(String)
		item = $data_ItemName[item] if item.is_a?(String)
		oldItem = @equips[slot_id].object #if @equips[slot_id] ########## tera part
		########## ace part
		if item.nil? && !@optimize_clear
			etype_id = equip_slots[slot_id]
			return unless $data_system.equip_type[etype_id][1]
		elsif item.nil? && @optimize_clear
			etype_id = equip_slots[slot_id]
			return unless $data_system.equip_type[etype_id][2]
		end
		@equips[slot_id] = Game_BaseItem.new if @equips[slot_id].nil?
		########## ace part

		########## rgss part
		return unless trade_item_with_party(item, equips[slot_id]) #dont delete this... or item will dispare.
		return if item && equip_slots[slot_id] != item.etype_id
		@equips[slot_id].object = item
		refresh_equip_part_covered
		map_token.light_check
		refresh
		update_chs
		$game_player.refresh_chs
		########## tera part
		newItem = @equips[slot_id].object
		if newItem!=oldItem then
			report_portrait_stat(oldItem.lonaStat.statName, nil) if !oldItem.nil?
			report_portrait_stat(newItem.lonaStat.statName, newItem.lonaStat.affectValue) if !newItem.nil?
		end
	end
	def refresh_equip_part_covered
		@equip_part_covered = []
		for i in 0...equips.length
			eqp=equips[i]
			next if eqp.nil?
			@equip_part_covered = (@equip_part_covered+eqp.equip_part_covered).uniq if eqp.equip_part_covered
		end
	end
  #--------------------------------------------------------------------------
  # * Forcibly Change Equipment
  #     slot_id:  Equipment slot ID
  #     item:     Weapon/armor (remove equipment if nil)
  #--------------------------------------------------------------------------


  def force_change_equip(slot_id, item)
    @equips[slot_id].object = item
    release_unequippable_items(false)
    refresh
  end
  #--------------------------------------------------------------------------
  # * Trade Item with Party
  #     new_item:  Item to get from party
  #     old_item:  Item to give to party
  #--------------------------------------------------------------------------
  def trade_item_with_party(new_item, old_item)
    return false if new_item && !$game_party.has_item?(new_item)
    $game_party.gain_item(old_item, 1)
    $game_party.lose_item(new_item, 1)
    return true
  end
  #--------------------------------------------------------------------------
  # * Change Equipment (Specify with ID)
  #     slot_id:  Equipment slot ID
  #     item_id:  Weapons/armor ID
  #--------------------------------------------------------------------------
	def change_equip_by_id(slot_id, item_id)
		if equip_slots[slot_id] == 0
			change_equip(slot_id, $data_weapons[item_id])
		else
			change_equip(slot_id, $data_armors[item_id])
		end
	end
  #--------------------------------------------------------------------------
  # * Discard Equipment
  #     item:  Weapon/armor to discard
  #--------------------------------------------------------------------------
	def discard_equip(item)
		report_portrait_stat(item.lonaStat.statName, nil) if item && item.lonaStat
		slot_id = equips.index(item)
		@equips[slot_id].object = nil if slot_id
	end
  #--------------------------------------------------------------------------
  # * Remove Equipment that Cannot Be Equipped
  #     item_gain:  Return removed equipment to party.
  #--------------------------------------------------------------------------
	def release_unequippable_items(item_gain = true)
		loop do
			last_equips = equips.dup
			@equips.each_with_index do |item, i|
				if !equippable?(item.object) || item.object.etype_id != equip_slots[i]
					if !item.object.nil?
						report_portrait_stat(item.object.lonaStat.statName, nil)
					end
					trade_item_with_party(nil, item.object) if item_gain
					item.object = nil
				end
			end
			return if equips == last_equips
		end
	end
  #--------------------------------------------------------------------------
  # * Remove All Equipment
  #--------------------------------------------------------------------------
  def clear_equipments
    equip_slots.size.times do |i|
      change_equip(i, nil) if equip_change_ok?(i)
    end
  end
  #--------------------------------------------------------------------------
  # * Ultimate Equipment
  #--------------------------------------------------------------------------
  def optimize_equipments
    clear_equipments
    equip_slots.size.times do |i|
      next if !equip_change_ok?(i)
      items = $game_party.equip_items.select do |item|
        item.etype_id == equip_slots[i] &&
        equippable?(item) && item.performance >= 0
      end
      change_equip(i, items.max_by {|item| item.performance })
    end
  end
  #--------------------------------------------------------------------------
  # * Determine if Skill-Required Weapon Is Equipped
  #--------------------------------------------------------------------------
  #def skill_wtype_ok?(skill)
  #  wtype_id1 = skill.required_wtype_id1
  #  wtype_id2 = skill.required_wtype_id2
  #  return true if wtype_id1 == 0 && wtype_id2 == 0
  #  return true if wtype_id1 > 0 && wtype_equipped?(wtype_id1)
  #  return true if wtype_id2 > 0 && wtype_equipped?(wtype_id2)
  #  return false
  #end
  #--------------------------------------------------------------------------
  # * Determine if Specific Type of Weapon Is Equipped
  #--------------------------------------------------------------------------
  def wtype_equipped?(wtype_id)
    weapons.any? {|weapon| weapon.wtype_id == wtype_id }
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
	def refresh
		release_unequippable_items
		@actStat.reset_reality_stats #????????????pry_plus?? pry_plus???????
		@actStat.reset_definition
		@actStat.reset_stat_def
		refresh_effects
		@skill_changed =true
		refresh_ext_item
		#super
		@actStat.check_stat_old
		recalculate_stats
	end
	def refresh_effects
		@hom_effects_data = []
		refresh_equip_effects
		refresh_state_effects
	end
  #--------------------------------------------------------------------------
  # * Determine if Actor or Not
  #--------------------------------------------------------------------------
  def actor?
    return true
  end
  #--------------------------------------------------------------------------
  # * Get Allied Units
  #--------------------------------------------------------------------------
  def friends_unit
    $game_party
  end
  #--------------------------------------------------------------------------
  # * Get Enemy Units
  #--------------------------------------------------------------------------
  def opponents_unit
    $game_troop
  end
  #--------------------------------------------------------------------------
  # * Get Actor ID
  #--------------------------------------------------------------------------
  def id
    @actor_id
  end
  #--------------------------------------------------------------------------
  # * Get Index
  #--------------------------------------------------------------------------
  def index
    $game_party.members.index(self)
  end
  #--------------------------------------------------------------------------
  # * Determine Battle Members
  #--------------------------------------------------------------------------
  def battle_member?
    $game_party.battle_members.include?(self)
  end
  #--------------------------------------------------------------------------
  # * Get Class Object
  #--------------------------------------------------------------------------
  def class
    $data_classes[@class_id]
  end
  #--------------------------------------------------------------------------
  # * Get Skill Object Array
  #--------------------------------------------------------------------------
	def skills
		(@skills | added_skills).sort.collect {|id| $data_skills[id] }
	end
  #--------------------------------------------------------------------------
  # * Get Array of Currently Usable Skills
  #--------------------------------------------------------------------------
	def usable_skills
		skills.select {|skill| usable?(skill) }
	end

  def movable?
	true
  end
  #--------------------------------------------------------------------------
  # * Get Array of All Objects Retaining Features
  #--------------------------------------------------------------------------
	def feature_objects
		#super + [actor] + equips.compact
		super + [actor] + [self.class] + equips.compact
	end
  #--------------------------------------------------------------------------
  # * Get Attack Element
  #--------------------------------------------------------------------------
  def atk_elements
    set = super
    set |= [1] if weapons.compact.empty?  # Unarmed: Physical element
    return set
  end
  #--------------------------------------------------------------------------
  # * Get Maximum Value of Parameter
  #--------------------------------------------------------------------------
  def param_max(param_id)
    return 9999 if param_id == 0  # MHP
    return super
  end
  #--------------------------------------------------------------------------
  # * Get Base Value of Parameter
  #--------------------------------------------------------------------------
  def param_base(param_id)
    self.class.params[param_id, @level]
  end
  #--------------------------------------------------------------------------
  # * Get Added Value of Parameter
  #--------------------------------------------------------------------------
  def param_plus(param_id)
    equips.compact.inject(super) {|r, item| r += item.params[param_id] }
  end
  #--------------------------------------------------------------------------
  # * Get Normal Attack Animation ID
  #--------------------------------------------------------------------------
  def atk_animation_id1
    #if dual_wield?
   #   return weapons[0].animation_id if weapons[0]
   #   return weapons[1] ? 0 : 1
   # else
      return weapons[0] ? weapons[0].animation_id : 1
  #  end
  end
  #--------------------------------------------------------------------------
  # * Get Animation ID of Normal Attack (Dual Wield: Weapon 2)
  #--------------------------------------------------------------------------
  def atk_animation_id2
   # if dual_wield?
   #   return weapons[1] ? weapons[1].animation_id : 0
   # else
      return 0
   # end
  end
  #--------------------------------------------------------------------------
  # * Change Experience
  #     show : Level up display flag
  #--------------------------------------------------------------------------
	def change_exp(exp, show)
		return if self.exp >= self.max_exp
		@exp[@class_id] = [exp, 0].max
		last_level = @level
		last_skills = skills
		level_up while !max_level? && self.exp >= next_level_exp
		level_down while self.exp < current_level_exp
		display_level_up(skills - last_skills) if show && @level > last_level
		#refresh #will cause laggy
	end
  #--------------------------------------------------------------------------
  # * Get Experience
  #--------------------------------------------------------------------------
  def exp
    @exp[@class_id]
  end
  #--------------------------------------------------------------------------
  # * Level Up
  #--------------------------------------------------------------------------
  def level_up
    @level += 1
	@trait_point +=1
    self.class.learnings.each do |learning|
      learn_skill(learning.skill_id) if learning.level == @level
    end
  end
  #--------------------------------------------------------------------------
  # * Level Down
  #--------------------------------------------------------------------------
  def level_down
    @level -= 1
  end
  #--------------------------------------------------------------------------
  # * Show Level Up Message
  #     new_skills : Array of newly learned skills
  #--------------------------------------------------------------------------
  def display_level_up(new_skills)
	SndLib.sys_LvUp
	$game_map.popup(0,"Level UP",0,0)
  end
  #--------------------------------------------------------------------------
  # * Get EXP (Account for Experience Rate)
  #--------------------------------------------------------------------------
	def gain_exp(exp)
		change_exp(self.exp + (exp * final_exp_rate).to_i, true)
	end
  #--------------------------------------------------------------------------
  # * Calculate Final EXP Rate
  #--------------------------------------------------------------------------
	def final_exp_rate
		1.0 * (battle_member? ? 1 : reserve_members_exp_rate)
	end
  #--------------------------------------------------------------------------
  # * Get EXP Rate for Reserve Members
  #--------------------------------------------------------------------------
  def reserve_members_exp_rate
    $data_system.opt_extra_exp ? 1 : 0
  end
  #--------------------------------------------------------------------------
  # * Change Level
  #     show : Level up display flag
  #--------------------------------------------------------------------------
  def change_level(level, show)
    level = [[level, max_level].min, 1].max
    change_exp(exp_for_level(level), show)
  end
  #--------------------------------------------------------------------------
  # * Learn Skill
  #--------------------------------------------------------------------------
	def learn_skill(skill_id)
		skill_id = $data_SkillName[skill_id].id if skill_id.is_a?(String)
		unless skill_learn?($data_skills[skill_id])
			@skills.push(skill_id)
			@skills.sort!
		end
	end
  #--------------------------------------------------------------------------
  # * Forget Skill
  #--------------------------------------------------------------------------
  def forget_skill(skill_id)
		@skills.delete(skill_id)
		@skills.sort!
  end
  #--------------------------------------------------------------------------
  # * Determine if Skill Is Already Learned
  #--------------------------------------------------------------------------
	def skill_learn?(skill)
		skill.is_a?(RPG::Skill) && @skills.include?(skill.id)
	end
	def skill_id_usable?(tmp_skill_id)
		tmpSkillList = (@skills | added_skills).sort
		tmpSkillList.include?(tmp_skill_id)
	end
  #--------------------------------------------------------------------------
  # * Get Description
  #--------------------------------------------------------------------------
  def description
    actor.description
  end
  #--------------------------------------------------------------------------
  # * Change Class
  #     keep_exp:  Keep EXP
  #--------------------------------------------------------------------------
  #def change_class(class_id, keep_exp = false)
  #  @exp[class_id] = exp if keep_exp
  #  @class_id = class_id
  #  change_exp(@exp[@class_id] || 0, false)
  #  refresh
  #end
  #--------------------------------------------------------------------------
  # * Change Graphics
  #--------------------------------------------------------------------------
  def set_graphic(character_name, character_index, face_name, face_index)
    @character_name = character_name
    @character_index = character_index
    #@face_name = face_name
    #@face_index = face_index
  end
  #--------------------------------------------------------------------------
  # * Use Sprites?
  #--------------------------------------------------------------------------
  def use_sprite?
    return false
  end
  #--------------------------------------------------------------------------
  # * Execute Damage Effect
  #--------------------------------------------------------------------------
  def perform_damage_effect
    $game_troop.screen.start_shake(5, 5, 5)
    @sprite_effect_type = :blink
    Sound.play_actor_damage
  end
  #--------------------------------------------------------------------------
  # * Execute Collapse Effect
  #--------------------------------------------------------------------------
  def perform_collapse_effect
    if $game_party.in_battle
      @sprite_effect_type = :collapse
      Sound.play_actor_collapse
    end
  end
  #--------------------------------------------------------------------------
  # * Create Action Candidate List for Auto Battle
  #--------------------------------------------------------------------------
  def make_action_list
	return
    list = []
    list.push(Game_Action.new(self).set_attack.evaluate)
    usable_skills.each do |skill|
      list.push(Game_Action.new(self).set_skill(skill.id).evaluate)
    end
    list
  end
  #--------------------------------------------------------------------------
  # * Create Action During Auto Battle
  #--------------------------------------------------------------------------
  def make_auto_battle_actions
    @actions.size.times do |i|
      @actions[i] = make_action_list.max_by {|action| action.value }
    end
  end
  #--------------------------------------------------------------------------
  # * Create Action During Confusion
  #--------------------------------------------------------------------------
  def make_confusion_actions
    @actions.size.times do |i|
      @actions[i].set_confusion
    end
  end
  #--------------------------------------------------------------------------
  # * Create Battle Action
  #--------------------------------------------------------------------------
  def make_actions
    super
    if auto_battle?
      make_auto_battle_actions
    elsif confusion?
      make_confusion_actions
    end
  end
  #--------------------------------------------------------------------------
  # * Processing Performed When Player Takes 1 Step
  #--------------------------------------------------------------------------
  def on_player_walk
    @result.clear
    if map_token.normal_walk?
      #turn_end_on_map
      states.uniq.each {|state| update_state_steps(state) }
    end
  end
  #--------------------------------------------------------------------------
  # * Update Step Count for State
  #--------------------------------------------------------------------------
	def update_state_steps(state)
		if state.remove_by_walking && state_stack(state.id)> 0
			@state_steps[state.id] -= 1 if @state_steps[state.id] > 0
			#p "#{state.item_name} #{@state_steps[state.id]} #{state.steps_to_remove} #{state_stack(state.id)} asdasdasd"
			if @state_steps[state.id] <= 0
				#@state_steps[state.id] = state.steps_to_remove #if state_stack(state.id) >=1
				@state_steps[state.id] = state.steps_to_remove
				@state_frames[state.id] = state.steps_to_remove * 60
				remove_state_stack(state.id)
			end
		end
	end
  #--------------------------------------------------------------------------
  # * Show Added State
  #--------------------------------------------------------------------------
	def show_added_states
		@result.added_state_objects.each do |state|
			$game_message.add(name + state.message1) unless state.message1.empty?
		end
	end

	def update_state_frames
		states.uniq.each{|state|
		#p "stack=>#{state_stack(state.id)} ,@state_steps[#{state.id}]=>#{@state_steps[state.id]} @state_frames[#{state.id}]=>#{@state_frames[state.id]}" if state.id == 161
			if state.remove_by_walking && state_stack(state.id)> 0
				@state_frames[state.id] -= 1 if @state_frames[state.id] > 0
				#p "#{state.item_name} #{@state_steps[state.id]} #{state.steps_to_remove} #{state_stack(state.id)} asdasdasd"
				if @state_frames[state.id] <= 0
					@state_steps[state.id] = state.steps_to_remove
					@state_frames[state.id] = state.steps_to_remove * 60
					remove_state_stack(state.id)
					next # or it will remove all stack
				end
			end
		}
	end

  #--------------------------------------------------------------------------
  # * ?? lona_stat
  #--------------------------------------------------------------------------

	def update_lonaStat
		#It was called in update_lonaStat so I guess it might be important for some states.
		#But update_lonaStat is called from so many places that it's strange.
		#for example, when loading. In other words, one can save/load until status that can be removed by walking is gone...
		update_state_frames
	end
	def update_lonaStat_old
		updatedLonaGears=Array.new
		@actStat.check_stat #why double update?  i dont know?
		stat["mood"]=self.mood
		stat["dirt"]=self.dirt
		stat["sta"]=self.sta
		update_state_link
		for eqn in 0...@equips.length
			next if @equips[eqn].object.nil?
			statName=@equips[eqn].object.lonaStat.statName
			stat[statName]=@equips[eqn].object.lonaStat.affectValue
			updatedLonaGears.push(statName)
		end
		updatedLonaGears = $data_system.gear_stats_update_flow - updatedLonaGears
		#updatedLonaGears=lona_gears-updatedLonaGears
		for x in 0...updatedLonaGears.length
			gearName=updatedLonaGears[x]
			stat[gearName]=nil
		end
		recalculate_stats
		update_state_frames
		update_on_update_lonaStat #editable 97.rb  #moved to mod folder
		@actStat.check_stat #why not just # it?
	end

	def recalculate_stats
		self.constitution=		self.constitution_trait+self.constitution_plus
		self.survival=			self.survival_trait+self.survival_plus
		self.wisdom=			self.wisdom_trait+self.wisdom_plus
		self.combat=			self.combat_trait+self.combat_plus
		self.scoutcraft=		self.scoutcraft_trait+self.scoutcraft_plus
		self.atk=				(self.combat*0.5) + self.atk_plus
		self.def=				self.def_plus
		update_sex_atk
		self.morality=			self.morality_lona + (self.morality_plus-200)
		self.hud_weight_count=	2*self.attr_dimensions["sta"][2] - self.weight_carried
	end

	def update_lonaStat_tera
		update_lonaStat_old
		@actStat.check_stat_old
	end
	def update_state_link
		# cursed
		tgtStates = self.states.uniq
		return if tgtStates.empty?
		tgtStates.each{|cState|
			next if cState.nil? || cState.lonaStat.nil?
			state_id=cState.id
			next if cState.lonaStat.isStringType?
			if cState.lonaStat.statLink # if link  pick MAX.   probably with bugs?
				#stat[cState.lonaStat.statName] = 0 if !stat[cState.lonaStat.statName] #2024 2 28 > make some support to old save
				stat[cState.lonaStat.statName]=[stat[cState.lonaStat.statName],state_stack(state_id)].max
			else
				stat[cState.lonaStat.statName]=state_stack(state_id)
			end
		}
	end

	def refresh_part_key_blacklist
		@part_key_blacklist = []
		@banned_receiver_holes = []
		feature_objects.uniq.each {|o|
			@banned_receiver_holes += o.banned_receiver_holes if o.banned_receiver_holes # should belong to refresh_banned_supported_receiver_slot.  but i m lazy.
			@part_key_blacklist += o.part_key_blacklist if o.part_key_blacklist && !o.part_key_blacklist.empty?
		}
		@part_key_blacklist = @part_key_blacklist.uniq
		$chs_data["Lona"].part_key_blacklist = @part_key_blacklist
		self.portrait.part_key_blacklist = @part_key_blacklist   #moved to 09_Lona_Portrait init and refresh
	end

	def calculate_weight_carried
		@weight_carried=0
		#?????
		$game_party.all_items.each{|itm|
			@weight_carried+=($game_party.item_number(itm)*itm.weight)
		}
		equips.each{|eqp|
			next if eqp.nil?
			@weight_carried+=eqp.weight
		}

		@weight_carried=@weight_carried.round(3)
		#p "weight updated weight:#{@weight_carried}" if @debug_attribute
	end

  #--------------------------------------------------------------------------
  # * Show Removed State
  #--------------------------------------------------------------------------
  def show_removed_states
    @result.removed_state_objects.each do |state|
      $game_message.add(name + state.message4) unless state.message4.empty?
    end
  end
  #--------------------------------------------------------------------------
  # * Number of Steps Regarded as One Turn in Battle
  #--------------------------------------------------------------------------
  def steps_for_turn
    return 20
  end
  #--------------------------------------------------------------------------
  # * End of Turn Processing on Map Screen
  #--------------------------------------------------------------------------
  #def turn_end_on_map
  #  if $game_party.steps % steps_for_turn == 0
  #    on_turn_end
  #    perform_map_damage_effect if @result.hp_damage > 0
  #  end
  #end
  #--------------------------------------------------------------------------
  # * Determine Floor Effect
  #--------------------------------------------------------------------------
 # def check_floor_effect
 #   execute_floor_damage if map_token.on_damage_floor?
 # end
  #--------------------------------------------------------------------------
  # * Floor Damage Processing
  #--------------------------------------------------------------------------
  #def execute_floor_damage
  #  damage = (basic_floor_damage * fdr).to_i
  #  self.hp -= [damage, max_floor_damage].min
  #  perform_map_damage_effect if damage > 0
  #end
  #--------------------------------------------------------------------------
  # * Get Base Value for Floor Damage
  #--------------------------------------------------------------------------
  def basic_floor_damage
    return 10
  end
  #--------------------------------------------------------------------------
  # * Get Maximum Value for Floor Damage
  #--------------------------------------------------------------------------
  def max_floor_damage
    $data_system.opt_floor_death ? hp : [hp - 1, 0].max
  end
  #--------------------------------------------------------------------------
  # * Execute Damage Effect on Map
  #--------------------------------------------------------------------------
  def perform_map_damage_effect
    $game_map.screen.start_flash_for_damage
  end
  #--------------------------------------------------------------------------
  # * Clear Actions
  #--------------------------------------------------------------------------
  def clear_actions
    super
    @action_input_index = 0
  end
  #--------------------------------------------------------------------------
  # * Get Action Being Input
  #--------------------------------------------------------------------------
  def input
    @actions[@action_input_index]
  end
  #--------------------------------------------------------------------------
  # * To Next Command Input
  #--------------------------------------------------------------------------
  def next_command
    return false if @action_input_index >= @actions.size - 1
    @action_input_index += 1
    return true
  end
  #--------------------------------------------------------------------------
  # * To Previous Command Input
  #--------------------------------------------------------------------------
  def prior_command
    return false if @action_input_index <= 0
    @action_input_index -= 1
    return true
  end

  #??????????
  def show_states
    p @states
  end



#  #??Lona_Gear???????????????????
#  def lona_gears
#	  ["equip_TopExtra","MainArm","WhateverEquipMayAffectStatmap"]
 # end


  #?????????????????(>=2*MSTA)
  def weight_immobilized?
	@weight_carried.round(1) > (@actStat.get_stat("sta",ActorStat::MAX_STAT)*2).round(1)
  end

#====================================================================================================
#	?? Game_Battler.item_conditions_met????????????????
#====================================================================================================
  def item_conditions_met?(item)
    super #&& item.consumable
  end


	#?? Game_Battler.use_item???????item?????
	def use_item(item)
		super
		if !item.player_item_usage_event_summon.nil? #???Ssummon EVENT ??????????SCENE???
			$game_temp.call_item_drop([item.player_item_usage_event_summon])
		end
		if !item.player_item_usage_eval.nil?
			eval(item.player_item_usage_eval)
		end
		if item.use_item_effect
			item.use_item_effect.each{|le|
					next if le.nil?
					next unless effect_allowed?(le)
					attrVal=@actStat.get_stat(le.attr,le.attr_type)
					@actStat.set_stat(le.attr,self.get_affected_attr(le),le.attr_type)
				}
		end
		self.json_addon_manage_state(item,item.player_item_usage_manage_state) if item.player_item_usage_manage_state
		self.json_addon_remove_equip(item.player_item_remove_equip) if item.player_item_remove_equip

	end

	def refresh_state_effects
		@states.each{|stateID|
			next if stateID.nil?
			next if $data_states[stateID].lona_effect.nil?
			$data_states[stateID].lona_effect.each{|le|
				next @hom_effects_data << le if le.attr_type == "current"
				next unless effect_allowed?(le)
				attrVal=@actStat.get_stat(le.attr,le.attr_type)
				@actStat.set_stat(le.attr,self.get_affected_attr(le),le.attr_type)
			}
		}
	end

	def refresh_equip_effects
		#@equip_part_covered = [] # to def change_equip
		for i in 0...equips.length
			eqp=equips[i]
			next if eqp.nil? || eqp.is_a?(RPG::Item)
			#@equip_part_covered = (@equip_part_covered+eqp.equip_part_covered).uniq if eqp.equip_part_covered
			for c in 0...eqp.lona_effect.length
				le=eqp.lona_effect[c]
				next @hom_effects_data << le if le.attr_type == "current"
				next unless effect_allowed?(le)
				attrVal=@actStat.get_stat(le.attr,le.attr_type)
				@actStat.set_stat(le.attr,self.get_affected_attr(le),le.attr_type)
			end
		end
		calculate_weight_carried
	end
	def refresh_hom_effects
		@hom_effects_data.each{|le|
			next unless effect_allowed?(le)
			attrVal=@actStat.get_stat(le.attr,le.attr_type)
			@actStat.set_stat(le.attr,self.get_affected_attr(le),le.attr_type)
		}
	end
	def effect_allowed?(le) # 23_Game_BattlerBase.rb
		#p le.block_by_part_cover if le.block_by_part_cover
		#p (le.block_by_part_cover.any? { |part| @equip_part_covered.include?(part)}) if  le.block_by_part_cover
		#return false if le.block_by_part_cover && le.block_by_part_cover.flatten.any? { |part| @equip_part_covered.include?(part.to_s) } #dress covered block
		return false if effect_dress_covered?(le.block_by_part_cover,@equip_part_covered)
		return super(le)
	end

	def effect_dress_covered?(block_by_part_cover, equip_part_covered)
		return false unless block_by_part_cover && !block_by_part_cover.empty?
		#p block_by_part_cover
		#p equip_part_covered
		#p !(block_by_part_cover & equip_part_covered).empty?
		!(block_by_part_cover & equip_part_covered).empty?
	end
	def update_chs
		@stat_changed=true #verb req update LonaCHS and portrait
	end

	def stat
		@prt_stat
	end

	def attr_dimensions
		@actStat.stat
	end

	def export_affected_attr(effect)
		@actStat.get_stat(effect.attr,effect.attr_type)
	end

	#???????= (???current:atk_plus +10)
	#?????= (???current:def_plus+2)
	#??= ??????? - ?????
	#{damage??adjustor}
	#???????1
	#Damage?? {eff.damage.adjustor} ??
	def take_skill_effect(user,skill,can_sap=true,force_hit=false)
		return if check_is_shieldEV_and_hit_by_master?(user,skill) && !force_hit
		return map_token.perform_dodge if @dodged && !skill.no_dodge
		return if with_ShieldEV? && !skill.is_support
		#return @shieldEV.actor.take_damage(user,skill,force_hit) if with_ShieldEV? && !skill.is_support
		#check_skill_cancel_by_hit(user,skill) if @action_state != :sex
		check_skill_cancel_by_hit(user,skill )if !skill.no_action_change
		take_damage(user,skill,force_hit)
		apply_skill_state_effect(skill,user) if !blocked?(user)
		take_sap(user) if skill.sap? && can_sap && !self.immune_state_effect && !self.immune_damage
		set_last_attacker(user) if !skill.is_support
		update_state_frames
		determine_death
	end

	def check_is_shieldEV_and_hit_by_master?(user,skill)
		return false if !@is_a_ProtectShield
		return false if !@master
		return true if skill.is_support
		return true if user == @master.actor
		false
	end
	def check_skill_cancel_by_hit(user,skill)
		@master.actor.player_control_mode(false) if map_token.mind_control_on_hit_cancel && @master && @master.actor
		take_skill_cancel(skill) if !blocked?(user) && !actor_skill_no_interrupt?
		remove_stun_by_chance
		map_token.move_normal
	end
	def actor_skill_no_interrupt?
		return false if self.skill.nil?
		#p "no_interrupt_LonaOnly #{self.skill.no_interrupt_LonaOnly}"
		#p "WeaponryKnowledge #{self.stat["WeaponryKnowledge"]}"
		return true if self.skill.no_interrupt || (self.skill.no_interrupt_LonaOnly && self.stat["WeaponryKnowledge"] == 1)
		return false
	end

	def determine_death
		return if [:grabbed,:sex].include?(@action_state)
		set_action_state(:death) if self.health <=0 || self.sta <= -100
	end

	def lonaDeath?
		tmpResult = self.health <=0 || self.sta <= -100
		self.action_state == :death || tmpResult
	end

	def select_skill(skillset,type)
		@skill=nil
		@current_animation=nil
		selected=skillset.select{
			|skill|
			skill.range_type==type
		}
		selected
	end

	def launch_player_skill(type)
		p "launch_player_skill action_state=>#{@action_state}"
		skill=self.usable_skills.select{
			|skill|
			skill.type.eql?(type)
		}[0]
		return if skill.nil?  || !cost_affordable?($data_arpgskills[skill.type_tag])
		#p "launch_player_skill=>#{skill.type_tag}"
		#p "cost_affordable?($data_arpgskills[skill.type_tag])=>#{cost_affordable?($data_arpgskills[skill.type_tag])}"
		#p "launch_player_skill=>#{$data_arpgskills[skill.type_tag]}, skill.type_tag=>#{skill.type_tag}"
		launch_skill($data_arpgskills[skill.type_tag])
	end
	#??????????target???range????
	def target_in_range?(skill)
		true
	end
	#???Battle_System??????????
	def battle_stat
		@actStat
	end

	#BattleSSyten??
	def map_token
		$game_player
	end

	def target
		return @target if @target
		@target = Struct::FakeTarget.new($game_map.round_x_with_direction(map_token.x, map_token.direction),$game_map.round_y_with_direction(map_token.y, map_token.direction))
	end

	#???fraction??????????????
	def fraction
		0
	end

	def friendly?(character)
		false
		#character.actor.fraction == self.fraction
	end


	def over_energized?
		if @skill.energizing?
			@holding_count >= @skill.launch_max
		elsif @skill.blocking?
			false
		else
			false
		end
	end


	def avoid_friendly_fire?(skill)
		false
	end




	def launch_holding_skill(skill)
		super(skill)
		map_token.set_animation(skill.hold_animation) if skill.hold_animation
	end

	def do_sap
		true
	end

	def apply_stun_effect(state_id)
		return if @action_state==:sex
		#state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		state=$data_StateName[state_id]
		return unless state.stun?
		super
		map_token.setup_stun_effect
	end

	def apply_fap_effect(state_id)
		return if @action_state==:sex
		#state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		state=$data_StateName[state_id]
		return unless state.stun?
		super
		map_token.setup_fap_effect
	end

	def apply_shock_effect(state_id)
		return if @action_state==:sex
		#state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		state=$data_StateName[state_id]
		return unless state.stun?
		super
		map_token.setup_shock_effect
	end

	def apply_cuming_effect(state_id)
		return if @action_state==:sex
		#state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		state=$data_StateName[state_id]
		return unless state.stun?
		super
		map_token.setup_cuming_effect
	end

	def apply_pindown_effect(state_id)
		return if @action_state==:sex
		#state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		state=$data_StateName[state_id]
		return unless state.stun?
		super
		map_token.setup_pindown_effect
	end


	def update_stun
		return unless @action_state==:stun
		return remove_stun_effect if self.stat["BerserkPack"] >= 1
		@stun_count -=1
		remove_stun_effect if @stun_count<=0
	end


	def set_action_state(action_state,force=false)
		prp "player.actor.set_action_state =>#{action_state}",2
		return if @action_state == :death && !force
		return if action_state == @action_state && !force
		map_token.cancel_stun_effect  && action_state!=:stun
		@action_state_changed=true
		@action_state=action_state
	end

	#debug ?
	def show_stat
		prp "current , min ,max ,max_true, min_true"
		@actStat.stat.keys.each{
			|key|
			prp "actor stat: #{key} =>#{@actStat.stat[key]}",2
		}
	end

	def char_spotted?(character,min_signal=1)
		false
	end

	def aggro_allowed?(attacker,skill)
		false
	end
	def reset_skill(force=false)
		super
		map_token.release_chs_group if [:sex,:grabber,:grabbed].include?(@action_state)
	end

	def can_set_skill?(skill)
		case skill.item_name
			when "sys_normal";tag="normal"
			when "sys_heavy";tag="heavy"
			when "sys_control";tag="control"
		end
		skill=get_system_skill(skill) if system_skill?(skill.item_name)
		skills.include?(skill) && !skill_sealed?(skill.item_name) && !skill_type_sealed?(skill.stype_id) && cost_affordable?($data_arpgskills[skill.type_tag])
		#usable_skills.include?(skill) && cost_affordable?($data_arpgskills[skill.type_tag])
	end


	def launch_skill(skill,force=false)
		@skill_changed=true
		super
	end

	#control,heavy,normal
	def system_skill?(skill_id)
	["sys_normal","sys_heavy","sys_control"].include?(skill_id)
	end

	def get_system_skill(skill)
		case skill.item_name
			when "sys_normal";tag="normal"
			when "sys_heavy";tag="heavy"
			when "sys_control";tag="control"
		end
		sys_skill=usable_skills.select{|skill|
				skill.type.eql?(tag)
				}[0]
		sys_skill
	end

	def set_aggro(attacker=0,skill=9,frame_count=300,no_action_change = false)
		return
	end

	def ranged?
		false
	end

	def no_aggro
		true
	end
	def set_alert_level(new_alert)
		#npc function   do nothing on player
	end
	def process_target_lost(reset_anomally)
		#npc function   do nothing on player
	end
	def age
		return 1
	end
	def drop_list
		[]
	end
	def npc_name
		@name
	end

	def user_redirect
		false
	end

	def update_skill_eff
		return if $game_map.interpreter.running? || $game_message.busy?
		return if set_action_state(:none) if @skill.nil?
		update_energizing
		if @skill_charging_state == 2 #??????????launch??????2
			@skill_wait-=1
			if (@skill_wait <= 0)
				tmpHitAnyTGT = false
				if !@current_skill_launched
					process_skill_result(@skill)
					map_token.move_normal unless (@skill && @skill.stealth) || self.stat["ShadowMaster"] == 1		 #player unique ver because this
					cancel_holding(true) if @skill && @skill.holding? && @holding_count!=-1
					@current_skill_launched = true
				end
				return if check_skill_hit_cancel(@skill)
				@last_used_skill = @skill
				set_action_state(:none) if @skill && !@skill.chs_animation
				map_token.skill_eff_reserved = false
				@skill=nil #MG42
				@skill_wait=-1
				reset_skill
			end
		#elsif @skill.simply_holding? && @skill_charging_state == 1
		#	@last_used_skill = @skill
		#	#p @last_used_skill
		end
	end


	def check_skill_hit_cancel(skill) #2Always 1#Last 0
		return false if !skill
		return false if skill.hit_cancel_mode == 0 && !skill.hit_cancel_req_a_tgt #Always
		skillCompare = !skill.hit_cancel_req_a_tgt || (map_token.target && map_token.target.actor.last_hit_by_skill == skill)
		return false if skill.hit_cancel_mode == 1 && skillCompare && @last_used_skill != skill #Differen
		return false if skill.hit_cancel_mode == 2 && skillCompare && @last_used_skill && skill.hit_cancel_req_last_skill == @last_used_skill.name #Last
		return false if skill.hit_cancel_mode == 0 && skillCompare #Always
		return true if map_token.chk_skill_eff_reserved
		false
	end


	def update_energizing # battle system player overwrite
		return if @skill_charging_state==2
		@holding_count += 1
		if over_energized?
			@skill_charging_state = 2
			map_token.move_normal unless @skill.stealth || self.stat["ShadowMaster"] == 1		 #player unique ver because this
			cancel_holding(true)
		elsif @holding_count >= @skill.launch_since
			map_token.move_normal unless @skill.stealth || self.stat["ShadowMaster"] == 1		 #player unique ver because this
			@skill_charging_state = 1
		end
	end



	##################### from stats mod tera
	def update_state_portrait_stat(state_id)
		state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		return prp "update_state_portrait_stat #{state_id} not found",1 if !state_id
		cState=$data_states[state_id]
		if !cState.nil? && !cState.lonaStat.nil?
			report_portrait_stat(cState.lonaStat.statName, state_stack(state_id)) if !cState.lonaStat.isStringType?
			update_state_link if cState.lonaStat.statLink
		end
	end

	#calls refresh before initializing state frames, instead add_state should call it in the end
	def add_new_state(state_id)
		state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		return prp "add_new_state #{state_id} not found",1 if !state_id
		die if state_id == death_state_id
		@states.push(state_id)
		on_restrict if restriction > 0
		sort_states
		update_state_portrait_stat(state_id)
		#refresh
	end

	def erase_state(state_id)
		state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		return prp "erase_state #{state_id} not found",1 if !state_id
		super(state_id)
		update_state_portrait_stat(state_id)
	end

	def remove_state_stack(state_id)
		state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		return prp "remove_state_stack #{state_id} not found",1 if !state_id
		super(state_id)
		update_state_portrait_stat(state_id)

	end

	def add_state(state_id)
		state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		return prp "add_state #{state_id} not found",1 if !state_id
		will_add_state=state_addable?(state_id) #condition for calling add_new_state
		super(state_id)
		if will_add_state then #only if add_new_state was called
			refresh
			eval("SndLib.#{$data_states[state_id].player_add_state_SndLib}") if $data_states[state_id].player_add_state_SndLib
			update_state_portrait_stat(state_id)
		end
	end

	def report_portrait_stat(statName, value) #separate method to allow 9999_StatPortraitOptimization.rb to hook here.
		@prt_stat[statName]=value
		portrait.set_stat(statName,value) if !$game_portraits.nil? && !portrait.nil?
	end

	def portrait_stat_value #used to intercept actor.stat[<name>] calls
		return @prt_stat
	end

	def stat #used to intercept actor.stat[<name>] calls
		if $game_actors.length > 0
			return (Portrait_Stat_Proxy.new(self)).freeze
		else
			@prt_stat
		end
	end

	def itemUseBatch(item)
		item = $data_ItemName[item] if item.is_a?(String)
		self.item_apply(self,item)
		self.use_item(item)
	end
end #class actor
class Game_NPC_Actor < Game_Actor
	def setup(actor_id)
		p "actor setup actor_id=>#{actor_id}"
		@actor_id = actor_id
		@name = actor_id
		#init_graphics
		#@class_id = actor.class_id
		#@level = actor.initial_level
		#@exp = {}
		#@ext_items = [nil,nil,nil,nil,nil]
		@equips = []
		#@add_specs=Note.get_data("")
		#@chs_configured=@add_specs["chs_config"]
		#@stamina=0
		#@debug_attribute=false
		@portrait_sync=true
		#@mouth_block=0
		#@weigth_carried=0 #?????????
		@max_stats=Hash.new
		#@master = nil
		#@hit_LinkToMaster = false
		#@is_object = false
		#@immune_state_effect = false
		#@immune_damage = false
		#@master = nil
		@actStat=LonaActorStat.new #??????????????stat??????????????????????????????
		@actStat.npc_name="NPCLayer"
		@state_frames={}
		@name_order = $data_lona_portrait[0]
		@part_key_blacklist = []
		#init_exp
		init_lonaStat #??????@stat???????portrait?????@prt_stat??
		init_statMap
		#initialize_battle_system
		#stat["Race"] = "Human"
		#stat["always"]="on"
		#stat["persona"]="typical"
		#stat["sex_pos"]=-1
		#init_cums
		#clear_param_plus
		#recover_all
		#init_rec_stats #96_Game_Actor_Attribute.rb
		#@prev_health = self.health
		#@prev_sta = self.sta
		#@actStat.check_stat_old
		@actStat.actor = self
	end




	def init_lonaStat
		if @actor_id != "NPCLayerMain"
			@prt_stat=$game_NPCLayerMain.prt_stat
		else
			@prt_stat=Hash.new
		end
	end


	def prt_stat
		if @actor_id != "NPCLayerMain"
			$game_NPCLayerMain.prt_stat
		else
			@prt_stat
		end
	end

	def stat #used to intercept actor.stat[<name>] calls
		if @actor_id != "NPCLayerMain"
			return $game_NPCLayerMain.stat
		else
			return super
		end
	end

	def init_statMap
		if @actor_id != "NPCLayerMain"
			@statMap=$game_NPCLayerMain.statMap
		else
			super
			init_layer_stats
		end
	end


	def init_layer_stats
		self.stat["Cocona_Hsta"] = nil
		self.stat["Cocona_DidWhoreJob"] = nil
		self.stat["Cocona_DidWhoreJob"] = nil
		self.stat["Cocona_Arousal"] = nil
		self.stat["Cocona_Dress"] = "Necro"
		self.stat["Cocona_GroinDamaged"] = nil
	end
	def nap_reset_stats
		self.stat["Cocona_Hsta"] = nil
		self.stat["Cocona_DidWhoreJob"] = nil
		self.stat["Cocona_DidWhoreJob"] = nil
		self.stat["Cocona_Arousal"] = nil
		#self.stat["Cocona_Dress"] = $game_map.interpreter.cocona_maid? ? "Maid" : "Necro"  #control by lona
		self.stat["Cocona_GroinDamaged"] = nil  if self.stat["Cocona_GroinDamaged"] && self.stat["Cocona_GroinDamaged"] <= 0
		self.stat["Cocona_GroinDamaged"] -= 1 if self.stat["Cocona_GroinDamaged"]
	end
	def take_sap(user)
		return false
	end
end
