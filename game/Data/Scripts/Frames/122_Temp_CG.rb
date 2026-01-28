#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
class TempCG
	#TEMP_CG_Z_STD=155
	#TEMP_CG_Z_CHCG=165

  def initialize(paths, duration = nil, repeat = false)
	$cg.erase unless $cg.nil?
    @paths = paths
    @duration = duration
    @repeat = repeat
    @timer = @duration
    @index = -1
	@viewport=Viewport.new
	@viewport.z=System_Settings::TEMP_CG_Z_STD if !$game_map.interpreter.IsChcg?
	@viewport.z=System_Settings::TEMP_CG_Z_CHCG if $game_map.interpreter.IsChcg?
    next_pic
	$cg=self
  end

  def toCHCG
	return if @viewport.z==System_Settings::TEMP_CG_Z_CHCG
	@viewport.z=System_Settings::TEMP_CG_Z_CHCG	
  end
  
  def toSTD
	return if @viewport.z==System_Settings::TEMP_CG_Z_STD
	@viewport.z=System_Settings::TEMP_CG_Z_CHCG	
  end

 def erase
	return if @pic.disposed? || @pic.nil?
	@pic.visible=false 
	@pic.dispose
 end
  
  def next_pic
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
	@pic.src_rect=Rect.new(320,180,304,215)
	@pic.x=System_Settings::TEMP_CG_X
	@pic.y=System_Settings::TEMP_CG_Y
	#p "#{@paths[@index]}.png"
	@pic.bitmap=Bitmap.new("Graphics/Pictures/#{@paths[@index]}.png") 
  end

end

class Window_Message < Window_Base
  def show_cg
    @blue_back.visible = false
  end
end

class Scene_Map < Scene_Base
  def show_cg
    @message_window.show_cg
  end
end

