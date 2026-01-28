
# ▼ Editting anything past this point may potentially result in causing
# computer damage, incontinence, explosion of user's head, coma, death, and/or
# halitosis so edit at your own risk.
#==============================================================================

#module YEA
#  module REGEXP
#  module BASEITEM
#    
#    #EQUIP_SLOTS_ON  = /<(?:EQUIP_SLOTS|equip slots)>/i
#    #EQUIP_SLOTS_OFF = /<\/(?:EQUIP_SLOTS|equip slots)>/i
#    #
#    #EQUIP_TYPE_INT = /<(?:EQUIP_TYPE|equip type):[ ]*(\d+)>/i
#    #EQUIP_TYPE_STR = /<(?:EQUIP_TYPE|equip type):[ ]*(.*)>/i
#    
#    #STARTING_GEAR = /<(?:STARTING_GEAR|starting gear):[ ](\d+(?:\s*,\s*\d+)*)>/i
#    
#    #FIXED_EQUIP = /<(?:FIXED_EQUIP|fixed equip):[ ](\d+(?:\s*,\s*\d+)*)>/i
#    #SEALED_EQUIP = /<(?:SEALED_EQUIP|sealed equip):[ ](\d+(?:\s*,\s*\d+)*)>/i
#    #SEALED_WTYPE = /<(?:SEALED_WTYPE|sealed wtype):[ ](\d+(?:\s*,\s*\d+)*)>/i
#    #SEALED_ATYPE = /<(?:SEALED_ATYPE|sealed atype):[ ](\d+(?:\s*,\s*\d+)*)>/i
#  end # BASEITEM
#  end # REGEXP
#end # YEA

#==============================================================================
# ■ Vocab
#==============================================================================

module Vocab
  
  #--------------------------------------------------------------------------
  # overwrite method: self.etype
  #--------------------------------------------------------------------------
  def self.etype(etype)
    #return $data_system.terms.etypes[etype] if [0,1,2,3,4].include?(etype)
    return $data_system.equip_type[etype][0] if $data_system.equip_type.include?(etype)
    return ""
  end
  
end # Vocab

#==============================================================================
# ■ Icon
#==============================================================================

#module Icon
#
#  #--------------------------------------------------------------------------
#  # self.remove_equip
#  #--------------------------------------------------------------------------
#  def self.remove_equip; return System_Settings::EQUIP::REMOVE_EQUIP_ICON; end
#
#  #--------------------------------------------------------------------------
#  # self.nothing_equip
#  #--------------------------------------------------------------------------
#  def self.nothing_equip; return System_Settings::EQUIP::NOTHING_ICON; end
#
#end # Icon




#==============================================================================
# ■ Game_Temp
#==============================================================================

class Game_Temp
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :eds_actor
  #attr_accessor :scene_equip_index
  #attr_accessor :scene_equip_oy
  
end # Game_Temp
#==============================================================================

class Game_Actor < Game_Battler
  
  
  #--------------------------------------------------------------------------
  # new method: fixed_etypes
  #--------------------------------------------------------------------------
	def fixed_hard_etypes
		array = []
		for equip in equips
			next if equip.nil?
			array |= equip.fixed_hard_equip_type
		end
		for state in states
			next if state.nil?
			array |= state.fixed_hard_equip_type
		end
		return array
	end
	def fixed_etypes
		array = []
		#array |= self.actor.fixed_equip_type
		#array |= self.class.fixed_equip_type
		for equip in equips
			next if equip.nil?
			array |= equip.fixed_equip_type
		end
		for state in states
			next if state.nil?
			array |= state.fixed_equip_type
		end
			return array
	end
	def sealed_etypes
		array = []
		#array |= self.actor.sealed_equip_type
		#array |= self.class.sealed_equip_type
		for equip in equips
			next if equip.nil?
			array |= equip.sealed_equip_type
		end
		for state in states
			next if state.nil?
			array |= state.sealed_equip_type
		end
		return array
	end
  #--------------------------------------------------------------------------
  # overwrite method: optimize_equipments
  #--------------------------------------------------------------------------
  def optimize_equipments
    $game_temp.eds_actor = self
    @optimize_clear = true
    clear_equipments
    @optimize_clear = false
    equip_slots.size.times do |i|
      next if !equip_change_ok?(i)
      next unless can_optimize?(i)
      items = $game_party.equip_items.select do |item|
        item.etype_id == equip_slots[i] &&
        equippable?(item) && item.performance >= 0
      end
      change_equip(i, items.max_by {|item| item.performance })
    end
    $game_temp.eds_actor = nil
  end
  
  #--------------------------------------------------------------------------
  # new method: can_optimize?
  #--------------------------------------------------------------------------
	def can_optimize?(slot_id)
		etype_id = equip_slots[slot_id]
		return $data_system.equip_type[etype_id][2]
	end
  
  #--------------------------------------------------------------------------
  # alias method: force_change_equip
  #--------------------------------------------------------------------------
  alias game_actor_force_change_equip_aee force_change_equip
  def force_change_equip(slot_id, item)
    @equips[slot_id] = Game_BaseItem.new if @equips[slot_id].nil?
    game_actor_force_change_equip_aee(slot_id, item)
  end
  
  #--------------------------------------------------------------------------
  # alias method: weapons
  #--------------------------------------------------------------------------
  alias game_actor_weapons_aee weapons
  def weapons
    anti_crash_equips
    return game_actor_weapons_aee
  end
  
  #--------------------------------------------------------------------------
  # alias method: armors
  #--------------------------------------------------------------------------
  alias game_actor_armors_aee armors
  def armors
    anti_crash_equips
    return game_actor_armors_aee
  end
  
  #--------------------------------------------------------------------------
  # alias method: equips
  #--------------------------------------------------------------------------
  alias game_actor_equips_aee equips
  def equips
    anti_crash_equips
    return game_actor_equips_aee
  end
  
  #--------------------------------------------------------------------------
  # new method: equips
  #--------------------------------------------------------------------------
  def anti_crash_equips
    for i in 0...@equips.size
      next unless @equips[i].nil?
      @equips[i] = Game_BaseItem.new
    end
  end
  
end # Game_Actor

#==============================================================================
# ■ Game_Interpreter
#==============================================================================

class Game_Interpreter
  
  #--------------------------------------------------------------------------
  # overwrite method: change equip
  #--------------------------------------------------------------------------
  def command_319
    return "trash unused"
  end
  
end # Game_Interpreter
