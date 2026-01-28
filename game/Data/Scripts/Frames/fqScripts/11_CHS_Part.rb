#==============================================================================
# This script is created by Kslander 
#==============================================================================
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

=begin
  Portrait_Part是基本型，本身的功能包括：圖層、黏貼位置，以及與數值綁定的功能
  bmp={
      :root =>"root directory path",含有這個物件的資料夾的路徑
       :bmps => 圖檔檔名hash
  }

=end

class CHS_Part < Portrait_Part
	attr_accessor :bitmap
	attr_accessor :posX 
	attr_accessor :posY
	attr_accessor :layer
	attr_accessor :ref  
	attr_accessor :root_folder
	attr_accessor :sex_slot_count
	attr_accessor :part_name
	attr_accessor :bitmaps
	attr_accessor :opacity

  def initialize(bmps,psx,psy,layer=255,name="default",stat="default")
    @part_name=name  #對應的數值的key，用來從外部物件(hash)取得數值
    @bitmaps=bmps #圖檔的檔名Hash
    @posX=psx
    @posY=psy
    @layer=layer
	@opacity=255
  end
  
  #move rescue to other position to improve the code readability
   def get_bitmap(origin,target,h_mode=-1,position=-1)
		if h_mode >=0
			ptarget=@h_bitmaps[position][target]
		else 
			ptarget=@bitmaps[target]
		end
		return nil if  ptarget.nil? || ptarget.eql?("NA") || ptarget.eql?("nil")
		Cache.chs_material("#{@root_folder}/#{h_mode>=0 ? "CHSF#{position}/" : ""}#{ptarget}")
	end
  
  def update(ref)
    @bitmap=get_bitmap(@bitmap,getPrtStat(ref),ref.statMap["sex_pos"],ref.statMap["sex_position"])
  end

  
  #取得設定stat數值，主要用來給後面的Lona_Portrait用
  def getPrtStat(ref)
    "#{@part_name}##{ref.statMap[@part_name]}"    
  end
  
#檢查是否存在相對應的H圖檔  
  def generate_h_bitmaps
	@h_bitmaps=Array.new(4,Hash.new)
	@bitmaps.keys.each{
		|key|
		@h_bitmaps[0][key]= @bitmaps[key] if File.exists?("#{@root_folder}/CHSF0/#{@bitmaps[key]}")
		@h_bitmaps[1][key]= @bitmaps[key] if File.exists?("#{@root_folder}/CHSF1/#{@bitmaps[key]}")
		@h_bitmaps[2][key]= @bitmaps[key] if File.exists?("#{@root_folder}/CHSF2/#{@bitmaps[key]}")
		@h_bitmaps[3][key]= @bitmaps[key] if File.exists?("#{@root_folder}/CHSF3/#{@bitmaps[key]}")
	}
  end
  
  
  
  

end

