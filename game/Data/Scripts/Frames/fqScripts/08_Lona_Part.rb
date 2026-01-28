#==============================================================================
# This script is created by Kslander 
#==============================================================================

class Lona_Part <Portrait_Part
	#Lona專用的part，支援透明度key以及複雜條件判斷
	attr_accessor :dirtKey
	attr_reader :nameOrder
	attr_reader :bitmaps
	attr_reader :prtArrKey
	attr_reader :isDirt
	attr_accessor :opacity
	attr_accessor :keyArr
	attr_accessor :root_folder
	
	def initialize(bmps,psx,psy,layer=255,name="default",stat="default",isDirt=false)
		@part_name=name  #對應的數值的key，用來從外部物件(hash)取得數值
		@bitmaps=bmps #圖檔的檔名Hash
		@posX=psx
		@posY=psy
		@layer=layer
		@isDirt=isDirt
		@opacity = @isDirt ? 0 : 255
		setup_arraybmps #把bmps改成以array作為key
	end
	
	def set_name_order(name_order)
		@prtArrKey = Array.new(name_order[@part_name].length)
		@nameOrder = name_order[@part_name]
	end
	
	def set_value(key, value, forcedOpacity = false)
		if key == dirtKey && @isDirt then
			value = 0 if value == false
			value = 255 if value == true
			dirtLevel = value.to_i
			dirtLevel = 255 if dirtLevel>255
			@opacity = dirtLevel
		else
			for i in 0...@nameOrder.length
				if @nameOrder[i]==key then
					@prtArrKey[i] = 0 if value.nil?
					if value.instance_of?(String)
						@prtArrKey[i]=value
					else
						@prtArrKey[i]=value.to_i
					end
					break
				end
			end
		end
		@opacity = forcedOpacity if forcedOpacity
		@bitmap = get_bitmap(@prtArrKey)
	end




	def setup_arraybmps
		arrKeyedBmps=Hash.new
		keys=@bitmaps.keys
		for x in 0..keys.length
			key=keys[x]
			keyArr=handleKeys(key)
			next if keyArr.nil?
			arrKeyedBmps[keyArr]=@bitmaps[key]
		end
		@bitmaps=arrKeyedBmps
	end
    
	#解讀key的結構並且回傳數值陣列
	def handleKeys(key)
		return nil if key.is_a?(Symbol) || key.nil?
		values=key.split(",")
		@keyArr=Array.new(values.length)
		for x in 0...@keyArr.length
			begin
				if values[x].include?("#")
					@keyArr[x]=get_string_val(values[x])
				else
					@keyArr[x]=get_numeric_val(values[x])
				end
			rescue
				p "error #{@part_name} layer: #{@layer}"
				p @keyArr[x]
			end
		end
		@keyArr
	end
    
    
	#取得本part用來抓取的數值陣列。
	def getPrtStat(ref,name_order)
		nameOrder=name_order[@part_name]
		@prtArrKey=Array.new(nameOrder.length)
		for z in 0...nameOrder.length
			if ref.stat[nameOrder[z]].instance_of?(String)
				@prtArrKey[z]=ref.stat[nameOrder[z]]
			else
				@prtArrKey[z]=ref.stat[nameOrder[z]].to_i
			end
		end
		@prtArrKey
	end
    
	#處理string 類型的key ex: bodyArmour#bikini
	def get_string_val(str)
		key= str.split("#")[1]
		key
	end
   
	#處理數值類型的key，ex preg02
	def get_numeric_val(str)
		numVal=str.split(//).last(2).join("")  
		numVal.to_i
	end
	#判斷這個圖片需不需要更新，並且更新之。
	def update(ref,name_order)
		updateDirt(ref) if @isDirt
		@bitmap=get_bitmap(getPrtStat(ref,name_order))
	end

	def updateDirt(ref)
		@opacity=ref.stat[@dirtKey]
	end
	
    
	
end
