#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# - Pathfinding script by Karanum -
#----------------------------------------------------------------------------
# This pathfinding script is based off a simplified version of Dijkstra's
# algorithm. It's mainly made for calculating paths over small distances,
# but also provides some methods for longer calculations.
#
# It adds 4 different methods for calculating the path and 1 method to check
# whether an event is pathfinding or not.
# For all of these methods, the x and y are the end coordinates and the id is
# the id of the event that has to run the pathfinding method. When left out, the
# id will always default to 0. **
# Setting through? allows you to change the pathfinding event's passability.
# This setting defaults to true if you don't set it.
#
#
#   - walk_to_straight( x, y, id, through? )
#	   This performs simple pathfinding, using only a part of the map.
#	   It can't find long detours, but it's the least expensive method.
#	   This should be used for basic events that don't require advanced
#	   pathfinding.
#
#   - walk_to( x, y, id, through? )
#	   This is the most basic form of the pathfinding algorithm, although it
#	   can lag when using large maps or when there is no path to the endpoint.
#	   This is the most balanced pathfinding method, able to find paths of up
#	   to a 1000 tiles.
#
#   - walk_to_short( x, y, id, through? )
#	   Basically a lesser version of the walk_to method.
#	   It can find paths of up to a 100 tiles and is best for larger maps.
#
#   - walk_to_long( x, y, max_steps, id, through? )
#	   This method lets you specify the maximum amount of tiles the path can
#	   be, but will take a while to calculate the path. This method is best
#	   for pathfinding over long distances, although it takes the longest.
#	   This method will only lag the calling event, not your entire game.
#
#   - pathfinding?( id )
#	   This method returns true when the specified event is currently going
#	   through one of the above methods. Otherwise it returns false.
#
#
# ** NOTE: As event id, you can use 0 for 'This Event' and -1 for 'Player'
#
# Don't change anything past this point if you don't know what you're doing.
# It can make your game crash when you try to call one of the methods.
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=begin
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# - Game_Character -
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
class Game_Character
 attr_accessor		:target_PF_x
 attr_accessor		:target_PF_y
 attr_reader		:path_through
 attr_accessor		:pathfinding
 attr_reader		:distance_map

 #--------------------------------------------------------------------------
 # Game_CharacterBase's update override
 # May cause incompatibility with other scripts that also override this
 #--------------------------------------------------------------------------

 #--------------------------------------------------------------------------
 # Update pathfinding movement
 #--------------------------------------------------------------------------
 def movePathfinding(character)
	if !@distance_map
		return move_toward_character(character)
	end

	if (@x == @target_PF_x) and (@y == @target_PF_y)
		#puts "[Pathfinding] Pathfinding completed"
		#@through = false if @path_through
		@pathfinding = false
		return move_toward_character(character)
		
	end

	next_dir = find_next_tag(@distance_map, @x, @y)
	if next_dir == 0
		#puts "[Pathfinding] Could not find path to endpoint"
		#puts "[Pathfinding] If a path exists, try increasing the amount of iterations"
		@pathfinding = false
		return move_toward_characterRNG(character)
	end
	move_straight(next_dir)
 end
 
 def movePathfindingXY
	if !@distance_map
		return @pathfinding = false
	end

	if (@x == @target_PF_x) and (@y == @target_PF_y)
		#puts "[Pathfinding] Pathfinding completed"
		#@through = false if @path_through
		@pathfinding = false
		return @pathfinding = false
		
	end

	next_dir = find_next_tag(@distance_map, @x, @y)
	if next_dir == 0
		#puts "[Pathfinding] Could not find path to endpoint"
		#puts "[Pathfinding] If a path exists, try increasing the amount of iterations"
		@pathfinding = false
		return @pathfinding = false
	end
	move_straight(next_dir)
 end

 #--------------------------------------------------------------------------
 # Check if currently pathfinding
 #--------------------------------------------------------------------------
 def pathfinding?
if @pathfinding
  return @pathfinding
else
  return false
end
 end

 #--------------------------------------------------------------------------
 # Obtain array with distance map from $game_map
 #--------------------------------------------------------------------------
 def createPath(x, y, iterations=25, long_mode=false, short_mode=false, passthrough=@through)
	#puts "[Pathfinding] Starting pathfinding"
	@pathfinding = true
	@path_through = passthrough
	
	@target_PF_x = x
	@target_PF_y = y
	
	@distance_map = $game_map.find_path(self, x, y, iterations, long_mode, short_mode)
	#puts "[Pathfinding] Distance map generated"
 end

 #--------------------------------------------------------------------------
 # Find next tile to walk to
 #--------------------------------------------------------------------------
 def find_next_tag(map, x, y)
current_tag = map[y][x]
if(current_tag == -1)
  return 0
end

if y != (map.length - 1)
  if map[y+1][x] == current_tag - 1
	return 2
  end
end

if x != 0
  if map[y][x-1] == current_tag - 1
	return 4
  end
end

if y != 0
  if map[y-1][x] == current_tag - 1
	return 8
  end
end

if x != (map[y].length - 1)
  if map[y][x+1] == current_tag - 1
	return 6
  end
end

return 0

 end
end

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# - Game_Map -
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
class Game_Map

	def get_event_passable(x,y) #test
		evs=events_xy(x,y)
		return true if evs.size==0
		return false if !evs[0].through && evs[0].priority_type == 1
		true
	end
	def passable_pathfinding?(x, y, d)
		return false if !get_event_passable(x,y)
		check_passage(x, y, (1 << (d / 2 - 1)) & 0x0f)
	end
 #--------------------------------------------------------------------------
 # Check adjacent tiles for passability
 #--------------------------------------------------------------------------
	def check_adjacent_panels(x, y)
		adjacent_panels = Array.new(4, false)
		if y != (height - 1)
			if passable_pathfinding?(x, y, 2) and passable_pathfinding?(x, y+1, 8) #Down
				adjacent_panels[0] = true
			end
		end
		
		if y != 0
			if passable_pathfinding?(x, y, 8) and passable_pathfinding?(x, y-1, 2) #Up
				adjacent_panels[2] = true
			end
		end
		
		if x != (width - 1)
			if passable_pathfinding?(x, y, 6) and passable_pathfinding?(x+1, y, 4) #Right
				adjacent_panels[3] = true
			end
		end
		
		if x != 0
			if passable_pathfinding?(x, y, 4) and passable_pathfinding?(x-1, y, 6) #Left
				adjacent_panels[1] = true
			end
		end
		return adjacent_panels
	end

 #--------------------------------------------------------------------------
 # Create an array with a distance map to the endpoint
 #--------------------------------------------------------------------------
	def find_path(event, x, y, iterations=1000, long_mode=false, short_mode=false)
		map_array = Array.new(height) { Array.new(width, -1) }
		map_array[y][x] = 0
		current_tag = 0
		current_iteration = 0
		low_x = 0
		low_y = 0
		high_x = width - 1
		high_y = height - 1
		if short_mode
			low_x = [event.x, x].min - 2
			low_y = [event.y, y].min - 2
			high_x = [event.x, x].max + 2
			high_y = [event.y, y].max + 2
		end
		iterations.times do
			current_iteration = current_iteration + 1
			for map_y in (low_y..high_y)
				for map_x in (low_x..high_x)
					if map_array[map_y][map_x] == current_tag
						adjacent_panels = check_adjacent_panels(map_x, map_y)
							if adjacent_panels[0]
								if map_array[map_y+1][map_x] == -1
									map_array[map_y+1][map_x] = current_tag + 1
								end
							end
							if adjacent_panels[1]
								if map_array[map_y][map_x-1] == -1
									map_array[map_y][map_x-1] = current_tag + 1
								end
							end
							if adjacent_panels[2]
								if map_array[map_y-1][map_x] == -1
									map_array[map_y-1][map_x] = current_tag + 1
								end
							end
							if adjacent_panels[3]
								if map_array[map_y][map_x+1] == -1
									map_array[map_y][map_x+1] = current_tag + 1
								end
							end
						end
					end
				end
				current_tag = current_tag + 1
				if map_array[event.y][event.x] != -1
					return map_array
				end
				if (current_iteration % 20 == 0) and long_mode
					Fiber.yield
			end
		end
		return map_array
	end
end

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# - Game_Interpreter -
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Changes:
#   - Added walk_to(x, y, id)
#   - Added walk_to_short(x, y, id)
#   - Added walk_to_long(x, y, iterations, id)
#   - Added walk_to_straight(x, y, id)
#   - Added pathfinding?(id)
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
class Game_Interpreter
 def walk_to(x, y, id=0, passthrough=true)
character = get_character(id)
character.walk_to(x, y, 1000, false, false, passthrough)
 end

 def walk_to_short(x, y, id=0, passthrough=true)
character = get_character(id)
character.walk_to(x, y, 100, false, false, passthrough)
 end

 def walk_to_long(x, y, iterations, id=0, passthrough=true)
character = get_character(id)
character.walk_to(x, y, iterations, true, false, passthrough)
 end

 def walk_to_straight(x, y, id=0, passthrough=true)
character = get_character(id)
character.walk_to(x, y, 1000, false, true, passthrough)
 end

 def pathfinding?(id=0)
character = get_character(id)
return character.pathfinding?
 end
end
=end



class Game_Character
	attr_accessor :target_PF_x, :target_PF_y, :pathfinding
	attr_reader   :path_through, :distance_map

	#--------------------------------------------------------------------------
	# Main pathfinding movement update
	#--------------------------------------------------------------------------
	def movePathfinding(character = nil)
		return finish_pathfinding(character) unless @distance_map
		return finish_pathfinding(character) if at_target?

		next_dir = find_next_tag(@distance_map, @x, @y)
		return fail_pathfinding(character) if next_dir == 0

		move_straight(next_dir)
	end

	def movePathfindingXY
		movePathfinding(nil)
	end

	def pathfinding?
		!!@pathfinding
	end

	def createPath(x, y, iterations = 25, long_mode = false, short_mode = false, passthrough = @through)
		@pathfinding = true
		@path_through = passthrough
		@target_PF_x, @target_PF_y = x, y
		@distance_map = $game_map.find_path(self, x, y, iterations, long_mode, short_mode)
	end

	#--------------------------------------------------------------------------
	# Check if at destination
	#--------------------------------------------------------------------------
	def at_target?
		@x == @target_PF_x && @y == @target_PF_y
	end

	#--------------------------------------------------------------------------
	# Handle pathfinding completion
	#--------------------------------------------------------------------------
	def finish_pathfinding(character)
		@pathfinding = false
		character ? move_toward_character(character) : false
	end

	#--------------------------------------------------------------------------
	# Handle pathfinding failure
	#--------------------------------------------------------------------------
	def fail_pathfinding(character)
		@pathfinding = false
		character ? move_toward_characterRNG(character) : false
	end

	#--------------------------------------------------------------------------
	# Determine next direction from distance map
	#--------------------------------------------------------------------------
	def find_next_tag(map, x, y)
		return 0 if map[y][x] == -1

		{
			2 => [x, y + 1],
			4 => [x - 1, y],
			8 => [x, y - 1],
			6 => [x + 1, y]
		}.each do |dir, (nx, ny)|
			next unless ny.between?(0, map.size - 1) && nx.between?(0, map[0].size - 1)
			return dir if map[ny][nx] == map[y][x] - 1
		end

		0
	end
end



class Game_Map
	def get_event_passable(x, y)
		evs = events_xy(x, y)
		return true if evs.empty?
		return false unless evs[0].through || evs[0].priority_type != 1
		true
	end

	def passable_pathfinding?(x, y, d)
		return false unless get_event_passable(x, y)
		check_passage(x, y, (1 << (d / 2 - 1)) & 0x0f)
	end

	def check_adjacent_panels(x, y)
		[
			y < height - 1 && passable_pathfinding?(x, y, 2) && passable_pathfinding?(x, y + 1, 8), # Down
			x > 0          && passable_pathfinding?(x, y, 4) && passable_pathfinding?(x - 1, y, 6), # Left
			y > 0          && passable_pathfinding?(x, y, 8) && passable_pathfinding?(x, y - 1, 2), # Up
			x < width - 1  && passable_pathfinding?(x, y, 6) && passable_pathfinding?(x + 1, y, 4)  # Right
			]
	end

	def find_path(event, x, y, iterations = 1000, long_mode = false, short_mode = false)
		map_array = Array.new(height) { Array.new(width, -1) }
		map_array[y][x] = 0
		current_tag = 0
		low_x, low_y = 0, 0
		high_x, high_y = width - 1, height - 1
		if short_mode
			low_x  = [event.x, x].min - 2
			low_y  = [event.y, y].min - 2
			high_x = [event.x, x].max + 2
			high_y = [event.y, y].max + 2
		end
		iterations.times do |i|
			for map_y in low_y..high_y
				for map_x in low_x..high_x
					next unless map_array[map_y][map_x] == current_tag
					check_adjacent_panels(map_x, map_y).each_with_index do |pass, index|
						next unless pass
						dx, dy = [[0,1],[ -1,0],[0,-1],[1,0]][index]
						nx, ny = map_x + dx, map_y + dy
						map_array[ny][nx] = current_tag + 1 if map_array[ny][nx] == -1
					end
				end
			end
			return map_array if map_array[event.y][event.x] != -1
			Fiber.yield if long_mode && (i % 20 == 0)
			current_tag += 1
		end
		map_array
	end







 ##########################################################################





	def passable_pathfinding?(x, y, d)
		return false unless get_event_passable(x, y)
		bitflag = (1 << (d / 2 - 1)) & 0x0f
		check_passage(x, y, bitflag)
	end
	def get_event_passable(x, y)
		evs = events_xy(x, y)
		return true if evs.empty?
		return false unless evs[0].through || evs[0].priority_type != 1
		true
	end
	def check_adjacent_panels(x, y)
		[
			y < height - 1 && passable_pathfinding?(x, y, 2) && passable_pathfinding?(x, y + 1, 8), # Down
			x > 0          && passable_pathfinding?(x, y, 4) && passable_pathfinding?(x - 1, y, 6), # Left
			y > 0          && passable_pathfinding?(x, y, 8) && passable_pathfinding?(x, y - 1, 2), # Up
			x < width - 1  && passable_pathfinding?(x, y, 6) && passable_pathfinding?(x + 1, y, 4)  # Right
			]
	end
	def find_path(event, x, y, iterations = 1000, long_mode = false, short_mode = false)
		map_array = Array.new(height) { Array.new(width, -1) }
		map_array[y][x] = 0
		frontier = [[x, y]]

		low_x, low_y = 0, 0
		high_x, high_y = width - 1, height - 1
		if short_mode
			low_x  = [[event.x, x].min - 2, 0].max
			low_y  = [[event.y, y].min - 2, 0].max
			high_x = [[event.x, x].max + 2, width - 1].min
			high_y = [[event.y, y].max + 2, height - 1].min
		end

		iterations.times do |i|
			break if frontier.empty?
			new_frontier = []
			for map_x, map_y in frontier
				check_adjacent_panels(map_x, map_y).each_with_index do |pass, index|
					next unless pass
					dx, dy = [[0,1],[-1,0],[0,-1],[1,0]][index]
					nx, ny = map_x + dx, map_y + dy
					next unless nx.between?(low_x, high_x) && ny.between?(low_y, high_y)
					if map_array[ny][nx] == -1
						map_array[ny][nx] = map_array[map_y][map_x] + 1
						new_frontier << [nx, ny]
					end
				end
			end
			return map_array if map_array[event.y][event.x] != -1
			frontier = new_frontier
			Fiber.yield if long_mode && (i % 20 == 0)
		end

		map_array
	end















=begin
	def find_path(event, x, y, iterations = 1000, long_mode = false, short_mode = false)
		map_array = Array.new(height) { Array.new(width, -1) }
		map_array[y][x] = 0
		current_tag = 0
		low_x, low_y = 0, 0
		high_x, high_y = width - 1, height - 1

		if short_mode
			low_x  = [event.x, x].min - 2
			low_y  = [event.y, y].min - 2
			high_x = [event.x, x].max + 2
			high_y = [event.y, y].max + 2
			# Clamp bounds
			low_x = [low_x, 0].max
			low_y = [low_y, 0].max
			high_x = [high_x, width - 1].min
			high_y = [high_y, height - 1].min
		end

		rows = (low_y..high_y).to_a
		thread_count = 1  # Adjust number of threads to your environment
		rows_per_thread = (rows.size / thread_count.to_f).ceil

		iterations.times do |i|
			# Collect updates from all threads
			updates = []

			threads = (0...thread_count).map do |t|
				Thread.new do
					local_updates = []
					thread_rows = rows[(t * rows_per_thread)...((t + 1) * rows_per_thread)] || []

					thread_rows.each do |map_y|
						(low_x..high_x).each do |map_x|
							next unless map_array[map_y][map_x] == current_tag
							check_adjacent_panels(map_x, map_y).each_with_index do |pass, index|
								next unless pass
								dx, dy = [[0,1],[-1,0],[0,-1],[1,0]][index]
								nx, ny = map_x + dx, map_y + dy
								# Only add update if within bounds and currently -1
								if nx.between?(0, width - 1) && ny.between?(0, height - 1) && map_array[ny][nx] == -1
									local_updates << [nx, ny]
								end
							end
						end
					end
					local_updates
				end
			end

			# Gather all updates from threads
			threads.each do |thr|
				updates.concat(thr.value)
			end

			# Apply updates to map_array
			updates.each do |nx, ny|
				map_array[ny][nx] = current_tag + 1
			end

			return map_array if map_array[event.y][event.x] != -1

			Fiber.yield if long_mode && (i % 20 == 0)
			current_tag += 1
		end

		map_array
	end
=end

end




class Game_Interpreter
	def walk_to(x, y, id = 0, passthrough = true)
		get_character(id).walk_to(x, y, 1000, false, false, passthrough)
	end

	def walk_to_short(x, y, id = 0, passthrough = true)
		get_character(id).walk_to(x, y, 100, false, false, passthrough)
	end

	def walk_to_long(x, y, iterations, id = 0, passthrough = true)
		get_character(id).walk_to(x, y, iterations, true, false, passthrough)
	end

	def walk_to_straight(x, y, id = 0, passthrough = true)
		get_character(id).walk_to(x, y, 1000, false, true, passthrough)
	end

	def pathfinding?(id = 0)
		get_character(id).pathfinding?
	end
end





