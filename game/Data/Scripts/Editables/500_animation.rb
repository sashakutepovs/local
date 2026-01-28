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
	def animation_nil
		
	end
#######################3 ANIMATION Editables############################3
  def animation_atk_mh #all
    x = 6
    y = 4 + direction_offset
    frames = [
      [x  , y, 4],
      [x+1, y, 2],
      [x+2, y, 15],
      [x+1, y, 2]
    ]
    [frames, 0]
  end
  def animation_atk_mh_reverse #all
    x = 6
    y = 4 + direction_offset
    frames = [ 
      [x+1  , y, 4],
      [x+2, y, 2],
      [x+1, y, 15],
      [x , y, 2]
    ]
    [frames, 0]
  end
  
  def animation_atk_mh_long #all
    x = 6
    y = 4 + direction_offset
    frames = [ 
      [x  , y, 4],
      [x+1, y, 2],
      [x+2, y, 20],
      [x+1, y, 12],
      [x, y, 2]
    ]
    [frames, 0]
  end

  def animation_atk_sh_long #all
    x = 6
    y = 4 + direction_offset
    frames = [ 
      [0, 0+ direction_offset, 4],
      [x+1, y, 2],
      [x,   y, 20],
      [x+1, y, 12]
    ]
    [frames, 0]
  end
  def animation_atk_sh #all
    x = 6
    y = 4 + direction_offset
    frames = [
      [0, 0+ direction_offset, 4],
      [x+1, y, 2],
      [x,   y, 15],
      [x+1, y, 2]
    ]
    [frames, 0]
  end
	def animation_atk_shP #all
		x = 6
		y = 4 + direction_offset
		frames = [ 
		[2  , y, 4],
		[1  , y, 2],
		[x+1, y, 2],
		[x,   y, 15],
		[x+1, y, 2]
		]
		[frames, 0]
	end


  
  def animation_atk_backstab #all
		case direction
			when 2 ;    x_offset0 = 0
						y_offset0 = 4
						x_offset1 = 0
						y_offset1 = 8
						x_offset2 = 0
						y_offset2 = 16
			when 4 ;    x_offset0 = -4
						y_offset0 = 0
						x_offset1 = -8
						y_offset1 = 0
						x_offset2 = -16
						y_offset2 = 0
			when 6 ;    x_offset0 = 4
						y_offset0 = 0
						x_offset1 = 8
						y_offset1 = 0
						x_offset2 = 16
						y_offset2 = 0
			when 8 ;    x_offset0 = 0
						y_offset0 = -4
						x_offset1 = 0
						y_offset1 = -8
						x_offset2 = 0
						y_offset2 = -16
		end
		x = 6
		y = 4 + direction_offset
		frames = [ 
		[0, 0+ direction_offset, 4],
		[x+1, y, 2,x_offset0,y_offset0],
		[x,   y, 13,x_offset1,y_offset1],
		[x+1, y, 2,x_offset2,y_offset2]
		]
		[frames, 0]
	end

	def animation_atk_berserk
		case direction
			when 2 ;    x_offset0 = 0
						y_offset0 = 8
						x_offset1 = 0
						y_offset1 = 4
						x_offset2 = 0
						y_offset2 = 2
			when 4 ;    x_offset0 = -8
						y_offset0 = 0
						x_offset1 = -4
						y_offset1 = 0
						x_offset2 = -2
						y_offset2 = 0
			when 6 ;    x_offset0 = 8
						y_offset0 = 0
						x_offset1 = 4
						y_offset1 = 0
						x_offset2 = 2
						y_offset2 = 0
			when 8 ;    x_offset0 = 0
						y_offset0 = -8
						x_offset1 = 0
						y_offset1 = -4
						x_offset2 = 0
						y_offset2 = -2
		end
		tmpRoll = [true,false].sample
		if tmpRoll
			x = 6
			y = 4 + direction_offset
			frames = [ 
				[0  , y, 2, x_offset2, y_offset2],
				[1  , y, 1, x_offset1, y_offset1],
				[x+2, y, 7, x_offset0, y_offset0],
				[x+1, y, 1, x_offset1, y_offset1]
			]
			[frames, 0]
		else
			x = 6
			y = 4 + direction_offset
			frames = [ 
				[2  , y, 1, x_offset2, y_offset2],
				[1  , y, 1, x_offset1, y_offset1],
				[x+1, y, 3, x_offset0, y_offset0],
				[x,   y, 4, x_offset0, y_offset0],
				[x+1, y, 1, x_offset1, y_offset1]
			]
			[frames, 0]
		end
	end
	
  def animation_atk_whip #all
    x = 6
    y = 4 + direction_offset
	if [true,false].sample
		xA1 = x+1
		xA2 = x+2
	else
		xA1 = x+2
		xA2 = x+1
	end
		case direction
			when 2 ;    x_offset0 = 0
						y_offset0 = 8
						x_offset1 = 0
						y_offset1 = 4
						x_offset2 = 0
						y_offset2 = 2
			when 4 ;    x_offset0 = -8
						y_offset0 = 0
						x_offset1 = -4
						y_offset1 = 0
						x_offset2 = -2
						y_offset2 = 0
			when 6 ;    x_offset0 = 8
						y_offset0 = 0
						x_offset1 = 4
						y_offset1 = 0
						x_offset2 = 2
						y_offset2 = 0
			when 8 ;    x_offset0 = 0
						y_offset0 = -8
						x_offset1 = 0
						y_offset1 = -4
						x_offset2 = 0
						y_offset2 = -2
		end
	
	frames = [ 
      [x  , y, 4	, x_offset2, y_offset2],
      [x, y, 2		, x_offset1, y_offset1],
      [xA1, y, 8	, x_offset0, y_offset0],
      [x, y, 4		, x_offset0, y_offset0],
      [xA2  , y, 5	, x_offset1, y_offset1],
      [x  , y, 5	, x_offset2, y_offset2],
      [0  , 0+direction_offset, 12]
    ]
    [frames, 0]
  end

  def animation_atk_sh_ThrowHook #all
    x = 6
    y = 4 + direction_offset
    frames = [ 
      [0, 0+ direction_offset, 4],
      [x+1, y, 2],
      [x,   y, 6],
      [x+1, y, 2]
    ]
    [frames, 0]
  end
  
  def animation_atk_shoot #for bow or crossbow
    x = 6
    y = 4 + direction_offset
    frames = [ 
      [0, 0+ direction_offset, 4],
      [x+1, y, 4],
      [x,   y, 16],
      [x+1, y, 2]
    ]
    [frames, 0]
  end


	def animation_atk_shoot_long #for bow or crossbow
		x = 6
		y = 4 + direction_offset
		frames = [ 
		  [0, 0+ direction_offset, 4],
		  [x+1, y, 4],
		  [x,   y, 30],
		  [x+1, y, 2]
		]
		[frames, 0]
	end

	def animation_atk_AbomFapShoot_long #for bow or crossbow
		x = 4
		y = 0 + direction_offset
		frames = [ 
		  [0, 0+ direction_offset, 4],
		  [x+1, y, 4],
		  [x,   y, 30],
		  [x+1, y, 2]
		]
		[frames, 0]
	end

	def animation_atk_ArrowBarraage #for bow or crossbow
		x = 6
		y = 4 + direction_offset
		frames = [ 
		  [0, 0+ direction_offset, 1],
		  [x+1, y, 1],
		  [x,   y, 4],
		  [x+1, y, 1],
		  [x+1, y, 1],
		  [x,   y, 4],
		  [x+1, y, 1],
		  [x+1, y, 1],
		  [x,   y, 4],
		  [x+1, y, 1]
		]
		[frames, 0]
	end

	def animation_atk_shoot_hold #for bow or crossbow
		x = 6
		y = 4 + direction_offset
		frames = (0..20).collect { |i| [x, y, 1 + i / 2,0, i % 2] }
		[frames, -1]
	end
	def animation_atk_pray_hold #for bow or crossbow
		x = 1
		y = 4 + direction_offset
		frames = (0..20).collect { |i| [x, y, 1 + i / 2,0, i % 2] }
		[frames, -1]
	end

	def animation_atk_hook_hold #for bow or crossbow
		x = 2
		y = 4 + direction_offset
		frames = (0..20).collect { |i| [x, y, 1 + i / 2,0, i % 2] }
		[frames, -1]
	end

	def animation_atk_DualCombo #better use different equip for each hand
		x = 6
		y = 4 + direction_offset
		frames = [ 
			[x  , y, 4],
			[x+1, y, 2],
			[x+2, y, 6],
			[x+1, y, 3],
			[x  , y, 6],
			[0, 0+direction_offset, 3],
			[x+1, y, 6]
		]
		[frames, 0]
	end

	def animation_atk_TailSpin #MC tail atk
		f1=2
		f2=4
		f3=4
		f4=8
		f5=10
		xT= self == $game_player ? 5 : 2
		case self.direction
			when 2
				frames=[ #2
					[2	,4,f1	,0	,3*2],
					[1	,4,f2	,0	,6*2],
					[1	,6,f3	,0	,6*2],
					[xT	,7,f4	,0	,6*2],
					[1	,5,f5	,0	,3*2],
				]
			when 6
				frames=[ #6
					[2	,6,f1	,3*2,0],
					[2	,6,f2	,6*2,0],
					[xT	,7,f3	,6*2,0],
					[1	,5,f4	,6*2,0],
					[1	,4,f5	,3*2,0],
				]
			when 4
				frames=[ #4
					[2	,5,f1	,-3*2,0],
					[2	,5,f2	,-6*2,0],
					[1	,4,f3	,-6*2,0],
					[1	,6,f4	,-6*2,0],
					[xT	,7,f5	,-3*2,0],
				]
			when 8
				frames=[ #8
					[xT	,7,f1	,0	,-3*2],
					[xT	,7,f2	,0	,-6*2],
					[1	,6,f3	,0	,-6*2],
					[1	,4,f4	,0	,-6*2],
					[1	,5,f5	,0	,-3*2],
				]
			end
		[frames, 0]
	end
	def animation_atk_2hSpins #use on 2h melee equip like Spear or 2hSword
		x = 8
		y = 4
		frames = [ 
			[x-1	,y+direction_offset		,15	,0,-2],
			[x-2	,y		,2	,0,-16],
			[x-1	,y		,2	,0,-32],
			[x		,y+2	,2	,0,-25],
			[x		,y+3	,2	,0,-20],
			[x		,y+1	,2	,0,-15],
			[x		,y		,2	,0,-7],
			[x		,y+2	,2	,0,-3],
			[x		,y+3	,2	,0,-1],
			[x		,y+1	,2	,0,0],
			[x-1	,y+direction_offset	,10	,0,0]
			]
		[frames, 0]
	end
	

	def animation_atk_KatanaSwingSH #KatanaSwingSH MC ver
		if self == $game_player
			x0 = 6
			x1 = 8
			x2 = 7
		else
			x0 = 6
			x1 = 7
			x2 = 8
		end
		y = 4
		frames = [ 
			[x2		,y+direction_offset		,3	,0,0],
			[x1		,y+direction_offset		,9	,0,0],
			[x0		,y+direction_offset		,9	,0,0]
			]
		[frames, 0]
	end

	def animation_atk_KatanaSwing #KatanaSwing MC ver
		if self == $game_player
			x0 = 6
			x1 = 8
			x2 = 7
		else
			x0 = 6
			x1 = 7
			x2 = 8
		end
		y = 4
		frames = [ 
			[x0		,y+direction_offset		,2	,0,0],
			[x1		,y+direction_offset		,2	,0,0],
			[x2		,y+direction_offset		,3	,0,0],
			[x1		,y+direction_offset		,9	,0,0],
			[x0		,y+direction_offset		,9	,0,0]
			]
		[frames, 0]
	end
	def animation_atk_SingleSpin #KatanaSpin MC ver
		if self == $game_player
			x0 = 6
			x1 = 8
			x2 = 7
		else
			x0 = 6
			x1 = 7
			x2 = 8
		end
		y = 4
		frames = [ 
			[x0		,y+direction_offset		,4	,0,-2],
			[x1		,y+direction_offset		,4	,0,-2],
			[x2		,y		,2	,0,-3],
			[x2		,y+1	,2	,0,-1],
			[x2		,y+2	,2	,0,0],
			[x2		,y+3	,6	,0,0],
			[x1		,y+direction_offset	,9	,0,0],
			[x0		,y+direction_offset	,9	,0,0]
			]
		[frames, 0]
	end
	def animation_atk_SpinsQuick #WaterfowlDance BOSS SKILL
		x = 6
		y = 4
		frames = [ 
			[x-1	,y+direction_offset		,1	,0,-2],
			[x-2	,y		,2	,0,-8],
			[x-1	,y		,2	,0,-16],
			[x		,y+2	,2	,0,-17],
			[x		,y+3	,2	,0,-10],
			[x		,y+1	,2	,0,-7],
			[x		,y		,2	,0,-3],
			[x		,y+2	,2	,0,-1],
			[x		,y+3	,2	,0,0],
			[x		,y+1	,2	,0,0],
			[x-1	,y+direction_offset,5	,0,0]
			]
		[frames, 0]
	end
	def animation_atk_OgreSpinsQuick1 #OgreSpin BOSS SKILL
		x = 6
		y = 4
		frames = [ 
			[0			,0+direction_offset		,4	,0,-2],
			[x+1		,y+direction_offset		,8	,0,-8],
			[x+2		,y+direction_offset		,16	,0,-16]
			]
		[frames, 0]
	end
	def animation_atk_OgreSpinsQuick2 #OgreSpin BOSS SKILL
		x = 6
		y = 4
		frames = [ 
			[0			,0+direction_offset		,4	,0,-2],
			[x+2		,y+direction_offset		,8	,0,-8],
			[x+1		,y+direction_offset		,16	,0,-16]
			]
		[frames, 0]
	end
	def animation_efx_SpinsQuick
		frames = [ 
			[11	,0		,1	,8,-24],
			[4	,0		,3	,8,20],
			[3	,5		,2	,8,-24],
			[11	,0		,1	,8,-24]
			]
		[frames, 0]
	end
	def animation_efx_KatanaAOE
		case self.direction
			when 2	;x0 = 0 ;y0 =0 ;xx0= -18	;yy0= 0
					;x1 = 1 ;y1 =2 ;xx1= 18		;yy1= 0
			when 8	;x0 = 1 ;y0 =2 ;xx0= 18		;yy0= -8
					;x1 = 0 ;y1 =1 ;xx1= -12	;yy1= -20
			when 4	;x0 = 0 ;y0 =3 ;xx0= -8	;yy0= -10
					;x1 = 1 ;y1 =3 ;xx1= 8	;yy1= 20
			when 6	;x0 = 2 ;y0 =1 ;xx0= -8	;yy0= -20
					;x1 = 0 ;y1 =1 ;xx1= 8	;yy1= -20
		end
		frames = [ 
			[12	,0		,1	,0,0],
			[x0	,y0		,3	,xx0,yy0],
			[x1	,y1		,2	,xx1,yy1],
			[12	,0		,32	,0,0]
			]
		[frames, 0]
	end
	
	def animation_atk_piercing #for Spear
		case @direction
			when 2 ;	x_offset0 = 0
						y_offset0 = -20
						x_offset1 = 0
						y_offset1 = -18
						x_offset2 = 0
						y_offset2 = -5
						x_offset3 = 0
						y_offset3 = 2
			when 4 ;	x_offset0 = 20
						y_offset0 = 0
						x_offset1 = 18
						y_offset1 = 0
						x_offset2 = 5
						y_offset2 = 0
						x_offset3 = -2
						y_offset3 = 0
			when 6 ;	x_offset0 = -20
						y_offset0 = 0
						x_offset1 = -18
						y_offset1 = 0
						x_offset2 = -5
						y_offset2 = 0
						x_offset3 = 2
						y_offset3 = 0
			when 8 ;	x_offset0 = 0
						y_offset0 = 20
						x_offset1 = 0
						y_offset1 = 18
						x_offset2 = 0
						y_offset2 = 5
						x_offset3 = 0
						y_offset3 = -2
			else
			x_offset0 = 0
			y_offset0 = 0
			x_offset1 = 0
			y_offset1 = 0
			x_offset2 = 0
			y_offset2 = 0
			x_offset3 = 0
			y_offset3 = 0
		end
		
		x = 6
		y = 4 + direction_offset
		frames = [ 
			[x+1, y, 7,  x_offset0, y_offset0],
			[x+2, y, 4,  x_offset1, y_offset1],
			[x+2, y, 2,  x_offset2, y_offset2],
			[x+2, y, 12,  x_offset3, y_offset3],
			[x+1, y, 2]
			]
		[frames, 0]
	end
	
	def animation_atk_charge #for Animal
		case @direction
			when 2 ;	x_offset0 = 0
						y_offset0 = -20
						x_offset1 = 0
						y_offset1 = -18
						x_offset2 = 0
						y_offset2 = -5
						x_offset3 = 0
						y_offset3 = 2
			when 4 ;	x_offset0 = 20
						y_offset0 = 0
						x_offset1 = 18
						y_offset1 = 0
						x_offset2 = 5
						y_offset2 = 0
						x_offset3 = -2
						y_offset3 = 0
			when 6 ;	x_offset0 = -20
						y_offset0 = 0
						x_offset1 = -18
						y_offset1 = 0
						x_offset2 = -5
						y_offset2 = 0
						x_offset3 = 2
						y_offset3 = 0
			when 8 ;	x_offset0 = 0
						y_offset0 = 20
						x_offset1 = 0
						y_offset1 = 18
						x_offset2 = 0
						y_offset2 = 5
						x_offset3 = 0
						y_offset3 = -2
			else
			x_offset0 = 0
			y_offset0 = 0
			x_offset1 = 0
			y_offset1 = 0
			x_offset2 = 0
			y_offset2 = 0
			x_offset3 = 0
			y_offset3 = 0
		end
		
		x = 6
		y = 4 + direction_offset
		frames = [ 
			#[cell_x_offset, cell_y_offset, 7,  x_offset0, y_offset0],
			#[cell_x_offset, cell_y_offset, 4,  x_offset1, y_offset1],
			#[cell_x_offset, cell_y_offset, 2,  x_offset2, y_offset2],
			#[cell_x_offset, cell_y_offset, 6,  x_offset3, y_offset3],
			#[cell_x_offset, cell_y_offset, 9]
			[0, 4+direction_offset, 7,  x_offset0, y_offset0],
			[7, 4+direction_offset, 4,  x_offset1, y_offset1-4],
			[2, direction_offset, 2,  x_offset2, y_offset2],
			[1, 4+direction_offset, 6,  x_offset3, y_offset3],
			[2, 4+direction_offset, 9]
			]
		[frames, 0]
	end
	
	def animation_hold_casting_mh
		x = 6
		y = 4 + direction_offset
		frames = [ 
		[x  , y, 3,0],
		[x  , y, 3,-1]
		]
		[frames, -1]
	end
	
	def animation_hold_casting_mh_Channel
		x = 7
		y = 4 + direction_offset
		frames = [ 
			[x  , y, 3,0],
			[x  , y, 3,-1]
		]
		[frames, -1]
	end
	
	def animation_hold_casting_sh
	x = 8
	y = 4 + direction_offset
	frames = [ 
		[x  , y, 3,0],
		[x  , y, 3,-1]
	]
	[frames, -1]
	end
	
	def animation_casting_mh
	x = 7
	y = 4 + direction_offset
	x_offset = 0
	y_offset = 0
	case direction
		when 8
		x_offset = 0
		y_offset = -1
		when 2
		x_offset = 0
		y_offset = 1
		when 6
		x_offset = -1
		y_offset = 0
		when 4
		x_offset = 1
		y_offset = 0
		
	end
		frames = [ 
			[x  , y, 8,0,0],
			[x  , y, 24,x_offset,y_offset]
		]
		[frames, 0]
	end
	
	def animation_casting_mh_3
	x = 7
	y = 4 + direction_offset
	x_offset = 0
	y_offset = 0
		frames = [ 
			[x-1  , y, 8,0,0],
			[x  , y, 16,x_offset,y_offset],
			[x-1  , y, 8,0,0],
			[x  , y, 16,x_offset,y_offset],
			[x-1  , y, 8,0,0],
			[x  , y, 16,x_offset,y_offset]
		]
		[frames, 0]
	end
	def animation_casting_musket
		x = 6
		y = 4 + direction_offset
		x_offset = 0
		y_offset = 0
		case direction
			when 8
			x_offset = 0
			y_offset = 1
			when 2
			x_offset = 0
			y_offset = -1
			when 6
			x_offset = -1
			y_offset = 0
			when 4
			x_offset = 1
			y_offset = 0
			
		end
		frames = [ 
		[x+1  , y, 2,x_offset*1,y_offset*1],
		[x+1  , y, 2,x_offset*4,y_offset*4],
		[x  , y, 4,x_offset*10,y_offset*10],
		[x  , y, 1,x_offset*7,y_offset*7],
		[x  , y, 1,x_offset*3,y_offset*3],
		[x  , y, 1,x_offset*1,y_offset*1],
		[x  , y, 3,x_offset*2,y_offset*2],
		[x  , y, 30,x_offset,y_offset]
		]
		[frames, 0]
	end
	
	def animation_casting_mh_long
		x = 7
		y = 4 + direction_offset
		x_offset = 0
		y_offset = 0
		case direction
			when 8
			x_offset = 0
			y_offset = -1
			when 2
			x_offset = 0
			y_offset = 1
			when 6
			x_offset = -1
			y_offset = 0
			when 4
			x_offset = 1
			y_offset = 0
			
		end
			frames = [ 
				[x  , y, 16,0,0],
				[x  , y, 48,x_offset,y_offset],
				[x  , y, 16,x_offset*2,y_offset*2]
			]
			[frames, 0]
	end
	def animation_casting_mh_mid
		x = 7
		y = 4 + direction_offset
		x_offset = 0
		y_offset = 0
		case direction
			when 8
			x_offset = 0
			y_offset = -1
			when 2
			x_offset = 0
			y_offset = 1
			when 6
			x_offset = -1
			y_offset = 0
			when 4
			x_offset = 1
			y_offset = 0
			
		end
			frames = [ 
				[x  , y, 10,0,0],
				[x  , y, 32,x_offset,y_offset],
				[x  , y, 10,x_offset*2,y_offset*2]
			]
			[frames, 0]
	end

	def animation_charge_run
		x = 0
		y = 4 + direction_offset
		frames = [ 
		[x+1 , y, 3],
		[x+2 , y, 3],
		[x+1 , y, 3],
		[x+0 , y, 3],
		[x+1 , y, 3],
		[x+2 , y, 3],
		[x+1 , y, 3],
		[x+0 , y, 3],
		[x+1 , y, 3],
		[x+2 , y, 3],
		[x+1 , y, 3],
		[x+0 , y, 3]
		]
		[frames, 0]
	end

	def animation_charge_run_attacks
		x = 0
		y = 4 + direction_offset
		case self.direction
			when 4 	; tmpX = -1 ; tmpY = 0
					; tmpX1 = 1 ; tmpY1 = 0
			when 2	; tmpX = 0 ; tmpY = 1
					; tmpX1 = 0 ; tmpY1 = -1
			when 6 	;tmpX = 1 ; tmpY = 0
					; tmpX1 = -1 ; tmpY1 = 0
			when 8 	; tmpX = 0 ; tmpY = -1
					tmpX1 = 0 ; tmpY1 = 1
		end
		frames = [ 
		[x+1 , y, 3,tmpX*1 ,tmpY*1 ],
		[x+2 , y, 3,tmpX*3 ,tmpY*3 ],
		[x+1 , y, 3,tmpX*5 ,tmpY*5 ],
		[x+0 , y, 3,tmpX*10 ,tmpY*10 ],
		[x+1 , y, 3,tmpX*15 ,tmpY*15 ],
		[x+2 , y, 3,tmpX*25,tmpY*25],
		[x+1 , y, 3,tmpX*12,tmpY*12],
		[x+0 , y, 3],
		[x+1 , y, 3,tmpX1*10,tmpY1*10],
		[x+2 , y, 3,tmpX1*15,tmpY1*15],
		[x+1 , y, 3,tmpX1*7,tmpY1*7],
		[x+0 , y, 3,tmpX1*3,tmpY1*3]
		]
		[frames, 0]
	end

	def animation_parryStun
		x = 7
		y = 4 + direction_offset
		case self.direction
			when 4 ; tmpX = -1 ; tmpY = 0
			when 2 ; tmpX = 0 ; tmpY = 1
			when 6 ; tmpX = 1 ; tmpY = 0
			when 8 ; tmpX = 0 ; tmpY = -1
		end
		frames = [ 
		[x,y,2,tmpX,tmpY],
		[x,y,2,0,0],
		[x,y,2,tmpX*2,tmpY*2],
		[x,y,2,0,0],
		[x,y,2,tmpX*3,tmpY*3],
		[x,y,2,0,0],
		[x,y,2,tmpX*4,tmpY*4],
		[x,y,2,0,0],
		[x,y,2,tmpX*3,tmpY*3],
		[x,y,2,0,0],
		[x,y,2,tmpX*2,tmpY*2],
		[x,y,2,0,0],
		[x,y,2,tmpX,tmpY]
		]
		[frames, 0]
	end
	def animation_parryStun_long
		x = 7
		y = 4 + direction_offset
		case self.direction
			when 4 ; tmpX = -1 ; tmpY = 0
			when 2 ; tmpX = 0 ; tmpY = 1
			when 6 ; tmpX = 1 ; tmpY = 0
			when 8 ; tmpX = 0 ; tmpY = -1
		end
		frames = [ 
		[x,y,2,tmpX,tmpY],
		[x,y,2,0,0],
		[x,y,2,tmpX*2,tmpY*2],
		[x,y,2,0,0],
		[x,y,2,tmpX*3,tmpY*3],
		[x,y,2,0,0],
		[x,y,2,tmpX*2,tmpY*2],
		[x,y,2,0,0],
		[x,y,2,tmpX*3,tmpY*3],
		[x,y,2,0,0],
		[x,y,2,tmpX*4,tmpY*4],
		[x,y,2,0,0],
		[x,y,2,tmpX*3,tmpY*3],
		[x,y,2,0,0],
		[x,y,2,tmpX*2,tmpY*2],
		[x,y,2,0,0],
		[x,y,2,tmpX*2,tmpY*2],
		[x,y,2,0,0],
		[x,y,2,tmpX,tmpY],
		[x,y,2,0,0],
		[x,y,2,tmpX,tmpY]
		]
		[frames, 0]
	end

	
	def animation_hold_mh
    x = 7
    y = 4 + direction_offset
    frames = [ 
      [x  , y, 3,0],
      [x  , y, 3,-1]
    ]
    [frames, -1]
	end
	

	
	def animation_hold_sh
		x = 8
		y = 4 + direction_offset
		frames = [ 
		[x , y, 3,0],
		[x , y, 3,-1]
		]
		[frames, -1]
	end
	
	def animation_hold_shield
    x = 6
    y = 4 + direction_offset
    frames = [ 
      [6, y, 0]
    ]
    [frames, -1]
	end
	

  def animation_harass_hold
	x_offset=0
	y_offset=0
	case self.direction
		when 8 ; x_offset= 0 	;	y_offset=-20
		when 2 ; x_offset= 0 	;	y_offset= 20
		when 4 ; x_offset=-20	;	y_offset=0
		when 6 ; x_offset= 20	;	y_offset=0
	end
	frames = [
		[0, 4+direction_offset, 4, x_offset - 1, y_offset],
		[2, 4+direction_offset, 4, x_offset, y_offset]
	]
	[frames, -1]
end

def animation_hold_yell
    x = 1
    y = 4 + direction_offset
    frames = [ 
      [x , y, 3,0],
      [x , y, 3,-1]
    ]
    [frames, -1]
end


  def animation_roar_hold
	x_offset=0
	y_offset=0
	frames = [
		[1, 4+direction_offset, 4, 0 - 1,0],
		[1, 4+direction_offset, 4, 0, 0]
	]
	[frames, -1]
end

  def animation_roar_release
	x_offset=0
	y_offset=0
	case self.direction
		when 8 ; x_offset1= 0 	;	y_offset1=10
				x_offset2= 0 	;	y_offset2=20
		when 2 ; x_offset1= 0 	;	y_offset1= -10
				x_offset2= 0 	;	y_offset2=-20
		when 4 ; x_offset1=10	;	y_offset1=0
				x_offset2=20 	;	y_offset2=0
		when 6 ; x_offset1= -10	;	y_offset1=0
				x_offset2= -20 	;	y_offset2=0
	end
	frames = [
		[1, 0+direction_offset, 3, x_offset1, y_offset1],
		[7, 4+direction_offset, 12, x_offset2, y_offset2]
	]
	[frames, 0]
end

	
	def animation_shield_bash
		case direction_offset #2 #4 #6 #8
			when 0 ;	x_offset0 = 0
						y_offset0 = -2
						x_offset1 = 0
						y_offset1 = 16
			when 1 ;	x_offset0 = 2
						y_offset0 = 0
						x_offset1 = -16
						y_offset1 = 0
			when 2 ;	x_offset0 = -2
						y_offset0 = 0
						x_offset1 = 16
						y_offset1 = 0
			when 3 ;	x_offset0 = 0
						y_offset0 = 2
						x_offset1 = 0
						y_offset1 = -16
			else
			x_offset0 = 0
			y_offset0 = 0
			x_offset1 = 0
			y_offset1 = 0
		end
		x = 6
		y = 4 + direction_offset
		frames = [ 
			[x,	 y, 6, x_offset0, y_offset0],
			[x,	 y, 6, x_offset0, y_offset0],
			[x,	 y, 8, x_offset0, y_offset0],
			[x,	 	y, 2],
			[x+1,	 	y, 18, x_offset1, y_offset1],
			[x+1,	 y, 8, x_offset0, y_offset0],
			[x+1,		 y, 2],
			]
		[frames, 0]
	end
	def animation_rifle_bash
		case direction_offset #2 #4 #6 #8
			when 0 ;	x_offset0 = 0
						y_offset0 = -2
						x_offset1 = 0
						y_offset1 = 22
			when 1 ;	x_offset0 = 2
						y_offset0 = 0
						x_offset1 = -22
						y_offset1 = 0
			when 2 ;	x_offset0 = -2
						y_offset0 = 0
						x_offset1 = 22
						y_offset1 = 0
			when 3 ;	x_offset0 = 0
						y_offset0 = 2
						x_offset1 = 0
						y_offset1 = -22
			else
			x_offset0 = 0
			y_offset0 = 0
			x_offset1 = 0
			y_offset1 = 0
		end
		x = 6
		y = 4 + direction_offset
		frames = [ 
			[x, y, 6, x_offset0, y_offset0],
			[x+1, y, 8, x_offset0, y_offset0],
			[x+2,	 y, 2],
			[x+2,	 y, 18, x_offset1, y_offset1],
			[x+1, y, 8, x_offset0, y_offset0],
			[x,	 y, 2]
			]
		[frames, 0]
	end

	def animation_dodge_hold
    x = 6
    y = 4 + direction_offset
    frames = [ 
      [x+1  , y,30],
    ]
    [frames, 0]
	end
	
	def animation_atk_heavy #for 1h or 2h melee
		case direction_offset
			when 0 ;	x_offset0 = 0
						y_offset0 = -20
						x_offset1 = 0
						y_offset1 = -10
						x_offset2 = 0
						y_offset2 = -5
						x_offset3 = 0
						y_offset3 = 2
			when 1 ;	x_offset0 = 20
						y_offset0 = 0
						x_offset1 = 10
						y_offset1 = -10
						x_offset2 = 5
						y_offset2 = -5
						x_offset3 = -2
						y_offset3 = -2
			when 2 ;	x_offset0 = -20
						y_offset0 = 0
						x_offset1 = -10
						y_offset1 = -10
						x_offset2 = -5
						y_offset2 = -5
						x_offset3 = 2
						y_offset3 = -2
			when 3 ;	x_offset0 = 0
						y_offset0 = 20
						x_offset1 = 0
						y_offset1 = 10
						x_offset2 = 0
						y_offset2 = 5
						x_offset3 = 0
						y_offset3 = -2
			else
			x_offset0 = 0
			y_offset0 = 0
			x_offset1 = 0
			y_offset1 = 0
			x_offset2 = 0
			y_offset2 = 0
			x_offset3 = 0
			y_offset3 = 0
		end
		
		x = 6
		y = 4 + direction_offset
		frames = [ 
			[x,	  y, 7, x_offset0, y_offset0],
			[x  , y, 4,  x_offset1, y_offset1],
			[x+1, y, 2,  x_offset2, y_offset2],
			[x+2, y, 12,  x_offset3, y_offset3],
			[x+1, y, 2]
			]
		[frames, 0]
	end
	def animation_atk_Tackle #for 1h or 2h melee
		case direction_offset
			when 0 ;	x_offset0 = 0
						y_offset0 = -20
						x_offset1 = 0
						y_offset1 = -10
						x_offset2 = 0
						y_offset2 = -5
						x_offset3 = 0
						y_offset3 = 2
			when 1 ;	x_offset0 = 20
						y_offset0 = 0
						x_offset1 = 10
						y_offset1 = -10
						x_offset2 = 5
						y_offset2 = -5
						x_offset3 = -2
						y_offset3 = -2
			when 2 ;	x_offset0 = -20
						y_offset0 = 0
						x_offset1 = -10
						y_offset1 = -10
						x_offset2 = -5
						y_offset2 = -5
						x_offset3 = 2
						y_offset3 = -2
			when 3 ;	x_offset0 = 0
						y_offset0 = 20
						x_offset1 = 0
						y_offset1 = 10
						x_offset2 = 0
						y_offset2 = 5
						x_offset3 = 0
						y_offset3 = -2
			else
			x_offset0 = 0
			y_offset0 = 0
			x_offset1 = 0
			y_offset1 = 0
			x_offset2 = 0
			y_offset2 = 0
			x_offset3 = 0
			y_offset3 = 0
		end
		
		x = 8
		y = 0 + direction_offset
		frames = [ 
			[x,	  y, 7, x_offset0, y_offset0],
			[x  , y, 4,  x_offset1, y_offset1],
			[x+1, y, 2,  x_offset2, y_offset2],
			[x+2, y, 12,  x_offset3, y_offset3],
			[x+1, y, 2]
			]
		[frames, 0]
	end
	
	def animation_dodge #all
	random_way = rand(4)
		case random_way
			when 0 ;	x_offset0 = 1
						y_offset0 = 0
						x_offset1 = 2
						y_offset1 = -1
						x_offset2 = 5
						y_offset2 = -2
						x_offset3 = 10
						y_offset3 = -5
			when 1 ;	x_offset0 = 0
						y_offset0 = 1
						x_offset1 = 1
						y_offset1 = 2
						x_offset2 = 2
						y_offset2 = 5
						x_offset3 = 5
						y_offset3 = 10
			when 2 ;	x_offset0 = 0
						y_offset0 = -1
						x_offset1 = -1
						y_offset1 = -2
						x_offset2 = -2
						y_offset2 = -5
						x_offset3 = -5
						y_offset3 = -10
			when 3 ;	x_offset0 = -1
						y_offset0 = 0
						x_offset1 = -2
						y_offset1 = 1
						x_offset2 = -5
						y_offset2 = 2
						x_offset3 = -10
						y_offset3 = 5
			else
			x_offset0 = 0
			y_offset0 = 0
			x_offset1 = 0
			y_offset1 = 0
			x_offset2 = 0
			y_offset2 = 0
			x_offset3 = 0
			y_offset3 = 0
		end
		x = 6
		y = 4 + direction_offset
		frames = [ 
			[x,	  y, 3+1, x_offset0, y_offset0],
			[x,	  y, 2+1, x_offset1, y_offset1],
			[x,	  y, 2+1, x_offset2, y_offset2],
			[x,	  y, 4+1, x_offset3, y_offset3],
			[x,	  y, 3+1, x_offset2, y_offset2],
			[x,	  y, 5+1, x_offset1, y_offset1],
			[x,	  y, 7+1, x_offset0, y_offset0]
			]
		[frames, 0]
	end

	
	def animation_parry
		case direction_offset
			when 0 ;	x_offset0 = 0
						y_offset0 = -2
						x_offset1 = 0
						y_offset1 = -3
			when 1 ;	x_offset0 = 2
						y_offset0 = 0
						x_offset1 = 3
						y_offset1 = 0
						x_offset2 = 10
			when 2 ;	x_offset0 = -2
						y_offset0 = 0
						x_offset1 = -3
						y_offset1 = 0
			when 3 ;	x_offset0 = 0
						y_offset0 = 2
						x_offset1 = 0
						y_offset1 = 3
			else
			x_offset0 = 0
			y_offset0 = 0
			x_offset1 = 0
			y_offset1 = 0
		end
		x = 6
		y = 4 + direction_offset
		frames = [ 
			[x,	  y, 2, x_offset0, y_offset0],
			[x,	  y, 6, x_offset1, y_offset1],
			[x,	  y, 3, x_offset0, y_offset0]
			]
		[frames, 0]
	end

	def animation_ChainMace_hold
			x = 6
			x_p0 = 1
			x_p1 = 0
			x_p2 = 2
			y = 4 + direction_offset
			x_offset = 8
			y_offset0 = 4
			y_offset1 = 7
			y_offset2 = 6
			y_offset3 = 5
		xD = 8
		yD = 4 + direction_offset
		frames = [ 
			[x+x_p0 , y, 3,1],
			[x+x_p0 , y, 2,1],
			[x+x_p1 , y, 2,0],
			[x+x_p1 , y, 2,0],
			[x+x_p2 , y, 2,-1],
			[x+x_p2 , y, 2,0],
			[x+x_p2 , y, 24,-1],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2],
			[xD , yD, 6, 2],
			[xD , yD, 6,-2]
		]
		[frames, -1]
	end
	def animation_BoardSword_hold(tmpMode=@switch1_id=[true,false].sample) #player only
		if tmpMode
			x = 6
			x_p0 = 2
			x_p1 = 0
			x_p2 = 1
			y = 4 + direction_offset
			x_offset = 8
			y_offset0 = 5
			y_offset1 = 6
			y_offset2 = 7
			y_offset3 = 4
		else
			
			x = 6
			x_p0 = 1
			x_p1 = 0
			x_p2 = 2
			y = 4 + direction_offset
			x_offset = 8
			y_offset0 = 4
			y_offset1 = 7
			y_offset2 = 6
			y_offset3 = 5
		end 
		frames = [
		[x+x_p0 , y, 3,1],
		[x+x_p0 , y, 2,1],
		[x+x_p1 , y, 2,0],
		[x+x_p1 , y, 2,0],
		[x+x_p2 , y, 2,-1],
		[x+x_p2 , y, 2,0],
		[x+x_p2 , y, 24,-1],
		
		[x_offset , y_offset0, 3, 1,0],
		[x_offset , y_offset1, 3,-1,0],
		[x_offset , y_offset2, 3, 1,0],
		[x_offset , y_offset3, 3,-1,0],
		[x_offset , y_offset0, 3, 1,0],
		[x_offset , y_offset1, 3,-1,0],
		[x_offset , y_offset2, 3, 1,0],
		[x_offset , y_offset3, 3,-1,0],
		
		[x_offset , y_offset0, 3, 1,0],
		[x_offset , y_offset1, 3,-1,0],
		[x_offset , y_offset2, 3, 1,0],
		[x_offset , y_offset3, 3,-1,0],
		[x_offset , y_offset0, 3, 1,0],
		[x_offset , y_offset1, 3,-1,0],
		[x_offset , y_offset2, 3, 1,0],
		[x_offset , y_offset3, 3,-1,0],
		
		[x_offset , y_offset0, 3, 1,0],
		[x_offset , y_offset1, 3,-1,0],
		[x_offset , y_offset2, 3, 1,0],
		[x_offset , y_offset3, 3,-1,0],
		[x_offset , y_offset0, 3, 1,0],
		[x_offset , y_offset1, 3,-1,0],
		[x_offset , y_offset2, 3, 1,0],
		[x_offset , y_offset3, 3,-1,0],
		
		[x_offset , y_offset0, 3, 1,0],
		[x_offset , y_offset1, 3,-1,0],
		[x_offset , y_offset2, 3, 1,0],
		[x_offset , y_offset3, 3,-1,0],
		[x_offset , y_offset0, 3, 1,0],
		[x_offset , y_offset1, 3,-1,0],
		[x_offset , y_offset2, 3, 1,0],
		[x_offset , y_offset3, 3,-1,0],
		
		[x_offset , y_offset0, 3, 1,0],
		[x_offset , y_offset1, 3,-1,0],
		[x_offset , y_offset2, 3, 1,0],
		[x_offset , y_offset3, 3,-1,0],
		[x_offset , y_offset0, 3, 1,0],
		[x_offset , y_offset1, 3,-1,0],
		[x_offset , y_offset2, 3, 1,0],
		[x_offset , y_offset3, 3,-1,0],
		
		[x_offset , y_offset0, 3, 1,0],
		[x_offset , y_offset1, 3,-1,0],
		[x_offset , y_offset2, 3, 1,0],
		[x_offset , y_offset3, 3,-1,0],
		[x_offset , y_offset0, 3, 1,0],
		[x_offset , y_offset1, 3,-1,0],
		[x_offset , y_offset2, 3, 1,0],
		[x_offset , y_offset3, 3,-1,0]
		]
		[frames, -1]
	end
	
	def animation_BoardSword_hold_spin_only(tmpMode=@switch1_id=[true,false].sample) #player only
		if tmpMode
			x = 6
			x_p0 = 2
			x_p1 = 0
			x_p2 = 1
			y = 4 + direction_offset
			x_offset = 8
			y_offset0 = 5
			y_offset1 = 6
			y_offset2 = 7
			y_offset3 = 4
		else

			x = 6
			x_p0 = 1
			x_p1 = 0
			x_p2 = 2
			y = 4 + direction_offset
			x_offset = 8
			y_offset0 = 4
			y_offset1 = 7
			y_offset2 = 6
			y_offset3 = 5
		end
		frames = [
			[x_offset , y_offset0, 3, 1,0],
			[x_offset , y_offset1, 3,-1,0],
			[x_offset , y_offset2, 3, 1,0],
			[x_offset , y_offset3, 3,-1,0],
			[x_offset , y_offset0, 3, 1,0],
			[x_offset , y_offset1, 3,-1,0],
			[x_offset , y_offset2, 3, 1,0],
			[x_offset , y_offset3, 3,-1,0]
		]
		[frames, -1]
	end
	def animation_BoardSword_end
		y = 4 + direction_offset
		x = 6
		x2 = 2
		frames = [
			[x	,y		,3	,0,0],
			[x	,y		,3	,0,0],
			[x2	,y		,3	,0,0]
			]
		[frames, 0]
	end
	
	
	
	def animation_hold_spins
		frames = [ 
			[4	,0		,3	,0,24],
			[4	,1		,3	,0,16],
			[12	,8		,3	,0,0],
			[4	,2		,3	,0,-24],
			[4	,3		,3	,0,-16],
			[12	,8		,3	,0,0]
			]
		[frames, -1]
	end
	def animation_battleStandard_hold
		frames = [ 
			[6	,4		,5	,0,-10],
			[7	,4		,5	,0,-8],
			[8	,4		,5	,0,-6],
			[7	,4		,5	,0,-4],
			[6	,4		,5	,0,-3],
			[7	,4		,-1	,0,-2]
			]
		[frames, -1]
	end
	

#########################################################################################################################################################
  def animation_masturbation #non target ver
	
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
  
  def animation_masturbation_fast #non target ver
    x = 3
    y = 0 + direction_offset
    frames = [ 
      [x  , y, 2],
      [x+1, y, 1],
      [x+2, y, 3],
      [x+1, y, 1]
    ]
    [frames, -1]
  end

	def animation_masturbation_cumming
		x = 3
		y = 0 + direction_offset
		frames = [ 
		[x  , y, 24],
		[x+1, y, 2],
		[x+2, y, 2],
		[x+1, y, 2],
		[x  , y, 24],
		[x+1, y, 2],
		[x+2, y, 2],
		[x+1, y, 2],
		[x  , y, 24],
		[x+1, y, 2],
		[x+2, y, 2],
		[x+1, y, 2],
		[x  , y, 24],
		[x+1, y, 2],
		[x+2, y, 2],
		[x+1, y, 2],
		[x  , y, 24],
		[x+1, y, 2],
		[x+2, y, 2],
		[x+1, y, 2],
		[x  , y, 24],
		[x+1, y, 2],
		[x+2, y, 2],
		[x+1, y, 2]
		]
		[frames, 0]
	end

	def animation_peeing
		x = 3+rand(3)
		y =direction_offset
		frames = [ 
		[x, y, 0],
		]
		[frames, -1]
	end

	def animation_stun #STUN
		#x_offset = (-5..5).to_a.sample
		#y_offset = -16-(-5..5).to_a.sample
		x_offset =0
		y_offset =0
		
		x = 9
		y = 4+rand(2)
		frames = [
		[x  , y, 10, x_offset,y_offset],
		[x+1, y, 10, x_offset,y_offset],
		[x+2, y, 10, x_offset,y_offset],
		[x+1, y, 10, x_offset,y_offset]
		]
		[frames, -1]
	end
  
	def animation_sleep(tmp_dir=8) #睡覺
		@charEffectReset = true
		case tmp_dir
			when 4
				@angle = 90
				@zoom_x = 1.1
				@zoom_y = 1.15
				x_offset = 20
				y_offset = -15
				[[[9, 3, 0,x_offset,y_offset]], 0]
			when 6
				@angle = 270
				@zoom_x = 1.1
				@zoom_y = 1.15
				x_offset = -20
				y_offset = -15
				[[[9, 3, 0,x_offset,y_offset]], 0]
			#else
			#	@angle = 350
			#	@zoom_y = 0.95
			#	x_offset = -4
			#	y_offset = -15
			#	@mirror=[true,false].sample
			#	[[[0, 6, 0,x_offset,y_offset]], 0]
			else
				@angle = 10
				x_offset = 4
				y_offset = 7
				@mirror=[true,false].sample
				[[[9, 3, 0,x_offset,y_offset]], 0]
		end
	end
  
	def animation_overfatigue_stable #過勞 或過勞死亡
		x_offset = 0
		y_offset = 0
		[[[9, 6, 0,x_offset,y_offset]], 0]
	end
  
  def animation_overfatigue #過勞 或過勞死亡
    x_offset = (-5..5).to_a.sample
    y_offset = (-5..5).to_a.sample
    [[[9, 6, 0,x_offset,y_offset]], 0]
  end
  
  def animation_corpsen  #生命死亡
    x_offset = (-5..5).to_a.sample
    y_offset = -16-(-5..5).to_a.sample
	x= 10+rand(2)
    [[[x, 6, 0,x_offset,y_offset]], 0]
  end
  
  def animation_randomCHScropse #隨機死亡  僅在布置地圖場景使用
  a = rand(3)+1
    x_offset = (-5..5).to_a.sample
    y_offset = (-5..5).to_a.sample
	case a
		when 1 ; x = 10 ; y = 6
		when 2 ; x= 11 ; y =6
		when 3 ; x= 11 ; y =7
	end
    frames = [
      [x, y, 0,x_offset,y_offset]
    ]
	[frames, -1]
  end
  
  def animation_over_corpse  #only used in Lona's def check_lona_way_of_death
    x_offset = (-5..5).to_a.sample
    y_offset = (-5..5).to_a.sample
    [[[11, 6, 0,x_offset,y_offset]], 0]
  end
  
	  def overkill_animation  #榮耀擊殺 單向目標版 不採用
		x = 9
		y = 7
		frames = [
		  [1,0,5],
		  [1,1,5],
		  [1,2,5],
		  [1,3,5],
		  [1,0,30],
		  [x  , y, 20],
		  [x+1, y, 20],
		  [x+2, y, 0]
		]
		[frames, 0]
	  end
  
	  def overkill_animation_fast #榮耀擊殺 快速版
		x = 9
		y = 7
		frames = [
		  [x  , y, 20],
		  [x+1, y, 20],
		  [x+2, y, 0]
		]
		[frames, 0]
	  end
  
	  def overkill_animation_slow #榮耀擊殺 Slow
		x = 9
		y = 7
		frames = [
		  [x  , y, 35],
		  [x+1, y, 35],
		  [x+2, y, 0]
		]
		[frames, 0]
	  end
	  
	  def overkill_animation_fast_rez #復活
		x = 9
		y = 7
		frames = [
		  [x+2  , y, 20],
		  [x+1, y, 20],
		  [x, y, 20],
		  [11, 5, 20]
		]
		[frames, 0]
	  end
	

	def animation_player_overkill(temp_target,temp_user=self) #新版榮耀擊殺  殺人者 #雙向需求 於進戰時造成OVERKILL 則傳送至目標身上,(距離擊殺則忽略這個 僅用接收端即可)
		if [true,false].sample
				x_offset = (temp_target.x - temp_user.x) * 32 + (-10..10).to_a.sample
				y_offset = (temp_target.y - temp_user.y) * 32 + (-10..10).to_a.sample
				x = 6
				y = 4 +direction_offset
				frames = [ 
					[0,		1,	1,		(x_offset*0.2).to_i, (y_offset*0.2).to_i-8],
					[0,		1,	1,		(x_offset*0.4).to_i, (y_offset*0.2).to_i-16],
					[0,		y,	2,		(x_offset*0.5).to_i, (y_offset*0.5).to_i-32],
					[x,		y,	2,		(x_offset*0.8).to_i, (y_offset*0.8).to_i-16],
					[6+rand(3)		,4		,2,x_offset, y_offset-2],
					[6+rand(3)		,4+2	,2,x_offset, y_offset],
					[6+rand(3)		,4+1	,2,x_offset, y_offset],
					[6+rand(3)		,4+3	,2,x_offset, y_offset],
					[x+1,	y,	2,		(x_offset*0.8).to_i, (y_offset*0.8).to_i],
					[x+1,	y,	2,		(x_offset*0.5).to_i, (y_offset*0.5).to_i],
					[x	,	y,	1,		(x_offset*0.2).to_i, (y_offset*0.2).to_i]
				]
				[frames, 0]
			else
				x_offset = (temp_target.x - temp_user.x) * 32 + (-10..10).to_a.sample
				y_offset = (temp_target.y - temp_user.y) * 32 + (-10..10).to_a.sample
				x = 6
				y = 4 +direction_offset
				frames = [ 
					[0,		1,	1,		(x_offset*0.2).to_i, (y_offset*0.2).to_i-8],
					[0,		1,	1,		(x_offset*0.4).to_i, (y_offset*0.2).to_i-16],
					[0,		y,	2,		(x_offset*0.5).to_i, (y_offset*0.5).to_i-32],
					[x,		y,	2,		(x_offset*0.8).to_i, (y_offset*0.8).to_i-16],
					[6+rand(3)		,4+3	,2,x_offset, y_offset-2],
					[6+rand(3)		,4+1	,2,x_offset, y_offset],
					[6+rand(3)		,4+2	,2,x_offset, y_offset],
					[6+rand(3)		,4		,2,x_offset, y_offset],
					[x+1,	y,	2,		(x_offset*0.8).to_i, (y_offset*0.8).to_i],
					[x+1,	y,	2,		(x_offset*0.5).to_i, (y_offset*0.5).to_i],
					[x	,	y,	1,		(x_offset*0.2).to_i, (y_offset*0.2).to_i]
				]
				[frames, 0]
		end
	end
	def animation_melee_touch_target(temp_target,temp_user=self) #舊版榮耀擊殺 BOBO撞門以及ARENA強暴依然採用
		case rand(3)
			when 0
				random_way = rand(4)
				x_offset = (temp_target.x - temp_user.x) * 32 + (-10..10).to_a.sample
				y_offset = (temp_target.y - temp_user.y) * 32 + (-10..10).to_a.sample
				x = 6
				y = 4 + random_way
				frames = [ 
					[0,		1,	2,		(x_offset*0.5).to_i, (y_offset*0.5).to_i],
					[x+2,	y,	6,		(x_offset*0.8).to_i, (y_offset*0.8).to_i],
					[x+1,	y,	10,		x_offset, y_offset-2],
					[x+1,	y,	8,		x_offset, y_offset],
					[x,		y,	2,		x_offset, y_offset],
					[x+1,	y,	2,		(x_offset*0.8).to_i, (y_offset*0.8).to_i],
					[x+1,	y,	2,		(x_offset*0.5).to_i, (y_offset*0.5).to_i],
					[x+1,	y,	1,		(x_offset*0.2).to_i, (y_offset*0.2).to_i]
				]
				[frames, 0]
			when 1
				random_way = rand(4)
				x_offset = (temp_target.x - temp_user.x) * 32 + (-10..10).to_a.sample
				y_offset = (temp_target.y - temp_user.y) * 32 + (-10..10).to_a.sample
				x = 6
				y = 4 +direction_offset
				frames = [ 
					[x,		1,	2,		(x_offset*0.2).to_i, (y_offset*0.2).to_i-8],
					[x+1,	y,	6,		(x_offset*0.5).to_i, (y_offset*0.5).to_i-6],
					[x+2,	y,	7,		(x_offset*0.8).to_i, (y_offset*0.8).to_i-2],
					[x+2,	y,	10,		x_offset, y_offset-2],
					[x+2,	y,	8,		x_offset, y_offset],
					[x+1,	y,	2,		(x_offset*0.8).to_i, (y_offset*0.8).to_i],
					[x+1,	y,	2,		(x_offset*0.5).to_i, (y_offset*0.5).to_i],
					[x	,	y,	1,		(x_offset*0.2).to_i, (y_offset*0.2).to_i]
				]
				[frames, 0]
			when 2
				random_way = rand(4)
				x_offset = (temp_target.x - temp_user.x) * 32 + (-10..10).to_a.sample
				y_offset = (temp_target.y - temp_user.y) * 32 + (-10..10).to_a.sample
				x = 6
				y = 4 +direction_offset
				frames = [ 
					[0,		1,	1,		(x_offset*0.2).to_i, (y_offset*0.2).to_i-8],
					[0,		1,	1,		(x_offset*0.4).to_i, (y_offset*0.2).to_i-16],
					[0,		y,	6,		(x_offset*0.5).to_i, (y_offset*0.5).to_i-32],
					[x,		y,	5,		(x_offset*0.8).to_i, (y_offset*0.8).to_i-16],
					[x,		y,	10,		x_offset, y_offset-10],
					[x,		y,	4,		x_offset, y_offset-8],
					[x+2,	y,	8,		x_offset, y_offset-4],
					[x+1,	y,	2,		(x_offset*0.8).to_i, (y_offset*0.8).to_i],
					[x+1,	y,	2,		(x_offset*0.5).to_i, (y_offset*0.5).to_i],
					[x	,	y,	1,		(x_offset*0.2).to_i, (y_offset*0.2).to_i]
				]
				[frames, 0]
		end
	end
  
  
  def animation_kill_reciver
	self.mirror = [true,false].sample
	x_offset = (-2..2).to_a.sample
	y_offset = (-2..2).to_a.sample
	x = 9
	y = 7
	if rand(2) == 0
		frames = [ 
		[0,4,3,2,-15],
		[0,4+1,3,0,-30],
		[0,4+3,3,0,-10],
		[0,4+2,3,0,-5]
		]
		[frames, 0]
	else
		frames = [ 
		[0,4,3,2,-15],
		[0,4+2,3,0,-30],
		[0,4+3,3,0,-10],
		[0,4+1,3,0,-5]
		]
		[frames, 0]
	end
  end    
  
  def animation_overkill_melee_reciver  #榮耀擊殺 被擊殺的單位 不須額外控制
	self.mirror = [true,false].sample
	x_offset = (-2..2).to_a.sample
	y_offset = (-2..2).to_a.sample
	x = 9
	y = 7
	if rand(2) == 0
		frames = [ 
		[0,4,3,2,-15],
		[0,4+1,3,0,-30],
		[0,4+3,3,0,-10],
		[0,4+2,3,0,-5],
		[0,4,3,2,0],
		[1,4,15		,x_offset, y_offset],
		[x  , y, 19	,x_offset, y_offset],
		[x+1, y, 19	,x_offset, y_offset],
		[x+2, y, 5	,x_offset, y_offset]
		]
		[frames, 0]
	else
		frames = [ 
		[0,4,3,2,-15],
		[0,4+2,3,0,-30],
		[0,4+3,3,0,-10],
		[0,4+1,3,0,-5],
		[0,4,3,2,0],
		[1,4,15		,x_offset, y_offset],
		[x  , y, 19	,x_offset, y_offset],
		[x+1, y, 19	,x_offset, y_offset],
		[x+2, y, 5	,x_offset, y_offset]
		]
		[frames, 0]
	end
  end  
  
  def animation_overkill_melee_reciver_loop  #榮耀擊殺 被擊殺的單位 不須額外控制  LOOP
	x_offset = (-15..15).to_a.sample
    y_offset = (-15..15).to_a.sample
    x = 9
    y = 7
	if rand(2) == 0
		frames = [ 
		[0,4,3,2,-15],
		[0,4+1,3,0,-30],
		[0,4+3,3,0,-10],
		[0,4+2,3,0,-5],
		[0,4,3,2,0],
		[1,4,15		,x_offset, y_offset],
		[x  , y, 19	,x_offset, y_offset],
		[x+1, y, 19	,x_offset, y_offset],
		[x+2, y, 0	,x_offset, y_offset]
		]
		[frames, -1]
	else
		frames = [ 
		[0,4,3,2,-15],
		[0,4+2,3,0,-30],
		[0,4+3,3,0,-10],
		[0,4+1,3,0,-5],
		[0,4,3,2,0],
		[1,4,15		,x_offset, y_offset],
		[x  , y, 19	,x_offset, y_offset],
		[x+1, y, 19	,x_offset, y_offset],
		[x+2, y, 0	,x_offset, y_offset]
		]
		[frames, -1]
	end
  end
  
	def animation_prayer
	tmpASD=[true,false].sample
	x = tmpASD ? 1 : 10
    y = tmpASD ? 4 : 0
	y = y+direction_offset
	tmpR = tmpASD ? 2 : 7
    frames = [ 
      [x, y, 0,0,tmpR]
    ]
    [frames, -1]
	end
  
	def animation_dance #DDRR DDRRRR DDRRRRRRRRRRR
		x = 6
		y = 4 
		frames = [ 
			[1,0,3,0,-15],
			[1,0,3,0,-30],
			[1,0,3,0,-10],
			[1,0,3,0,-5],
			[10,0,30,0,15],
			[2,0,5],
			[2,1,5],
			[1,2,5],
			[0,3,5],
			[1,0,15],
			[x  , y, 4, 0,0],
			[x+1, y, 2, 8,0],
			[x+2, y, 4,12,0],
			[2,0,5,16,0],
			[2,1,5,16,0],
			[1,2,5,16,0],
			[0,3,5,16,0],
			[1,0,10,16,0],
			[9,   5, 30,16,0],
			[x+2, y, 4,8,0],
			[2,0,5,0,0],
			[2,3,5,0,0],
			[1,2,5,0,0],
			[0,1,5,0,0],
			[1,0,10,0,0],
			[x+1, y, 2,-4,0],
			[x  , y, 4,-12,0],
			[2,0,5,-16,0],
			[2,3,5,-16,0],
			[1,2,5,-16,0],
			[0,1,5,-16,0],
			[1,0,10,-16,0],
			[9,   4, 30,-16,0],
			[x  , y, 10,-12,0],
			[x+1, y, 2, 4,0],
			[2,0,5,0,0],
			[2,3,5,0,0],
			[1,2,5,0,0],
			[0,1,5,0,0],
			[1,0,5,0,0]
		]
		[frames, -1]
	end
	
	
	def animation_JumpTurn(tmpWay=rand(2)) #DDRR DDRRRR DDRRRRRRRRRRR
		if tmpWay == 0
			frames = [ 
			[0,4,3,2,-15],
			[0,4+1,3,0,-30],
			[0,4+3,3,0,-10],
			[0,4+2,3,0,-5],
			[0,4,3,2,0]
			]
			[frames, 0]
		else
			frames = [ 
			[0,4,3,2,-15],
			[0,4+2,3,0,-30],
			[0,4+3,3,0,-10],
			[0,4+1,3,0,-5],
			[0,4,3,2,0]
			]
			[frames, 0]
		end
	end
	
	def animation_TurnLoop #DDRR DDRRRR DDRRRRRRRRRRR
		frames = [ 
			[1,4,3,2,0,0],
			[1,4+1,2,0,0],
			[1,4+3,2,0,0],
			[1,4+2,2,0,0]
		]
		[frames, -1]
	end
	
 ###########33 EFFECTS	##########################ˇ##############ˇ##############ˇ##############ˇ##############ˇ
 ###########33 EFFECTS	##########################ˇ##############ˇ##############ˇ##############ˇ##############ˇ
 ###########33 EFFECTS	##########################ˇ##############ˇ##############ˇ##############ˇ##############ˇ
 ###########33 EFFECTS	##########################ˇ##############ˇ##############ˇ##############ˇ##############ˇ
 ###########33 EFFECTS	##########################ˇ##############ˇ##############ˇ##############ˇ##############ˇ
 
def animation_MagicCasting1 #blood
    x_offset= 0
	y_offset=3
    frames = [ 
    [x_offset,y_offset,2],
    [x_offset+1,y_offset,2],
    [x_offset+2,y_offset,2],
    [x_offset+3,y_offset,2],
    [x_offset+4,y_offset,2],
    [x_offset+5,y_offset,4],
    [x_offset+6,y_offset,4],
    [x_offset+7,y_offset,4],
    [x_offset+8,y_offset,4],
    [x_offset+9,y_offset,4],
    [x_offset+10,y_offset,4],
    [x_offset+11,y_offset,4]
    ]
    [frames, -1]
end

def animation_MagicCasting2 #fire
    x_offset= 0
	y_offset=2
    frames = [ 
    [x_offset,y_offset,2],
    [x_offset+1,y_offset,2],
    [x_offset+2,y_offset,2],
    [x_offset+3,y_offset,2],
    [x_offset+4,y_offset,2],
    [x_offset+5,y_offset,4],
    [x_offset+6,y_offset,4],
    [x_offset+7,y_offset,4],
    [x_offset+8,y_offset,4],
    [x_offset+9,y_offset,4],
    [x_offset+10,y_offset,4],
    [x_offset+11,y_offset,4]
    ]
    [frames, -1]
end

def animation_MagicCasting3 #ice
    x_offset= 0
	y_offset=1
    frames = [ 
    [x_offset,y_offset,2],
    [x_offset+1,y_offset,2],
    [x_offset+2,y_offset,2],
    [x_offset+3,y_offset,2],
    [x_offset+4,y_offset,2],
    [x_offset+5,y_offset,4],
    [x_offset+6,y_offset,4],
    [x_offset+7,y_offset,4],
    [x_offset+8,y_offset,4],
    [x_offset+9,y_offset,4],
    [x_offset+10,y_offset,4],
    [x_offset+11,y_offset,4]
    ]
    [frames, -1]
end

def animation_MagicCasting4 #life
    x_offset= 0
	y_offset=0
    frames = [ 
    [x_offset,y_offset,2],
    [x_offset+1,y_offset,2],
    [x_offset+2,y_offset,2],
    [x_offset+3,y_offset,2],
    [x_offset+4,y_offset,2],
    [x_offset+5,y_offset,4],
    [x_offset+6,y_offset,4],
    [x_offset+7,y_offset,4],
    [x_offset+8,y_offset,4],
    [x_offset+9,y_offset,4],
    [x_offset+10,y_offset,4],
    [x_offset+11,y_offset,4]
    ]
    [frames, -1]
end

#def animation_firewall
#    x_offset= 7
#	y_offset=0
#    frames = [ 
#    [x_offset,y_offset,5,	0,1],
#    [x_offset,y_offset+1,5,	0,1],
#    [x_offset,y_offset+2,5,	0,1],
#    [x_offset,y_offset+3,5,	0,1]
#	]
#    [frames, -1]
#end

def animation_tornado
    x_offset= 11
	y_offset= 4
    frames = [ 
    [x_offset,y_offset,		2,	0,0],
    [x_offset,y_offset+1,	2,	1,0],
    [x_offset,y_offset+2,	2,	2,0],
    [x_offset,y_offset+3,	2,	3,0],
    [x_offset,y_offset,		2,	4,0],
    [x_offset,y_offset+1,	2,	3,0],
    [x_offset,y_offset+2,	2,	2,0],
    [x_offset,y_offset+3,	2,	1,0],
    [x_offset,y_offset,		2,	0,0],
    [x_offset,y_offset+1,	2,	-1,0],
    [x_offset,y_offset+2,	2,	-2,0],
    [x_offset,y_offset+3,	2,	-3,0],
    [x_offset,y_offset,		2,	-4,0],
    [x_offset,y_offset+1,	2,	-3,0],
    [x_offset,y_offset+2,	2,	-2,0],
    [x_offset,y_offset+3,	2,	-1,0]
	]
    [frames, -1]
end

def animation_swirl
    x_offset= 9
	y_offset= 4
	tmpY=16
    frames = [ 
    [x_offset,y_offset,		2,	0, tmpY],
    [x_offset,y_offset+1,	2,	1, tmpY],
    [x_offset,y_offset+2,	2,	2, tmpY],
    [x_offset,y_offset+3,	2,	3, tmpY],
    [x_offset,y_offset,		2,	4, tmpY],
    [x_offset,y_offset+1,	2,	3, tmpY],
    [x_offset,y_offset+2,	2,	2, tmpY],
    [x_offset,y_offset+3,	2,	1, tmpY],
    [x_offset,y_offset,		2,	0, tmpY],
    [x_offset,y_offset+1,	2,	-1,tmpY],
    [x_offset,y_offset+2,	2,	-2,tmpY],
    [x_offset,y_offset+3,	2,	-3,tmpY],
    [x_offset,y_offset,		2,	-4,tmpY],
    [x_offset,y_offset+1,	2,	-3,tmpY],
    [x_offset,y_offset+2,	2,	-2,tmpY],
    [x_offset,y_offset+3,	2,	-1,tmpY]
	]
    [frames, -1]
end

def animation_buff_life
    x_offset= 10
	y_offset= 4
    frames = [ 
    [x_offset,y_offset,		3,	0,0],
    [x_offset,y_offset+1,	3,	1,0],
    [x_offset,y_offset+2,	3,	2,0],
    [x_offset,y_offset+3,	3,	3,0],
    [12,0,60]
	]
    [frames, 1]
end

def animation_buff_life_rev
    x_offset= 10
	y_offset= 7
    frames = [ 
    [x_offset,y_offset,	5,	3,0],
    [x_offset,y_offset-1,	6,	2,0],
    [x_offset,y_offset-2,	7,	1,0],
    [x_offset,y_offset-3,		8,	0,0],
    [12,0,60]
	]
    [frames, 1]
end

def animation_BurnSmoke1
    x_offset= 0
	y_offset=7
    frames = [ 
    [x_offset,y_offset,2],
    [x_offset+1,y_offset,2],
    [x_offset+3,y_offset,2],
    [x_offset+4,y_offset,2],
    [x_offset+5,y_offset,4],
    [x_offset+6,y_offset,4],
    [x_offset+7,y_offset,4],
	[12,0,60]
    ]
    [frames, 1]
end

def animation_BurnSmoke2
    x_offset= 0
	y_offset=6
    frames = [ 
    [x_offset,y_offset,2],
    [x_offset+1,y_offset,2],
    [x_offset+3,y_offset,2],
    [x_offset+4,y_offset,2],
    [x_offset+5,y_offset,4],
    [x_offset+6,y_offset,4],
    [x_offset+7,y_offset,4],
	[12,0,60]
    ]
    [frames, 1]
end

def animation_KaBom1
    x_offset= 0
	y_offset=7
    frames = [ 
    [x_offset,y_offset,2],
    [x_offset+1,y_offset,2],
    [x_offset+3,y_offset,2],
    [x_offset+4,y_offset,2],
    [x_offset+5,y_offset,4],
    [x_offset+6,y_offset,4],
    [x_offset+7,y_offset,4],
    [x_offset+8,y_offset,4],
    [x_offset+9,y_offset,4],
    [x_offset+10,y_offset,4],
    [x_offset+11,y_offset,4],
    [12,0,60]
    ]
    [frames, 1]
end

def animation_KaBom2
    x_offset= 0
	y_offset=6
    frames = [ 
    [x_offset,y_offset,2],
    [x_offset+1,y_offset,2],
    [x_offset+3,y_offset,2],
    [x_offset+4,y_offset,2],
    [x_offset+5,y_offset,4],
    [x_offset+6,y_offset,4],
    [x_offset+7,y_offset,4],
    [x_offset+8,y_offset,4],
    [x_offset+9,y_offset,4],
    [x_offset+10,y_offset,4],
    [x_offset+11,y_offset,4],
    [12,0,60]
    ]
    [frames, 1]
end

def animation_KaBom3
    x_offset= 0
	y_offset=5
    frames = [ 
    [x_offset,y_offset,2],
    [x_offset+1,y_offset,2],
    [x_offset+3,y_offset,2],
    [x_offset+4,y_offset,2],
    [x_offset+5,y_offset,4],
    [x_offset+6,y_offset,4],
    [x_offset+7,y_offset,4],
    [x_offset+8,y_offset,4],
    [x_offset+9,y_offset,4],
    [x_offset+10,y_offset,4],
    [x_offset+11,y_offset,4],
    [12,0,60]
    ]
    [frames, 1]
end

def animation_KaBom4
    x_offset= 0
	y_offset=4
    frames = [ 
    [x_offset,y_offset,2],
    [x_offset+1,y_offset,2],
    [x_offset+3,y_offset,2],
    [x_offset+4,y_offset,2],
    [x_offset+5,y_offset,4],
    [x_offset+6,y_offset,4],
    [x_offset+7,y_offset,4],
    [x_offset+8,y_offset,4],
    [x_offset+9,y_offset,4],
    [x_offset+10,y_offset,4],
    [x_offset+11,y_offset,4],
    [12,0,60]
    ]
    [frames, 1]
end

def animation_KaBom4_reverse
    x_offset= 0
	y_offset=4
    frames = [ 
    [x_offset+10,y_offset,2],
    [x_offset+9,y_offset,2],
    [x_offset+8,y_offset,2],
    [x_offset+7,y_offset,2],
    [x_offset+6,y_offset,4],
    [x_offset+5,y_offset,4],
    [x_offset+4,y_offset,4],
    [x_offset+3,y_offset,4],
    [x_offset+2,y_offset,4],
    [x_offset+1,y_offset,4],
    [x_offset,y_offset,4],
    [12,0,90]
    ]
    [frames, 1]
end

def animation_CastingCorrosionMissile
    x_offset= 0
	y_offset=4
    frames = [ 
    [x_offset,y_offset,2],
    [x_offset+1,y_offset,4],
    [x_offset+2,y_offset,4],
    [x_offset+3,y_offset,4],
    [x_offset+2,y_offset,4],
    [x_offset+3,y_offset,4],
    [x_offset+2,y_offset,4],
    [x_offset+1,y_offset,4],
    [x_offset,y_offset,4],
    [12,0,90]
    ]
    [frames, 1]
end

def get_height
	if use_chs?
		return ($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs
	else
		return (@tmp_cellheight.nil? ? 10 : @tmp_cellheight)
	end
end 
 
	def animation_effect_PunchHit #EffectPunchHit
		#temp =($chs_data[get_character(targetid).chs_type].balloon_height).abs
		temp =get_height
		temp2=(temp*0.5).round
		x_offset = 0
		y_offset= 4
		temp_x = (-16-temp2)+rand(32+temp)
		temp_y = (-16-temp2)+rand(32+temp)
		frames = [ 
		[x_offset,y_offset,2,temp_x,temp_y],
		[x_offset+1,y_offset,2,temp_x,temp_y],
		[x_offset+2,y_offset,4,temp_x,temp_y],
		[12,0,20,temp_x,temp_y]
		]
		[frames, 0]
	end

	def animation_effect_SpeamHit
		temp =get_height
		temp2=(temp*0.5).round
		x_offset = 0
		y_offset= 5
		temp_x = (-16-temp2)+rand(32+temp)
		temp_y = (-16-temp2)+rand(32+temp)
		frames = [ 
		[x_offset,y_offset,2,temp_x,temp_y],
		[x_offset+1,y_offset,2,temp_x,temp_y],
		[x_offset+2,y_offset,4,temp_x,temp_y],
		[12,0,20,temp_x,temp_y]
		]
		[frames, 1]
	end


 def animation_effect_GoreHit #EffectPunchHit
	temp= get_height
	temp2=(temp*0.5).round
	x_offset= 0
	y_offset= 7
	temp_x = (-16-temp2)+rand(32+temp)
	temp_y = (-16-temp2)+rand(32+temp)
	frames = [ 
	[x_offset,y_offset,2,temp_x,temp_y],
	[x_offset+1,y_offset,2,temp_x,temp_y],
	[x_offset+2,y_offset,4,temp_x,temp_y],
	[12,0,20,temp_x,temp_y]
	]
	[frames, 1]
end

 def animation_effect_WaterHit #EffectPunchHit
	temp= get_height
	temp2=(temp*0.5).round
	x_offset= 0
	y_offset= 6
	temp_x = (-16-temp2)+rand(32+temp)
	temp_y = (-16-temp2)+rand(32+temp)
	frames = [ 
	[x_offset,y_offset,2,temp_x,temp_y],
	[x_offset+1,y_offset,2,temp_x,temp_y],
	[x_offset+2,y_offset,4,temp_x,temp_y],
	[12,0,20,temp_x,temp_y]
	]
	[frames, 1]
end


 def animation_effect_NecroHit #EffectNecroHit
	temp= get_height
	temp2=(temp*0.5).round
	x_offset= 3
	y_offset= 3
	temp_x = (-16-temp2)+rand(32+temp)
	temp_y = (-16-temp2)+rand(32+temp)
	frames = [ 
	[x_offset,y_offset,2,temp_x,temp_y],
	[x_offset+1,y_offset,2,temp_x,temp_y],
	[x_offset+2,y_offset,4,temp_x,temp_y],
	[12,0,20,temp_x,temp_y]
	]
	[frames, 1]
end

 def animation_effect_NecroHitRev #EffectNecroHit
	temp= get_height
	temp2=(temp*0.5).round
	x_offset= 3
	y_offset= 3
	temp_x = 0#(-16-temp2)+rand(32+temp)
	temp_y = 0#(-16-temp2)+rand(32+temp)
	frames = [ 
	[x_offset+2,y_offset,4,temp_x,temp_y],
	[x_offset+1,y_offset,2,temp_x,temp_y],
	[x_offset,y_offset,2,temp_x,temp_y],
	[12,0,20,temp_x,temp_y]
	]
	[frames, 1]
end

def animation_effect_slashHeavy
	temp =($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs
	y_offset = 0
	x_offset = 0
	case get_character(@summoner_id).direction
		when 8 ; y_offset = 0-temp
		when 2 ; y_offset = 0+temp
		when 4 ; x_offset = 0-temp
		when 6 ; x_offset = 0+temp
	end
	frames = [ 
		[11,0, 10, x_offset, y_offset],
		[cell_x_offset,cell_y_offset, 2, x_offset, y_offset]
		]
	[frames, 1]
end
 
def animation_effect_WaterLaunch
	temp =($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs
	y_offset = 0
	x_offset = 0
	x=0
	y=6
	case get_character(@summoner_id).direction
		when 8 ; y_offset = -16
		when 2 ; y_offset = 16
		when 4 ; x_offset = -16
		when 6 ; x_offset = 16
	end
	frames = [ 
		[12,	0, 5, x_offset, y_offset],
		[x,		y, 6, x_offset, y_offset],
		[x+1,	y, 6, x_offset, y_offset],
		[x+2,	y, 6, x_offset, y_offset],
		[12,	0, -1, x_offset, y_offset]
		]
	[frames, 1]
end 
def animation_effect_WaterLaunch2
	temp =($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs
	y_offset = 0
	x_offset = 0
	x=0
	y=6
	case get_character(@summoner_id).direction
		when 8 ; y_offset = -16
		when 2 ; y_offset = 16
		when 4 ; x_offset = -16
		when 6 ; x_offset = 16
	end
	frames = [ 
		[12,	0, 2, x_offset, y_offset],
		[x+2,	y, 6, x_offset, y_offset],
		[x+1,	y, 6, x_offset, y_offset],
		[x,		y, 6, x_offset, y_offset],
		[12,	0, -1, x_offset, y_offset]
		]
	[frames, 1]
end 
 
def animation_effect_BombArrowLoop
	y_offset = ($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs/2
	self.direction = @summon_data[:user].direction
	frames = [ 
		[cell_x_offset-1,direction_offset, 2, 0, y_offset],
		[cell_x_offset+1,direction_offset, 2, 0, y_offset]
		]
	[frames, -1]
end

def animation_effect_arrow
	y_offset = ($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs/2
	self.direction = @summon_data[:user].direction
	frames = [ 
		[cell_x_offset,direction_offset, 20, 0, y_offset],
		[cell_x_offset-1,direction_offset, 0, 0, y_offset]
		]
	[frames, 0]
end
def animation_effect_ThrowingKnife
	y_offset = ($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs/2
	self.direction = @summon_data[:user].direction
	frames = [ 
		[9,direction_offset+4, 20, 0, y_offset]
		]
	[frames, -1]
end
 
def animation_effect_arrow_hold
	y_offset = ($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs/2
	self.direction = @summon_data[:user].direction
	frames = [ 
		[cell_x_offset,direction_offset, 20, 0, y_offset]
		]
	[frames, -1]
end

def animation_effect_hook_hold
	y_offset = ($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs/2
	self.direction = @summon_data[:user].direction
	frames = [ 
		[11,4+direction_offset, 20, 0, y_offset]
		]
	[frames, -1]
end

#def animation_arrow_projectile
#	y_offset = ($chs_data[@summon_data[:user].chs_type].balloon_height).abs/2
#	self.direction = @summon_data[:user].direction
#	frames = [ 
#		[6,direction_offset, 20, 0, y_offset]
#		]
#	[frames, -1]
#end

 def animation_effect_punch_piercing
    temp = ($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs
    @opacity = 180
    x_offset = 0
    y_offset = 0

    self.direction = @summon_data[:user].direction
    case self.direction
        when 8;y_offset -= temp
        when 2;y_offset += temp
        when 4;x_offset -= temp
        when 6;x_offset += temp
    end
            frames = [ 
            [11,0, 6, x_offset, y_offset],
            [5,4+direction_offset, 2, 0, 0],
            [5,4+direction_offset, 2, x_offset, y_offset],
            [11,0, -1, x_offset, y_offset]
            ]
        [frames, 0]
    end
	
 def animation_effect_piercing
	temp = ($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs
	@opacity = 180
	x_offset = 0
	y_offset = 0

	self.direction = @summon_data[:user].direction
	case self.direction
		when 8;y_offset -= temp
		when 2;y_offset += temp
		when 4;x_offset -= temp
		when 6;x_offset += temp
	end
			frames = [ 
			[11,0, 6, x_offset, y_offset],
			[cell_x_offset,direction_offset, 2, 0, 0],
			[cell_x_offset,direction_offset, 2, x_offset, y_offset],
			[11,0, -1, x_offset, y_offset]
			]
		[frames, 0]
	end
	
 def animation_effect_piercing_long
	temp = ($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs
	@opacity = 200
	x_offset0 = 0
	y_offset0 = 0
	x_offset1 = 0
	y_offset1 = 0
	x_offset2 = 0
	y_offset2 = 0
	x=7
	y=4
	if @summon_data[:user]==$game_player
		self.direction =@summon_data[:user].direction
	else
		self.direction = @summon_data[:user].relative_dir?(@summon_data[:target])
	end
	case self.direction
		when 8;	y_offset0 -= temp*2
				y_offset1 -= temp*4
				y_offset2 -= temp*8
		when 2;	y_offset0 += temp*2
				y_offset1 += temp*4
				y_offset2 += temp*8
		when 4;	x_offset0 -= temp*2
				x_offset1 -= temp*4
				x_offset2 -= temp*8
		when 6;	x_offset0 += temp*2
				x_offset1 += temp*4
				x_offset2 += temp*8
	end
			frames = [ 
			[11,0, 6, x_offset0, y_offset0],
			[x,y+direction_offset, 1, x_offset0, y_offset0],
			[x,y+direction_offset, 1, x_offset1, y_offset1],
			[x,y+direction_offset, 1, x_offset2, y_offset2],
			[11,0, -1, x_offset2, y_offset2]
			]
		[frames, 0]
end

 def animation_effect_hook_long
	temp = ($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs
	
	@opacity = 200
	x_offset0 = 0
	y_offset0 = 0
	x_offset1 = 0
	y_offset1 = 0
	x_offset2 = 0
	y_offset2 = 0
	x=10
	y=4
	if @summon_data[:user]==$game_player
		self.direction =@summon_data[:user].direction
	else
		self.direction = @summon_data[:user].relative_dir?(@summon_data[:target])
	end
	case self.direction
		when 8;	y_offset0 -= temp*2
				y_offset1 -= temp*4
				y_offset2 -= temp*8
		when 2;	y_offset0 += temp*2
				y_offset1 += temp*4
				y_offset2 += temp*8
		when 4;	x_offset0 -= temp*2
				x_offset1 -= temp*4
				x_offset2 -= temp*8
		when 6;	x_offset0 += temp*2
				x_offset1 += temp*4
				x_offset2 += temp*8
	end
			frames = [ 
			[11,0, 6, x_offset0, y_offset0],
			[x,y+direction_offset, 1, x_offset0, y_offset0],
			[x,y+direction_offset, 1, x_offset1, y_offset1],
			[x,y+direction_offset, 1, x_offset2, y_offset2],
			[11,0, -1, x_offset2, y_offset2]
			]
		[frames, 0]
end

	def animation_effect_spins
			y_offset = ($chs_data[get_character(@summoner_id).chs_type].balloon_height)
			frames = [ 
			[cell_x_offset,cell_y_offset, 2, 0, y_offset],
			[cell_x_offset,cell_y_offset+1, 2, 0, y_offset],
			[11,0, 4, 0, y_offset],
			[cell_x_offset,cell_y_offset+2, 2, 0, y_offset],
			[cell_x_offset,cell_y_offset+3, 2, 0, y_offset],
			[11,0, 2, 0, y_offset],
			[cell_x_offset,cell_y_offset, 1, 0, 0],
			[cell_x_offset,cell_y_offset+1, 1, 0, 0],
			[11,0, -1, 0, y_offset]
			]
		[frames, -1]
	end
	
	
	
 def animation_effect_slashSH
            temp = 2/($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs
            x_offset = 0
            y_offset = 0
        self.direction = @summon_data[:user].direction
            case self.direction
                when 8;y_offset -= temp
                when 2;y_offset += temp
                when 4;x_offset -= temp
                when 6;x_offset += temp
            end
            frames = [ 
            [11,0, 2, x_offset, y_offset],
            [cell_x_offset,direction_offset, 2, x_offset, y_offset],
            [11,0, -1, x_offset, y_offset]
            ]
        [frames, 0]
    end
	

def animation_effect_smoke_move
	basicX= -8+rand(16)
	basicY= -4+rand(16)
	temp_wait_count=rand(5)+15
	temp_smoke_type=3+rand(3)
	frames = [ 
	[temp_smoke_type,2,temp_wait_count,basicX+1,basicY],
	[temp_smoke_type,2,temp_wait_count,basicX,basicY],
	[temp_smoke_type,2,temp_wait_count,basicX-1,basicY],
	[temp_smoke_type,2,temp_wait_count,basicX,basicY]
	]
	[frames, -1]
end

#def animation_effect_corrosion_water_area
#	asd_X= -2+rand(4)
#	asd_Y= -2+rand(4)
#	frames = [ 
#	[3,0,12,0+asd_X,40+asd_Y],
#	[4,0,12,0+asd_X,40+asd_Y],
#	[5,0,12,0+asd_X,40+asd_Y]
#	]
#	[frames, -1]
#end

def animation_effect_corrosion_missile
	frames = [ 
	[3,1,20,0,1],
	[4,1,5,0, 1],
	[5,1,5,0, 1]
	]
	[frames, -1]
end

def animation_effect_roar_move
	temp = ($chs_data[get_character(@summoner_id).chs_type].balloon_height).abs
	x_offset1 = 0
	y_offset1 = 0
	x_offset2 = 0
	y_offset2 = 0
	x_offset3 = 0
	y_offset3 = 0
	x_offset4 = 0
	y_offset4 = 0
	self.direction = @summon_data[:user].direction
	case self.direction
		when 8;	y_offset1 -= temp
				y_offset2 -= temp*2
				y_offset3 -= temp*3
				y_offset4 -= temp*4
		when 2;	y_offset1 += temp
				y_offset2 += temp*2
				y_offset3 += temp*3
				y_offset4 += temp*4
		when 4;	x_offset1 -= temp
				x_offset2 -= temp*2
				x_offset3 -= temp*3
				x_offset4 -= temp*4
		when 6;	x_offset1 += temp
				x_offset2 += temp*2
				x_offset3 += temp*3
				x_offset4 += temp*4
		
	end
	frames = [ 
	[0,direction_offset,1,x_offset1,y_offset1],
	[1,direction_offset,1,x_offset2,y_offset2],
	[2,direction_offset,1,x_offset3,y_offset3],
	[0,direction_offset,1,x_offset1,y_offset1],
	[1,direction_offset,1,x_offset2,y_offset2],
	[2,direction_offset,1,x_offset3,y_offset3],
	[2,direction_offset,1,x_offset4,y_offset4]
	]
	[frames, 0]
end

def animation_effect_roar_dir(temp_dir = 2)
	temp = 16
	x_offset1 = 0
	y_offset1 = 0
	x_offset2 = 0
	y_offset2 = 0
	x_offset3 = 0
	y_offset3 = 0
	x_offset4 = 0
	y_offset4 = 0
	self.direction = temp_dir
	case self.direction
		when 8;	y_offset1 -= 5
				y_offset2 -= temp*2
				y_offset3 -= temp*3
				y_offset4 -= temp*4
		when 2;	y_offset1 += 5
				y_offset2 += temp*2
				y_offset3 += temp*3
				y_offset4 += temp*4
		when 4;	x_offset1 -= 5
				x_offset2 -= temp*2
				x_offset3 -= temp*3
				x_offset4 -= temp*4
		when 6;	x_offset1 += 5
				x_offset2 += temp*2
				x_offset3 += temp*3
				x_offset4 += temp*4
		
	end
	frames = [ 
	[0,direction_offset,2,x_offset1,y_offset1+23],
	[1,direction_offset,2,x_offset2,y_offset2+23],
	[2,direction_offset,2,x_offset3,y_offset3+23],
	[0,direction_offset,2,x_offset1,y_offset1+23],
	[1,direction_offset,2,x_offset2,y_offset2+23],
	[2,direction_offset,2,x_offset3,y_offset3+23],
	[2,direction_offset,2,x_offset4,y_offset4+23]
	]
	[frames, 1]
end

 def animation_effect_slashMH
			#userid=@summon_data[:user]== $game_player ? -1 : @summon_data[:user].id
			if use_chs?
				temp = ($chs_data[@summon_data[:user].chs_type].balloon_height).abs/2
			else
				temp = 16
			end
			x_offset = 0
			y_offset = 0
			self.direction = @summon_data[:user].direction
			case self.direction
				when 8;y_offset -= temp
				when 2;y_offset += temp
				when 4;x_offset -= temp
				when 6;x_offset += temp
			end
			frames = [ 
			[11,0, 2, x_offset, y_offset],
			[cell_x_offset,direction_offset, 2, x_offset, y_offset],
			[11,0, -1, x_offset, y_offset]
			]
		[frames, 0]
	end
	
 def animation_effect_PunchJump
			#userid=@summon_data[:user]== $game_player ? -1 : @summon_data[:user].id
			temp = ($chs_data[@summon_data[:user].chs_type].balloon_height).abs/2
			x_offset = 0
			y_offset = 0-temp
			self.direction = @summon_data[:user].direction
			case self.direction
				when 8;y_offset -= temp
				when 2;y_offset += temp
				when 4;x_offset -= temp
				when 6;x_offset += temp
			end
			frames = [ 
			[11,0, 2, x_offset, y_offset],
			[4,4+direction_offset, 2, x_offset, y_offset],
			[11,0, -1, x_offset, y_offset]
			]
		[frames, 0]
	end
	
 def animation_effect_SlashJump
			#userid=@summon_data[:user]== $game_player ? -1 : @summon_data[:user].id
			temp = ($chs_data[@summon_data[:user].chs_type].balloon_height).abs/2
			x_offset = 0
			y_offset = 0-temp
			self.direction = @summon_data[:user].direction
			case self.direction
				when 8;y_offset -= temp
				when 2;y_offset += temp
				when 4;x_offset -= temp
				when 6;x_offset += temp
			end
			frames = [ 
			[11,0, 2, x_offset, y_offset],
			[3,4+direction_offset, 2, x_offset, y_offset],
			[11,0, -1, x_offset, y_offset]
			]
		[frames, 0]
	end
	
	
	def animation_waste_drop
		x_offset = -18+rand(30)
		y_offset = -8+rand(28)
			frames = [ 
			[cell_x_offset+rand(3), cell_y_offset+rand(4), -1, x_offset, y_offset]
			]
		[frames, 0]
	end
 
	def animation_waste_drop_small
		x_offset = -9+rand(15)
		y_offset = -4+rand(14)
		if self.moving?
			case self.direction
				when 8;y_offset -=20
				when 2;y_offset +=20
				when 4;x_offset -=20
				when 6;x_offset +=20
			end
		end
			frames = [ 
			[cell_x_offset+rand(3), cell_y_offset+rand(4), -1, x_offset, y_offset]
			]
		[frames, 0]
	end
 
  	def animation_cell_loop_lock
		frames = [ 
			[cell_x_offset, cell_y_offset, -1,0,0]
		]
		[frames, -1]
	end
 
  	def animation_item_drop
		x_offset = -8+rand(17)
		y_offset = -12+rand(24)
			frames = [ 
			[cell_x_offset, cell_y_offset, 1, x_offset, y_offset-18],
			[cell_x_offset, cell_y_offset, 1, x_offset, y_offset-20],
			[cell_x_offset, cell_y_offset, 1, x_offset, y_offset-22],
			[cell_x_offset, cell_y_offset, 1, x_offset, y_offset-23],
			[cell_x_offset, cell_y_offset, 1, x_offset, y_offset-24],
			[cell_x_offset, cell_y_offset, 1, x_offset, y_offset-23],
			[cell_x_offset, cell_y_offset, 1, x_offset, y_offset-22],
			[cell_x_offset, cell_y_offset, 1, x_offset, y_offset-20],
			[cell_x_offset, cell_y_offset, 1, x_offset, y_offset-16],
			[cell_x_offset, cell_y_offset, 1, x_offset, y_offset-10],
			[cell_x_offset, cell_y_offset, 1, x_offset, y_offset-3],
			[cell_x_offset, cell_y_offset, 0, x_offset, y_offset]
			]
		[frames, 0]
	end
 
  	def animation_atk_pull_fix #fish fat
		case @direction
			when 4 ; x_offset = 7
			when 6 ; x_offset = -7
		end
		y_offset = -32
			frames = [ 
			[cell_x_offset, cell_y_offset, 0, x_offset, y_offset]
			]
		[frames, 0]
	end
	
 
  	def animation_atk_AbomPull_fix #fish fat
		case @direction
			when 4 ; x_offset = 3
			when 6 ; x_offset = -3
		end
		y_offset = -16
			frames = [ 
			[cell_x_offset, cell_y_offset, 0, x_offset, y_offset]
			]
		[frames, 0]
	end
	
	
  	def animation_blood_jump
		x_offset = -8+rand(17)
		y_offset = -12+rand(24)
		cell_controlX =cell_x_offset+rand(3)
		cell_controlY =cell_y_offset+rand(4)
			frames = [ 
			[cell_controlX, cell_controlY, 1, x_offset, y_offset-18],
			[cell_controlX, cell_controlY, 1, x_offset, y_offset-20],
			[cell_controlX, cell_controlY, 1, x_offset, y_offset-22],
			[cell_controlX, cell_controlY, 1, x_offset, y_offset-23],
			[cell_controlX, cell_controlY, 1, x_offset, y_offset-24],
			[cell_controlX, cell_controlY, 1, x_offset, y_offset-23],
			[cell_controlX, cell_controlY, 1, x_offset, y_offset-22],
			[cell_controlX, cell_controlY, 1, x_offset, y_offset-20],
			[cell_controlX, cell_controlY, 1, x_offset, y_offset-16],
			[cell_controlX, cell_controlY, 1, x_offset, y_offset-10],
			[cell_controlX, cell_controlY, 1, x_offset, y_offset-3],
			[cell_controlX, cell_controlY, 0, x_offset, y_offset]
			]
		[frames, 0]
	end
	
	def animation_mc_pick_up
	x =4
	y =4+direction_offset
			frames = [ 
			[x, y, 10]
			]
		[frames, 0]
	end
	
	def animation_mc_pick_up_hold
		x =4
		y =4+direction_offset
		frames = (0..20).collect { |i| [x, y, 1 + i / 2,0, i % 2] }
		[frames, -1]
	end
	
	def aniCustom(tmpData,tmpMode)
		frames = tmpData
		[frames, tmpMode]
	end
 ###########33 非通用動畫區 ###########################ˇ##############ˇ##############ˇ##############ˇ##############ˇ
 ###########33 非通用動畫區 ###########################ˇ##############ˇ##############ˇ##############ˇ##############ˇ
 ###########33 非通用動畫區 ###########################ˇ##############ˇ##############ˇ##############ˇ##############ˇ
 ###########33 非通用動畫區 ###########################ˇ##############ˇ##############ˇ##############ˇ##############ˇ
 

	def animation_launch_CompMusketeer_Sneak
		tmpFrame = animation_casting_musket
		x = 8
		y = 0+direction_offset
		tmpFrame[0].each{|asdasd|
			asdasd[0]=x
			asdasd[1]=y
		}
		tmpFrame
	end
	def animation_hold_CompMusketeer_Sneak
		tmpFrame = animation_hold_casting_mh
		x = 8
		y = 0+direction_offset
		tmpFrame[0].each{|asdasd|
			asdasd[0]=x
			asdasd[1]=y
		}
		tmpFrame
	end
	def animation_ClapSlow
		spd = 10+rand(6)
		x = 1
		y0 = 0 + direction_offset
		y1 = 4 + direction_offset
		frames = [ 
		[x , y0, spd],
		[x , y1, spd],
		[x , y0, spd],
		[x , y1, spd],
		[x , y0, spd],
		[x , y1, spd],
		[x , y0, spd],
		[x , y1, spd]
		]
		[frames, 0]
	end
	
	def animation_ClapFast
		spd = 4+rand(3)
		x = 1
		y0 = 0 + direction_offset
		y1 = 4 + direction_offset
		frames = [ 
		[x , y0, spd],
		[x , y1, spd],
		[x , y0, spd],
		[x , y1, spd],
		[x , y0, spd],
		[x , y1, spd],
		[x , y0, spd],
		[x , y1, spd],
		[x , y0, spd],
		[x , y1, spd]
		]
		[frames, 0]
	end
 
 
 def animation_CBTatkEFX
	@opacity = 200
			frames = [ 
			[11,0, 6, 0, 0],
			[7,7, 1, 0, 128],
			[7,7, 1, 0, 64],
			[7,7, 1, 0, 0],
			[7,7, 1, 0, -64],
			[11,0, -1, 0, 0]
			]
		[frames, 0]
end


	def animation_atk_DualAR #all
		x = 1
		y = 4 + direction_offset
		frames = [ 
		[x  , y-4, 3],
		[x  , y, 3],
		[x-1, y, 3,-1],
		[x+1, y, 3, 1],
		[x-1, y, 3,-1],
		[x+1, y, 3, 1],
		[x-1, y, 3,-1],
		[x+1, y, 3, 1],
		[x-1, y, 3,-1],
		[x+1, y, 3, 1],
		[x-1, y, 3,-1],
		[x+1, y, 3, 1],
		[x-1, y, 3,-1],
		[x+1, y, 3, 1],
		[x-1, y, 3,-1],
		[x+1, y, 3, 1]
		]
		[frames, 0]
	end
 
 
 def animation_AbominationTentacle_surprised
	
    x = 0
    y = 0
    frames = [ 
      [x  , y, 8],
      [x+1, y, 8],
      [x+2, y, 8],
      [12, 12, -1]
    ]
    [frames, 1]
 end
 
	def animation_Undead_surprised
		
		x = 0
		y = 7
		frames = [ 
		[x  , y, 8],
		[x+1, y, 8],
		[x+2, y, 8],
		[12, 12, -1]
		]
		[frames, 1]
	end

	def animation_AbomSpiderDown_surprised
		x = 6
		y = 4
		frames = [ 
		[x , y, 4, 0 , -72],
		[x , y, 4, 0 , -64],
		[x , y, 4, 0 , -48],
		[x , y, 4, 0 , -32],
		[x , y, 4, 0 , -16],
		[12 , 12, 60, 0 , -16]
		]
		[frames, 0]
	end
	
	def animation_AbomSpiderUp_surprised
		x = 6
		y = 4
		frames = [ 
		[x , y, 4, 0 , -16],
		[x , y, 4, 0 , -32],
		[x , y, 4, 0 , -48],
		[x , y, 4, 0 , -64],
		[x , y, 4, 0 , -72],
		[12 , 12, 60, 0 , -72]
		]
		[frames, 0]
	end
	
	def animation_AbomSpiderWeb
		frames = [ 
		[3+rand(3),7,-1]
		]
		[frames, -1]
	end

	def animation_ground_spore
		frames = [ 
		[6,6,20,0,1],
		[7,6,5,0, 1],
		[8,6,5,0, 1]
		]
		[frames, -1]
	end
  
	#def animation_MConOvermap
	#x =1
	#y =0
	#		frames = [ 
	#		[x, y, 0,0,+22]
	#		]
	#	[frames, -1]
	#end

  
  def animation_seedbed_breed
cell_controlX = cell_x_offset
cell_controlY = cell_y_offset
	frames = [ 
	[0,cell_controlY, 3,0,-3],
	[0+1, cell_controlY, 3,0,-2],
	[0+2, cell_controlY, 3,0,1],
	[0, cell_controlY, 3,0,0]
	]
    [frames, 1]
end
  
	def animation_pain_shockXfast#看起來像發抖 未採用
		cell_controlX = cell_x_offset
		cell_controlY =cell_y_offset
		frames = (0..20).collect { |i| [cell_controlX, cell_controlY, 3 + i / 2, i % 2] }
		[frames, -1]
	end
	
	def animation_seedbed_shockYslow #嬤嬤用
		cell_controlX = cell_x_offset
		cell_controlY =cell_y_offset
		frames = (0..20).collect { |i| [cell_controlX, cell_controlY, 1 + i / 2,0, i % 2] }
		[frames, -1]
	end
	
  
  def h_demo_animation
    frames = [
      [0, 2, 10],
      [1, 2, 5],
      [2, 2, 15],
      [1, 2, 3]
    ]
    [frames, -1]
  end

  def dog_demo_0_animation
    [[[4, 0, 0, 0, 14]], 0]
  end

  def dog_demo_1_animation
    f1 = [3, 0, 6, 0, 14]
    f2 = [4, 0, 6, 0, 14]
    f3 = [5, 0, 6, 0, 14]
    frames = [f2, f1, f2, f3, f2, f1, f2, f3, f2]
    [frames, -1]
  end

  def dog_demo_2_animation
    f1 = [3, 1, 3, 0, 14]
    f2 = [4, 1, 0, 0, 14]
    f3 = [5, 1, 6, 0, 14]
    frames = [f1, f3, f1, f3, f1, f3, f2]
    [frames, 0]
  end

	def animation_no_chs_fucker #useless
		case @direction
			when 6 ;	x_offset0 = 15
						y_offset0 = 0
						x_offset1 = 16
						y_offset1 = 0
						x_offset2 = 17
						y_offset2 = 0
						x_offset3 = 20
						y_offset3 = 0
			when 4 ;	x_offset0 = -15
						y_offset0 = 0
						x_offset1 = -16
						y_offset1 = 0
						x_offset2 = -17
						y_offset2 = 0
						x_offset3 = -20
						y_offset3 = 0
			when 2 ;	x_offset0 = 0
						y_offset0 = 15
						x_offset1 = 0
						y_offset1 = 16
						x_offset2 = 0
						y_offset2 = 17
						x_offset3 = 0
						y_offset3 = 20
			when 8 ;	x_offset0 = 0
						y_offset0 = -15
						x_offset1 = 0
						y_offset1 = -16
						x_offset2 = 0
						y_offset2 = -17
						x_offset3 = 0
						y_offset3 = -20
			else
			x_offset0 = 0
			y_offset0 = 0
			x_offset1 = 0
			y_offset1 = 0
			x_offset2 = 0
			y_offset2 = 0
			x_offset3 = 0
			y_offset3 = 0
		end
		
		x = 3
		y = 0 + direction_offset
		frames = [ 
			[x, y, 7,  x_offset0, y_offset0],
			[x, y, 4,  x_offset1, y_offset1],
			[x, y, 2,  x_offset2, y_offset2],
			[x, y, 6,  x_offset3, y_offset3]
			]
		[frames, -1]
	end
	
	 
 
########################################################## FishFistMaster


	def animation_FishFistMasterLP
		case direction
			when 2 ;    x_offset0 = 0
						y_offset0 = 8
						x_offset1 = 0
						y_offset1 = 4
						x_offset2 = 0
						y_offset2 = 2
			when 4 ;    x_offset0 = -8
						y_offset0 = 0
						x_offset1 = -4
						y_offset1 = 0
						x_offset2 = -2
						y_offset2 = 0
			when 6 ;    x_offset0 = 8
						y_offset0 = 0
						x_offset1 = 4
						y_offset1 = 0
						x_offset2 = 2
						y_offset2 = 0
			when 8 ;    x_offset0 = 0
						y_offset0 = -8
						x_offset1 = 0
						y_offset1 = -4
						x_offset2 = 0
						y_offset2 = -2
		end
		x = 6
		y = 0 + direction_offset
			frames = [ 
				[5  , y, 2, 0, 0],
				[4  , y, 2, 0, 0],
				[x+1, y+4, 2, x_offset2, y_offset2],
				[x+2, y+4, 5,  x_offset1, y_offset1],
				[x+0, y+4, 30, x_offset0, y_offset0],
				[x+1, y+4, 2,  x_offset1, y_offset1],
				[x+1, y+4, 2,  x_offset2, y_offset2],
				[x+1, y+4, 2,  0, 0],
			]
		[frames, 0]
	end

	def animation_FishFistMasterRP
		case direction
			when 2 ;    x_offset0 = 0
						y_offset0 = 8
						x_offset1 = 0
						y_offset1 = 4
						x_offset2 = 0
						y_offset2 = 2
			when 4 ;    x_offset0 = -8
						y_offset0 = 0
						x_offset1 = -4
						y_offset1 = 0
						x_offset2 = -2
						y_offset2 = 0
			when 6 ;    x_offset0 = 8
						y_offset0 = 0
						x_offset1 = 4
						y_offset1 = 0
						x_offset2 = 2
						y_offset2 = 0
			when 8 ;    x_offset0 = 0
						y_offset0 = -8
						x_offset1 = 0
						y_offset1 = -4
						x_offset2 = 0
						y_offset2 = -2
		end
		x = 6
		y = 0 + direction_offset
			frames = [ 
				[5  , y, 2, 0, 0],
				[4  , y, 2, 0, 0],
				[1  , y, 2, x_offset2, y_offset2],
				[x+1, y+4, 5,  x_offset1, y_offset1],
				[x+2, y+4, 30, x_offset0, y_offset0],
				[x+1, y+4, 2,  x_offset1, y_offset1],
				[x+1, y+4, 2,  x_offset2, y_offset2],
				[x+1, y+4, 2,  0, 0],
			]
		[frames, 0]
	end
	def animation_FishFistMasterUppercut
		case direction
			when 2 ;    tmpKY1 = 4
						tmpKY2 = 5
						tmpKY3 = 7
						tmpKY4 = 6
			when 4 ;    tmpKY1 = 5
						tmpKY2 = 7
						tmpKY3 = 6
						tmpKY4 = 4
			when 6 ;    tmpKY1 = 6
						tmpKY2 = 4
						tmpKY3 = 5
						tmpKY4 = 7
			when 8 ;    tmpKY1 = 7
						tmpKY2 = 6
						tmpKY3 = 4
						tmpKY4 = 5
		end
		y=direction_offset
		tmpRoll = [true,false].sample
			frames = [ 
				[0  , y+4,		1, 0, 1],
				[7  , y+4,		2, 0, 2],
				[4  , y+4,		3, 0, 3],
				[5  , y+4,		5, 0, -1],
				[4  , tmpKY1,	8, 0, -2],
				[4  , tmpKY2,	4, 0, -6],
				[4  , tmpKY3,	4, 0, -7],
				[4  , tmpKY4,	4, 0, -3],
				[4  , tmpKY1,	3, 0, -2],
				#[4  , y+4,	5, 0, -2],
				#[4  , y+4,	6, 0, -6],
				#[4  , y+4,	5, 0, -7],
				#[4  , y+4,	4, 0, -3],
				#[4  , y+4,	3, 0, -2],
				[5  , y+4,		5, 0, -1],
				[4  , y+4,		3, 0, 3],
				[7  , y+4,		2, 0, 2],
				[0  , y+4,		1, 0, 1]
			]
		[frames, 0]
	end
	
	def animation_FishFistMasterLK
		tmpKY1=0
		tmpKY2=0
		tmpKY3=0
		tmpKY4=0
		tmpKY5=0
		tmpKX1=0
		tmpKX2=0
		tmpKX3=0
		tmpKX4=0
		tmpKX5=0
		case direction
			when 2 ;    tmpKY1 = 1
						tmpKY2 = 2
						tmpKY3 = 3
						tmpKY4 = 4
						tmpKY5 = 5
			when 4 ;    tmpKX1 = -1
						tmpKX2 = -2
						tmpKX3 = -3
						tmpKX4 = -4
						tmpKX5 = -5
			when 6 ;    tmpKX1 = 1
						tmpKX2 = 2
						tmpKX3 = 3
						tmpKX4 = 4
						tmpKX5 = 5
			when 8 ;    tmpKY1 = -1
						tmpKY2 = -2
						tmpKY3 = -3
						tmpKY4 = -4
						tmpKY5 = -5
		end
		x = 6
		y = 0 + direction_offset
			frames = [ 
				[7  , y+4,		2,  tmpKX1, tmpKY1],
				[7  , y+4,		2,  tmpKX2, tmpKY2],
				[0  , y+4,		2,  tmpKX3, tmpKY3],
				[0  , y+4,		2,  tmpKX4, tmpKY4],
				[5  , y+4,		3,  tmpKX5, tmpKY5],
				[1  , y+4,		2, tmpKX5+tmpKX2, tmpKY5+tmpKY2],
				[1  , y+4,		28, tmpKX5+tmpKY4, tmpKY5+tmpKY4],
				[0  , y+4,		2,  tmpKY5, tmpKY5],
				[7  , y+4,		2,  tmpKX3, tmpKY3],
				[7  , y+4,		2,  tmpKX1, tmpKY1]
			]
		[frames, 0]
	end
	def animation_FishFistMasterWhirlwindKick
		case direction
			when 2 ;    tmpKY1 = 4
						tmpKY2 = 5
						tmpKY3 = 7
						tmpKY4 = 6
			when 4 ;    tmpKY1 = 5
						tmpKY2 = 7
						tmpKY3 = 6
						tmpKY4 = 4
			when 6 ;    tmpKY1 = 6
						tmpKY2 = 4
						tmpKY3 = 5
						tmpKY4 = 7
			when 8 ;    tmpKY1 = 7
						tmpKY2 = 6
						tmpKY3 = 5
						tmpKY4 = 5
		end
		y=direction_offset
		tmpRoll = [true,false].sample
			frames = [ 
				[0  , y+4,		1, 0, -1],
				[1  , y+4,		2, 0, -3],
				[7  , y+4,		2, 0, -4],
				[3  , tmpKY1,	2, 0, -10-5],
				[3  , tmpKY2,	2, 0, -10-6],
				[3  , tmpKY3,	2, 0, -10-7],
				[3  , tmpKY4,	2, 0, -10-8],
				[3  , tmpKY1,	2, 0, -10-8],
				[3  , tmpKY2,	2, 0, -10-7],
				[3  , tmpKY3,	2, 0, -10-6],
				[3  , tmpKY4,	2, 0, -10-5],
				
				[3  , tmpKY1,	2, 0, -10-5],
				[3  , tmpKY2,	2, 0, -10-6],
				[3  , tmpKY3,	2, 0, -10-7],
				[3  , tmpKY4,	2, 0, -10-8],
				[3  , tmpKY1,	2, 0, -10-8],
				[3  , tmpKY2,	2, 0, -10-7],
				[3  , tmpKY3,	2, 0, -10-6],
				[3  , tmpKY4,	2, 0, -10-5],
				[7  , y+4,		5, 0, -10-1],
				[1  , y+4,		3, 0, -2],
				[0  , y+4,		-1, 0, 0]
			]
		[frames, 0]
	end
	def animation_FishFistMasterTatsumaki_hold
		tmpKY1=0
		tmpKY2=0
		tmpKY3=0
		tmpKY4=0
		tmpKY5=0
		tmpKX1=0
		tmpKX2=0
		tmpKX3=0
		tmpKX4=0
		tmpKX5=0
		case direction
			when 2 ;    tmpKY1 = 1
						tmpKY2 = 2
						tmpKY3 = 3
						tmpKY4 = 4
						tmpKY5 = 5
			when 4 ;    tmpKX1 = -1
						tmpKX2 = -2
						tmpKX3 = -3
						tmpKX4 = -4
						tmpKX5 = -5
			when 6 ;    tmpKX1 = 1
						tmpKX2 = 2
						tmpKX3 = 3
						tmpKX4 = 4
						tmpKX5 = 5
			when 8 ;    tmpKY1 = -1
						tmpKY2 = -2
						tmpKY3 = -3
						tmpKY4 = -4
						tmpKY5 = -5
		end
		y=direction_offset
					frames = [ 
						[7  , y+4,		2,  tmpKX1, 0],
						[7  , y+4,		2,  tmpKX2, 0],
						[0  , y+4,		2,  tmpKX3, -1],
						[0  , y+4,		2,  tmpKX4, -2],
						[5  , y+4,		4, tmpKX5, -3],
						[1  , y+4,		4, 	tmpKX5+tmpKX2, -8],
						[7  , y+4,		-1,  tmpKX1, -14]
					]		
		[frames, -1]
	end
	def animation_FishFistMasterTatsumaki_end
		tmpKY1=0
		tmpKY2=0
		tmpKY3=0
		tmpKY4=0
		tmpKY5=0
		tmpKX1=0
		tmpKX2=0
		tmpKX3=0
		tmpKX4=0
		tmpKX5=0
		case direction
			when 2 ;    tmpKY1 = 1
						tmpKY2 = 2
						tmpKY3 = 3
						tmpKY4 = 4
						tmpKY5 = 5
			when 4 ;    tmpKX1 = -1
						tmpKX2 = -2
						tmpKX3 = -3
						tmpKX4 = -4
						tmpKX5 = -5
			when 6 ;    tmpKX1 = 1
						tmpKX2 = 2
						tmpKX3 = 3
						tmpKX4 = 4
						tmpKX5 = 5
			when 8 ;    tmpKY1 = -1
						tmpKY2 = -2
						tmpKY3 = -3
						tmpKY4 = -4
						tmpKY5 = -5
		end
		y=direction_offset
					frames = [ 
						[1  , y+4,		4, tmpKX5+tmpKY4, -8],
						[0  , y+4,		8,  tmpKY5, -4],
						[7  , y+4,		10,  tmpKX3, -2],
						[7  , y+4,		10,  tmpKX1, 0]
					]		
		[frames, 0]
	end
	def animation_FishFistMasterTatsumaki_atkHold
					frames = [ 
						[3  , 4,		2, 	0,-16],
						[3  , 5,		2, 	0,-16],
						[3  , 7,		2, 	0,-16],
						[3  , 6,		2, 	0,-16]
					]		
					[frames, -1]
	end
	def animation_FishFistMasterTatsumakiSingle
					frames = [ 
						[3  , 4,		2, 	0,-16],
						[3  , 5,		2, 	0,-16],
						[3  , 7,		2, 	0,-16],
						[3  , 6,		2, 	0,-16]
					]		
					frames += animation_FishFistMasterTatsumaki_end[0]
					[frames, 0]
	end
	
	def animation_FishFistMasterShadowDashHold
		x = 5
		y = 4 + direction_offset
		frames = [ 
			[x  , y, 3,0],
			[x  , y, 3,-1]
		]
		[frames, -1]
	end
	def animation_FishFistMasterShadowPrepairHold
		x = 6
		y = 0 + direction_offset
		frames = [ 
			[x  , y, 3,0],
			[x  , y, 3,-1]
		]
		[frames, -1]
	end
	def animation_FishFistMasterShadowDashEnd
		x = 0
		y = 4 + direction_offset
		frames = [ 
			[x  , y, 3,0]
		]
		[frames, 0]
	end
	def animation_FishFistMasterComboEnd
		x1 = 6
		y1 = 0 + direction_offset
		x2 = 0
		y2 = 4 + direction_offset
		frames = [ 
			[x2  , y2, 10,0],
			[x1  , y1, -1,0]
		]
		[frames, 0]
	end
	
end


