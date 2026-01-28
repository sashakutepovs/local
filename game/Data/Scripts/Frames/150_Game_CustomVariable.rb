

class Story_Stats
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  attr_accessor :data
	def initialize
		@data = {}
		init_basic_data
		@overmap_character={}
	end
	def init_basic_data
		@data["sex_record_first_mouth"]				= Array.new
		@data["sex_record_first_vag"]				= Array.new
		@data["sex_record_first_anal"]				= Array.new
		@data["sex_record_last_mouth"]				= Array.new
		@data["sex_record_last_vag"]				= Array.new
		@data["sex_record_last_anal"]				= Array.new
		@data["sex_record_partner_count"]			= Hash.new(0)
		@data["sex_record_race_count"]				= Hash.new(0)
		@data["logTxt"]							= "\\}"
		@data["logNarr"]						= "\\}"
		@data["logBoard"]						= "\\}"
		@data["record_killcount"]				= Hash.new(0)
		@data["record_dropped_items"]			= nil
	end
	#$story_stats["sex_record_race_count"]["DataNpcName:race/Orkind"]
	#data = race/type, npc_name, sex_part #$story_stats.sex_record_vag(["DataNpcName:race/Orkind" , "DataNpcName:name/OrcWarrior" , "DataNpcName:part/penis"])
	#data = race/type, npc_name, sex_part #$story_stats.sex_record_vag(["DataNpcName:race/Fishkind" , "DataNpcName:name/OrcWarrior" , "DataNpcName:part/penis"])
	def sex_record_vag(data)
		@data["sex_record_first_vag"] = data if @data["sex_record_first_vag"].empty?
		@data["sex_record_last_vag"] = data
		@data["sex_record_partner_count"][data.to_s] += 1
		@data["sex_record_race_count"][data[0]] += 1
	end
	def sex_record_anal(data)data
		@data["sex_record_first_anal"] = data if @data["sex_record_first_anal"].empty?
		@data["sex_record_last_anal"] = data
		@data["sex_record_partner_count"][data.to_s] += 1
		@data["sex_record_race_count"][data[0]] += 1
	end
	def sex_record_mouth(data)
		@data["sex_record_first_mouth"] = data if @data["sex_record_first_mouth"].empty?
		@data["sex_record_last_mouth"] = data
		@data["sex_record_partner_count"][data.to_s] += 1
		@data["sex_record_race_count"][data[0]] += 1
	end
  #--------------------------------------------------------------------------
  # * Get Variable
  #--------------------------------------------------------------------------
  def [](key)
    @data[key] || 0
  end
  #--------------------------------------------------------------------------
  # * Set Variable
  #--------------------------------------------------------------------------
  def []=(variable_id, value)
    @data[variable_id] = value
    on_change
  end
  
  def overmap_char(name,event)
	raise "duplicate overmap_character name=>#{name}  , event.id=>#{event.id} , location=>(#{event.x},#{event.y})" if(!@overmap_character[name].nil? &&  @overmap_character[name].assigned)
	return @overmap_character[name].assign if @overmap_character[name]
	return @overmap_character[name]=OvermapCharacter.new(name,event).assign
  end
  
  def get_overmap_char
	return @overmap_character[name]
  end
  
  def reset_chars
	@overmap_character.each{
		|name,char|
		char.reset
	}
  end
  
  def keys
	@data.keys
  end
  
  #--------------------------------------------------------------------------
  # * Processing When Setting Variables
  #--------------------------------------------------------------------------
  def on_change
    $game_map.need_refresh = true
  end
end


class OvermapCharacter
	attr_accessor	:name
	attr_accessor	:overmap_x
	attr_accessor	:overmap_y
	attr_reader		:assigned
	attr_accessor	:erased
	attr_accessor	:addData
	
	def initialize(name,event)
		@name=name
		@overmap_x=event.x
		@overmap_y=event.y
		@assigned=false
		@erased=false
		@addData={}
	end
	
	def assign
		@assigned=true
		return self
	end
	
	def reset
		@assigned=false
	end
	
	def location
		[@overmap_x,@overmap_y]
	end
	
	
end
