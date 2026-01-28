
=begin

  這個類型主要用來組裝給Charset使用的行走圖。
  在這個類型中base_char為腳色所屬的類型。(如MregHobo)
  

=end

class Charset_Creator
 

  
 def initialize(base_char,parts,canvas=[384,256])
    @base_char=base_char #portrait的主人的物件參考
    @canvas=canvas  #畫布範圍
    @prts=sort_parts(parts)  #CHS_Part，用來組織的零件
  end
  

	def self.parts
		[
			"equip_top",
			"body",
			"bot",
			"bot2",
			"mid",
			"mid2",
			"top",
			"top2",
			"head",
			"head_equip",
			"head_equip2",
			"equip_bot"
		]
	end

 def sort_parts(parts)
   return parts if parts.nil?
   return parts.sort_by!{|prt| prt.layer } #按照圖層高低進行排序
 end
 
  
  #取得Charset的行走圖如果未傳入時使用建造時的預設char
  def get_charset(char=@base_char)
		@prts.each{|prt| prt.update(char)}
        chs=Bitmap.new(@canvas[0].to_i,@canvas[1].to_i)
        @prts.each{
		|part|
        next if part.bitmap.nil?
			opa=part.opacity
			opa=255 if opa.nil?
			chs.blt(part.posX,part.posY,part.bitmap,part.bitmap.rect,opa)      
        }
    chs
  end
  
  

  
    

  
end
  
  
  
