#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Game_Map
#------------------------------------------------------------------------------
#  This class handles maps. It includes scrolling and passage determination
# functions. The instance of this class is referenced by $game_map.
#==============================================================================

class Game_Map

	#--------------------------------------------------------------------------
	# * Public Instance Variables
	#--------------------------------------------------------------------------
	attr_accessor   :screen                   # map screen state
	attr_reader   :interpreter              # map event interpreter
	attr_reader   :events                   # events
	attr_reader   :display_x                # display X coordinate
	attr_reader   :display_y                # display Y coordinate
	attr_accessor	:parallax_name            # parallax background filename
	attr_accessor	:parallax_loop_x
	attr_accessor	:parallax_loop_y
	attr_accessor	:parallax_sx
	attr_accessor	:parallax_sy
	attr_accessor	:parallax_x
	attr_accessor	:parallax_y
	#attr_reader   :vehicles                 # vehicle
	attr_reader   :battleback1_name         # battle background (floor) filename
	attr_reader   :battleback2_name         # battle background (wall) filename
	attr_accessor :name_display             # map name display flag
	attr_accessor :need_refresh             # refresh request flag
	attr_reader		:map_id	
	#attr_reader   :monster_lib
	attr_reader 	:isOverMap
	attr_accessor 	:isUnderGround
	attr_reader 	:region_deduction
	attr_reader 	:add_data
	attr_reader 	:refreshing
	attr_accessor :added_ev_ids
	attr_reader	:napEventId
	attr_accessor :threat
	attr_reader		:storypoint_map
	attr_reader		:region_map
	attr_accessor :force_setup
	attr_accessor :map_background_color
	attr_accessor :map_background_color_blend
	attr_accessor :map_background_color_opacity
	attr_accessor :map_background_changed
	attr_accessor :force_setup
	attr_accessor :prev_bgm_name
	attr_accessor :prev_bgm_volume
	attr_accessor :prev_bgm_pitch
	attr_accessor :prev_bgm_pos
	attr_accessor :cam_target
	attr_accessor :forced_block_dir


	attr_reader :map_id_rec#map file name
	attr_reader :name #file name
	attr_reader :preload_EventHash #event name hash

  

	#--------------------------------------------------------------------------
	# #Optimization mod by Teravisor
	#--------------------------------------------------------------------------
	attr_accessor :pos_to_event
	attr_accessor :starting_events      # To store activated event

	def add_event_to_pos_hash(event)
		if has_event?(event.x,event.y) then
			@pos_to_event[hash_func(event.x,event.y)].push(event)
		else
			@pos_to_event[hash_func(event.x,event.y)]=[event]
		end
		return event
	end
	
	
	def has_event?(x,y)
		!@pos_to_event[hash_func(x,y)].nil? && @pos_to_event[hash_func(x,y)].length>0
	end

	def eventarray_xy(x,y)
		@pos_to_event[hash_func(x,y)] || []
	end

	def delete_event_from_pos_hash(event)
		res=@pos_to_event[hash_func(event.x,event.y)].delete(event) if has_event?(event.x,event.y)
		@pos_to_event.delete(hash_func(event.x,event.y)) if !@pos_to_event[hash_func(event.x,event.y)].nil? && @pos_to_event[hash_func(event.x,event.y)].empty?
		return res
	end
	
	def TERFIX2_remove_pos_to_event (event)
		elem = $game_map.delete_event_from_pos_hash(event)
		if elem.nil? then #when characters spawn, moveto sees previous coordinates (0,0) and cannot properly remove previous hash.
			success = $game_map.delete_event_from_pos_hash_erroneous(event)
		end
	end
	
	#looks through whole array to delete specified event. Should be called as few times as possible.
	def delete_event_from_pos_hash_erroneous(event)
		@pos_to_event.each_value{|arr| arr.delete(event) if !arr.nil?}
	end

	def reload_events_into_pos_hash
		@pos_to_event = {}
		@events.each_value do |event|
			add_event_to_pos_hash(event)
		end
	end
	
	#Simple hash function to check which hash to put object in. Result is integer for speed.
	def hash_func(x,y)
		(x << 16) + y
	end
	
	#--------------------------------------------------------------------------
	# * Object Initialization
	#--------------------------------------------------------------------------
	def initialize
		@screen = Game_Screen.new
		@interpreter = Game_Interpreter.new
		@map_id = 0
		@events = {}
		@display_x = 0
		@display_y = 0
		#create_vehicles
		@name_display = false
		@refreshing=0
		@turn_based = false
		@added_ev_ids=[]
		@forced_block_dir = [] #[[x,y,dir]
		@threat=false
		@non_threaten = 0
		@npcs = Array.new
		@all_characters = []
		@summoned_evs=[]
		@recover_ids=[]
		@force_setup=true
		@npc_changed = true
		@map_background_color = Color.new(System_Settings::MAP_BG_RED,System_Settings::MAP_BG_GREEN,System_Settings::MAP_BG_BLUE)
		@map_background_color_blend = System_Settings::MAP_BG_BLEND
		@map_background_color_opacity = System_Settings::MAP_BG_OPACITY
		@map_background_changed = true
		@prev_bgm_name = ""
		@prev_bgm_volume = 100
		@prev_bgm_pitch = 100
		@prev_bgm_pos = 0
		@pos_to_event = Hash.new
		@starting_events=[] #antiLag
		initialize_ultra_graphics
	end
	#--------------------------------------------------------------------------
	# * Setup
	#--------------------------------------------------------------------------
	def setup(map_id)
		@starting_events=[] #remove starting events from previous map. Fixes crash when moving from sewers to OrkindCave1 #antiLag
		@cam_target = 0
		Cache.clear_chs_character
		prp "setting up map id=>#{map_id}",6
		nap = (@map_id_rec == map_id  && !@force_setup)#用目標地圖是否與當下所在地圖id香等來判斷
		@threat =false
		save_overmap_char if @isOverMap
		prp "Game_Map :nap =>#{nap}, @map_id_rec==map_id =>#{@map_id_rec == map_id} , @force_setup=>#{@force_setup}"
		@map_id_rec = map_id
		@map_id = $data_mapinfos[map_id].id
		@name = $data_mapinfos[map_id].name
		@map = load_data($data_mapinfos[map_id].filename)
		@preload_EventHash = {}
		@map.events.each{|i,event| @preload_EventHash[event.name] = event }
		#@map_id_rec = map_id
		#if map_id.is_a?(String)
		#	@map_id = DataManager.extra_map_get_id(map_id)
		#	@map = load_data(sprintf(map_id, @map_id))
		#else
		#	@map_id = map_id
		#	@filename = sprintf("Data/Map%03d.rvdata2", @map_id)
		#	@map = load_data(@filename)
		#end
		@tileset_id = @map.tileset_id
		@tileset_id = 1 if $data_tilesets[@map.tileset_id].nil?
		@display_x = 0
		@display_y = 0
		#@npcs = Array.new if !nap
		@turn_based=nil
		@screen.brightness = 0
		prp "$game_map.setup_event_hack",6
		setup_event_hack
		prp "$game_map.clear_parallax",6
		clear_parallax
		prp "$game_map.setup_storypoint_map",6
		setup_storypoint_map
		prp "$game_map.setup_region_map",6
		setup_region_map
		prp "$story_stats.reset_chars during Game_Map.setup",6
		$story_stats.reset_chars
		prp "$game_map.setup_parallax",6
		setup_parallax
		prp "$game_map.setup_events",6
		nap ? reset_events : setup_events
		prp "$game_map.setup_overmap",6
		setup_overmap
		prp "$game_map.setup_scroll",6
		setup_scroll
		#prp "$game_map.setup_battleback",6
		#setup_battleback
		@need_refresh = false
		@force_setup = false 
		@scroll_blocked = false
		reload_events_into_pos_hash
		prp "$game_map.khas_extend_setup",6
		khas_extend_setup
		prp "load map Successed! update VerInfo"
		$story_stats["VerInfo"] = DataManager.export_full_ver_info
		prp "$game_map.setup finish",6
		@preload_EventHash = {}
	end
	def setup_event_hack
		#nothing so u can mod
	end
	def save_overmap_char
		@events.each do |i,ev|
		ev.save_overmap_stat if ev.is_overmap_char
	end
  
  
  end
  
  #clear all npcs for in case nap or map change
  def refresh_npc_arrays
	#p "refresh_npc_arrays TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
	@npcs.clear
	@events.each{|key,ev|
		@npcs << ev if ev.npc? && !ev.deleted?
	}
	@all_characters = @npcs + [$game_player]
	#p "refresh_npc_arrays end TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
  end
  
  def event_id_locked
	@npcs.each{
		|ev|
		next if !ev.npc? 
		next if !ev.npc.player_sighted? && !ev.npc.tracking_player?
		prp "ev.id =>#{ev.id} , ev.x =>#{ev.x} ev.y=>#{ev.y} include?#{@events.value?(ev)}",1
	}
  end
  
	def setup_storypoint_map
		point_format=/(-point-)(.+)/
		@storypoint_map=Hash.new
		@map.events.each{
			|key,ev|
			next if !point_format.match(ev.name)
			point_name=ev.name.split(point_format)[2]
			raise "Multiple point of name #{point_name} was found on this map_id=#{@map_id}." if !@storypoint_map[point_name].nil?
			@storypoint_map[point_name]=[ev.x,ev.y,key]
		}
	end
	
	def add_storypoint(point_name,x,y,id)
		@storypoint_map[point_name]=[x,y,id]
	end
	
  def setup_region_map
	@region_map=Array.new(64){Array.new}
	map_width=width
	map_height=height
	for x in 0...map_width
		for y in 0...map_height
			rg_id=region_id(x,y)
			@region_map[rg_id].push([x,y])
		end
	end
  end
  
  
  
  	
  def setup_overmap
    @add_data=Note.get_data(@map.note)
    @isOverMap=@add_data["isOverMap"]=="true"
    @isUnderGround=@add_data["isUnderGround"]=="true"
    $game_player.move_overmap
    $game_player.light_check
    #overmap
    if @isOverMap
        $game_player.transparent = true
        self.turn_based = true 
        $game_player.animation = nil
        $game_player.refresh_chs
    else
        #normal map
        $game_player.transparent = false
        self.turn_based = false 
        $game_player.animation = nil
        $game_player.refresh_chs
    end
    set_light
  end
  
  def init_region_deduction
	file=open(@add_data["region_config"])
	@region_deduction=JSON.decode(Note.clearGTcomments(file.read))
	@region_deduction.each{
		|key,val|
		@region_deduction[key]=val.to_i
	}
  end

  
  #--------------------------------------------------------------------------
  # * Event Setup
  #--------------------------------------------------------------------------
	def setup_events
		prp "$game_map.setup_events",6
		setup_ultra_lighting
		@napEventId=nil
		@npcs = Array.new
		@events = {}
		setup_bios_event #setup bios first if there's one
		@map.events.each do |i, event|
			prp "setup_events MAME=>#{event.name} ID=>#{i} X=>#{event.x} Y=>#{event.y}",6
			next if event.name.eql?("BIOS") #因為前面已經處理過BIOS所以這邊就跳過BIOS
			@events[i] = Game_Event.new(@map_id, event)
		end
		@common_events = parallel_common_events.collect do |common_event|
			Game_CommonEvent.new(common_event.name)
		end
		refresh_npc_arrays
		refresh_tile_events
		prp "$game_map.setup_events end",6
	end
	
  
  
	def setup_bios_event
		bios_event = Array.new
		@map.events.each{
			|i,ev|
			bios_event<< [i,ev] if ev.name.eql?("BIOS")
		}
		if bios_event.length > 1
		prp "Multiple BIOS event on map ID #{@map_id}",1
		bios_event.each do |kvpair| p "id=#{kvpair[0]} , x=>#{kvpair[1].x} y=>#{kvpair[1].y}"; end
		raise "MULTIPLE BIOS on Map, see console for list"
		end
		@events[bios_event[0][0]] = Game_Event.new(@map_id, bios_event[0][1]) if bios_event.length == 1
	end
  
  #--------------------------------------------------------------------------
  # * Nap時重新設定地圖事件，不會重設common event
  #--------------------------------------------------------------------------  
	def reset_events
		setup_ultra_lighting
		@npcs =Array.new
		@events.each do |i, event|
			next @events[i].delete if !event.nappable?  #傳回true或false，false的話就把事件刪掉
			next @events[i].delete if event.foreign_event && !event.nappable?
			next @events[i] = Game_Event.new(@map_id, @map.events[i]) if !event.foreign_event && event.reset_strong
			@events[i].nap_refresh
		end
		@common_events = parallel_common_events.collect do |common_event|
			Game_CommonEvent.new(common_event.name)
		end
		refresh_npc_arrays
		refresh_tile_events
		@interpreter.setup_reserved_common_event
	 end

  #--------------------------------------------------------------------------
  # * Get Array of Parallel Common Events
  #--------------------------------------------------------------------------
	def parallel_common_events
		$data_common_parallel
		#$data_common_events.values.select{|event|
		#	event.parallel?
		#}
	end
  #--------------------------------------------------------------------------
  # * Scroll Setup
  #--------------------------------------------------------------------------
  def setup_scroll
    @scroll_direction = 2
    @scroll_rest = 0
    @scroll_speed = 4
  end
  #--------------------------------------------------------------------------
  # * Parallax Background Setup
  #--------------------------------------------------------------------------
	def clear_parallax
		@parallax_name = nil
		@parallax_loop_x = false
		@parallax_loop_y = false
		@parallax_sx = 0
		@parallax_sy = 0
		@parallax_x = 0
		@parallax_y = 0
	end
	def setup_parallax
		@parallax_name = @map.parallax_name == "" ? nil : @map.parallax_name
		@parallax_loop_x = @map.parallax_loop_x
		@parallax_loop_y = @map.parallax_loop_y
		@parallax_sx = @map.parallax_sx
		@parallax_sy = @map.parallax_sy
		@parallax_x = 0
		@parallax_y = 0
	end
  #--------------------------------------------------------------------------
  # * Set Up Battle Background
  #--------------------------------------------------------------------------
  #def setup_battleback
  #  if @map.specify_battleback
  #    @battleback1_name = @map.battleback1_name
  #    @battleback2_name = @map.battleback2_name
  #  else
  #    @battleback1_name = nil
  #    @battleback2_name = nil
  #  end
  #end
  #--------------------------------------------------------------------------
  # * Set Display Position
  #--------------------------------------------------------------------------
	def set_display_pos(x, y)
		x = [0, [x, width - screen_tile_x].min].max unless loop_horizontal?
		y = [0, [y, height - screen_tile_y].min].max unless loop_vertical?
		@display_x = (x + width) % width
		@display_y = (y + height) % height
		@parallax_x = x
		@parallax_y = y
	end
  #--------------------------------------------------------------------------
  # * Calculate X Coordinate of Parallax Display Origin
  #--------------------------------------------------------------------------
  def parallax_ox(bitmap)
    if @parallax_loop_x
      @parallax_x * 16
    else
      w1 = [bitmap.width - Graphics.width, 0].max
      w2 = [width * 32 - Graphics.width, 1].max
      @parallax_x * 16 * w1 / w2
    end
  end
  #--------------------------------------------------------------------------
  # * Calculate Y Coordinate of Parallax Display Origin
  #--------------------------------------------------------------------------
  def parallax_oy(bitmap)
    if @parallax_loop_y
      @parallax_y * 16
    else
      h1 = [bitmap.height - Graphics.height, 0].max
      h2 = [height * 32 - Graphics.height, 1].max
      @parallax_y * 16 * h1 / h2
    end
  end
  #--------------------------------------------------------------------------
  # * Get Map ID
  #--------------------------------------------------------------------------
  def map_id
    @map_id
  end
  #--------------------------------------------------------------------------
  # * Get Tileset
  #--------------------------------------------------------------------------
	def tileset
		$data_tilesets[@tileset_id]
	end
  #--------------------------------------------------------------------------
  # * Get Display Name
  #--------------------------------------------------------------------------
  def display_name
    @map.display_name
  end
  #--------------------------------------------------------------------------
  # * Get Width
  #--------------------------------------------------------------------------
  def width
    @map.width
  end
  #--------------------------------------------------------------------------
  # * Get Height
  #--------------------------------------------------------------------------
  def height
    @map.height
  end
  #--------------------------------------------------------------------------
  # * Loop Horizontally?
  #--------------------------------------------------------------------------
  def loop_horizontal?
    @map.scroll_type == 2 || @map.scroll_type == 3
  end
  #--------------------------------------------------------------------------
  # * Loop Vertically?
  #--------------------------------------------------------------------------
  def loop_vertical?
    @map.scroll_type == 1 || @map.scroll_type == 3
  end
  #--------------------------------------------------------------------------
  # * Get Whether Dash is Disabled
  #--------------------------------------------------------------------------
  def disable_dash?
    @map.disable_dashing
  end
  #--------------------------------------------------------------------------
  # * Get Encounter List
  #--------------------------------------------------------------------------
  def encounter_list
    @map.encounter_list
  end
  #--------------------------------------------------------------------------
  # * Get Encounter Steps
  #--------------------------------------------------------------------------
  def encounter_step
    @map.encounter_step
  end
  #--------------------------------------------------------------------------
  # * Get Map Data
  #--------------------------------------------------------------------------
  def data
    @map.data
  end
  #--------------------------------------------------------------------------
  # * Determine if Field Type
  #--------------------------------------------------------------------------
  def overworld?
    tileset.mode == 0
  end
  #--------------------------------------------------------------------------
  # * Number of Horizontal Tiles on Screen
  #--------------------------------------------------------------------------
  def screen_tile_x
    Graphics.width / 32
  end
  #--------------------------------------------------------------------------
  # * Number of Vertical Tiles on Screen
  #--------------------------------------------------------------------------
  def screen_tile_y
    Graphics.height / 32
  end
  #--------------------------------------------------------------------------
  # * Calculate X Coordinate, Minus Display Coordinate
  #--------------------------------------------------------------------------
  def adjust_x(x)
    if loop_horizontal? && x < @display_x - (width - screen_tile_x) / 2
      x - @display_x + @map.width
    else
      x - @display_x
    end
  end
  #--------------------------------------------------------------------------
  # * Calculate Y Coordinate, Minus Display Coordinate
  #--------------------------------------------------------------------------
  def adjust_y(y)
    if loop_vertical? && y < @display_y - (height - screen_tile_y) / 2
      y - @display_y + @map.height
    else
      y - @display_y
    end
  end
  #--------------------------------------------------------------------------
  # * Calculate X Coordinate After Loop Adjustment
  #--------------------------------------------------------------------------
  def round_x(x)
    loop_horizontal? ? (x + width) % width : x
  end
  #--------------------------------------------------------------------------
  # * Calculate Y Coordinate After Loop Adjustment
  #--------------------------------------------------------------------------
  def round_y(y)
    loop_vertical? ? (y + height) % height : y
  end
  #--------------------------------------------------------------------------
  # * Calculate X Coordinate Shifted One Tile in Specific Direction
  #   (No Loop Adjustment)
  #--------------------------------------------------------------------------
  def x_with_direction(x, d)
    x + (d == 6 ? 1 : d == 4 ? -1 : 0)
  end
  #--------------------------------------------------------------------------
  # * Calculate Y Coordinate Shifted One Tile in Specific Direction
  #   (No Loop Adjustment)
  #--------------------------------------------------------------------------
  def y_with_direction(y, d)
    y + (d == 2 ? 1 : d == 8 ? -1 : 0)
  end
  #--------------------------------------------------------------------------
  # * Calculate X Coordinate Shifted One Tile in Specific Direction
  #   (With Loop Adjustment)
  #--------------------------------------------------------------------------
  def round_x_with_direction(x, d)
    round_x(x + (d == 6 ? 1 : d == 4 ? -1 : 0))
  end
  #--------------------------------------------------------------------------
  # * Calculate Y Coordinate Shifted One Tile in Specific Direction
  #   (With Loop Adjustment)
  #--------------------------------------------------------------------------
  def round_y_with_direction(y, d)
    round_y(y + (d == 2 ? 1 : d == 8 ? -1 : 0))
  end
  #--------------------------------------------------------------------------
  # * Automatically Switch BGM and BGS
  #--------------------------------------------------------------------------
  def autoplay
    @map.bgm.play if @map.autoplay_bgm
    @map.bgs.play if @map.autoplay_bgs
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    @events.each_value {|event| event.refresh }
    @common_events.each {|event| event.refresh }
    refresh_tile_events
	refresh_npc_arrays
	reload_events_into_pos_hash #tera
    @need_refresh = false
  end
  #--------------------------------------------------------------------------
  # * Refresh Array of Tile-Handling Events
  #--------------------------------------------------------------------------
  def refresh_tile_events
    @tile_events = @events.values.select {|event| event.tile? }
  end
  #--------------------------------------------------------------------------
  # * Get Array of Events at Designated Coordinates
  #--------------------------------------------------------------------------
	def events_xy(x,y) #tera
		eventarray_xy(x,y).select{|event| !event.nil? && !event.deleted?}
	end
  #--------------------------------------------------------------------------
  # * Get Array of Events at Designated Coordinates (Except Pass-Through)
  #--------------------------------------------------------------------------
	def events_xy_nt(x, y) #tera
		eventarray_xy(x,y).select {|event| !event.deleted? && !event.through }
	end
  #--------------------------------------------------------------------------
  # * Get Array of Tile-Handling Events at Designated Coordinates
  #   (Except Pass-Through)
  #--------------------------------------------------------------------------
  def tile_events_xy(x, y)
    @tile_events.select {|event| event.pos_nt?(x, y) }
  end
  #--------------------------------------------------------------------------
  # * Get ID of Events at Designated Coordinates (One Only)
  #--------------------------------------------------------------------------
  def event_id_xy(x, y)
    list = events_xy(x, y)
    list.empty? ? 0 : list[0].id
  end
  #--------------------------------------------------------------------------
  # * Scroll Down
  #--------------------------------------------------------------------------
  def scroll_down(distance)
    if loop_vertical?
      @display_y += distance
      @display_y %= @map.height
      @parallax_y += distance if @parallax_loop_y
    else
      last_y = @display_y
      @display_y = [@display_y + distance, height - screen_tile_y].min
      @parallax_y += @display_y - last_y
    end
  end
  #--------------------------------------------------------------------------
  # * Scroll Left
  #--------------------------------------------------------------------------
  def scroll_left(distance)
    if loop_horizontal?
      @display_x += @map.width - distance
      @display_x %= @map.width 
      @parallax_x -= distance if @parallax_loop_x
    else
      last_x = @display_x
      @display_x = [@display_x - distance, 0].max
      @parallax_x += @display_x - last_x
    end
  end
  #--------------------------------------------------------------------------
  # * Scroll Right
  #--------------------------------------------------------------------------
  def scroll_right(distance)
    if loop_horizontal?
      @display_x += distance
      @display_x %= @map.width
      @parallax_x += distance if @parallax_loop_x
    else
      last_x = @display_x
      @display_x = [@display_x + distance, (width - screen_tile_x)].min
      @parallax_x += @display_x - last_x
    end
  end
  #--------------------------------------------------------------------------
  # * Scroll Up
  #--------------------------------------------------------------------------
  def scroll_up(distance)
    if loop_vertical?
      @display_y += @map.height - distance
      @display_y %= @map.height
      @parallax_y -= distance if @parallax_loop_y
    else
      last_y = @display_y
      @display_y = [@display_y - distance, 0].max
      @parallax_y += @display_y - last_y
    end
  end
  #--------------------------------------------------------------------------
  # * Determine Valid Coordinates
  #--------------------------------------------------------------------------
  def valid?(x, y)
    x >= 0 && x < width && y >= 0 && y < height
  end
  #--------------------------------------------------------------------------
  # * Check Passage
  #     bit:  Inhibit passage check bit
    #    0x0001: 不可向下通行
    #    0x0002: 不可向左通行
    #    0x0004: 不可向右通行
    #    0x0008: 不可向上通行
    #    0x0010: 顯示優先度在角色之上
    #    0x0020: 梯子屬性
    #    0x0040: 流體屬性
    #    0x0080: 櫃檯屬性
    #    0x0100: 有害地形
    #    0x0200: 小舟無法通行
    #    0x0400: 大船無法通行
    #    0x0800: 飛艇無法著陸
    #    0xF000: 地形標誌
  #--------------------------------------------------------------------------
  def check_passage(x, y, bit)
    all_tiles(x, y).each do |tile_id|
      flag = tileset.flags[tile_id]
      next if flag & 0x10 != 0            # [☆]: No effect on passage
      return true  if flag & bit == 0     # [○] : Passable
      return false if flag & bit == bit   # [×] : Impassable
    end
    return false                          # Impassable
  end
  #--------------------------------------------------------------------------
  # * Get Tile ID at Specified Coordinates
  #--------------------------------------------------------------------------
  def tile_id(x, y, z)
    @map.data[x, y, z] || 0
  end
  #--------------------------------------------------------------------------
  # * Get Array of All Layer Tiles (Top to Bottom) at Specified Coordinates
  #--------------------------------------------------------------------------
  def layered_tiles(x, y)
    [2, 1, 0].collect {|z| tile_id(x, y, z) }
  end
  #--------------------------------------------------------------------------
  # * Get Array of All Tiles (Including Events) at Specified Coordinates
  #--------------------------------------------------------------------------
  def all_tiles(x, y)
    tile_events_xy(x, y).collect {|ev| ev.tile_id } + layered_tiles(x, y)
  end
  #--------------------------------------------------------------------------
  # * Get Type of Auto Tile at Specified Coordinates
  #--------------------------------------------------------------------------
  def autotile_type(x, y, z)
    tile_id(x, y, z) >= 2048 ? (tile_id(x, y, z) - 2048) / 48 : -1
  end
  #--------------------------------------------------------------------------
  # * Determine Passability of Normal Character
  #     d:  direction (2,4,6,8)
  #    Determines whether the tile at the specified coordinates is passable
  #    in the specified direction.
  #--------------------------------------------------------------------------
	def passable?(x, y, d)
		return false if spec_dir_blocker_passable?(x,y,d)
		check_passage(x, y, (1 << (d / 2 - 1)) & 0x0f)
	end
	def spec_dir_blocker_passable?(x,y,d)
		@forced_block_dir.include?([x,y,d])
	end
#  def rg9_check_start_tile(x, y) #unused
#    star_tile = false
#    all_tiles(x, y).each do |tile_id|
#      flag = tileset.flags[tile_id]
#      star_tile = true if flag & 0x10 != 0
#    end # do
#    return star_tile
#  end # def
  #--------------------------------------------------------------------------
# # * Determine if Passable by Boat
# #--------------------------------------------------------------------------
# def boat_passable?(x, y)
#   check_passage(x, y, 0x0200)
# end
# #--------------------------------------------------------------------------
# # * Determine if Passable by Ship
# #--------------------------------------------------------------------------
# def ship_passable?(x, y)
#   check_passage(x, y, 0x0400)
# end
# #--------------------------------------------------------------------------
# # * Determine if Airship can Land
# #--------------------------------------------------------------------------
# def airship_land_ok?(x, y)
#   check_passage(x, y, 0x0800) && check_passage(x, y, 0x0f)
# end
# #--------------------------------------------------------------------------
  # * Determine Flag for All Layers at Specified Coordinates
  #--------------------------------------------------------------------------
  def layered_tiles_flag?(x, y, bit)
    layered_tiles(x, y).any? {|tile_id| tileset.flags[tile_id] & bit != 0 }
  end
  #--------------------------------------------------------------------------
  # * Determine if Ladder
  #--------------------------------------------------------------------------
  def ladder?(x, y)
    valid?(x, y) && layered_tiles_flag?(x, y, 0x20)
  end
  #--------------------------------------------------------------------------
  # * Determine if Bush
  #--------------------------------------------------------------------------
  def bush?(x, y)
    valid?(x, y) && layered_tiles_flag?(x, y, 0x40)
  end
  #--------------------------------------------------------------------------
  # * Determine if Counter
  #--------------------------------------------------------------------------
  def counter?(x, y)
    valid?(x, y) && layered_tiles_flag?(x, y, 0x80)
  end
  #--------------------------------------------------------------------------
  # * Determine if Damage Floor
  #--------------------------------------------------------------------------
  def damage_floor?(x, y)
    valid?(x, y) && layered_tiles_flag?(x, y, 0x100)
  end
	#def water_floor?(x, y)
	#	valid?(x, y) && layered_tiles_flag?(x, y, 0x100)
	#end

	def water_floor?(x, y)
		return true if valid?(x, y) && layered_tiles_flag?(x, y, 0x100)
		return true if get_event_water_floor(x,y)
		return false
	end


	 def get_event_water_floor(x,y)
		#return nil if evs.size == 0
		evs = events_xy(x,y)
		return true if evs.any?{|event| event.ev_water_floor}
		return false
		#return nil if tmpTagEV.size == 0
		#return tmpTagEV.first.ev_water_floor
	end
  #--------------------------------------------------------------------------
  # * Get Terrain Tag
  #--------------------------------------------------------------------------
	def terrain_tag(x, y)
		return 0 unless valid?(x, y)
		ev_tt=get_event_terrain_tag(x,y)
		return ev_tt unless ev_tt.nil?
		layered_tiles(x, y).each do |tile_id|
			tag = tileset.flags[tile_id] >> 12
			return tag if tag > 0
		end
		return 0
	end
  
	
	def get_event_terrain_tag(x,y)
		evs = events_xy(x,y)
		return nil if evs.size == 0
		tmpTagEV = evs.select{|event| event.ev_terrain_tag}
		return nil if tmpTagEV.size == 0
		return tmpTagEV.first.ev_terrain_tag
	end
  #--------------------------------------------------------------------------
  # * Get Region ID
  #--------------------------------------------------------------------------
	def region_id(x, y)
		valid?(x, y) ? @map.data[x, y, 3] >> 8 : 0
	end

	#when get path and teleport  but blocked by touchevent
	def get_touch_or_region_events_here(tmpX,tmpY)
		tmpEv = nil
		@events.any?{|ev|
			next unless !ev[1].deleted? || !ev[1].erased
			next unless ev[1].trigger_in?([1,2])
			next unless !ev[1].normal_priority? || ev[1].through
			next unless (region_id(tmpX,tmpY) != 0 && ev[1].region_id == region_id(tmpX,tmpY)) || (ev[1].x == tmpX && ev[1].y == tmpY)
			tmpEv = ev[1]
		}
		tmpEv
	end
  #--------------------------------------------------------------------------
  # * Get Region Deduction with position
  #--------------------------------------------------------------------------  
	#def get_region_deduction(x,y)
		#@region_deduction[region_id(x,y).to_s]
	#end
  #--------------------------------------------------------------------------
  # * Start Scroll
  #--------------------------------------------------------------------------
  def start_scroll(direction, distance, speed)
    @scroll_direction = direction
    @scroll_rest = distance
    @scroll_speed = speed
  end
  #--------------------------------------------------------------------------
  # * Determine if Scrolling
  #--------------------------------------------------------------------------
  def scrolling?
    @scroll_rest > 0
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #     main:  Interpreter update flag
  #--------------------------------------------------------------------------
  def update(main = false)
    refresh if @need_refresh
    update_interpreter if main
    update_scroll
    update_events
	update_threatening
    #update_parallax
    @screen.update
  end
  
  
	def overmap_threatended?
		@npcs.any?{|ev| ev.npc.sensors.any?{|sensor|sensor.get_signal(ev,$game_player)!=0} && (!ev.erased && !ev.deleted?)}
	end
  
	def alskjdlasjdlad
		#asdEV = nil
		#@npcs.any?{|ev| 
		#	ev.npc.sensors.any?{|sensor|
		#		p sensor.get_signal(ev,$game_player)
		#		#next if sensor.get_signal(ev,$game_player) == 0
		#		#asdEV = ev
		#	}
		#}
		
		@npcs.any?{|ev| 
			ev.npc.sensors.any?{|sensor|
				if sensor.get_signal(ev,$game_player) != 0
					p "#{ev.name} #{ev.id} #{ev.x} #{ev.y}"
					ev.call_balloon(28,-1)
					ev.opacity = 255
					$game_player.moveto(ev.x,ev.y+1)
				end
				#p ev.name if sensor.get_signal(ev,$game_player) != 0
				#sensor.get_signal(ev,$game_player) != 0
			}
		}
	end
	
	#def g_sig(event)
	#	p "rst=>#{rst}" 
	#	rst 
	#end
  
	def update_threatening
		return if @isOverMap
		#OLD original
		#threatended = @npcs.any?{|npc| npc.actor.tracking_player?}
		#if @threat
		#	@non_threaten +=1 if !threatended
		#	@non_threaten = 0 if threatended && @non_threaten != 0
		#	if @non_threaten >= System_Settings::NON_THREATEN_COUNT
		#		@threat=false  #frame
		#		@non_threaten = 0
		#	end
		#else
		#	@threat = threatended
		#end
		@non_threaten += 1
		if @non_threaten >= System_Settings::NON_THREATEN_COUNT
			#@threat = @npcs.any?{|npc| 
			#next if npc.actor.action_state == :stun
			#npc.actor.tracking_player?
			#}
			@threat = nearTheThreaten?($game_player)
			@non_threaten = 0
		end
	end
	
	def nearTheThreaten?(tmpTar,tmpRange=8)
		@npcs.any?{|npc| 
			next if !npc.actor.tracking_player?
			next if npc.actor.action_state == :stun
			npc.near_the_target?(tmpTar,tmpRange)
		}
	end
  #--------------------------------------------------------------------------
  # * Update Scroll
  #--------------------------------------------------------------------------
  def update_scroll
    return unless scrolling?
    last_x = @display_x
    last_y = @display_y
    do_scroll(@scroll_direction, scroll_distance)
    if @display_x == last_x && @display_y == last_y
      @scroll_rest = 0
    else
      @scroll_rest -= scroll_distance
    end
  end
  #--------------------------------------------------------------------------
  # * Calculate Scroll Distance
  #--------------------------------------------------------------------------
  def scroll_distance
    2 ** @scroll_speed / 256.0
  end
  #--------------------------------------------------------------------------
  # * Execute Scroll
  #--------------------------------------------------------------------------
  def do_scroll(direction, distance)
    case direction
    when 2;  scroll_down (distance)
    when 4;  scroll_left (distance)
    when 6;  scroll_right(distance)
    when 8;  scroll_up   (distance)
    end
  end
  #--------------------------------------------------------------------------
  # * Update Events
  #--------------------------------------------------------------------------
	def update_events
		#檢查event是否被刪除，若已被刪除，將key所對應的值設為nil
		@events.keys.each{|key|
			event=@events[key]
			next if event.backgroundEvent
			if !event.nil? && event.deleted?
				@npc_changed =true if event.npc?
				if event.foreign_event || !event.nappable? || !event.reset_strong
					delete_event_from_pos_hash(event) #events that are going to be deleted, code taken from 31_Game_Map.rb update_events #tera
					delete_npc(event) if event.npc
					@events[key]=nil 
					@events.delete(key) 
				end
			end
			}
			@events.each_value {|event|
				###next if event.deleted? #warning,,   test
				event.update
			}
			@common_events.each {|event| event.update }
			summon_event(*@summoned_evs.shift) until @summoned_evs.empty?
	end
  #--------------------------------------------------------------------------
  # * Update Vehicles
  #--------------------------------------------------------------------------
  #def update_vehicles
  #  @vehicles.each {|vehicle| vehicle.update }
  #end
  #--------------------------------------------------------------------------
  # * Update Parallax
  #--------------------------------------------------------------------------
	def update_parallax
		@parallax_x += @parallax_sx / 64.0 if @parallax_loop_x
		@parallax_y += @parallax_sy / 64.0 if @parallax_loop_y
	end
  
  #--------------------------------------------------------------------------
  # * Change Tileset
  #--------------------------------------------------------------------------
	def change_tileset(tileset_id)
		@tileset_id = tileset_id
		@tileset_id = 1 if $data_tilesets[tileset_id].nil?
		refresh
	end
  #--------------------------------------------------------------------------
  # * Change Battle Background
  #--------------------------------------------------------------------------
  def change_battleback(battleback1_name, battleback2_name)
    @battleback1_name = battleback1_name
    @battleback2_name = battleback2_name
  end
  #--------------------------------------------------------------------------
  # * Change Parallax Background
  #--------------------------------------------------------------------------
	def change_parallax(name, loop_x, loop_y, sx, sy)
		@parallax_name = name
		@parallax_x = 0 if @parallax_loop_x && !loop_x
		@parallax_y = 0 if @parallax_loop_y && !loop_y
		@parallax_loop_x = loop_x
		@parallax_loop_y = loop_y
		@parallax_sx = sx
		@parallax_sy = sy
	end
  #--------------------------------------------------------------------------
  # * Update Interpreter
  #--------------------------------------------------------------------------
  def update_interpreter
    loop do
      @interpreter.update
      return if @interpreter.running?
      if @interpreter.event_id > 0
        unlock_event(@interpreter.event_id)
        @interpreter.clear
      end
      return unless setup_starting_event
    end
  end
  #--------------------------------------------------------------------------
  # * Unlock Event
  #--------------------------------------------------------------------------
  def unlock_event(event_id)
    @events[event_id].unlock if @events[event_id]
  end
  #--------------------------------------------------------------------------
  # * Starting Event Setup
  #--------------------------------------------------------------------------
  def setup_starting_event
    refresh if @need_refresh
    return true if @interpreter.setup_reserved_common_event
    return true if setup_starting_map_event
    return true if setup_autorun_common_event
    return false
  end
  #--------------------------------------------------------------------------
  # * Determine Existence of Starting Map Event
  #--------------------------------------------------------------------------
	def any_event_starting?
		!@starting_events.empty? #antiLag
		######original
		#@events.values.any? {|event| event.starting }
  end
  #--------------------------------------------------------------------------
  # * Detect/Set Up Starting Map Event
  #--------------------------------------------------------------------------
	def setup_starting_map_event
		######antiLag
		event = @starting_events[0]
		event.clear_starting_flag if event
		@interpreter.setup(event.list, event.id) if event
		event
		
		######original
		#event = @events.values.find {|event| event.starting }
		#event.clear_starting_flag if event
		#@interpreter.setup(event.list, event.id) if event
		#event
	end
  
  #--------------------------------------------------------------------------
  # * get line, from battle sensor, modded by 417
  #--------------------------------------------------------------------------
	def get_SightHpAndDist(tmpFromX,tmpFromY,tmpToX,tmpToY,tmpShp=4)
			shp=tmpShp
			line=get_line(tmpFromX,tmpFromY,tmpToX,tmpToY)
			last=line.last
				for point in 0...line.length
					tmpTerranTag=terrain_tag(line[point][:x],line[point][:y])
					tmpTerranTag == 4 ? shp= -1 : shp-= tmpTerranTag
					break if shp<0
				end
				tgt_dist=line.length== 0 ? 0 : line.length-1
			[shp,tgt_dist] #回傳sight_hp及距離
	    end
	def get_line(x0,y0,x1,y1)
		  points = []
		  steep = ((y1-y0).abs) > ((x1-x0).abs)
		  if steep
			x0,y0 = y0,x0
			x1,y1 = y1,x1
		  end
		  if x0 > x1
			x0,x1 = x1,x0
			y0,y1 = y1,y0
		  end
		  deltax = x1-x0
		  deltay = (y1-y0).abs
		  error = (deltax / 2).to_i
		  y = y0
		  ystep = nil
		  if y0 < y1
			ystep = 1
		  else
			ystep = -1
		  end

  		  x0=x0.to_i
		  x1=x1.to_i
		  for x in x0..x1
			if steep
			  points << {:x => y, :y => x}
			else
			  points << {:x => x, :y => y}
			end
			error -= deltay
			if error < 0
			  y += ystep
			  error += deltax
			end
		  end
		  return points
		end
  
  #--------------------------------------------------------------------------
  # * Detect/Set Up Autorun Common Event
  #--------------------------------------------------------------------------
	def setup_autorun_common_event
		#event = $data_common_events.values.find do |event|
		event = $data_common_auto.find do |event|
			event && event.autorun? && $game_switches.data_common_event[event.switch_id]
		end
		@interpreter.setup(event.list) if event
		event
	end
	
	def summon_event_help
		p event_lib.keys
	end
	
	def ask_add_event(mapid, eventid, x, y)
		map = load_data(sprintf("Data/Map%03d.rvdata2", mapid))
		new_event_id=@events.keys.max
		new_event_id=new_event_id.nil? ? 1 : new_event_id+1
		@added_ev_ids.push(new_event_id)
		new_event=map.events[eventid]
		new_event.x=x
		new_event.y=y
		new_event.id=new_event_id
		appended_event=Game_Event.new(@map_id,new_event)
		@events[new_event_id]=appended_event
	end
	#召喚事件，並且回傳招喚進來的事件
	def ask_summon_event(event_name,x=nil,y=nil,id= -1,data=nil)
		x=$game_player.x  if x.nil?
		y=$game_player.y  if y.nil?
		if(event_lib[event_name].nil?)
			msgbox "Summon event, event not found.\n#{event_name},x=#{x},y=#{y}" # if $debug_summon_event
			return
		else
			summoned_ev=event_lib[event_name][1]
		end
		summ_event_id=@events.keys.max
		summ_event_id=summ_event_id.nil? ? 1 : summ_event_id+1
		@added_ev_ids.push(summ_event_id)
		summoned_ev.x=x
		summoned_ev.y=y
		summoned_ev.id=summ_event_id
		appended_event=Game_Event.new(@map_id,summoned_ev,data)
		appended_event.summoner_id=id
		#return nil if appended_event.deleted?
		@events[summ_event_id]=appended_event
		appended_event.foreign_event=true
		#@npc_changed = appended_event.npc? && !@npc_changed
		appended_event
	end
	def add_event(mapid, eventid, x, y)
		#Copied from 31_Game_Map.rb, but this will make non-unique IDs if you try to delete key. Be extra careful and will need fixing if ever fixed in original.
#		eventid=@events.keys.max
#		eventid=new_event_id.nil? ? 1 : new_event_id+1
		#var = add_event_TERFIX2(mapid, eventid, x, y)
		#p var.class #DEBUG, maybe I can do less calls if this works
		event_itself = ask_add_event(mapid, eventid, x, y)
#		event_itself = @events[eventid]
		add_event_to_pos_hash(event_itself)
	end
	def summon_event(event_name,x=nil,y=nil,id= -1,data=nil)
		event_itself = ask_summon_event(event_name,x,y,id,data)
		add_event_to_pos_hash(event_itself)
	end
  
  #將招喚事件的指令放入到@summon_evs並且在下一個UPDATE中招喚
  def reserve_summon_event(event_name,x=$game_player.x,y=$game_player.y,id= -1,data=nil)
		prp "reserve_summon_event :#{event_name} x=#{x} y=#{y}",5
		@summoned_evs << [event_name,x,y,id,data]
  end
  
  #暫時先用summon_event的原始碼頂著
  def summon_skill(event_name,data=nil,id= -1)
		@summoned_evs <<[event_name,nil,nil,id,data]
  end
	
  def turn_based?
    @turn_based
  end
  
  
  def turn_based=(boolean)
    return if !!@turn_based == boolean # No effect if called again with same argument. !! for nil case
    @turn_based = boolean
    if @turn_based
      $game_player.previous_movement = $game_player.movement if [:dash, :dash_fatigue, :dash_cuffed, :dash_overfatigue].include?($game_player.movement)
      $game_player.move_normal if [:dash, :dash_fatigue, :dash_cuffed, :dash_overfatigue].include?($game_player.movement)
      next_round
    else
      $game_player.move_normal if [:dash, :dash_fatigue, :dash_cuffed, :dash_overfatigue].include?($game_player.movement)
      stop_round
    end
  end

    # Starts a new round of turns.
  def next_round
    $game_player.update_timeout
    $game_player.update_overmap
    $game_player.update_normalmap
    stop_round # Stop a round if one's already in progress
    @turn_list = [$game_player].concat(@events.values)
    @turn_list.first.take_turn
  end
  
  def stop_round
    return if @turn_list.nil? || @turn_list.empty?
    @turn_list.first.revoke_turn
    @turn_list = nil
  end
  
  def next_turn
    @turn_list.shift
    if @turn_list.empty?
      next_round
    else
      @turn_list.first.take_turn
    end
  end
  
  def hostile?
    @events.values.count { |e| e.hostile? } > 0
  end
  
  def setNapEvent(event)
	#raise "duplicate nap event on event##{event.id} and event##{@napEventId}" unless @napEventId.nil? && @napEventId==event.id
	@napEventId=event.id
  end
  
	def call_nap_event
		return if @napEventId.nil? || @events[@napEventId].nil?
		prp "found @napEventId =>#{@napEventId}",4
		@events[@napEventId].start
	end
  
  def get_enterpoint(map_id,point_name)
	smap = load_data(sprintf("Data/Map%03d.rvdata2", map_id))	
	points=Array.new
	smap.events.keys.each{
		|key|
		ev=smap.events[key]
		points.push(ev.name.split(point_format)[2]) if point_format.match(ev.name)
	}
	raise "no map_point of point_name #{point_name} was found ,map_id=#{map_id}" if points.length==0
	raise "multiple map_point of point_name #{point_name} was found map_id=#{map_id}" if points.length>1
	points[0]
  end
  

  def get_random_region(region_id)
	raise "there's no region_id=#{region_id} on this map. map_id=#{@map_id}" if @region_map.nil? || @region_map[region_id].length ==0
	return @region_map[region_id].sample
  end
  
  def get_storypoint(point_name)
	point=@storypoint_map[point_name]
	raise "no point of #{point_name} was fund on this map. map_id=#{@map_id}" if point.nil?
	point
  end
	def list_storypoints
		@storypoint_map
	end
  
  def get_story_event(point_name)
	point=@storypoint_map[point_name]
	if point.nil?
		msgbox "no point of #{point_name} was fund on this map. map_id=#{@map_id}" if !point_name.eql?("BIOS")
		return nil
	end
	story_event=@events[point[2]]
	msgbox "story point gone for point_name=#{point_name}" if story_event.nil?
	story_event
  end
  
  def all_characters
	@all_characters
  end
  
  
  def npcs
	@npcs
  end
  
  #debug method
  def de_event_under
	self.events_xy($game_player.x,$game_player.y).each{
		|ev|
		p "ev.name=>#{ev.name}"
	}
  end
  
  #debug method
  def print_all_characters
	@all_characters.each_with_index{
		|index,char|
		p "index=>#{index} , char=>#{char.to_s} "
	}
  end
  
  def clear_cached_npc_skills
	@events.values.each{
		|ev|
		next unless ev.npc?
		ev.actor.clear_cached_skill
	}
  end
  
	def event_lib
		$data_EventLib
	end
  
  def register_npc(event)
   @npcs << event
   @all_characters << event
  end
  
	def delete_npc(event)
		@npcs.delete(event)
		@all_characters.delete(event)
	end

end
