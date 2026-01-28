#==============================================================================
# +++ MOG - Character EX (v1.2) +++
#==============================================================================
# By Moghunter 
# https://atelierrgss.wordpress.com/
#==============================================================================
# Adiciona vários efeitos visuais animados nos characters.
#==============================================================================

#==============================================================================
# ■ AUTO MODE (Animated Effects)
#==============================================================================
# Os efeitos começam automaticamente, coloque no evento os sequintes
# comentários para ativar os efeitos.
#
# <Effects = EFFECT_TYPE> 
#
# EX
#
# <Effects = Breath>
# <Effects = Ghost>
# <Effects = Clear>   
#
#  <--- EFFECT_TYPE --->
# 
# ●   Breath 
# Ativa o efeito de respiração. (LOOP EFFECT)
#
# ●   Big Breath
# Ativa o efeito de loop de zoom in e out. (LOOP EFFECT)
#
# ●   Ghost
# Ativa o efeito de desaparecer e aparecer. (LOOP EFFECT)
#
# ●   Swing
# Ativa o efeito do character balançar para os lados.
#
# ●   Swing Loop
# Ativa o efeito do character balançar para os lados. (LOOP EFFECT)
#
# ●  Spin
# Faz o character girar em 360 graus
#
# ●  Spin Loop 
# Faz o character girar em 360 graus. (LOOP EFFECT)
#
# ●  Slime Breath
# Ativa o efeito de movimento semelhante ao de um slime. (LOOP EFFECT)
#
# ●  Crazy
# 
# Faz o character virar para esquerda e direita rapidamente. (LOOP EFFECT)
#
# ●  Appear
# Ativa o efeito de aparição.
#
# ●  Disappear
# Ativa o efeito de desaparecer.
#
# ●  Dwarf
# Deixa o character anão.
#
# ●  Giant
# Deixa o character gigante.
#
# ●  Normal
# Faz o character voltar ao normal de forma gradual.
#
# ●  Clear
# Cancela todos os efeitos.
#
#==============================================================================

#==============================================================================
# ■ MANUAL MODE (Animated Effects)
#==============================================================================
# Use o código abaixo através do comando chamar script. 
#
# char_effect(EVENT_ID, EFFECT_TYPE)
#
# EX -    char_effect( 10,"Breath")
#         char_effect( 0, "Dwarf")     
#
# ● EVENT_ID
# - Maior que 0 para definir as IDs dos eventos no mapa.
# - Iguál a 0 para ativar os efeitos no personagem principal (Leader).
# - Menor que 0 para definir as IDs dos sequidores.
#
# ● EFFECT_TYPE
# - Use os mesmos nomes dos efeitos da ativação automática.
# 
#==============================================================================

#==============================================================================
# ■ EXTRA EFFECTS (Fix Values)
#==============================================================================
#
# ●     <Zoom = X> 
#   
# ●     <Opacity = X> 
#
# ●     <Blend Type = X>   
#    
# ●     <Mirror = X>   
#
#==============================================================================

#==============================================================================
# ■ CANCEL EFFECTS        (Loop Effects)
#==============================================================================
#
# ●     char_effect(EVENT_ID, "Clear")
# EX -  char_effect(15, "Clear") 
#
# Para cancelar um evento(Personagem) especifico.
#
# ●     clear_all_events_effects
# Para cancelar todos os efeitos dos eventos no mapa.
#
# ●     clear_all_party_effects     
# Para cancelar todos os efeitos do grupo(Personagem).
#
# ●     clear_all_ex_effects
# Para cancelar tudo.
#
#==============================================================================


#==============================================================================
# ● Histórico (Version History)
#==============================================================================
# v 1.2 - Adição dos comandos para definir valores fixos nos characters.
# v 1.1 - Correção na definição da ID dos personagens aliados.
#==============================================================================

#==============================================================================
# ■ Game_CharacterBase
#==============================================================================
class Game_CharacterBase
  
  attr_accessor :effects
  attr_accessor :opacity
  attr_accessor :erased
  attr_accessor :zoom_x
  attr_accessor :zoom_y
  attr_accessor :mirror
  attr_accessor :angle
  attr_accessor :blend_type
  attr_accessor :effect
  
  #--------------------------------------------------------------------------
  # ● initialize
  #--------------------------------------------------------------------------  
  #--------------------------------------------------------------------------
  # ● Clear Effects
  #--------------------------------------------------------------------------      
  def clear_effects
      @effects = ["",0,false]
      @zoom_x = 1.00
      @zoom_y = 1.00
      @mirror = false
      @angle = 0
      @opacity = 255
      @blend_type = 0
  end  
  
  #--------------------------------------------------------------------------
  # ● Update Character EX Effects
  #--------------------------------------------------------------------------      
  def update_character_ex_effects
      return if @erased or @effects[0] == ""
      check_new_effect if @effects[2]
      case @effects[0] 
			when "Breath";      	update_breath_effect
			when "pepeMoving";     	update_pepeMoving_effect
			when "Ghost";       	update_ghost_effect
			when "Big Breath";  	update_big_breath_effect
			when "Slime Breath";	update_slime_breath_effect
			when "Spin Loop";   	update_spin_loop_effect
			when "Swing Loop";  	update_swing_loop_effect
			when "Crazy";       	update_crazy_effect
			when "Appear";      	update_appear_effect
			when "Disappear";   	update_disappear_effect
			when "Swing";       	update_swing_effect
			when "Spin";        	update_spin_effect
			when "Dwarf";       	update_dwarf_effect
			when "Giant";       	update_giant_effect
			when "Normal";      	update_normal_effect
			when "TentaclePull";  	update_tentaclePull_effect
			when "TentaclePullSM";  	update_tentaclePullSM_effect
			when "Nova";   	   		update_nova_effect
			when "FireZoomIn";    	update_FireZoomIn_effect
			when "XYzoomIn";    	update_XYzoomIn_effect
			when "XYzoomOut";    	update_XYzoomOut_effect
			when "ThrowRotate";   	update_ThrowRotate_effect
			when "BreathSingle";      update_BreathSingle_effect
			when "CutTree";      	update_CutTree_effect
			when "CutTreeSM";      	update_CutTreeSM_effect
			when "CutTreeFall";    	update_CutTreeFall_effect
			#when "StoneCollapse";  	update_StoneCollapse_effect
			when "CutTreeFallFast";	update_CutTreeFallFast_effect
			when "SeaWaveA";      	update_SeaWaveUP_effect
			when "SeaWaveB";      	update_SeaWaveUP_effect
			when "TeslaFadeIn";   	update_TeslaFadeIn_effect
			when "FadeOutDelete";   update_FadeOutDelete_effect
			when "FadeOutDeleteCosshair";   update_FadeOutDeleteCosshair_effect
			when "ZoomOutDelete";   update_ZoomOutDelete_effect
			when "ZoomOutDeleteFast";   update_ZoomOutDeleteFast_effect
			when "ZoomOutFadeOff";   update_ZoomOutFadeOff_effect
			when "ZoomInFadeOff";   update_ZoomInFadeOff_effect
			when "FadeIn";  		 update_FadeIn_effect
			when "FadeOff";  		 update_FadeOff_effect
			when "SkillWaveBanner";   update_SkillWaveBanner_effect
			when "ShieldBubble";   	update_ShieldBubble_effect
			when "float";   update_float_effect
      end
  end
  #--------------------------------------------------------------------------
  # ● Check New Effect  [2] =若不想重啟 則2為false
  #--------------------------------------------------------------------------        
  def check_new_effect
		@effects[2] = false
		@effects[1] = 0
		unless @effects[0] == "Normal" 
				@opacity = 255
				@angle = 0
				@mirror = false
				unless (@effects[0] == "Dwarf" or @effects[0] == "Giant") 
					@zoom_x = 1.00
					@zoom_y = 1.00
				end
		end
	case @effects[0] 
			when "Breath"
				@effects[1] = rand(60)
			when "Appear"
					@zoom_x = 0.1
					@zoom_y = 3.5
					@opacity = 0
			when "Ghost"
				@opacity = rand(255)
			when "Swing Loop"
				@angle = 20
				@effects[1] = rand(60)
			when "Spin Loop"
				@angle = rand(360)
			when "Slime Breath"
				@effects[1] = rand(60)
			when "Big Breath"
				@effects[1] = rand(60)
			when "Normal"
				pre_angle = 360 * (@angle / 360).truncate
				@angle = @angle - pre_angle
				@angle = 0 if @angle < 0
			when "TentaclePull"
				@effects[1] = 0
				@zoom_x = 1
				@zoom_y = 0.1
				#@real_y -= 0.5
				case @direction
					when 8;	@angle = 0+5		#up
					when 4;	@angle = 90+5		#left
					when 2;	@angle = 180+5		#down
					when 6;	@angle = 270+5		#right
				end
			when "TentaclePullSM"
				@effects[1] = 0
				@effects[3] = 0.10 if !@effects[3]
				@effects[4] = 0.01 if !@effects[4]
				@zoom_x = 1
				@zoom_y = 0.1
				#@real_y -= 0.5
				case @direction
					when 8;	@angle = 0+5		#up
					when 4;	@angle = 90+5		#left
					when 2;	@angle = 180+5		#down
					when 6;	@angle = 270+5		#right
				end
			when "Nova"
				@zoom_x = 1
				@zoom_y = 1
				@opacity = 255
				case @direction
					when 8;	@angle = 0+8		#up
					when 4;	@angle = 90+8		#left
					when 2;	@angle = 180+8		#down
					when 6;	@angle = 270+8		#right
				end
			when "SeaWaveA"
				@zoom_x = 3
				@mirror = true
				@zoom_y = 1
				@opacity = 255
				@effects[1] = 0
				
			when "SeaWaveB"
				@zoom_x = 3
				@zoom_y = 1
				@opacity = 0
				@effects[1] = 130
			when "BreathSingle"
				@effects[1] = 0
				@effects[3] = @zoom_x
				@effects[4] = @zoom_y
			when "CutTree","CutTreeSM"
				@angle = 0
				@effects[1] = 0
			
			when "CutTreeFall","CutTreeFallFast"
				@angle = 0
				@effects[1] = 0
				
			when "FireZoomIn"
				@zoom_y = 0.2
			when "XYzoomIn"
				@zoom_x = 0.1
				@zoom_y = 0.1
			when "XYzoomOut"
			when "ThrowRotate"
				@angle = 0
			when "TeslaFadeIn"
				#@effects=["TeslaFadeIn",[0,@forced_y,@eleTop,@pattern,0]]
				@effects[1][2] = 32 if @effects[1][2]
				@effects[1][3] = 0  if @effects[1][3]
				@opacity = 0
				@effects[1][0] = 0
				@effects[1][4] = 0
			when "SkillWaveBanner"
				@effects[1] = 0
				@forced_z = 3
				@angle = 60
			when "float"
				@effects[1] = 0
			when "ShieldBubble"
				@effects[1][0] = 0
				@effects[1][1] = @zoom_x
				@effects[1][2] = @zoom_y
				@effects[1][3] = true
				@effects[1][4] = true
				#@forced_z = 1
				#@blend_type =1
				@opacity = 0
				@zoom_x = 0
				@zoom_y = 0
			#when "ZoomOutDelete"
			#	@effects[1] = 0.02 if @effects[1] < 0.02
			#when "ZoomOutDeleteFast"
			#	@effects[1] = 0.1 if @effects[1] < 0.1
		end
	end
  
  #--------------------------------------------------------------------------
  # ● Check New Effect
  #--------------------------------------------------------------------------          
  
	def update_ShieldBubble_effect
		if @opacity <= 180
			@opacity += 9
			#@effects[1][3] = @opacity >= 180
		end
		if @zoom_x <= @effects[1][1] || @zoom_x <= @effects[1][2]
			@zoom_x += 0.1 if @zoom_x <= @effects[1][1]
			@zoom_y += 0.1 if @zoom_y <= @effects[1][2]
			#@effects[1][4] = @zoom_x >= @effects[1][1]
		end
		if @zoom_x >= @effects[1][1] && @opacity >= 180
			#@effect[1][3] = true if @effect[1][3].nil?
			#@effect[1][4] = true if @effect[1][4].nil?
			if @effects[1][3]
				@zoom_x += 0.01 if @zoom_x < @effects[1][1]+0.05
				@effects[1][3] = false if @zoom_x >= @effects[1][1]+0.05
			else
				@zoom_x -= 0.01 if @zoom_x > @effects[1][1]
				@effects[1][3] = true if @zoom_x <= @effects[1][1]+0.01
			end
			if @effects[1][4]
				@zoom_y -= 0.01 if @zoom_y > @effects[1][2]
				@effects[1][4] = false if @zoom_y <= @effects[1][2]+0.01
			else
				@zoom_y += 0.01 if @zoom_y < @effects[1][2]+0.05
				@effects[1][4] = true if @zoom_y >= @effects[1][2]+0.05
			end
			
			
			#if @zoom_x < @effects[1][1]+0.1
			#	@zoom_x += 0.01
			#elsif @zoom_x > @effects[1][1]
			#	@zoom_x -= 0.01
			#end
			#if @zoom_y > @effects[1][2] && @zoom_y < @effects[1][2]+0.1
			#	@zoom_y += 0.01
			#elsif @zoom_y < @effects[1][2]+0.1
			#	@zoom_y += 0.01
			#end
		end
	end
	def update_float_effect
		@effects[1] += 1
		case @effects[1]
			when  0..8  ; @forced_y +=1 if @effects[1] == 8 
			when  9..16 ; @forced_y +=1 if @effects[1] == 16
			when 17..24 ; @forced_y +=1 if @effects[1] == 24
			when 25..32 ; @forced_y +=1 if @effects[1] == 32
			when 33..40 ; @forced_y -=1 if @effects[1] == 40
			when 41..48 ; @forced_y -=1 if @effects[1] == 48
			when 49..56 ; @forced_y -=1 if @effects[1] == 56
			when 57..64 ; @forced_y -=1 if @effects[1] == 64
			else ;@effects[1] = 0
		end
	end
	def update_breath_effect
		@effects[1] += 1
		case @effects[1]
			when 0..25
			@zoom_y += 0.005
			if @zoom_y > 1.12
				@zoom_y = 1.12
				@effects[1] = 26
			end  
			when 26..50
			@zoom_y -= 0.005
			if @zoom_y < 1.0 
				@zoom_y = 1.0
				@effects[1] = 51
			end           
			else
			@zoom_x = 1
			@zoom_y = 1
			@effects[1] = 0 
		end
	end
	def update_pepeMoving_effect
		if !moving?
			@effects[1] = 0
			@angle = 0
			@forced_y = 0
			return
		end
		@effects[1] += 1
		case @effects[1]
			when 0..6
			@forced_y -= 1
			when 7..12
			@forced_y += 1
		else
			@forced_y = 0
			@effects[1] = 0
		end
	end
  
  #--------------------------------------------------------------------------
  # ● Update Ghost Effect
  #--------------------------------------------------------------------------            
  def update_ghost_effect
      @effects[1] += 1
      case @effects[1]
         when 0..55
             @opacity += 5
             @effects[1] = 56 if @opacity >= 255
         when 56..120
             @opacity -= 5
             @effects[1] = 121 if @opacity <= 0
         else
            @opacity = 0
            @effects[1] = 0
      end 
  end  

  #--------------------------------------------------------------------------
  # ● Update Swing Loop Effect
  #--------------------------------------------------------------------------              
  def update_swing_loop_effect
      @effects[1] += 1
      case @effects[1]
         when 0..40
            @angle -= 1
            if @angle < -19
               @angle = -19
               @effects[1] = 41
            end  
         when 41..80 
            @angle += 1
            if @angle > 19
               @angle = 19
               @effects[1] = 81
            end   
         else
            @angle = 20
            @effects[1] = 0
       end
  end  

  #--------------------------------------------------------------------------
  # ● Update Swing Effect
  #--------------------------------------------------------------------------              
  def update_swing_effect
      @effects[1] += 1
      case @effects[1]
         when 0..20
            @angle -= 1
         when 21..60 
            @angle += 1 
         when 61..80  
            @angle -= 1
         else
            clear_effects
      end     
  end  
    
  #--------------------------------------------------------------------------
  # ● Update Spin Loop Effect
  #--------------------------------------------------------------------------                
  def update_spin_loop_effect
      @angle += 3
  end  
  
  #--------------------------------------------------------------------------
  # ● Update Spin Effect
  #--------------------------------------------------------------------------                
  def update_spin_effect
      @angle += 10
      clear_effects if @angle >= 360
  end    
  
  

	def update_tentaclePull_effect
		return @opacity = 0 if @effects[1] >= 20
		@effects[1] += 1
			@angle -=1
			if @effects[1] >= 10
				@zoom_y -= 0.40
				@zoom_x += 0.04
			else
				@zoom_y += 0.40
				@zoom_x -= 0.04
			end
	end

	def update_tentaclePullSM_effect
		return @opacity = 0 if @effects[1] >= 20
		@effects[1] += 1
			@angle += 1
			if @effects[1] >= 10
				@zoom_y -= @effects[3]
				@zoom_x += @effects[4]
			else
				@zoom_y += @effects[3]
				@zoom_x -= @effects[4]
			end
	end

	def update_nova_effect
		@zoom_y += 0.1
		@zoom_x += 0.1
		@opacity -= 10
		clear_effects if @opacity <= 0
	end
	def update_FireZoomIn_effect
		return if @zoom_y >= 1
		@zoom_y += 0.05
	end
	def update_XYzoomIn_effect
		return if @zoom_y >= 1 || @zoom_y >= 1
		@zoom_y += 0.05
		@zoom_x += 0.05
	end
	def update_XYzoomOut_effect
		return if @zoom_y <= 0 || @zoom_x <= 0
		@zoom_y -= 0.05
		@zoom_x -= 0.05
	end
	def update_ThrowRotate_effect
		return @angle = 0 if @angle >= 360
		@angle += 10
	end
	
  #--------------------------------------------------------------------------
  # ● Update Slime Breath Effect
  #--------------------------------------------------------------------------          
  def update_slime_breath_effect
      @effects[1] += 1
      case @effects[1]
         when 0..30
           @zoom_x += 0.005
           @zoom_y -= 0.005
           if @zoom_x > 1.145 
              @zoom_x = 1.145
              @zoom_y = 0.855
              @effects[1] = 31
           end             
         when 31..60
           @zoom_x -= 0.005
           @zoom_y += 0.005    
           if @zoom_x < 1.0
              @zoom_x = 1.0
              @zoom_y = 1.0
              @effects[1] = 61
           end             
         else
           @zoom_x = 1
           @zoom_y = 1.0
           @effects[1] = 0 
      end
  end  
 
  #--------------------------------------------------------------------------
  # ● Update Big Breath Effect
  #--------------------------------------------------------------------------          
  def update_big_breath_effect
      @effects[1] += 1
      case @effects[1]
         when 0..30
           @zoom_x += 0.02
           @zoom_y = @zoom_x 
           if @zoom_x > 1.6   
              @zoom_x = 1.6         
              @zoom_y = @zoom_x 
              @effects[1] = 31
           end
         when 31..60
           @zoom_x -= 0.02
           @zoom_y = @zoom_x 
           if @zoom_x < 1.0    
              @zoom_x = 1.0
              @zoom_y = @zoom_x 
              @effects[1] = 61 
           end   
         else
           @zoom_x = 1
           @zoom_y = 1
           @effects[1] = 0 
      end
  end    
	def update_FadeOutDelete_effect
		if @effects[1] > 0
			speed = @effects[1]
		else
			speed = 3
		end
		@opacity -= speed
		return self.delete if @opacity <= 0
	end
	def update_FadeOutDeleteCosshair_effect
		if @effects[1] > 0
			speed = @effects[1]
		else
			speed = 3
		end
		@opacity -= speed
		return self.delete_crosshair if @opacity <= 0
	end
	def update_ZoomOutDelete_effect
		@effects[1] = 0.01 if @effects[1] < 0.01
		@zoom_x -= @effects[1]
		@zoom_y -= @effects[1]
		return self.delete if @zoom_x < 0.1 || @zoom_y < 0.1
	end
	def update_ZoomOutDeleteFast_effect
		@effects[1] = 0.1 if @effects[1] < 0.1
		@zoom_x -= @effects[1]
		@zoom_y -= @effects[1]
		return self.delete if @zoom_x < 0.2 || @zoom_y < 0.2
	end
	def update_ZoomOutFadeOff_effect
		return self.effects = ["",0,false] if self.opacity <= 0
		return self.opacity = 0 if @zoom_x < 0.1 || @zoom_y < 0.1 
		@zoom_x -= 0.02
		@zoom_y -= 0.02
	end
	def update_ZoomInFadeOff_effect
		return self.effects = ["",0,false] if self.opacity <= 0
		@opacity -= 10
		@zoom_x += 0.04
		@zoom_y += 0.04
	end
	def update_FadeIn_effect
		return self.effects = ["",0,false] if self.opacity >= 255
		self.opacity += 10
		self.opacity = 255 if self.opacity >255
	end
	def update_FadeOff_effect
		return self.effects = ["",0,false] if self.opacity <= 0
		@opacity -= 5
	end
	def update_SkillWaveBanner_effect
		@effects[1] += 1
		case @effects[1]
			when 0..5
				@angle = 40
				@zoom_x = 0
				@zoom_y = 0.6
				@forced_x = -3
				@forced_y = -20
			when 6..10
				@angle = 0
				@zoom_x = 0.90
				@zoom_y = 1
				@forced_x = 0
				@forced_y = -15
			when 11..15
				@angle = -40
				@zoom_x = 0.70
				@zoom_y = 0.9
				@forced_x = -3
				@forced_y = -10
			when 16..20
				@angle = -20
				@zoom_x = 0.90
				@zoom_y = 1
				@forced_x = 0
				@forced_y = -15
			else
				@zoom_x = 1.0
				@zoom_y = 1.0
				@angle = 0
				@forced_x = -12
				@forced_y = 1
				@forced_z = 3
				@effects = ["",0,false]
		end
	end
  #--------------------------------------------------------------------------
  # ● Update CutTree
  #--------------------------------------------------------------------------          
 
	def update_BreathSingle_effect
		@effects[1] += 1
		case @effects[1]
			when 1..5
				@zoom_x -= 0.02
				@zoom_y += 0.04
			when 6..15
				@zoom_x += 0.01
				@zoom_y -= 0.02
			else
				@zoom_x = @effects[3]
				@zoom_y = @effects[4]
				@effects = ["",0,true]
				@angle = 0
		end
	end  
	def update_CutTree_effect
		@effects[1] += 1
		case @effects[1]
			when 0..5
				@effects[5] ? @angle += 1 : @angle -= 1
			when 6..10
				@effects[5] ? @angle -= 1 : @angle += 1
			when 11..15
				@effects[5] ? @angle = (360 - (@effects[1]-10)) : @angle = (360 + (@effects[1]-10))
			when 16..20
				@effects[5] ? @angle = (360 + (@effects[1]-16)) : @angle = (360 - (@effects[1]-16))
			else
				@effects = ["",0,true]
				@angle = 0
		end
	end
	def update_CutTreeSM_effect
		@effects[1] += 1
		case @effects[1]
			when 0..2
				@effects[5] ? @angle += 1 : @angle -= 1
			when 3..4
				@effects[5] ? @angle -= 1 : @angle += 1
			when 5..7
				@effects[5] ? @angle = (360 - (@effects[1]-4)) : @angle = (360 + (@effects[1]-4))
			when 8..10
				@effects[5] ? @angle = (360 + (@effects[1]-4)) : @angle = (360 - (@effects[1]-4))
			else
				@effects = ["",0,true]
				@angle = 0
		end
	end
	
	
	def update_CutTreeFall_effect
		@effects[1] += 1
		if @effects[5]
			if @angle < 90
				@angle += 1+(@angle*0.01).round
				@forced_y -= 0.3
			elsif @angle >= 90 && @opacity > 0
				@opacity -= 3
			else
				@effects = ["",0,true]
				self.delete
			end
		else
			@angle = 360 if @angle == 0
			if @angle >= 270
				@angle -= 1+(@effects[1]*0.01).round
				@forced_y -= 0.3
			elsif @angle <= 270 && @opacity > 0
				@opacity -= 3
			else
				@effects = ["",0,true]
				self.delete
			end
		end
	end
	
	#def update_StoneCollapse_effect # shit  unfinish
	#	if @effects[1] == 0
	#		@forced_x -= 1
	#	end
	#	@effects[1] += 1
	#	if @effects[1] % 2 == 0
	#		@forced_x += 2
	#	else
	#		@forced_x -= 2
	#	end
	#	@zoom_y -= 0.01
	#	return self.delete if @zoom_y <= 0.1
	#end
	
	def update_CutTreeFallFast_effect
		@effects[1] += 1
		if @effects[5]
			if @angle < 90
				@angle += 1+(@angle*0.1).round
				@forced_y -= 0.3
			elsif @angle >= 90 && @opacity > 0
				@opacity -= 5
			else
				@effects = ["",0,true]
				self.delete
			end
		else
			@angle = 360 if @angle == 0
			if @angle >= 270
				@angle -= 1+(@effects[1]*0.1).round
				@forced_y -= 0.3
			elsif @angle <= 270 && @opacity > 0
				@opacity -= 5
			else
				@effects = ["",0,true]
				self.delete
			end
		end
	end
  #--------------------------------------------------------------------------
  # ● Update SeaWave up
  #--------------------------------------------------------------------------          
	def update_SeaWaveUP_effect
		@effects[1] += 1
		case @effects[1]
			when 0..30
				@opacity += 5
				@zoom_y += 0.03
				if @opacity >= 255
					@effects[1] = 31
				end
			when 31..90
				@zoom_y += 0.02
				@opacity -= 1 if @opacity > 0
				if @opacity <= 125
					@effects[1] = 91
				end
			when 91..110
				@zoom_y += 0.01
				@opacity -= 1 if @opacity > 0
				if @opacity <= 1
					@effects[1] = 111
				end
			when 111..120
				@zoom_y += 0.005
				@opacity -= 1 if @opacity > 0
				if @opacity <= 1
					@effects[1] = 121
				end
			when 121..130
				@zoom_y -= 0.005
				@opacity -= 1 if @opacity > 0
				if @opacity <= 1
					@effects[1] = 131
				end
			when 131..400
				@zoom_y -= 0.004
				@opacity -= 1 if @opacity > 0
				if @opacity <= 1
					@effects[1] = 401
				end
			else
			@opacity = 0
			@zoom_y = 0.3
			@effects[1] = 0 
		end
	end  
  
  #--------------------------------------------------------------------------
  # ● Update Disappear Effect
  #--------------------------------------------------------------------------            
		def update_disappear_effect
			@zoom_x += 0.05
			@zoom_y += 0.05
			@opacity -= 30
			return delete if @opacity <= 0
		end
		
		def update_TeslaFadeIn_effect
			################################@effects=["TeslaFadeIn",[0,@forced_y,@eleTop,@pattern,0]]
			#p "zoom_x:#{@zoom_x}    zoom_y:#{@zoom_y}    direction:#{@direction}"
			#@zoom_x -= 0.008 if @zoom_x > 0.1
			#@zoom_y += 0.002 if @zoom_y > 0.5
			#@pattern = @effects[1][3] + rand(3)
			@effects[1][0] += 2
			@angle = [345,330,0,15,30].sample if @effects[1][0] %10 == 0
			if @eleTop > @effects[1][0]
				@forced_y -= 2
			else
				@mirror = [true,false].sample
				@forced_y = @effects[1][1]
				@effects[1][0] = 0
			end
		end
  
  #--------------------------------------------------------------------------
  # ● Update Appear Effect
  #--------------------------------------------------------------------------            
  def update_appear_effect
      @zoom_x += 0.02
      @zoom_x = 1.0 if @zoom_x > 1.0
      @zoom_y -= 0.05
      @zoom_y = 1.0 if @zoom_y < 1.0
      @opacity += 3
      clear_effects if @opacity >= 255
  end  

  #--------------------------------------------------------------------------
  # ● Update Crazy Effect
  #--------------------------------------------------------------------------              
  def update_crazy_effect
      @effects[1] += 1
      case @effects[1]
         when 1..5
           @mirror = false
         when 6..10
           @mirror = true
         else
           @mirror = false
           @effects[1] = 0 
      end      
  end  
  
  #--------------------------------------------------------------------------
  # ● Update Dwarf Effect
  #--------------------------------------------------------------------------                
  def update_dwarf_effect
      if @zoom_x > 0.5
         @zoom_x -= 0.01
         @zoom_y -= 0.01
      end       
  end
  
  #--------------------------------------------------------------------------
  # ● Update Giant Effect
  #--------------------------------------------------------------------------                
  def update_giant_effect
      if @zoom_x < 1.8
         @zoom_x += 0.01
         @zoom_y += 0.01
      end       
  end   
  
  #--------------------------------------------------------------------------
  # ● Update Normal
  #--------------------------------------------------------------------------                  
  def update_normal_effect  
      if @zoom_x > 1.0 
         @zoom_x -= 0.01
         @zoom_x = 1.0 if @zoom_x < 1.0  
      elsif @zoom_x < 1.0 
         @zoom_x += 0.01
         @zoom_x = 1.0 if @zoom_x > 1.0              
      end
      if @zoom_y > 1.0 
         @zoom_y -= 0.01
         @zoom_y = 1.0 if @zoom_y < 1.0  
      elsif @zoom_y < 1.0 
         @zoom_y += 0.01
         @zoom_y = 1.0 if @zoom_y > 1.0              
     end        
     if @opacity < 255
        @opacity += 2 
        @opacity = 255 if @opacity > 255
     end
     if @angle > 0 
        @angle -= 5 
        @angle = 0 if @angle < 0
     end   
     if (@zoom_x == 1.0 and @zoom_y == 1.0 and @opacity == 255 and @angle == 0)
        clear_effects
     end  
  end  
  
end

#==============================================================================
# ■ Game Event
#==============================================================================
class Game_Event < Game_Character  
  
 #--------------------------------------------------------------------------
 # ● Setup Page Setting
 #--------------------------------------------------------------------------                     
  alias mog_character_effects_setup_page_settings setup_page_settings
  def setup_page_settings
      mog_character_effects_setup_page_settings
      setup_character_ex_effects
  end
    
 #--------------------------------------------------------------------------
 # ● Setup Character Effects
 #--------------------------------------------------------------------------                       
  def setup_character_ex_effects
      return if @list == nil
      for command in @list
      if command.code == 108
         if command.parameters[0] =~ /<Effects = ([^>]*)>/
            @effects = [$1,0,true]
         end   
         if command.parameters[0] =~ /<Zoom = (\d+)>/i 
            @zoom_x = $1.to_i
            @zoom_y = @zoom_x
         end   
         if command.parameters[0] =~ /<Opacity = (\d+)>/i 
            @opacity = $1.to_i
         end   
         if command.parameters[0] =~ /<Blend Type = (\d+)>/i   
            @blend_type = $1.to_i           
         end 
         if command.parameters[0] =~ /<Mirror = (\w+)>/i
            @mirror = $1
         end            
       end
      end 
  end
end  

#==============================================================================
# ■ CHARCTER EX EFFECTS COMMAND
#==============================================================================
module CHARACTER_EX_EFFECTS_COMMAND
  
  #--------------------------------------------------------------------------
  # ● Char Effect
  #--------------------------------------------------------------------------      
  def char_effect(event_id = 0, effect_type = "Breath")
      if event_id < 0
         target = $game_player.followers[event_id.abs - 1] rescue nil
      elsif event_id == 0
         target = $game_player rescue nil
      else  
         target = $game_map.events[event_id] rescue nil
      end
      execute_char_effect(target,effect_type) if target != nil
 end  
      
  #--------------------------------------------------------------------------
  # ● Execute Char Effect
  #--------------------------------------------------------------------------        
  def execute_char_effect(target,effect_type)
      if effect_type == "Clear"
         target.clear_effects rescue nil
         return
      end           
      target.effects[0] = effect_type.to_s rescue nil
      target.effects[2] = true rescue nil
  end
  
  #--------------------------------------------------------------------------
  # ● Clear_All_Events Effects
  #--------------------------------------------------------------------------            
  def clear_all_events_effects
      for event in $game_map.events.values
          event.clear_effects
      end  
  end

  #--------------------------------------------------------------------------
  # ● Clear_All_Party Effects
  #--------------------------------------------------------------------------              
  def clear_all_party_effects
      $game_player.clear_effects
      for folower in $game_player.followers
          folower.clear_effects
      end
  end
    
  #--------------------------------------------------------------------------
  # ● Clear_All_Char_Effects
  #--------------------------------------------------------------------------          
  def clear_all_ex_effects
      clear_all_events_effects
      clear_all_party_effects
  end
  
  
    ########################################################### 417
	def get_target_angle(tmpTarX,tmpTarY,tmpMyX=self.x,tmpMyY=self.y)
		return 0 if tmpMyX == tmpTarX && tmpMyY == tmpTarY
		tmpAngle = Math.atan2(tmpMyX - tmpTarX, tmpMyY - tmpTarY)
		tmpAngle = tmpAngle * (180 / Math::PI)
		tmpAngle +=360 if tmpAngle < 0
		tmpAngle = 360 if tmpAngle > 360
		tmpAngle = tmpAngle.round
		tmpAngle
	end

    ########################################################### 417
	def get_direction_angle(dir = self.direction)
		case dir
			when 8 ; angle = 0
			when 4 ; angle = 90
			when 2 ; angle = 180
			when 6 ; angle = 270
			else ; angle = 0
		end
		angle
	end
	
	
	
end  #class

#==============================================================================
# ■ Game Interpreter
#==============================================================================
class Game_Interpreter
   include CHARACTER_EX_EFFECTS_COMMAND
end  

#==============================================================================
# ■ Game_CharacterBase
#==============================================================================
class Game_CharacterBase
    include CHARACTER_EX_EFFECTS_COMMAND
end

$mog_rgss3_character_ex = true
