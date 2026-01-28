#==============================================================================
# This script is created by Kslander 
#==============================================================================
#=============================================================================================
#這個模組主要提供CHS相關的設定功能，被引用到Game_Event及Game_Player中。w
#這裡的東西主要在Game_Event.setup_event_page中被呼叫到。
#				
#		=============================================================================
#		||	注意：這個檔案的主要運作環境是Game_Event，非Game_Interpreter					   ||
#		=============================================================================
#
#破例相依於Cache模組
#這個腳本使用全域變數 $chs_data :儲存所有的charset設定資料
#	CHS系統支援兩種指定方式：使用-char-開頭的行走圖素材或是使用 set_chs_char(char_type,number)來設定
#
#=============================================================================================

module CHS
	RANDOM_ONLY_ONCE=0		#一旦random完就不再更新
	RANDOM_EVERY_LOAD=1	#每次載入地圖都重新產生
	RANDOM_EVERY_SHIFT=2	#每次日夜變化都重新產生
	RANDOM_EVERY_NIGHT=3	#每個夜晚都重新產生
	RANDOM_EVERY_DAYTIME=4	#每次白天都重新產生
	RANDOM_EVERYDAY=5		#每次換日都重新產生
	RANDOM_EVERY_MONTH=6	#每個月重新產生
	
	HCHS_RECEIVER = 0
	HCHS_FUCKER =  1
	CHS_GRAPHIC=0
	CHS_SCRIPT=0
	CHS_PARTORDER_STANDARD={
			"equip_top"		=>16,
			"ext4"			=>15,
			"ext3"			=>14,
			"ext2"			=>13,
			"ext1"			=>12,
			"head_equip2"	=>11,
			"head_equip"	=>10,
			"head"			=>9,
			"top2"			=>8,
			"top"			=>7,
			"mid2"			=>6,
			"mid"			=>5,
			"bot2"			=>4,
			"bot"			=>3,
			"body"			=>2,
			"equip_bot"		=>1
			}
		
	attr_accessor  		:chs_type			#腳色的類型
	attr_accessor  		:chs_name			#存檔時用來分辨腳色的名稱
	attr_accessor  		:chs_name_h			#存檔時用來分辨腳色的名稱
	attr_accessor 		:chs_configuration	#腳色的chs顯示設定，相當於一般portrait的statMap
	attr_accessor		:random_freq
	attr_accessor		:charset_index
	attr_accessor		:chs_need_update
	attr_accessor		:chs_default_index
	attr_accessor		:fuckers #當下正在幹他的腳色
	
	#取得一個累積型的不重複編號，用來區分每個chs腳色
	def self.get_chs_count
		@chs_count.nil? ? @chs_count=0 : @chs_count+=1
	end
	
	def chs_name
		@chs_name
	end
	
	def use_chs?
		!@chs_configuration.nil?
	end

	#type: charset的type，ex:-char-m-reg-human，nameAsType:輸入的類型是否等於名稱，傳入true時以輸入的名稱作為腳色的辨識依據。
	def set_char_type(type,nameAsType=false)
		@chs_type=type
		name = chs_definition.random?(@charset_index) ? nil : chs_definition.char_default_names[@charset_index]+"_i_"+@charset_index.to_s
		set_char_name(name)
	end
	
	#設定腳色的名字，未設定時採用預設命名方式
	def set_char_name(name=nil)
		@chs_name = name.nil? ? "#{sprintf("%03d",CHS.get_chs_count)}@MAP_#{sprintf("%03d",$game_map.map_id)}" : name
		@chs_name_h = @chs_name+"_H"
		@chs_need_update=true
	end
	
	#設定系統不理會腳色圖片指定的腳色，如果腳本中沒有指定腳色澤不做任何事情
	def use_script
	end
	
	def che_definition
		$chs_data[@chs_type]
	end
	
	#非chs腳色的高度，主要給 Galv's Event Pop-Ups
	def char_block_height
		#如果沒有被特別設定就直接回傳rm標準的32
		@char_block_height.nil? ? 32 : @char_block_height
	end
	
	def char_block_width
		@char_block_width.nil? ? 32 : @char_block_width
	end
	
	def char_block_height=(val)
	 @char_block_height=val
	end
	
	def char_block_width=(val)
	 @char_block_width=val
	end
	
	def create_chs_configuration(char_index)
		@chs_configuration={}
		@chs_configuration["sex_pos"] = -1 # >=0 為chs模式 0: receiver
		chs_data=$chs_data[@chs_type].parts[char_index]
		chs_data.each{
			|part|
			next if part.nil? || part.part_name.eql?("name") 
			@chs_configuration[part.part_name]= part.bitmaps[part.bitmaps.keys.sample]
		}		
	end
	
	def statMap
		@chs_configuration
	end
	
	
	
	#=======================================================================================================================
	#設定腳色多久重新更新一次，，預設每次載入地圖都更新(CHS::RANDOM_EVERY_LOAD)
	#mode： 
	#	CHS::RANDOM_ONLY_ONCE=0		一旦random完就不再更新
	#	CHS::RANDOM_EVERY_LOAD=1	每次載入地圖都重新產生
	#	CHS::RANDOM_EVERY_SHIFT=2	每次日夜變化都重新產生
	#  	CHS::RANDOM_EVERY_NIGHT=3	每個夜晚都重新產生
	#  	CHS::RANDOM_EVERY_DAYTIME=4	每次白天都重新產生
	#  	CHS::RANDOM_EVERYDAY=5		每次換日都重新產生
	#  	CHS::RANDOM_EVERY_MONTH=6	每個月重新產生
	#=======================================================================================================================
	def set_random_freq(mode=CHS::RANDOM_EVERY_LOAD)
		@random_freq=mode
	end
	#下面開始是嘗試這樣設計用的方法
	def set_random_only_once
		@random_freq=CHS::RANDOM_ONLY_ONCE
	end
	def set_random_every_load
		@random_freq=CHS::RANDOM_EVERY_LOAD
	end
	
	def set_random_every_shift
		@random_freq=CHS::RANDOM_EVERY_SHIFT
	end
	
	def set_random_every_day
		@random_freq=CHS::RANDOM_EVERY_SHIFT
	end
	
	def set_random_every_daytime
		@random_freq=CHS::RANDOM_EVERY_DAYTIME
	end
	
	def set_random_everyday
		@random_freq=CHS::RANDOM_EVERYDAY
	end
	
	def set_random_every_month
		@random_freq=CHS::RANDOM_EVERY_MONTH
	end
	
	
	class CHS_Data
		attr_accessor	:char_type
		attr_accessor	:parts		#這個腳色的物件，CHS_Part陣列
		attr_accessor	:folder		#這個chartype的圖片放在Graphics/CharacterCharset底下的哪個資料夾
		attr_accessor	:height		#這個腳色的高度資料
		attr_accessor	:soundinfo 	#這個腳色的聲音資料hash
		attr_accessor	:gender
		attr_accessor	:supported_fucker
		attr_accessor	:receiver_holename
		attr_accessor	:supported_receiver
		attr_accessor	:cell_y_adjust
		attr_accessor	:sex_cell_y_adjust
		attr_accessor	:cell_height
		attr_accessor	:cell_width
		attr_accessor	:sex_cell_height
		attr_accessor	:sex_cell_width
		attr_accessor	:balloon_height
		attr_accessor	:balloon_height_low
		attr_accessor	:root_folder
		attr_accessor	:part_key_blacklist
		attr_reader		:char_default_names
		attr_reader		:chs_default_index
		attr_reader		:max_capacity #這個CHS腳色H的最大容量
	
		#產生器
		def self.create_from_hash(dataHash)
			chsData=self.new
			chsData.folder=dataHash["folder"]
			chsData.soundinfo=dataHash["soundinfo"]
			chsData.height=dataHash["height"].to_i
			chsData.char_type=dataHash["chartype"]
			chsData.parts=dataHash["parts"]
			chsData.gender=dataHash["sex"]
			chsData.supported_fucker=dataHash["supported_fucker"]
			chsData.supported_receiver=dataHash["supported_reciver"]
			chsData.cell_height=dataHash["cell_height"].to_i
			chsData.cell_width=dataHash["cell_width"].to_i
			chsData.sex_cell_height=dataHash["sex_cell_height"]
			chsData.sex_cell_width=dataHash["sex_cell_width"]
			chsData.balloon_height=dataHash["balloon_height"].to_i
			chsData.balloon_height_low=dataHash["balloon_height_low"].to_i
			chsData.cell_y_adjust=dataHash["cell_y_adjust"].to_i
			chsData.sex_cell_y_adjust=dataHash["sex_cell_y_adjust"]
			#chsData.sex_cell_y_adjust = Hash.new(0)
			#dataHash["sex_cell_y_adjust"].each_with_index do |val, idx|
			#	chsData.sex_cell_y_adjust[idx] = val
			#end
			#adjust_map = dataHash["sex_cell_y_adjust"]
			#chsData.sex_cell_y_adjust = adjust_map[chsData.id] || 0
			chsData
		end
		
		def chs_partorder
			CHS::CHS_PARTORDER_STANDARD
		end

				
		#取得當下這個腳色應該被放到的layer位置，如果沒有，return -1，傳入當下的狀況
		def get_layer(stat)
			return 1
		end
		
		#讀取JSON中的parts部分
		def parts=(partSrc)
			p "chs loading #{@char_type}" if $debug_chs
			@parts=Array.new(8)
			@random_part_index=Array.new(8)
			@char_default_names=Array.new(8)
			@chs_default_index=Array.new(8)
			partOrder=chs_partorder
			for i in 0...partSrc.length
				$loading_screen.update("Init CHS") if $loading_screen
				use_custom_root_folder = partSrc[i]["root_folder"]
				sPart=partSrc[i]
				random_indicator =false
				octParts=Array.new(8)
				if sPart["random"]
					random_indicator=true
					@char_default_names[i]=nil
				else
					p "setting non random char =>#{sPart["name"]}"
					@char_default_names[i]=sPart["name"]
				end
					partOrder.each{|partname,layer|
						bmps={}
						next if sPart[partname].nil?
						for partSelect in 0...sPart[partname].length
							bmps["#{partname}##{sPart[partname][partSelect]}"]=sPart[partname][partSelect]
						end
						part=CHS_Part.new(bmps,0,0,layer,partname,0)
						if use_custom_root_folder
							part.root_folder="#{use_custom_root_folder}/#{@folder}"
						else
							part.root_folder="Graphics/CharacterCharsets/#{@folder}"
						end
						part.generate_h_bitmaps
						octParts[partOrder[partname]]=part
					}
				@chs_default_index[i]=sPart["default_index"].nil? ? 0 : sPart["default_index"].to_i
				@random_part_index[i]=random_indicator
				@parts[i]=octParts
			end
		end
		
		def random?(chs_index)
			@random_part_index[chs_index]
		end
		
		
		
		#檢查對象身上是否還有空位，如果沒有，Go Fuck Yourself
		#沒有這個腳色的CHS支援且偏好的位置時回傳false
		#掙脫時間位結束也回傳false
		def support_fucker?(fucker)
			return false  
		end
		
		def supported_receiver=(reciver_data)
			@max_capacity=0
			@receiver_holename= Array.new(reciver_data.length)
			@supported_receiver = Array.new(reciver_data.length)
			
			for  pose_index in 0...reciver_data.length
			if reciver_data[pose_index].length> @max_capacity
				@max_capacity=reciver_data[pose_index].length 
			end
				current_pose=reciver_data[pose_index]
				holeindex= Array.new
				holename= Array.new(current_pose.length)
				for holenumber in 0...current_pose.length
					holename[holenumber]=current_pose[holenumber].eql?("nil") ? nil :  current_pose[holenumber]
					holeindex << holenumber+1 if !current_pose[holenumber].eql?("nil")
				end
				@supported_receiver[pose_index]=holeindex
				@receiver_holename[pose_index]=holename
			end
		end		
		
		def support_receiver?(receiver)
			return false
		end
		
		def get_position(required_capacity=0)
			@supported_fucker.select {|pos|
				pos.length > required_capacity
			}.sample
		end

		def get_holename(fucker)
			@receiver_holename[fucker.chs_config["sex_pos"]][fucker.chs_config["sex_position"]-1]
		end
		
		def get_pos_by_holename(holename,capacity=1)
			available_pos=Array.new
			for i in 0...@receiver_holename.length
				posi=@receiver_holename[i]
				available_pos << i if posi.include?(holename) && posi.reject{|a|a.nil?}.length >=capacity
			end
			available_pos
		end
		
		def get_position_index(position,holename)
			@receiver_holename[position].index(holename)
		end
		
		def dispose_cached_bitmap
			@parts.each{
				|key,part|
				next if part.nil?
				part.dispose
			}
		end
		
		
		
	end

	#Lona專用的CHS_Data類別，僅複寫 parts=，除此之外混入正常程序處理
	class Lona_CHS_Data < CHS_Data
		attr_accessor	:part_key_blacklist
		attr_reader		:name_order #紀錄該如何組織key的陣列
		#attr_accessor  		:chs_type			#腳色的類型


		def initialize
			@part_key_blacklist = []
		end

		#讀取JSON中的parts部分，同時產生nameOrder供part使用。
		def parts=(partSrc)
			@name_order={}
			@lonaParts=Array.new(partSrc.length)
			@parts=[]
			for i in 0...partSrc.length
				use_custom_root_folder = partSrc[i]["root_folder"]
				bmps = partSrc[i]["bmps"]
				bmps = partSrc[i]["bmps"]
				layer= partSrc[i]["layer"]
				partname = partSrc[i]["part_name"]
				isDirt = partSrc[i]["isDirt"]
				isDirt = isDirt.nil? ? false :isDirt
				@name_order[partname]=partSrc[i]["name_order"]
				@lonaParts[i]=Lona_CHS_Part.new(bmps,0,0,layer,partname,0,isDirt)
				if isDirt
					@lonaParts[i].dirtKey=partSrc[i]["dirtKey"].nil? ? "dirt" : partSrc[i]["dirtKey"]
				end
				@lonaParts[i].name_order=@name_order
				if use_custom_root_folder
					@lonaParts[i].root_folder="#{use_custom_root_folder}/#{@folder}"
				else
					@lonaParts[i].root_folder="Graphics/CharacterCharsets/#{@folder}"
				end
				@lonaParts[i].generate_h_bitmaps
			end
			@lonaParts.sort_by!{|part| part.layer}
			@parts.push(@lonaParts)
		end
		
		def dispose_cached_bitmap
			@lonaParts.each{|lonapart|lonapart.dispose}
		end
		

	
	
	end
	

  
end

	
	
	
