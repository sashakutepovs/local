#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
class TempBG
	#TEMP_BG_Z_STD=110
	#TEMP_BG_Z_CHCG=110

  def initialize(paths,temp_x=0,temp_y=0)
	$bg.erase unless $bg.nil?
    @paths = paths
    @duration = 0
    @repeat = 0
    @timer = 0
    @index = -1
	@viewport=Viewport.new
	@viewport.z=System_Settings::TEMP_BG_Z_STD
    next_pic(temp_x,temp_y)
	$bg=self
  end

	
  def toCHCG
	return if @viewport.z==System_Settings::TEMP_BG_Z_CHCG
	@viewport.z=System_Settings::TEMP_BG_Z_CHCG	
  end
  
  def toSTD
	return if @viewport.z==System_Settings::TEMP_BG_Z_STD
	@viewport.z=System_Settings::TEMP_BG_Z_CHCG	
  end

 def erase
	p "$bg erase"
	return if @pic.disposed? || @pic.nil?
	@pic.visible=false
	@pic.dispose
 end
  
  def next_pic(temp_x,temp_y)
    @index += 1
    if @index >= @paths.length
      if @repeat
        @index = 0
      else
        @timer = nil
        return
      end
    end
	@pic=Sprite.new(@viewport)
	@pic.src_rect=Rect.new(0,0,640,360)
	@pic.x=temp_x
	@pic.y=temp_y
	#p "#{@paths[@index]}.png" if $debug_temp_cg
	@pic.bitmap=Bitmap.new("Graphics/Pictures/#{@paths[@index]}.png") 
  end

end


