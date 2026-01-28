#==============================================================================
# This script is created by Kslander 
#==============================================================================
=begin

  這個類別是基本型的 Portrait， 包含對位、動畫等功能。

=end

class Portrait
	attr_reader :portrait
	attr_accessor :prt_vp
	
	def initialize(base_char,parts,canvas=[300,400,0,0])
		@portrait = FakeSprite.new
		@base_char=base_char
		@canvas=Array.new(canvas.length){|index|canvas[index].to_i}
		@prts=sort_parts(parts)
		#don't create portrait on init
	end
  
 
 def sort_parts(parts)
   return parts if parts.nil?
   return parts.sort_by!{|prt| prt.layer } #按照圖層高低進行排序
 end
 
  
	def update
		#don't reassemble portrait if it's not visible
		return if !@portrait.visible
		update_parts
		assemble_portrait
	end

	def force_update
		update_parts
		assemble_portrait
	end
  
  def update_parts
    @prts.each{|prt| prt.update(@base_char)}
  end
  
  
  #製造portrait的Sprite物件
	def create_portrait()
		create_sprite
		reset_position
		force_update
	end
	def create_sprite
		return if !@portrait.sprite.nil?
		@prt_vp=Viewport.new
		#@prt_vp.z=System_Settings::PORTRAIT_MAP_Z
		@prt_vp.z=System_Settings::PORTRAIT_CHCG_Z
		@portrait.viewport = @prt_vp
		@portrait.show
		@portrait.visible=false
	end
	def delete_sprite
		return if @portrait.sprite.nil?
		@prt_vp.dispose
		@portrait.bitmap.dispose
		@portrait.dispose
		@portrait.viewport = nil
	end
	def show
		if @portrait.sprite.nil? then
			create_portrait
		end
		@portrait.visible=true
		update
	end
  
	def unshow
		@portrait.visible=false
		delete_sprite
	end
  
  #設定腳色立繪的色調，tone由外部直接傳入整個tome類別的物件
  #Tone.new(red,green,blue,[gray])
  def set_prt_tone(tone)
    @portrati.tone.set(tone)
  end
  
  def reset_position
		@portrait.x=@canvas[2]
		@portrait.y=@canvas[3]
  end
    

  #blt(x, y, src_bitmap, src_rect[, opacity]) 
	def assemble_portrait
		prt=Bitmap.new(@canvas[0],@canvas[1])
		prt.fill_rect(0,0,prt.width,prt.height,Color.new(0,255,0,0))
		@prts.each{|part|
			next if part.bitmap.nil?
			begin
				opa=part.opacity
				opa=255 if opa.nil?
				prt.blt(part.posX,part.posY,part.bitmap,part.bitmap.rect,opa)      
			rescue =>err
				p "Portrait missing file err.message=>#{err.message}"
			end
		}
		@portrait.bitmap=prt
	end
  
	#def rotate(deg)
	#	@portrait.angle=deg
	#end
	def angle=(deg)
		@portrait.angle=deg
	end
	def mirror=(deg)
		@portrait.mirror=deg
	end
	def zoom_y=(deg)
		@portrait.zoom_y=deg
	end
	def zoom_x=(deg)
		@portrait.zoom_x=deg
	end
	
	def reset_rotation
		@portrait.angle=0
		@portrait.zoom_x=1
		@portrait.zoom_y=1
		@portrait.mirror=false
	end
  
  def dispose_part
	return if @part.nil?
	@parts.each{
		|part|
		part.dispose	
	}
  end
  
  
end
  
  
  
