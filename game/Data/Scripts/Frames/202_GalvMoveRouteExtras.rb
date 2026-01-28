#------------------------------------------------------------------------------#
#  Galv's Move Route Extras
#------------------------------------------------------------------------------#
#  For: RPGMAKER VX ACE
#  Version 1.9
#------------------------------------------------------------------------------#
#  2013-07-30 - Version 1.9 - added move toward and away from x,y
#  2013-04-25 - Version 1.8 - added turn toward event
#  2013-03-22 - Version 1.7 - move randomly only in region id's specified
#  2013-03-14 - Version 1.6 - added activating other events
#  2013-03-14 - Version 1.5 - fixed a bug with jumping to xy, added jump forward
#  2013-03-12 - Version 1.4 - added random wait and play animation
#  2013-03-12 - Version 1.3 - added changing priortiy level
#  2013-03-12 - Version 1.2 - added repeating multiple commands
#  2013-03-12 - Version 1.1 - added fading in/out and repeating move commands
#  2013-03-12 - Version 1.0 - release
#------------------------------------------------------------------------------#
#  This script was written to fill some gaps the move route commands left out.
#  Script commands can be used in move routes (for events and player) to:
#  - Jump to x,y coordinates on the map
#  - Jump to an event's or player's current location
#  - Jump forward (the direction currently facing) x number of tiles
#  - Move toward or away from an event
#  - Move toward or away from x,y location
#  - Turn self switches on and off
#  - Change charset to any pose without that 'visible turning frame'
#  - Repeat move commands
#  - Change the priority level (under, same as, above player)
#  - Play animation/balloon
#  - Activate an event below or in front of
#  - Move in a random direction only on a specified region
#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
#  SCRIPTS to use within MOVE ROUTES
#------------------------------------------------------------------------------#
#
#  jump_to(x,y)               # jumps to that x,y location
#  jump_to_char(id)           # jumps to event with that id or -1 for player
#  jump_forward(x)            # jump forward x amount of tiles
#
#  move_toward_event(id)      # steps toward event with that id.
#  move_away_from_event(id)   # moves away from event with that id.
#  turn_toward_event(id)      # turns toward event with that id
#
#  move_toward_xy(x,y)        # steps toward x,y coordinates
#  move_away_from_xy(x,y)     # steps away from x,y coordinates
#
#  fadeout(speed)             # fade out an event at the speed specified
#  fadein(speed)              # fade in an event at the speed specified
#
#  repeat(x)                  # repeat all commands between this and end_repeat
#  end_repeat                 # and do it x number of times.
#
#  repeat_next(x)             # repeat the following move command x times
#
#  char_level(x)              # change the character's level to x (0-2)
#                             # 0 = below    1 = same as player    2 = above
#
#  anim(id)                   # play animation with that id on character
#  balloon(id)                 # pops ballon with that id above player
#
#  wait(a,b)                  # wait a random amount of frames between a and b
#
#  self_switch("switch",status)    # turns self switch on or off (true or false)
#  self_switch("switch",status,x)  # turns self switch on/off for event id x
#
#  set_char("Charset",index,col,dir)  # Change event graphic to any charset pose
#                                     # index = character in the charset (1-8)
#                                     # col = the column/step of graphic (1-3)
#                                     # dir = direction (2,4,6,8)
#
#  restore_char       # restores event animation (that was disabled by set_char)
#
#  activate_event(type)     # activates another event...
#                           # type 0 is below it, type 1 is in front of it.
#                           # NOTE: If the move route is "wait for completition
#                           # then the other event won't start until the current
#                           # move route is finished.
#
#  random_region(x,x,x)     # Move in a random direction ONLY on the region ids
#                           # specified (x's) to keep NPC's where they belong.
#
#------------------------------------------------------------------------------#
#  EXAMPLES OF USE:
#
#  set_char("Damage3",5,1,4)   # 5th actor, left facing, column 1 of Damage3
#  self_switch("A",true)       # turns self switch A ON
#  self_switch("C",false)      # turns self switch C OFF
#  fadeout(10)                 # gradually fades the event out at speed 10
#  anim(66)                    # play animation with id 66
#  wait(50,100)                # wait a random amount of frames between 50 & 100
#  char_level(0)               # set level as below player
#  random_region(1,2,3,4,5)    # will move a random direction on these regions
#  repeat_next(9)              # repeats the next move command 9 times
#
#  repeat(10)                  # Will repeat moving forward and turning 10 times
#  - Move Forward
#  - Turn 90 degrees left
#  end_repeat
#
#
#  move_toward_xy(10,5)        # Moves toward tile at coordinates x10, y5
#  move_toward_xy($game_varables[1],$game_varables[2])  # same as above using
#                                                       # stored variables
#------------------------------------------------------------------------------#


#------------------------------------------------------------------------------#
#  NO SETTINGS FOR YOU! Script calls only for this one :)
#------------------------------------------------------------------------------#

class Game_Character < Game_CharacterBase
	def jump_to(x,y,tmpPeak=10)
		sx = distance_x_from(x)
		sy = distance_y_from(y)
		jump(-sx,-sy,tmpPeak)
	end
  
  
	def jump_to_low(x,y,tmpPeak=5)
		sx = distance_x_from(x)
		sy = distance_y_from(y)
		jump(-sx,-sy,tmpPeak)
	end
  
  
#  def jump_forward(count=1)
#    sx = 0; sy = 0
#    case @direction
#    when 2; sy = count
#    when 8; sy = -count
#    when 4; sx = -count
#    when 6; sx = count
#    end
#    jump(sx,sy)
#  end
  
	def jump_forward_low(count=1)
		sx = 0; sy = 0
		case @direction
		when 2; sy = count
		when 8; sy = -count
		when 4; sx = -count
		when 6; sx = count
		end
		jump_low(sx,sy)
	end
  
  def jump_reverse(count=1,temp_low=false)
    sx = 0; sy = 0
    case @direction
    when 2; sy = -count
    when 8; sy = count
    when 4; sx = count
    when 6; sx = -count
    end
    jump(sx,sy) if temp_low=false
    jump_low(sx,sy) if temp_low=true
  end
  
  
  def jump_from_self_to_rand(rang=3) #417 for blood
      x = distance_x_from(@x-1+rand(rang))
      y = distance_y_from(@y-1+rand(rang))
      jump_low(x,y)
  end
  
  def move_from_self_to_rand(rang=3) #417 for blood
      x = @x-1+rand(rang)
      y = @y-1+rand(rang)
      moveto(x,y)
  end
  
  def jump_to_char(id)
    if id <= 0
      sx = distance_x_from($game_player.x)
      sy = distance_y_from($game_player.y)
    else
      sx = distance_x_from($game_map.events[id].x)
      sy = distance_y_from($game_map.events[id].y)
    end
    jump(-sx,-sy)
  end
  
  def jump_forward(count=1)
    sx = 0; sy = 0
    case @direction
    when 2; sy = count
    when 8; sy = -count
    when 4; sx = -count
    when 6; sx = count
    end
    jump(sx,sy)
  end
  
  def set_rand_dir(dir)#made by 417
    dir = rand(4) if dir ==nil
    case dir
    when 0;@direction = 2
    when 1;@direction = 4
    when 2;@direction = 6
    when 3;@direction = 8
    end
  end
  
	def set_char(name,index,pattern,direction)
		@gstop = true
		@direction = direction
		@pattern = pattern - 1
		@character_name = name
		@character_index = index - 1
	end
  
  def set_index(index)
    @character_index = index 
  end
  
  def restore_char
    @gstop = false
  end
  
	alias galv_move_extras_gc_update_anime_pattern update_anime_pattern
		def update_anime_pattern
		return if @gstop
		galv_move_extras_gc_update_anime_pattern
	end
  
	def move_toward_event(id) #old   should remove and use move_toward_character
		move_toward_xy($game_player.x,$game_player.y) if id == -1
		move_toward_xy($game_map.events[id].x,$game_map.events[id].y) if id != -1
	end
  
  def move_goto_xy(tgtx,tgty,no_strand=true)
  return if self.x == tgtx && self.y == tgty
    sx = distance_x_from(tgtx)
    sy = distance_y_from(tgty)
    if sx.abs > sy.abs
      move_straight(sx > 0 ? 4 : 6) if @sx!=0
      move_straight(sy > 0 ? 8 : 2) if !@move_succeed && no_strand
	  else
      move_straight(sy > 0 ? 8 : 2) if @sy!=0
	  move_straight(sx > 0 ? 4 : 6) if !@move_succeed && no_strand
    end
		
  end

  def move_goto_xy_rand(tgtx,tgty,no_strand=true)
  return if self.x == tgtx && self.y == tgty
    sx = distance_x_from(tgtx)
    sy = distance_y_from(tgty)
    if sx.abs > sy.abs
      move_straight(sx > 0 ? 4 : 6) if @sx!=0
      move_random if !@move_succeed && no_strand
	  else
      move_straight(sy > 0 ? 8 : 2) if @sy!=0
	  move_random if !@move_succeed && no_strand
    end
		
  end

  def turn_toward_event(id)
    turn_toward_character($game_map.events[id])
  end
  
  def move_away_from_event(id)
    move_away_from_xy($game_player.x,$game_player.y) if id == -1
    move_away_from_xy($game_map.events[id].x,$game_map.events[id].y) if id != -1
  end
  
  def move_away_from_xy(sx,sy,no_strand=true)
    sx = distance_x_from(sx)
    sy = distance_y_from(sy)
    if sx.abs > sy.abs
      move_straight(sx > 0 ? 6 : 4)
      move_straight(sy > 0 ? 2 : 8) if !@move_succeed && sy != 0 && no_strand
    elsif sy != 0
      move_straight(sy > 0 ? 2 : 8)
      move_straight(sx > 0 ? 6 : 4) if !@move_succeed && sx != 0 && no_strand
    end
  end
  
  def self_switch(switch,status,id = @id)
    return if $game_self_switches[[@map_id,id,switch]].nil?
    $game_self_switches[[@map_id,id,switch]] = status
  end
  
	def fadeout_delete(speed=3)
		npc_story_mode(true)
		$game_map.delete_npc(self) if self.actor
		@npc = nil
		@trigger = -1
		@move_type = 0
		@through = true
		@effects=["FadeOutDelete",speed,false,nil,nil]
	end
	def fadeout_delete_crosshair(speed=3)
		npc_story_mode(true)
		$game_map.delete_npc(self) if self.actor
		@npc = nil
		@trigger = -1
		@move_type = 0
		@through = true
		@effects=["FadeOutDeleteCosshair",speed]
	end
  
	def zoomout_delete(speed=0.1)
		npc_story_mode(true)
		$game_map.delete_npc(self) if self.actor
		@npc = nil
		@trigger = -1
		@move_type = 0
		@through = true
		@effects=["ZoomOutDelete",speed]
	end
  
	#for orkind cave meat toilet
	def fadeout_delete_region(speed,trigger_region_id=50)
		return if self.region_id != trigger_region_id
		if @npc
			self.npc_story_mode(true)
			$game_map.delete_npc(self)
		end
		@opacity -= (speed)
		@move_route_index -= 1 if @opacity > 0
		@trigger = -1
		@through = true
		if @opacity <=60
			@opacity = 0
			self.delete
		end
	end
  
	#Unused Bullshit
	#def fade_teleport(speed,target_x,target_y,vise=0)
	#	if vise ==0
	#	self.npc_story_mode(true) if self.npc?
	#	@opacity -= (speed)
	#	vise =1 if @opacity <=60
	#	@move_route_index -= 1 if @opacity > 0
	#	end
	#	if vise == 1
	#	self.npc_story_mode(false) if self.npc?
	#	@opacity =255
	#	moveto(target_x,target_y)
	#	vise = 2
	#	end
	#end
  
	def fadeout(speed,temp_opacity=0)
		#p @trigger if self.id == 66
		#p "Asdasdasdasd" if self.id == 66
		return if @opacity <= temp_opacity
		 if @npc
			@recNpcName=@npc.npc_name
			$game_map.delete_npc(self)
			@npc = nil
			@trigger = -1
			@through = true
		end
		self.npc_story_mode(true)
		@opacity -= (speed)
		@move_route_index -= 1 if @opacity > temp_opacity
	end
	def fadein(speed,temp_opacity=255)
		return if @opacity >= temp_opacity
		self.npc_story_mode(false)
		@opacity += (speed)
		if @opacity < temp_opacity
			if @recNpcName && !@npc && @opacity > temp_opacity-50
				self.set_npc(@recNpcName)
				charStealHashName = "#{$game_map.map_id}_#{self.id}".to_sym
				$story_stats["CharacterItems"].delete(charStealHashName)
				$story_stats["CharacterSteal"].delete(charStealHashName)
				@summon_data[:SexTradeble] = true if @summon_data && summon_data[:SexTradeble] == false
				#@steal_did = false if @steal_did && @steal_did == true
				@recNpcName = nil
				@through = @manual_through.nil? ? @page.through : @manual_through
				@trigger = @manual_trigger.nil? ? @page.trigger : @manual_trigger
			end
			@move_route_index -= 1
		end
	end
	
	def fadeinLite(speed,temp_opacity=255)
		@opacity += (speed)
		if @opacity < temp_opacity
			@move_route_index -= 1
		end
	end
  
	def fadeoutLite(speed,temp_opacity=0)
		return if @opacity <= temp_opacity
		@opacity -= (speed)
		@move_route_index -= 1 if @opacity > temp_opacity
	end
  
  def repeat_next(times)
    @crepeat_next = times - 1
  end
  
  def repeat(times)
    @crepeats = times - 1
    @index_position = @move_route_index
  end
  
  def end_repeat
    if @crepeats > 0
      @crepeats -= 1
      @move_route_index = @index_position if @index_position
    else
      @index_position = nil
    end
  end

  def char_level(type)
    @priority_type = type
  end
  
  def anim(id)
    @animation_id = id
  end
  def balloon(id)
    @balloon_id = id
  end
  
  def wait(low,high)
    @wait_count = (rand(low - high) + low).to_i
  end
  
  alias galv_move_extras_gc_init_private_members init_private_members
  def init_private_members
    @crepeats = 0
    @crepeat_next = 0
    galv_move_extras_gc_init_private_members
  end
  
  alias galv_move_extras_gc_process_move_command process_move_command
  def process_move_command(command)
    if @crepeat_next > 0
      @move_route_index -= 1
      @crepeat_next -= 1
    end
    galv_move_extras_gc_process_move_command(command)
  end
  
  def activate_event(type)
    sx = 0; sy = 0
    if type != 0
      case @direction
      when 2; sy = 1
      when 8; sy = -1
      when 4; sx = -1
      when 6; sx = 1
      end
    end
    $game_map.events_xy(@x + sx, @y + sy).each do |event|
      event.start unless event.id == @id
    end
  end
  
  def random_region(*args)
    r = [*args]
    dir = 2 + rand(4) * 2
    sx = 0; sy = 0
    case dir
    when 2; sy = 1
    when 8; sy = -1
    when 4; sx = -1
    when 6; sx = 1
    end
    return if !r.include?($game_map.region_id(@x + sx, @y + sy))
    move_straight(dir, false)
  end
  
  def random_regionArray(tmpArray)
    dir = 2 + rand(4) * 2
    sx = 0; sy = 0
    case dir
    when 2; sy = 1
    when 8; sy = -1
    when 4; sx = -1
    when 6; sx = 1
    end
    return if !tmpArray.include?($game_map.region_id(@x + sx, @y + sy))
    move_straight(dir, false)
  end
  
	def move_random_water
		dir = 2 + rand(4) * 2
		sx = 0; sy = 0
		case dir
		when 2; sy = 1
		when 8; sy = -1
		when 4; sx = -1
		when 6; sx = 1
		end
		return if !$game_map.water_floor?(@x + sx, @y + sy)
		move_straight(dir, false)
	end

	def get_item_jump_xy(skip_character=false)
		temp_pssable_dir=Array.new
		temp_tar=Array.new
		temp_pssable_dir<< 2 if self.item_drop_passable?(@x,@y,2,skip_character)
		temp_pssable_dir<< 4 if self.item_drop_passable?(@x,@y,4,skip_character)
		temp_pssable_dir<< 6 if self.item_drop_passable?(@x,@y,6,skip_character)
		temp_pssable_dir<< 8 if self.item_drop_passable?(@x,@y,8,skip_character)
		return [self.x,self.y] if temp_pssable_dir.size==0
		dir=temp_pssable_dir.sample
		case dir
			when 2 ; [self.x+0,self.y+1]
			when 4 ; [self.x-1,self.y+0]
			when 6 ; [self.x+1,self.y+0]
			when 8 ; [self.x+0,self.y-1]
			else   ; [self.x+0,self.y+0]
		end
	end

	def item_jump_to(tmpPeak= 10,skip_character=false)
		tmp_toX,tmp_toY=get_item_jump_xy(skip_character)
		jump_to(tmp_toX,tmp_toY)
	end
	
	def item_move_to
		tmpThrough = @through
		tmpPriority_type = @priority_type
		@through = false
		@priority_type = 1
		move_random
		@priority_type = tmpPriority_type
		@through = tmpThrough
	end
	
	#def all_way_block?(tmpX=self.x,tmpY=self.y)
	#	return false if self.passable?(tmpX,tmpY,8)
	#	return false if self.passable?(tmpX,tmpY,4)
	#	return false if self.passable?(tmpX,tmpY,6)
	#	return false if self.passable?(tmpX,tmpY,2)
	#	return true
	#end
	#def all_way_block?(x, y)
	#	# Define your blocking logic here. Placeholder:
	#	return !passable?(x, y, 2) && !passable?(x, y, 4) && !passable?(x, y, 6) && !passable?(x, y, 8)
	#end
	def all_way_block?(x=self.x, y=self.y)
		[2, 4, 6, 8].all? { |dir| !self.passable?(x, y, dir) }
	end


#	def find_nearest_passable_and_jump
#		max_range = 10
#		found = false
#
#		(1..max_range).each do |r|
#			(-r).upto(r) do |dx|
#				(-r).upto(r) do |dy|
#					tx = self.x + dx
#					ty = self.y + dy
#					next if tx < 0 || ty < 0 || tx >= $game_map.width || ty >= $game_map.height
#					next if dx == 0 && dy == 0
#					next if all_way_block?(tx, ty)
#
	#				if self.passable?(tx, ty, 2) || self.passable?(tx, ty, 4) || self.passable?(tx, ty, 6) || self.passable?(tx, ty, 8)
	#					self.jump(dx, dy)
	#					found = true
	#					return
	#				end
	#			end
	#		end
	#	end
	#end

	def find_nearest_passable_and_jump
		#return unless all_way_block?(self.x, self.y)

		max_range = 10
		candidates = []

		(1..max_range).each do |r|
			(-r).upto(r) do |dx|
				(-r).upto(r) do |dy|
					tx = self.x + dx
					ty = self.y + dy
					next if tx < 0 || ty < 0 || tx >= $game_map.width || ty >= $game_map.height
					next if dx == 0 && dy == 0
					if self.passable?(tx, ty, 2) || self.passable?(tx, ty, 4) ||
							self.passable?(tx, ty, 6) || self.passable?(tx, ty, 8)
						candidates << [dx, dy]
					end
				end
			end
			break unless candidates.empty?  # Stop if any candidates found in this ring
		end

		if !candidates.empty?
			dx, dy = candidates.sample
			self.jump(dx, dy)
		#else
		#	puts "❌ No valid tile found for event #{@event_id}"
		end
	end
	def howManyWayBlocked?(tmpX=self.x,tmpY=self.y)
		tmpWayBlocked = 0
		tmpWayBlocked += 1 if !self.passable?(tmpX,tmpY,8)
		tmpWayBlocked += 1 if !self.passable?(tmpX,tmpY,4)
		tmpWayBlocked += 1 if !self.passable?(tmpX,tmpY,6)
		tmpWayBlocked += 1 if !self.passable?(tmpX,tmpY,2)
		tmpWayBlocked
	end
	def howManyWayEnter?(tmpX=self.x,tmpY=self.y) #mouse click  unused
		tmpWayBlocked = 0
		tmpWayBlocked += 1 if self.passable?(tmpX-1,tmpY,6)
		tmpWayBlocked += 1 if self.passable?(tmpX+1,tmpY,4)
		tmpWayBlocked += 1 if self.passable?(tmpX,tmpY+1,8)
		tmpWayBlocked += 1 if self.passable?(tmpX,tmpY-1,2)
		tmpWayBlocked
	end
	def xy_core_block?(tmp_x=$game_player.x,tmp_y=$game_player.y)
		!self.passable?(tmp_x+1,tmp_y,4) && !self.passable?(tmp_x-1,tmp_y,6) && !self.passable?(tmp_x,tmp_y+1,8) && !self.passable?(tmp_x,tmp_y-1,2)
	end

	def get_target_front_xy(target)
		case target.direction
			when 8; trans=[target.x,target.y-1]
			when 2; trans=[target.x,target.y+1]
			when 4; trans=[target.x-1,target.y]
			when 6; trans=[target.x+1,target.y]
		end
		trans
	end
	def get_target_back_xy(target)
		case target.direction
			when 8; trans=[target.x,target.y+1]
			when 2; trans=[target.x,target.y-1]
			when 4; trans=[target.x+1,target.y]
			when 6; trans=[target.x-1,target.y]
		end
		trans
	end
  def chase_target_character(tmpTarget)
    unless moving?
      sx = distance_x_from(tmpTarget.x)
      sy = distance_y_from(tmpTarget.y)
      if sx != 0 && sy != 0
        move_diagonal(sx > 0 ? 4 : 6, sy > 0 ? 8 : 2)
      elsif sx != 0
        move_straight(sx > 0 ? 4 : 6)
      elsif sy != 0
        move_straight(sy > 0 ? 8 : 2)
      end
    end
  end
	def companion_chase_character_overmap(temp_event)
		return moveto(temp_event.x,temp_event.y) if !self.near_the_target?(temp_event,5)
		return move_random if self.x == temp_event.x && self.y == temp_event.y
		return if !$game_player.moving?
		tmpWithEV = $game_map.events_xy(self.x, self.y).any?{|event| next if event == self ; event.overmapFollower}
		if tmpWithEV
			case @follower[2]
			when  1 ;@forced_x = -10
			when  0 ;@forced_x = 10
			when -1 ;@forced_y = -10
			end
		elsif !tmpWithEV
			@forced_x = 0
			@forced_y = 0
		end
		chase_target_character(temp_event)
	end
	
	def companion_chase_character_ext(temp_event=$game_player)
		#return moveto(temp_event.x,temp_event.y) if !self.near_the_target?(temp_event,10)
		return if !self.near_the_target?(temp_event,17)
		return if @follower[1] == 0
		return move_toward_TargetSmartAI(temp_event) if !self.near_the_target?(temp_event,3)
		#return move_goto_xy(temp_event.x,temp_event.y) if !self.near_the_target?(temp_event,3)
		#trans = get_target_back_xy(temp_event)
		#return move_goto_xy(temp_event.x+trans[0],temp_event.y+trans[1]) if self.x == temp_event.x && self.y == temp_event.y
		unless moving?
			sx = distance_x_from(temp_event.x)
			sy = distance_y_from(temp_event.y)
			if sx != 0 && sy != 0
				move_diagonal(sx > 0 ? 4 : 6, sy > 0 ? 8 : 2)
			elsif sx != 0
				move_straight(sx > 0 ? 4 : 6)
			elsif sy != 0
				move_straight(sy > 0 ? 8 : 2)
			end
		end
	end
	
	def companion_chase_character_back(temp_event=$game_player)
		return if !self.near_the_target?(temp_event,17)
		return move_goto_xy($game_player.crosshair.x,$game_player.crosshair.y) if temp_event == $game_player && $game_player.check_companion_assemblyCall?
		if @follower[1] == 0 && @summon_data
			if @summon_data[:CallMarkedX] && @summon_data[:CallMarkedY]
				tmpCM_x = @summon_data[:CallMarkedX]
				tmpCM_y = @summon_data[:CallMarkedY]
				move_toward_XY_SmartAI(tmpCM_x,tmpCM_y)
				if (tmpCM_x == self.x &&  tmpCM_y == self.y) || (self.report_distance_to_XY(tmpCM_x,tmpCM_y) <= 1 && !self.passable?(self.x,self.y,self.get_turn_toward_dir(tmpCM_x,tmpCM_y)))
					@summon_data[:CallMarkedX] = nil
					@summon_data[:CallMarkedY] = nil
				end
			elsif @summon_data[:CallMarked] && $game_player.crosshair
				self.turn_toward_character($game_player.crosshair)
			end
			return
		end
		return move_toward_TargetSmartAI(temp_event) if !self.near_the_target?(temp_event,3)
		#trans = get_target_back_xy(temp_event)
		#return move_goto_xy(temp_event.x+trans[0],temp_event.y+trans[1]) if self.x == temp_event.x && self.y == temp_event.y
		unless moving?
			sx = distance_x_from(temp_event.x)
			sy = distance_y_from(temp_event.y)
			if sx != 0 && sy != 0
				move_diagonal(sx > 0 ? 4 : 6, sy > 0 ? 8 : 2)
			elsif sx != 0
				move_straight(sx > 0 ? 4 : 6)
			elsif sy != 0
				move_straight(sy > 0 ? 8 : 2)
			end
		end
	end
	

	def companion_chase_character_front(temp_event=$game_player)
		return if !self.near_the_target?(temp_event,17)
		return move_goto_xy($game_player.crosshair.x,$game_player.crosshair.y) if temp_event == $game_player && $game_player.check_companion_assemblyCall?
		if @follower[1] == 0 && @summon_data
			if @summon_data[:CallMarkedX] && @summon_data[:CallMarkedY]
				tmpCM_x = @summon_data[:CallMarkedX]
				tmpCM_y = @summon_data[:CallMarkedY]
				move_toward_XY_SmartAI(tmpCM_x,tmpCM_y)
				if (tmpCM_x == self.x &&  tmpCM_y == self.y) || (self.report_distance_to_XY(tmpCM_x,tmpCM_y) <= 1 && !self.passable?(self.x,self.y,self.get_turn_toward_dir(tmpCM_x,tmpCM_y)))
					@summon_data[:CallMarkedX] = nil
					@summon_data[:CallMarkedY] = nil
				end
			elsif @summon_data[:CallMarked] && $game_player.crosshair
				self.turn_toward_character($game_player.crosshair)
			end
			return
		end
		return move_toward_TargetSmartAI(temp_event) if !self.near_the_target?(temp_event,3)
		trans = get_target_front_xy(temp_event)
		#return move_goto_xy(temp_event.x+trans[0],temp_event.y+trans[1]) if self.x == temp_event.x && self.y == temp_event.y
		unless moving?
			sx = distance_x_from(trans[0])
			sy = distance_y_from(trans[1])
			if sx != 0 && sy != 0
				move_diagonal(sx > 0 ? 4 : 6, sy > 0 ? 8 : 2)
			elsif sx != 0
				move_straight(sx > 0 ? 4 : 6)
			elsif sy != 0
				move_straight(sy > 0 ? 8 : 2)
			end
		end
	end
	
	def summon_npc_chase_character_back(master=self.summon_data[:user]) #not for player
		return if master == nil
		return self.actor.take_aggro(master.actor.target.actor,$data_arpgskills["BasicNormal"]) if !master.nil? && master.actor.target != nil && self.actor.aggro_frame <10
		return moveto(master.x,master.y) if !self.near_the_target?(master,15)
		return move_goto_xy(master.x,master.y) if !self.near_the_target?(master,4)
		trans = get_target_back_xy(master)
		return move_goto_xy(master.x+trans[0],master.y+trans[1]) if self.x == master.x && self.y == master.y
		unless moving?
		sx = distance_x_from(master.x)
		sy = distance_y_from(master.y)
		if sx != 0 && sy != 0
			move_diagonal(sx > 0 ? 4 : 6, sy > 0 ? 8 : 2)
		elsif sx != 0
			move_straight(sx > 0 ? 4 : 6)
		elsif sy != 0
			move_straight(sy > 0 ? 8 : 2)
		end
		end
	end
	
	def madness_movement(target)
		return if target.nil?
		return if target.action_state_block?
		$game_player.move_normal if target == $game_player
		target.move_random if !target.moving?
		target.call_balloon([1,2,5,6,7,8,13,14,15,16,20,26,27].sample) if rand(100) >=50
	end
	
	def action_state_block?
		return false if [nil,:none].include?(self.actor.action_state)
		true
	end
	
	def action_state_parallel_block?
		return false if [nil,:none,:skill].include?(self.actor.action_state)
		true
	end
	
	def overmapPopup(tmpText,tmpFreq1,tmpFreq2)
		return if @overmapPoped == nil || @overmapPoped
		return if !tmpText || !tmpFreq1 || !tmpFreq2
		return if !($story_stats["OverMapEvent_DateCount"] % tmpFreq1 >= tmpFreq2)
		SndLib.sound_QuickDialog
		@overmapPoped = true
		$game_map.popup(self.id,tmpText,0,0)
	end
	
	def atkEFX_XY_sync(user,xyFIX = 25)
		case user.direction
			when 8;	self.moveto(user.x,user.y-1)
			@forced_y -= ((user.y-user.real_y) * 32).to_i
			@forced_y += xyFIX
			when 2;	self.moveto(user.x,user.y+1)
			@forced_y -= ((user.y-user.real_y) * 32).to_i
			@forced_y -= xyFIX
			when 4;	self.moveto(user.x-1,user.y)
			@forced_x -= ((user.x-user.real_x) * 32).to_i
			@forced_x += xyFIX
			when 6;	self.moveto(user.x+1,user.y)
			@forced_x -= ((user.x-user.real_x) * 32).to_i
			@forced_x -= xyFIX
		end
	end
	def atkEFX_XY_sync_center(user)
		tmpThrough = self.through
		self.moveto(user.x,user.y)
		case user.direction
			when 8;@forced_y -= ((user.y-user.real_y).abs * 32).to_i
			when 2;@forced_y += ((user.y-user.real_y).abs * 32).to_i
			when 4;@forced_x -= ((user.x-user.real_x).abs * 32).to_i
			when 6;@forced_x += ((user.x-user.real_x).abs * 32).to_i
		end
		self.through = tmpThrough
	end
	def movetoRolling_forward(count=1)
		sx = self.x; sy = self.y
		case @direction
			when 2; sy += count
			when 8; sy -= count
			when 4; sx -= count
			when 6; sx += count
		end
		movetoRolling(sx,sy)
	end
###################################################################################################################
###################################################################################################################
######################################## COMBAT SYSTEM    #########################################################
###################################################################################################################
###################################################################################################################

	def summon_speam(user,target=self)
		return
		race = user.actor.race
		temp_x = target.x
		temp_y = target.y
		$game_damage_popups.add(rand(12)+1,temp_x, temp_y,2,9)
		$game_damage_popups.add(rand(12)+1,temp_x, temp_y,2,9)
		$game_damage_popups.add(rand(12)+1,temp_x, temp_y,2,9)
		$game_damage_popups.add(rand(12)+1,temp_x, temp_y,2,9)
			case race
				when "Human"       	;$game_map.reserve_summon_event("WasteSemenHuman",		temp_x,temp_y)
				when "Moot"        	;$game_map.reserve_summon_event("WasteSemenHuman",		temp_x,temp_y)
				when "Orkind"      	;$game_map.reserve_summon_event("WasteSemenOrcish",		temp_x,temp_y)
				when "Goblin"      	;$game_map.reserve_summon_event("WasteSemenOrcish",		temp_x,temp_y)
				when "Abomination" 	;$game_map.reserve_summon_event("WasteSemenAbomination",temp_x,temp_y)
				when "Deepone"     	;$game_map.reserve_summon_event("WasteSemenHuman",		temp_x,temp_y)
				when "Fishkind"    	;$game_map.reserve_summon_event("WasteSemenFishkind",	temp_x,temp_y)
				when "Troll"       	;$game_map.reserve_summon_event("WasteSemenTroll",		temp_x,temp_y)
			else 
			$game_map.reserve_summon_event("WasteSemenHuman",temp_x,temp_y)
			end
	end



def combat_move_to_tgt(tgt)
	return if !tgt #if user is ded. mean no tgt. mean crash
	self.turn_toward_character(tgt)
	if self.passable?(self.x,self.y,self.direction)
		x2=$game_map.round_x_with_direction(self.x,self.direction)
		y2=$game_map.round_y_with_direction(self.y,self.direction)
		self.movetoRolling(x2,y2)
		#combat_jump_forward(8,self.actor.target)
	end
end
def combat_move_forward(user)
	return if 2 >= user.actor.battle_stat.get_stat("move_speed") 
	if user.passable?(user.x,user.y,user.direction)
		#self.movetoRolling([@tmpUser.x+@dirX,0].max,[@tmpUser.y+@dirY,0].max) ; @direction = @tmpTar.direction
		#x2=$game_map.round_x_with_direction(user.x,user.direction)
		#y2=$game_map.round_y_with_direction(user.y,user.direction)
		user.jump_forward_low
	end
end

def combat_pull_to_user(user,target,jump=true)
	return if ![:stun, :none, nil].include?(target.actor.action_state)
	case user.direction
		when 8; trans=[user.x,user.y-1]
		when 2; trans=[user.x,user.y+1]
		when 4; trans=[user.x-1,user.y]
		when 6; trans=[user.x+1,user.y]
	end
	if target.passable?(user.x,user.y,user.direction)
		if target==$game_player
		target.moveto(trans[0],trans[1]) if jump ==false
		target.jump_to(trans[0],trans[1]) if jump ==true
		elsif target.actor.is_object == false && target.actor.immune_state_effect == false
		target.moveto(trans[0],trans[1]) if jump ==false
		target.jump_to(trans[0],trans[1]) if jump ==true
		end
	end
end

def combat_knockback(user,target,range=1,force_dir=nil)
	return if ![:stun, :none, nil].include?(target.actor.action_state)
	return if target.actor.is_object
	return if target.actor.immune_state_effect
	range.times{
		target.knockback_from_char(user,force_dir)
	}
end

def knockback_from_char(tgt,force_dir=nil)
	myDIR = self.direction
	if force_dir
		self.direction = force_dir
	else
		self.turn_away_from_character(tgt)
	end
	if self.passable?(self.x,self.y,self.direction)
		self.jump_forward(1)
	else
		self.jump_to(self.x,self.y)
	end
	self.direction = myDIR
end
def combat_jumpback(user,checkImmue=true)
	temp_tar_x=user.x
	temp_tar_y=user.y
	case user.direction
		when 2; trans=[user.x,		user.y-1	,8]
		when 8; trans=[user.x,		user.y+1	,2]
		when 6; trans=[user.x-1,	user.y		,4]
		when 4; trans=[user.x+1,	user.y		,6]
	end
	if user.passable?(user.x,user.y,trans[2]) #target.passable?(target.x,target.y,target.direction)
		if (user.actor.is_object == false && (user.actor.immune_state_effect == false && checkImmue)) || user==$game_player
		user.jump_to(trans[0],trans[1])
		end
	else
	user.jump_to(user.x,user.y)
	end
	user.jump_to(temp_tar_x,temp_tar_y) if user.all_way_block?
end

def combat_jump_to_target(user,target,tmpPeak=10,toEV=false)
		temp_pssable_dir=Array.new
		temp_tar=Array.new
		return user.jump_to(user.x,user.y,tmpPeak) if target.nil?
		temp_pssable_dir<< 2 if user.passable?(target.x,target.y,2)
		temp_pssable_dir<< 4 if user.passable?(target.x,target.y,4)
		temp_pssable_dir<< 6 if user.passable?(target.x,target.y,6)
		temp_pssable_dir<< 8 if user.passable?(target.x,target.y,8)
		return user.jump_to(user.x,user.y,tmpPeak) if temp_pssable_dir.size==0
		dir=temp_pssable_dir.sample
		if		dir == 2 ;temp_tar=[0,1]
		elsif	dir == 4 ;temp_tar=[-1,0]
		elsif	dir == 6 ;temp_tar=[1,0]
		elsif	dir == 8 ;temp_tar=[0,-1]
		end
		user.jump_to(target.x+temp_tar[0],target.y+temp_tar[1],tmpPeak)
end

def combat_ChargeJump(user)
	temp_tar_x=user.x
	temp_tar_y=user.y
	case user.direction
		when 2; tar_trans=[user.x,		user.y+2	,2]
				bef_trans=[user.x,		user.y+1	,2]
		when 8; tar_trans=[user.x,		user.y-2	,8]
				bef_trans=[user.x,		user.y-1	,8]
		when 6; tar_trans=[user.x+2,	user.y		,6]
				bef_trans=[user.x+1,	user.y		,6]
		when 4; tar_trans=[user.x-2,	user.y		,4]
				bef_trans=[user.x-1,	user.y		,4]
	end
	if user.passable?(bef_trans[0],bef_trans[1],bef_trans[2]) #target.passable?(target.x,target.y,target.direction)
		if (user.actor.is_object == false && user.actor.immune_state_effect == false) || user==$game_player
		user.jump_to_low(tar_trans[0],tar_trans[1])
		end
	else
	user.jump_to_low(user.x,user.y)
	end
	user.jump_to_low(temp_tar_x,temp_tar_y) if user.all_way_block?
end

def combat_jump_forward(peck=10,faceTGT=nil)
		case self.direction
			when 8; trans=[self.x,self.y-1]
			when 2; trans=[self.x,self.y+1]
			when 4; trans=[self.x-1,self.y]
			when 6; trans=[self.x+1,self.y]
		end
		if self.passable?(self.x,self.y,self.direction)
			self.jump_to(trans[0],trans[1],peck)
		else
			self.jump_to(self.x,self.y,peck)
		end
		turn_toward_character(faceTGT) if faceTGT
end

def combat_jump_reverse #unused, for tornato, but now tornato use knockback
	if self == $game_player
		user = $game_player
	else
		user=@summon_data[:user]
	end
	return if user == nil
	#return if ![:stun, :none, nil].include?(user.actor.action_state)
	trans=Array.new
	case user.direction
		when 8; trans=[0,1]
				back_dir = 2
		when 2; trans=[0,-1]
				back_dir = 8
		when 4; trans=[1,0]
				back_dir = 6
		when 6; trans=[-1,0]
				back_dir = 4
	end
	if  user.passable?(user.x,user.y,back_dir)
		if user==$game_player 
		user.jump_to(user.x+trans[0],user.y+trans[1])
		elsif user.actor.is_object == false && user.actor.immune_state_effect == false
		user.jump_to(user.x+trans[0],user.y+trans[1])
		end
	else
	user.jump_to(user.x,user.y)
	end
end

def left_dir
	[6,2,8,4][(@direction/2)-1]
end

def right_dir
	[4,8,2,6][(@direction/2)-1]
end

def pick_a_passable_dir
	pickedDir = [2,4,6,8].select{|dir|
		passable?(@x,@y,dir)
	}
	pickedDir.sample
end

def move_forward_passable_dir
	pickedDir = pick_a_passable_dir
	@direction = pickedDir if pickedDir
	move_forward if pickedDir
end

def can_push_npc_away?
	x2 = $game_map.round_x_with_direction(@x,@direction)
	y2 = $game_map.round_y_with_direction(@y,@direction)
	#事件可以被推開
	return true if passable?(@x,@y,@direction)
	#if (target.actor.is_object == false && target.actor.immune_state_effect == false) || target==$game_player
	return !$game_map.events_xy_nt(x2,y2).any?{|ev| !ev.npc? || (ev.npc? && ev!=self && !ev.can_push_away?)} && (!$game_player.pos?(x2,y2) || $game_player.can_push_away?)#只要有任何一個不行就直接out
end

def can_push_away?
	[2,4,6,8].any?{|dir|
	passable?(@x,@y,dir)
	}
end

#向左或向右跳動，如果不行就jump_back
def push_away(dist=1)
	return if self != $game_player && (!self.npc? || self.actor.is_object || self.actor.immune_state_effect)
	dirs=[]
	dirs << left_dir		if passable?(@x,@y,left_dir)
	dirs << right_dir		if passable?(@x,@y,right_dir)
	if dirs.empty?
		dirs << @direction		if passable?(@x,@y,@direction) #jump forward if front is blocked
		dirs << (10-@direction) if passable?(@x,@y,(10-@direction)) #jump backward if front is blocked
	end
	dir=dirs.sample
	tgt_x = @x
	tgt_y = @y
	return jump_to(tgt_x,tgt_y) if dir.nil?
	for dis in 0...dist
		break if !passable?(tgt_x,tgt_y,dir)
		case dir
			when 2; tgt_y += 1 ;
			when 4; tgt_x -= 1 ;
			when 6;	tgt_x += 1 ;
			when 8;	tgt_y -= 1 ;
		end
	end
	jump_to(tgt_x,tgt_y)
end

def undead_trap_opacity
	@opacity = [rand(80)+ $game_player.actor.scoutcraft_trait*2,200].min
	@mirror = [true, false].sample
	@forced_z = -5
end
def trigger_trap_opacity
	@opacity = [35+rand(40)+ $game_player.actor.scoutcraft_trait*2,200].min
	@mirror = [true, false].sample
	@forced_z = -5
end
def fish_trap_opacity
	@opacity = [90+rand(20)+ $game_player.actor.scoutcraft_trait*2,200].min
	@forced_z = -5
end
def tentacle_trap_opacity
	@opacity = [0+$game_player.actor.scoutcraft_trait*4,255].min
	@forced_z = -5
end


# for test  wormsprite in test map.
def asdasdasd_test(tgt,center_tgt=nil,center_tgt_range=nil)

	tt_Range = self.report_range(tgt)-1
	tt_Range.times{
		return if self.report_range(tgt) <=2 && (tgt.x != self.x && tgt.y != self.y)
	return if self.report_range(tgt) <=1
	#return if center_tgt && self.report_range(center_tgt) > center_tgt_range

	self.move_speed = tgt.move_speed #if tgt != $game_player
	#return if tgt.moving?
	tt_Range = self.report_range(tgt)-1
	sx = distance_x_from(tgt.x)
	sy = distance_y_from(tgt.y)

	savedDIR = @direction

	if sx != 0 && sy != 0
	#move_diagonal(sx > 0 ? 4 : 6, sy > 0 ? 8 : 2)

	sx > 0 ? @direction = 4 : @direction = 6
	#jump_forward_low
	movetoRolling_forward
	sy > 0 ? @direction = 8 : @direction = 2
	#jump_forward_low
	movetoRolling_forward
	elsif sx != 0
	#move_straight(sx > 0 ? 4 : 6)


	sx > 0 ? @direction = 4 : @direction = 6
	#jump_forward_low
	movetoRolling_forward
	elsif sy != 0
	#move_straight(sy > 0 ? 8 : 2)

	sy > 0 ? @direction = 8 : @direction = 2
	#jump_forward_low
	movetoRolling_forward
	end
	@direction = savedDIR
	}
end

end #class
