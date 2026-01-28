module GIM_CHCG
	def mini_game_ddr(timer_max = 300 - $story_stats["Setup_Hardcore"]*60 , how_many_grid = [4+rand(7),4+$story_stats["Setup_Hardcore"]].max)
		# === CONFIGURATION ===
		#timer_max = 300 - $story_stats["Setup_Hardcore"]*60
		#how_many_grid = [4+rand(7),4].max
		grid_size = 32
		arrow_bitmap = Cache.system("32px_arrow")
		input_key_map = {
			:UP => :up,
			:DOWN => :down,
			:LEFT => :left,
			:RIGHT => :right
		}

		tmpGW = Graphics.width
		tmpGH = Graphics.height
		rect_width = how_many_grid * grid_size
		rect_height = 32
		rect_x = (tmpGW - rect_width) / 2
		rect_y = tmpGH / 4
		start_x = rect_x + 1
		end_x = rect_x + rect_width - 2

		tmpSpriteBG = Sprite.new
		tmpSpriteBG.bitmap = Bitmap.new(tmpGW, tmpGH)
		tmpSpriteBG.bitmap.fill_rect(tmpSpriteBG.bitmap.rect, Color.new(25, 25, 25))
		tmpSpriteBG.opacity = 45
		tmpSpriteBG.z = 100

		tmpSprite_SUC_Area = Sprite.new
		tmpSprite_SUC_Area.bitmap = Bitmap.new(tmpGW, tmpGH)
		tmpSprite_SUC_Area_OUT_Rect = [rect_x, rect_y, rect_width, rect_height]
		tmpSprite_SUC_Area.bitmap.fill_rect(Rect.new(*tmpSprite_SUC_Area_OUT_Rect), Color.new(255, 255, 125))
		tmpSprite_SUC_Area.z = 102
		tmpSprite_SUC_Area.opacity = 0

		tmpSprite_SUC_Area_IN = Sprite.new
		tmpSprite_SUC_Area_IN.bitmap = Bitmap.new(tmpGW, tmpGH)
		tmpSprite_SUC_Area_IN_Rect = [rect_x + 1, rect_y + 1, rect_width - 2, rect_height - 2]
		tmpSprite_SUC_Area_IN.bitmap.fill_rect(Rect.new(*tmpSprite_SUC_Area_OUT_Rect), Color.new(255, 255, 255, 80))
		tmpSprite_SUC_Area.bitmap.clear_rect(*tmpSprite_SUC_Area_IN_Rect)
		tmpSprite_SUC_Area_IN.z = 101
		tmpSprite_SUC_Area_IN.opacity = 0

		tmpSprite_TimerLine = Sprite.new
		tmpSprite_TimerLine.bitmap = Bitmap.new(1, 36)
		tmpSprite_TimerLine.bitmap.fill_rect(tmpSprite_TimerLine.bitmap.rect, Color.new(255, 255, 255))
		tmpSprite_TimerLine.x = start_x
		tmpSprite_TimerLine.y = rect_y - 2
		tmpSprite_TimerLine.z = 103

		directions = [:up, :down, :left, :right]
		@arrow_sprites = []

		how_many_grid.times do |i|
			dir = directions.sample
			frame_index = directions.index(dir)

			sprite = Sprite.new
			sprite.bitmap = Bitmap.new(32, 32)
			sprite.bitmap.blt(0, 0, arrow_bitmap, Rect.new(frame_index * 32, 0, 32, 32))
			sprite.x = rect_x + i * grid_size
			sprite.y = rect_y
			sprite.z = 104

			sprite.instance_variable_set(:@dir_symbol, dir)
			sprite.instance_variable_set(:@result, :pending)

			@arrow_sprites << sprite
		end

		current_time = 0
		input_index = 0
		perfect_finish = false
		success_sound_pitch = 90

		@arrow_sprites.each { |s|
			s.tone.set(255, 255, 255)
		}
		while current_time <= timer_max
			tmpSprite_TimerLine.x = start_x + ((end_x - start_x) * current_time / timer_max)

			if input_index < @arrow_sprites.size
				expected_dir = @arrow_sprites[input_index].instance_variable_get(:@dir_symbol)

				input_key_map.each do |key_sym, dir_sym|
					if Input.trigger?(key_sym) || Input.TriggerMouseDir4?(key_sym)
						target_arrow = @arrow_sprites[input_index]
						target_arrow.blend_type = 1
						if dir_sym == expected_dir
							target_arrow.instance_variable_set(:@result, :success)
							#10.times do
								target_arrow.tone.set(0, 255, 0)
								target_arrow.opacity = 255
								SndLib.sys_Gain(80,success_sound_pitch)
								success_sound_pitch += 5
							#end
						else
							target_arrow.instance_variable_set(:@result, :fail)
							#3.times do
								target_arrow.tone.set(255, 0, 0)
								target_arrow.opacity = 255
								SndLib.sys_buzzer
								#target_arrow.tone.set(0, 0, 0)
							#end
						end

						input_index += 1
						# Early finish if all correct
						all_inputed = !@arrow_sprites.any?{|a| a.instance_variable_get(:@result) == :pending }
						current_time = timer_max if all_inputed
						if @arrow_sprites.all? { |a|a.instance_variable_get(:@result) == :success }
							perfect_finish = true
							break
						end

						break
					end
				end
			end

			break if perfect_finish

			current_time += 1
			wait(1)
		end
		success_sound_pitch = 100

			while input_index < @arrow_sprites.size
				arrow = @arrow_sprites[input_index]
				if arrow.instance_variable_get(:@result) == :pending
					arrow.instance_variable_set(:@result, :fail)
					#if arrow.instance_variable_get(:@result) == :success }
					#else
					#	3.times do
					#		arrow.tone.set(255, 0, 0)
					#		wait(2)
					#		arrow.tone.set(0, 0, 0)
					#		wait(2)
					#	end
					#end
				end
				input_index += 1
			end
			@arrow_sprites.each {|arrow|
				SndLib.sound_step(100,success_sound_pitch)
				success_sound_pitch -= 5
				3.times do
					arrow.opacity = 25
					wait(1)
					arrow.opacity = 255
					wait(1)
				end
			}
			fail_count = @arrow_sprites.count { |a| a.instance_variable_get(:@result) == :fail }
			if perfect_finish
				report_result = 2 #"SuccessFull"
				SndLib.sys_CoinsFalling(100)
				SndLib.buff_life(80,130)
			elsif fail_count >= 2
				SndLib.glassBreak
				report_result = 0 #"Failed"
			else
				SndLib.sys_CoinsFalling(100)
				SndLib.buff_life(80,130)
				report_result = 1 #"Success"
			end
		sprites = [tmpSprite_SUC_Area, tmpSprite_SUC_Area_IN, tmpSpriteBG, tmpSprite_TimerLine]
		sprites.each(&:dispose)
		@arrow_sprites.each { |s| s.bitmap.dispose; s.dispose }
		@arrow_sprites.clear
		return report_result
	end
end
