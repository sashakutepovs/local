class Loading_Screen < Sprite
	def initialize
		super(nil)
		@count = 0
		@index=rand(4)
		@countTar = 17 #update rate
		@cloak = [true,false].sample
		@imported_text = ""
		genPIC
	end
	def genPIC
		@importTextSprite = Sprite.new
		@importTextSprite.bitmap = Bitmap.new(Graphics.width,30)
		@importTextSprite_rect = Rect.new(0,0,Graphics.width,30)
		@importTextSprite.bitmap.clear_rect(@importTextSprite_rect)
		@importTextSprite.bitmap.font.outline = false
		@importTextSprite.bitmap.font.size = 12
		@importTextSprite.bitmap.font.bold = true
		@importTextSprite.y = Graphics.height-40#/2+@aniPic0.height/3
		@importTextSprite.bitmap.draw_text(-4, 0,Graphics.width,40,@imported_text,1)
		if $TEST
			@testSprite = Sprite.new
			@testSprite.bitmap = Bitmap.new(70,30)#(Graphics.width,Graphics.height)
			@testSprite_rect = Rect.new(0,0,70,30)
			@testSprite.bitmap.clear_rect(@testSprite_rect)
			@testSprite.bitmap.font.outline = false
			@testSprite.bitmap.font.size = 14
			@testSprite.bitmap.draw_text(8, -10,70,40,"DEV MODE",0)
		end
		@aniPic0 = Sprite.new
		@aniPic1 = Sprite.new
		@aniPic2 = Sprite.new
		@aniPic3 = Sprite.new
		@aniPic0.opacity = 0 if @aniPic0
		@aniPic1.opacity = 0 if @aniPic1
		@aniPic2.opacity = 0 if @aniPic2
		@aniPic3.opacity = 0 if @aniPic3
		if @cloak
			@aniPic0.bitmap = Bitmap.new("Graphics/System/LoadingScreenCloak0.png")
			@aniPic1.bitmap = Bitmap.new("Graphics/System/LoadingScreenCloak1.png")
			@aniPic2.bitmap = Bitmap.new("Graphics/System/LoadingScreenCloak2.png")
			@aniPic3.bitmap = Bitmap.new("Graphics/System/LoadingScreenCloak3.png")
		else
			@aniPic0.bitmap = Bitmap.new("Graphics/System/LoadingScreenFrame0.png")
			@aniPic1.bitmap = Bitmap.new("Graphics/System/LoadingScreenFrame1.png")
			@aniPic2.bitmap = Bitmap.new("Graphics/System/LoadingScreenFrame2.png")
			@aniPic3.bitmap = Bitmap.new("Graphics/System/LoadingScreenFrame3.png")
		end
		tmpX=Graphics.width/2 - (@aniPic0.width)/2
		tmpY=Graphics.height/2 - (@aniPic0.height)/2
		@aniPic0.x = tmpX
		@aniPic1.x = tmpX
		@aniPic2.x = tmpX
		@aniPic3.x = tmpX
		@aniPic0.y = tmpY
		@aniPic1.y = tmpY
		@aniPic2.y = tmpY
		@aniPic3.y = tmpY
		@aniPic0.z = 1000
		@aniPic1.z = 1000
		@aniPic2.z = 1000
		@aniPic3.z = 1000
	end
  def hide
		@aniPic0.opacity = 0
		@aniPic1.opacity = 0
		@aniPic2.opacity = 0
		@aniPic3.opacity = 0
  end
  def show
		@aniPic0.opacity = 255
		@aniPic1.opacity = 0
		@aniPic2.opacity = 0
		@aniPic3.opacity = 0
  end
	def next_pic
			case @index
				when 0 ; @aniPic0.opacity = 255 ; @aniPic1.opacity = 0 ; @aniPic2.opacity = 0 ; @aniPic3.opacity = 0
				when 1 ; @aniPic1.opacity = 255 ; @aniPic0.opacity = 0 ; @aniPic2.opacity = 0 ; @aniPic3.opacity = 0
				when 2 ; @aniPic2.opacity = 255 ; @aniPic0.opacity = 0 ; @aniPic1.opacity = 0 ; @aniPic1.opacity = 0
				when 3 ; @aniPic3.opacity = 255 ; @aniPic0.opacity = 0 ; @aniPic1.opacity = 0 ; @aniPic2.opacity = 0
			end
			@index += 1
			@index = 0 if @index >= 4
	end

	def next_text(tmp_text=nil)
		return if !tmp_text
		if @imported_text != tmp_text.upcase
			@imported_text = tmp_text.upcase
			@importTextSprite.bitmap.clear_rect(@importTextSprite_rect)
			@importTextSprite.bitmap.draw_text(0, 0,Graphics.width,40,@imported_text,1)
			Graphics.update
		end
	end
	def update(tmp_text)
		@count += 1
		next_text(tmp_text)
		if @count >= @countTar
			next_pic
			Graphics.update
			@count = 0
		end
	end
	
	def dispose
		@aniPic0.dispose if @aniPic0
		@aniPic1.dispose if @aniPic1
		@aniPic2.dispose if @aniPic2
		@aniPic3.dispose if @aniPic3
		@importTextSprite.dispose if @importTextSprite
		@testSprite.dispose if @testSprite
		super
	end
end
$loading_screen = Loading_Screen.new
