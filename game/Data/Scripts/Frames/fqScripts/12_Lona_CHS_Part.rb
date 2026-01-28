#==============================================================================
# This script is created by Kslander 
#==============================================================================

class Lona_CHS_Part <Lona_Part

  #Lona專用的part，支援透明度key以及複雜條件判斷
    attr_reader 	:opacity
    attr_accessor	:name_order
	
	def getPrtStat(ref)
	partNameOrder=@name_order[@part_name]
    @prtArrKey=Array.new(partNameOrder.length)
    for z in 0...partNameOrder.length
	key=partNameOrder[z]
      if ref.actor.stat[key].instance_of?(String)
        @prtArrKey[z]=ref.actor.stat[key]
      else
        @prtArrKey[z]=ref.actor.stat[key].to_i
      end
    end
    @prtArrKey
    end
	
	def update(ref)
		updateDirt(ref.actor) if @isDirt
		@bitmap=get_bitmap(getPrtStat(ref),ref.actor.stat["sex_pos"],ref.actor.stat["sex_position"])
	end
	

   def get_bitmap(target,h_mode=-1,position=-1)
	if h_mode >=0
		ptarget=@h_bitmaps[0][target]
	else 
		ptarget=@bitmaps[target]
	end
	return nil if  ptarget.nil? || ptarget.eql?("NA") || ptarget.eql?("nil")
	Cache.chs_material("#{@root_folder}/#{h_mode>=0 ? "CHSF0/" : ""}#{ptarget}")
  end

  
  #覆寫Lona_Part.setup_opacity
  def setup_opacity(isDirt)
      if isDirt
        @opacity=0
      else 
        @opacity=255
      end
    end

	#檢查是否存在相對應的H圖檔  
  def generate_h_bitmaps
	@h_bitmaps=Array.new()
	@h_bitmaps << Hash.new
	@bitmaps.keys.each{
		|key|
		@h_bitmaps[0][key]= @bitmaps[key] if File.exists?("#{@root_folder}/CHSF0/#{@bitmaps[key]}")
	}
  end

  
end
