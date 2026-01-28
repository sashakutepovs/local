#==============================================================================
# ** Game_Temp
#------------------------------------------------------------------------------
#  This class handles temporary data that is not included with save data.
# The instance of this class is referenced by $game_temp.
#==============================================================================

class Game_Temp
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
	attr_reader			:common_event_id          # Common Event ID
	attr_accessor		:fade_type                # Fade Type at Player Transfer
	attr_accessor		:preserved_message
	attr_accessor		:choice
	attr_accessor		:knot_mode	#是否前往節點，booleans
	attr_reader 		:tempvar
	#attr_accessor		:dropped_items
	attr_accessor		:summon_events
	attr_accessor		:basic_event_vag_str
	attr_accessor		:basic_event_anal_str
	attr_accessor		:basic_event_mouth_str
	attr_accessor		:reserved_story
	attr_accessor		:region_event_id
	attr_accessor		:load_RB_Frame
	attr_accessor		:load_MSG
	attr_accessor		:load_EVAL
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    @common_event_id = nil
    @fade_type = 0
	@choice =-1
	@tempvar={}
	@summon_events=Array.new
  end
  #--------------------------------------------------------------------------
  # * Reserve Common Event Call
  #--------------------------------------------------------------------------
	def reserve_common_event(common_event_id)
		@common_event_id = common_event_id
	end
	def loadEval(tmpEVAL)
		@load_EVAL = tmpEVAL
		@common_event_id = :Load_Eval
	end
	def loadRB(tmpRB)
		@load_RB_Frame = tmpRB
		@common_event_id = :Load_RubyScript
	end
	def loadMSG(tmpRB)
		@load_MSG = tmpRB
		@common_event_id = :Load_MSG
	end
  #--------------------------------------------------------------------------
  # * Clear Common Event Call Reservation
  #--------------------------------------------------------------------------
	def clear_common_event
		@common_event_id = nil
	end
  #--------------------------------------------------------------------------
  # * Determine Reservation of Common Event Call
  #--------------------------------------------------------------------------
	def common_event_reserved?
		!@common_event_id.nil?
	end
  #--------------------------------------------------------------------------
  # * Get Reserved Common Event
  #--------------------------------------------------------------------------
	def reserved_common_event
		$data_common_events[@common_event_id]
	end
	def register_item_drop(items,character=$game_player)
		$story_stats.data["record_dropped_items"] = Array.new if $story_stats.data["record_dropped_items"].nil?
		$story_stats.data["record_dropped_items"] << [items,character]
	end
	def call_item_drop(items,character=$game_player)
		register_item_drop(items,character=$game_player)
		reserve_common_event(:Dropitem)
	end
  
  #data => hash[]
  def summon_event(event_name,x,y,summoner_id=nil,data=nil)
	#very important
	$game_map.reserve_summon_event(event_name,x,y,summoner_id,data)
  end
  
  
  def set_new_stage_prop(event_name,x,y,summoner_id=nil,data=nil)
	@summon_events<<[event_name,x,y,summoner_id,data]
  end
  
  
  def exec_setup_stage
	until @summon_events.empty?
		$game_map.summon_event(*@summon_events.shift) 
	end
  end
	
	def reserve_story(story_name)
		@reserved_story=story_name
		reserve_common_event(:reserve_storypoint)
	end
	
	def reserve_region_event(region)
		@region_event_id=region
		reserve_common_event(:reserve_region_event)
	end
  
end
