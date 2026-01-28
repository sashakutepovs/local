
class Scene_ACHlistMenu < Scene_Map
	def start
		super
		@background_sprite = Sprite.new
		@background_sprite.bitmap = Cache.load_bitmap("Graphics/System/TitleScreen/","titleOptBg")
		@background_sprite.z = System_Settings::TITLE_COMMAND_WINDOW_Z-1
		@menu = AchListMenu.new

	end
	
	def dispose_background
		@background_sprite.dispose
		@menu.dispose
	end

	def terminate
		super
		@background_sprite.dispose
		@menu.dispose
	end

	def update
		super
		refresh_menu
	end

	def createOptionACH(tmpIcon,tmpTitle,tmpDesp,tmpProg)
		
	end
	
	
	def refresh_menu
		
		if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK) || Input.trigger?(:MRB)
			SndLib.sys_cancel
			return SceneManager.goto(Scene_MapTitle)
		end
		@menu.update
	end
end


class AchListMenu < Sprite
	def initialize
		super(nil)
		@yFix = 40
		tmpW = Graphics.width
		tmpH = Graphics.height
		self.bitmap = Bitmap.new(tmpW,tmpH)
		self.x = tmpW/2
		self.y = tmpH/2
		self.y += @yFix
		self.ox = 272
		self.oy = 208
		self.z = System_Settings::TITLE_COMMAND_WINDOW_Z
		self.bitmap.font.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
		self.bitmap.font.outline = false
		self.bitmap.font.bold = false
		@achData = GabeSDK.GetACHlist
		@maxAchOnScreen = 7
		@achBitmap = Sprite.new(@viewport)
		@achBitmap.bitmap = Bitmap.new(640,280)
		@achBitmap.z = self.z+1
		@eachIndexPX = 40
		@currentIndex = 0
		@achBitmap.x = 50
		@achBitmap.y = 70
		@achBitmapGW = Graphics.width
		@totalACH = 0
		@achShowUp = 0
		drawAch(true)
		draw_title
		@ACHborder = @totalACH-@maxAchOnScreen+1
	end
	
	
	def drawAch(doTotal=false)
		@achMax = 0
		@achCurrent = 0
		tmpRound = 0
		@achData.each{|tmpAch|
			@totalACH += 1 if doTotal
			tmpRound += 1
			next if @currentIndex > tmpRound-1
			@achCurrent +=1 if tmpAch[1][0] >= tmpAch[1][1]
			@achMax += 1
			next if @achMax >= @maxAchOnScreen
			
		#:ach_id						=>[stat,														TriggerVal,hidden],			,folder
			# 顯示隱藏 若隱藏 未解
			if tmpAch[1][2] == true && tmpAch[1][1] > tmpAch[1][0]
				buildACHline(nil,@achMax-1,tmpAch[1][0] >= tmpAch[1][1],tmpRound,tmpAch[1][3],tmpAch[1][4],tmpAch[1][5])
			#若隱藏 以解
			else
				buildACHline(tmpAch[0].to_s,@achMax-1,tmpAch[1][0] >= tmpAch[1][1],tmpRound,tmpAch[1][3],tmpAch[1][4],tmpAch[1][5])
			end
		}
	end
	
	def buildACHline(tmpName,tmpIndex,tmpUnlocked,tmpAchNum,overFolder,overTitle,overDesp)
		tmpUnlocked ? tmpOPA = 255 : tmpOPA = 125
		tmpUnlocked ? tmpIconOPA = 255 : tmpIconOPA = 75
		if !tmpName
			tmpBMP = Bitmap.new("Graphics/System/ACH/Hidden.png")
			tmpNameText = "?????"
			tmpDespText = "??????????????????????"
			tmpProg = "???"
		else
			tmpFolder = overFolder ? overFolder : "Graphics/System/ACH/"
			tmpNameText = overTitle ? overTitle : "#{$game_text["DataACH:#{tmpName}/item_name"]}      #{tmpProg}"
			tmpDespText = overDesp ? overDesp : $game_text["DataACH:#{tmpName}/description"]
			tmpBMP = Bitmap.new("#{tmpFolder}#{tmpName}.png")
			@achData[tmpName.to_sym][1] > 1 ? tmpProg = "#{@achData[tmpName.to_sym][0]} / #{@achData[tmpName.to_sym][1]}" : tmpProg = ""
		end
		@achBitmap.bitmap.blt(35 , 5+tmpIndex*@eachIndexPX ,tmpBMP,Rect.new(0, 0, 32, 32),opacity = tmpIconOPA)
		@achBitmap.bitmap.font.bold = true
		@achBitmap.bitmap.font.outline = false
		@achBitmap.bitmap.font.name = Font.default_name
		@achBitmap.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_ACH_NUM
		@achBitmap.bitmap.font.color.set(255,255,255,tmpOPA)
		@achBitmap.bitmap.draw_text(0, 7+tmpIndex*@eachIndexPX,@achBitmapGW,25,"#{tmpAchNum} :",0)
		@achBitmap.bitmap.font.bold = false
		@achBitmap.bitmap.font.color.set(255,255,255,tmpOPA)
		@achBitmap.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_ACH_NAME
		@achBitmap.bitmap.draw_text(80, tmpIndex*@eachIndexPX,@achBitmapGW,25,tmpNameText,0)
		@achBitmap.bitmap.font.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
		@achBitmap.bitmap.font.color.set(255,255,255,tmpOPA)
		@achBitmap.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_ACH_DESP
		@achBitmap.bitmap.draw_text(80, 18+tmpIndex*@eachIndexPX,@achBitmapGW,25,tmpDespText,0)
		
	end
	

	def update
		prevCurrentIndex = @currentIndex
		@currentIndex += 1 if Input.repeat?(:DOWN)
		@currentIndex -= 1 if Input.repeat?(:UP)
		@currentIndex += 5 if Input.repeat?(:R)
		@currentIndex -= 5 if Input.repeat?(:L)
		@currentIndex = 0 if @currentIndex < 0
		@currentIndex = @ACHborder if @currentIndex > @ACHborder
		if @currentIndex < prevCurrentIndex 
			SndLib.play_cursor
			clear_item
			drawAch
		elsif @currentIndex > prevCurrentIndex 
			SndLib.play_cursor
			clear_item
			drawAch
		end
	end
	
	def clear_item
		@achBitmap.bitmap.clear_rect(0,0,640,280)
	end
	
	def draw_title
		self.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_ACH_TITLE
		self.bitmap.draw_text(20,0,Graphics.width,32,$game_text["menu:title/ACH"],0)
		self.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_ACH_CURRENT_VAL
		self.bitmap.draw_text(20,5,Graphics.width,32,"#{@achCurrent} / #{@totalACH}",1)
		self.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_ACH_NUM
	end
	def dispose
		@achBitmap.dispose
		self.bitmap.dispose
		super
	end
end
