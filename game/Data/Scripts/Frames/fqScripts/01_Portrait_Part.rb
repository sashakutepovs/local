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

class Portrait_Part
	attr_accessor :bitmap
	attr_accessor :posX 
	attr_accessor :posY
	attr_accessor :layer
	attr_accessor :ref  
	attr_accessor :root_folder
	attr_accessor :part_name
	attr_accessor	:bitmaps
 

  def initialize(bmps,psx,psy,layer=255,name="default",stat="default")
    @part_name=name  #對應的數值的key，用來從外部物件(hash)取得數值
    @bitmaps=bmps #圖檔的檔名Hash
    @stat=""  #對應到的數值當下的值
    @posX=psx
    @posY=psy
    @layer=layer
  end

  
  #取得設定stat數值，主要用來給後面的adv跟alona portrait用
  def getPrtStat(ref)
    ref.statMap[@part_name]
  end
  
  def get_bitmap(target)
    return if @bitmaps[target].nil?
	Cache.load_part(@root_folder,"/"+@bitmaps[target])
  end


  #判斷這個圖片需不需要更新，並且更新之。
  def update(ref)
    @bitmap=get_bitmap(getPrtStat(ref))
  end
  
  def opacity
    255
  end
  
  def dispose
	@bitmap = nil
  end
  

end
