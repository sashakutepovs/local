=begin

Define animations here.

The spritesheet is divided into 12 columns and 8 rows, for 96 cells.
Cells are specified by their x (0-11) and y (0-7) offsets from the top left.
A cell is shown for a specified number of frames. 0 for infinite frames.
Loops is the number of extra times to repeat the animation. -1 for inifinite.
TODO rename or rework loops.
Animation functions should return the following structure:
[[[cell_x, cell_y, frames], ...], loops]

TODO support sounds and perhaps sub-animations.
frames
1 = play 1 times
2= play 2 times
0= 1 times
-1 = loops
[[[9, 6, 0]], 0] x,y,frame,  if frame =0 then forever
? [Cell_x,Cell_y,frame_time,x,y]

修正點
direction_offset須改為隊目標有效
$game_player 須改為地圖之目標  對其他NPC也有效
=end

class Game_CharacterBase

	attr_reader :real_x
	attr_reader :real_Y

	############################################################ Event only #################################################################
	def animation_event_sex(tar,pose)  #基本SEX動畫6sec
		y = pose
		x_offset = (tar.x - self.x) * 32
		y_offset = (tar.y - self.y) * 32
		y_offset += 2
		frames = [
			[0, y, 10, x_offset, y_offset],
			[1, y, 10, x_offset, y_offset],
			[2, y, 10, x_offset, y_offset]
		]
		[frames, -1]
	end

	#CHSH
	def animation_event_sex_fast(tar,pose)  #基本SEX動畫 加速 3sec
		y = pose
		x_offset = (tar.x - self.x) * 32
		y_offset = (tar.y - self.y) * 32
		y_offset += 2
		frames = [
			[0, y, 5, x_offset, y_offset],
			[1, y, 5, x_offset, y_offset],
			[2, y, 5, x_offset, y_offset]
		]
		[frames, -1]
	end

	#CHSH
	def animation_event_sex_cumming(tar,pose) #進入三穴事件前 3sec
		y = pose
		x_offset = (tar.x - self.x) * 32
		y_offset = (tar.y - self.y) * 32
		y_offset += 2
		frames = [
			[0, y, 2, x_offset, y_offset],
			[1, y, 2, x_offset, y_offset],
			[2, y, 41, x_offset, y_offset]
		]
		[frames, -1]
	end
	def animation_event_sex_cumming_eject(tar,pose) #進入三穴事件前 3sec
		y = pose
		x_offset = (tar.x - self.x) * 32
		y_offset = (tar.y - self.y) * 32
		y_offset += 2
		frames = [
			[0, y, 10, x_offset, y_offset],
			[1, y, 4, x_offset, y_offset],
			[2, y, 2, x_offset+1, y_offset],
			[2, y, 2, x_offset-1, y_offset],
			[2, y, 2, x_offset+1, y_offset],
			[2, y, 2, x_offset-1, y_offset],
			[2, y, 2, x_offset+1, y_offset],
			[2, y, 2, x_offset-1, y_offset],
			[2, y, 2, x_offset+1, y_offset],
			[2, y, 2, x_offset-1, y_offset],
			[2, y, 2, x_offset+1, y_offset],
			[2, y, 2, x_offset-1, y_offset],
			[2, y, 2, x_offset+1, y_offset],
			[2, y, 2, x_offset-1, y_offset],
			[2, y, 2, x_offset+1, y_offset],
			[2, y, 2, x_offset-1, y_offset],
			[2, y, 2, x_offset+1, y_offset],
			[2, y, 2, x_offset-1, y_offset],
			[2, y, 2, x_offset+1, y_offset],
			[2, y, 2, x_offset-1, y_offset],
			[2, y, 2, x_offset+1, y_offset],
			[2, y, 2, x_offset-1, y_offset],
			[2, y, 2, x_offset+1, y_offset],
			[2, y, 2, x_offset-1, y_offset]
		]
		[frames, -1]
	end

	#雙向需求 則傳送至目標 面對上方目標  看起來再幫吹
	def animation_handjob_giver(tar)
		if tar.nil?
			tar_x = self.x
			tar_y = self.y
		else
			tar_x = tar.x
			tar_y = tar.y
		end
		x_offset = (tar_x - self.x) * 32 +1
		y_offset = (tar_y - self.y) * 32 +7
		frames = [
			[10  , 3  ,8 ,x_offset, y_offset],
			[10  , 3  ,4 ,x_offset, y_offset+1],
			[10  , 3  ,12 ,x_offset+1, y_offset+1],
			[10+1, 3  ,4 ,x_offset, y_offset+1]
		]
		[frames, -1]
	end

	def animation_handjob_target#non target ver
		self.direction = 2
		x = 3
		y = 0 + direction_offset
		frames = [
			[x  , y, 8],
			[x+1, y, 4],
			[x+2, y, 12],
			[x+1, y, 4]
		]
		[frames, -1]
	end

	def animation_handjob_giver_fast(tar)
		if tar.nil?
			tar_x = self.x
			tar_y = self.y
		else
			tar_x = tar.x
			tar_y = tar.y
		end
		x_offset = (tar_x - self.x) * 32 +1
		y_offset = (tar_y - self.y) * 32 +7
		frames = [
			[10  , 3  ,4 ,x_offset, y_offset],
			[10  , 3  ,2 ,x_offset, y_offset+1],
			[10  , 3  ,6 ,x_offset+1, y_offset+1],
			[10+1, 3  ,2 ,x_offset, y_offset+1]
		]
		[frames, -1]
	end

	def animation_handjob_target_fast #non target ver
		self.direction = 2
		x = 3
		y = 0 + direction_offset
		frames = [
			[x  , y, 4],
			[x+1, y, 2],
			[x+2, y, 6],
			[x+1, y, 2]
		]
		[frames, -1]
	end

	def animation_handjob_giver_fast_cumming(tar)
		if tar.nil?
			tar_x = self.x
			tar_y = self.y
		else
			tar_x = tar.x
			tar_y = tar.y
		end
		x_offset = (tar_x - self.x) * 32 +1
		y_offset = (tar_y - self.y) * 32 +7
		frames = [
			[10  , 3  ,2 ,x_offset, y_offset],
			[10  , 3  ,1 ,x_offset, y_offset+1],
			[10  , 3  ,32 ,x_offset+1, y_offset+1],
			[10+1, 3  ,1 ,x_offset, y_offset+1]
		]
		[frames, -1]
	end

	def animation_handjob_target_fast_cumming #non target ver
		self.direction = 2
		x = 3
		y = 0 + direction_offset
		frames = [
			[x  , y, 2],
			[x+1, y, 1],
			[x+2, y, 32],
			[x+1, y, 1]
		]
		[frames, -1]
	end

	def animation_handjob_giver_fast_cumming_eject(tar)
		if tar.nil?
			tar_x = self.x
			tar_y = self.y
		else
			tar_x = tar.x
			tar_y = tar.y
		end
		x_offset = (tar_x - self.x) * 32 +1
		y_offset = (tar_y - self.y) * 32 +7
		frames = [
			[10  , 3  ,10 ,x_offset, y_offset],
			[10  , 3  ,4 ,x_offset, y_offset+1],
			[10  , 3  ,2 ,x_offset+1, y_offset+1],
			[10  , 3  ,2 ,x_offset-1, y_offset+1],
			[10  , 3  ,2 ,x_offset+1, y_offset+1],
			[10  , 3  ,2 ,x_offset-1, y_offset+1],
			[10  , 3  ,2 ,x_offset+1, y_offset+1],
			[10  , 3  ,2 ,x_offset-1, y_offset+1],
			[10  , 3  ,2 ,x_offset+1, y_offset+1],
			[10  , 3  ,2 ,x_offset-1, y_offset+1],
			[10  , 3  ,2 ,x_offset+1, y_offset+1],
			[10  , 3  ,2 ,x_offset-1, y_offset+1],
			[10  , 3  ,2 ,x_offset+1, y_offset+1],
			[10  , 3  ,2 ,x_offset-1, y_offset+1],
			[10  , 3  ,2 ,x_offset+1, y_offset+1],
			[10  , 3  ,2 ,x_offset-1, y_offset+1],
			[10  , 3  ,2 ,x_offset+1, y_offset+1],
			[10  , 3  ,2 ,x_offset-1, y_offset+1],
			[10+1, 3  ,4 ,x_offset, y_offset+1]
		]
		[frames, -1]
	end

	def animation_handjob_target_fast_cumming_eject #non target ver
		self.direction = 2
		x = 3
		y = 0 + direction_offset
		x_offset = 0
		frames = [
			[x  , y, 10],
			[x+1, y, 4],
			[x+2, y, 2,x_offset+1],
			[x+2, y, 2,x_offset-1],
			[x+2, y, 2,x_offset+1],
			[x+2, y, 2,x_offset-1],
			[x+2, y, 2,x_offset+1],
			[x+2, y, 2,x_offset-1],
			[x+2, y, 2,x_offset+1],
			[x+2, y, 2,x_offset-1],
			[x+2, y, 2,x_offset+1],
			[x+2, y, 2,x_offset-1],
			[x+2, y, 2,x_offset+1],
			[x+2, y, 2,x_offset-1],
			[x+2, y, 2,x_offset+1],
			[x+2, y, 2,x_offset-1],
			[x+2, y, 2,x_offset+1],
			[x+2, y, 2,x_offset-1],
			[x+1, y, 4]
		]
		[frames, -1]
	end


	############################################################ BATTLE SEX ONLY ############################################################

	#雙向需求 傳送至目標身上  被抓取者撥放GRABBED QTE
	def animation_grabber_qte(target_id) #抓取者使用
		#turn_toward_character(target_id)
		temp_x=7
		temp_y=4 +direction_offset
		case direction
		when 8; x_tar=0 ; y_tar=-20
		when 2; x_tar=0 ; y_tar=20
		when 4; x_tar=-20 ; y_tar=0
		when 6; x_tar=20 ; y_tar=0
		end
		#x_offset = (get_character(target_id).x - self.x) * 32 + 7
		#y_offset = (get_character(target_id).y - self.y) * 32 - 9
		x_offset = x_tar
		y_offset = y_tar
		frames = [
			[temp_x, temp_y, 5, x_offset - 1, y_offset],
			[temp_x, temp_y, 5, x_offset, y_offset]
		]
		[frames, -1]
	end



	def animation_grabbed_qte#被抓取者使用
		#frames = (0..20).collect { |i| [6, 6, 3 + i / 2, i % 2] }
		frames =[
			[6, 6, 3, -1,0],
			[6, 6, 3, 0, 0]
		]
		[frames, -1]
	end
	def animation_grabbed_qte20 #被抓取者使用
		#frames = (0..20).collect { |i| [6, 6, 3 + i / 2, i % 2] }
		frames =[
			[6, 6, 3, -1,0],
			[6, 6, 3, 0, 0]
		]
		[frames, -1]
	end

	def animation_cuming_qte#
		frames =[
			[3, 0+direction_offset, 3, -1,0],
			[3, 0+direction_offset, 3, 0, 0]
		]
		[frames, -1]
	end
	def animation_pindown_qte#
		frames =[
			[9, 0+direction_offset, 3, -1,0],
			[9, 0+direction_offset, 3, 0, 0]
		]
		[frames, -1]
	end

	def animation_endSex #use when player unset chs group
		cell_controlX1 = 10
		cell_controlY1 = 0 + direction_offset
		cell_controlX2 = 6
		cell_controlY2 = 4 + direction_offset
		frames1 = (0..2).collect { |i|
		                           [cell_controlX1, cell_controlY1, 3 + i / 2, i % 2]
		                         }
		frames2 = (0..2).collect { |i|
		                           [cell_controlX2, cell_controlY2, 3 + i / 2, i % 2]
		                         }
		result = [frames1+frames2, 0]
		result
	end

	def animation_endSex_long #use when player unset chs group
		cell_controlX1 = 10
		cell_controlY1 = 0 + direction_offset
		cell_controlX2 = 6
		cell_controlY2 = 4 + direction_offset
		frames1 = (0..2).collect { |i|
		                           [cell_controlX1, cell_controlY1, 6 + i / 2, i % 2]
		                         }
		frames2 = (0..2).collect { |i|
		                           [cell_controlX2, cell_controlY2, 6 + i / 2, i % 2]
		                         }
		result = [frames1+frames2, 0]
		result
	end
	#  def animation_grabbed #unused
	#    frames = [[6, 6, 5]]
	#    [frames, -1]
	#  end

	#def animation_grabber(target_id) #unused
	#temp_x=7
	#temp_y=4 +direction_offset
	#  x_offset = (get_character(target_id).x - self.x) * 32 + 7
	#  y_offset = (get_character(target_id).y - self.y) * 32 - 9
	#  frames = [[temp_x, temp_y, 60, x_offset, y_offset]]
	#  [frames, -1]
	#end


	#CHSH
	#基本SEX動畫6sec
	def animation_sex
		y = self.chs_config["sex_pos"]
		x_offset = sex_receiver? ? 0 : (actor.fucker_target.x - self.x) * 32
		y_offset = sex_receiver? ? 0 : (actor.fucker_target.y - self.y) * 32
		y_offset += 2
		frames = [
			[0, y, 10, x_offset, y_offset],
			[1, y, 10, x_offset, y_offset],
			[2, y, 10, x_offset, y_offset]
		]
		[frames, -1]
	end

	#CHSH
	#基本SEX動畫 加速 3sec
	def animation_sex_fast
		p "animation_sex_fast "
		y = chs_config["sex_pos"]
		x_offset = sex_receiver? ? 0 : (actor.fucker_target.x - self.x) * 32
		y_offset = sex_receiver? ? 0 : (actor.fucker_target.y - self.y) * 32
		y_offset += 2
		frames = [
			[0, y, 5, x_offset, y_offset],
			[1, y, 5, x_offset, y_offset],
			[2, y, 5, x_offset, y_offset]
		]
		[frames, -1]
	end

	#CHSH
	#進入三穴事件前 3sec
	def animation_sex_cumming
		p "animation_sex_cumming "
		y = chs_config["sex_pos"]
		x_offset = sex_receiver? ? 0 : (actor.fucker_target.x - self.x) * 32
		y_offset = sex_receiver? ? 0 : (actor.fucker_target.y - self.y) * 32
		y_offset += 2
		frames = [
			[0, y, 2,  x_offset, y_offset],
			[1, y, 2,  x_offset, y_offset],
			[2, y, 41, x_offset, y_offset]
		]
		[frames, -1]
	end



end

