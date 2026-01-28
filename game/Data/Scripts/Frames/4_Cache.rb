#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Cache
#------------------------------------------------------------------------------
#  This module loads graphics, creates bitmap objects, and retains them.
# To speed up load times and conserve memory, this module holds the
# created bitmap object in the internal hash, allowing the program to
# return preexisting objects when the same bitmap is requested again.
#==============================================================================

module Cache
  #--------------------------------------------------------------------------
  # * Get Animation Graphic
  #--------------------------------------------------------------------------
  def self.animation(filename, hue)
    load_bitmap("Graphics/Animations/", filename, hue)
  end
  #--------------------------------------------------------------------------
  # * Get Battle Background (Floor) Graphic
  #--------------------------------------------------------------------------
  def self.battleback1(filename)
    load_bitmap("Graphics/Battlebacks1/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Battle Background (Wall) Graphic
  #--------------------------------------------------------------------------
  def self.battleback2(filename)
    load_bitmap("Graphics/Battlebacks2/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Battle Graphic
  #--------------------------------------------------------------------------
  def self.battler(filename, hue)
    load_bitmap("Graphics/Battlers/", filename, hue)
  end
  #--------------------------------------------------------------------------
  # * Get Character Graphic
  #--------------------------------------------------------------------------
  def self.character(filename)
    load_bitmap("Graphics/Characters/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Face Graphic
  #--------------------------------------------------------------------------
  def self.face(filename)
    load_bitmap("Graphics/Faces/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Parallax Background Graphic
  #--------------------------------------------------------------------------
 # def self.parallax(filename)
 #   load_bitmap("/", filename)
 # end
  #--------------------------------------------------------------------------
  # * Get Picture Graphic
  #--------------------------------------------------------------------------
  def self.picture(filename)
    load_bitmap("Graphics/Pictures/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get System Graphic
  #--------------------------------------------------------------------------
  def self.system(filename)
    load_bitmap("Graphics/System/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Tileset Graphic
  #--------------------------------------------------------------------------
  def self.tileset(filename)
    load_bitmap("Graphics/Tilesets/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Title (Background) Graphic
  #--------------------------------------------------------------------------
  def self.title1(filename)
    load_bitmap("Graphics/Titles1/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Title (Frame) Graphic
  #--------------------------------------------------------------------------
  def self.title2(filename)
    load_bitmap("Graphics/Titles2/", filename)
  end
  #--------------------------------------------------------------------------
  # * Load Bitmap
  #--------------------------------------------------------------------------
  def self.load_bitmap(folder_name, filename, hue = 0)
    @cache ||= {}
    if filename.empty?
      empty_bitmap
    elsif hue == 0
      normal_bitmap(folder_name + filename)
    else
      hue_changed_bitmap(folder_name + filename, hue)
    end
  end

	def self.load_png(filename, hue = 0)
		@cache ||= {}
		if filename.empty?
			empty_bitmap
		elsif hue == 0
		 	normal_bitmap(filename)
		else
			hue_changed_bitmap(filename, hue)
		end
	end
  #--------------------------------------------------------------------------
  # * Create Empty Bitmap
  #--------------------------------------------------------------------------
  def self.empty_bitmap
    Bitmap.new(32, 32)
  end
  #--------------------------------------------------------------------------
  # * Create/Get Normal Bitmap
  #--------------------------------------------------------------------------
	def self.normal_bitmap(path)
		@cache[path] = Bitmap.new(path) unless include?(path)
		@cache[path]
	end
	def self.savefile_bitmap(path)
		@cache_savefile_bitmap[path] = Bitmap.new(path) unless include?(path)
		@cache_savefile_bitmap[path]
	end
  #--------------------------------------------------------------------------
  # * Create/Get Hue-Changed Bitmap
  #--------------------------------------------------------------------------
  def self.hue_changed_bitmap(path, hue)
    key = [path, hue]
    unless include?(key)
      @cache[key] = normal_bitmap(path).clone
      @cache[key].hue_change(hue)
    end
    @cache[key]
  end
  #--------------------------------------------------------------------------
  # * Check Cache Existence
  #--------------------------------------------------------------------------
  def self.include?(key)
    @cache[key] && !@cache[key].disposed?
  end
  #--------------------------------------------------------------------------
  # * Clear Cache
  #--------------------------------------------------------------------------
	def self.clear
		p "Cache.clear TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
		#@cache ||= {}
		#@cache_savefile ||= {}
		@chs_chars ||= {}
		@chs_range ||= {}
		@chs_materials ||= {}
		@parts_cache ||= {}
		clear_savefile_bitmap
		clear_normal_bitmap
		clear_chs
		@chs_chars.clear
		@chs_range.clear
		@chs_materials.clear if $LonaINI["Cache"]["DisableChsMaterialClear"] != 1
		@parts_cache.clear if $LonaINI["Cache"]["DisablePartsClear"] != 1
		GC.start
	end
	def self.clear_normal_bitmap
		@cache ||= {}
		@cache.clear
	end
	def self.clear_savefile_bitmap
		@cache_savefile_bitmap ||= {}
		@cache_savefile_bitmap.clear
	end
	def self.clear_GUI #todo. a cache will never clear
		@cache_GUI_bitmap ||= {}
		@cache_GUI_bitmap.clear
	end
	def self.clear_QMSG #todo. a cache will never clear
		@cache_QMSG_bitmap ||= {}
		@cache_QMSG_bitmap.clear
	end
 #--------------------------------------------------------------------------
 # 取得CHS使用的腳色行走圖，組織交給Charset_Part
 #	*@chs_charset:儲存組織好的行走圖，用腳色的Name+某種特殊代號當key
 #	character:Game_Character/Game_Event物件
 #	force_update:是否要update，為true時，強制重新組織。
 #會先檢查是否有該腳色已經有組織過，如果已組過charset且不要求強制更新的話直接回傳組好的。
 #--------------------------------------------------------------------------

	MAX_ENTRIES_TO_STORE = 100 #maximum stored parts bitmaps < MAX_ENTRIES_TO_STORE and maximum stored chs bitmaps < MAX_ENTRIES_TO_STORE
  def self.chs_character(character,force_update=false)
		@chs_chars ||= {}
		#p "chs_char : char_id=>#{character.id}" if $debug_chs
		#p "chs_char :character.chs_name =>#{character.chs_name} , force_update=>#{force_update} , exist =>#{@chs_chars[character.chs_name].nil?}" if $debug_chs
		#p "chs_char :@chs_chars.key?(#{character.chs_name}) =>#{@chs_chars.key?(character.chs_name)}" if $debug_chs

		return @chs_chars[character.chs_name] if @chs_chars.key?(character.chs_name) && !@chs_chars[character.chs_name].nil? && !force_update
		#p "chs_char creating:character.chs_name =>#{character.chs_name}" if $debug_chs || character.sex_mode?
		return @chs_chars[character.chs_name]=create_chs_character_bitmap(character)
  end

  def self.clear_chs_character(regenerate=false)
		#p "Cache.clear_chs_character TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
		@chs_chars ||= {}
		@chs_chars.clear
		#p "Cache.clear_chs_character end TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
		@last_parts = {}
  end

  #處理隨機一般行走圖，隨機sex動畫交給下面的create_chs_sex_character_sprite
	def self.create_chs_character_bitmap(character)
		chs_data=$chs_data[character.chs_type]
		chs_parts=chs_data.parts[character.charset_index]
		arr = [character.sex_mode?]
		chs_parts.each{|part|
			begin
				next if part.nil?
				part.update(character)
				next if part.bitmap.nil?
			rescue => err
				p "chs missing file err.message=>#{err.message}"
			end
			part_opacity = part.opacity
			part_opacity = 255 if part.opacity > 255
			part_opacity = 0 if chs_data.part_key_blacklist && chs_data.part_key_blacklist.include?(part.part_name)
			arr << [part.bitmap, part_opacity] if part.bitmap && part_opacity>0
		}
		@last_parts = {} if @last_parts.nil?
		if arr != @last_parts[character] then #when not same.  create new sprite.   basicly cause failed to create bitmap bug.  make arr=nil in 2023 12 28
			@last_parts[character] = arr
			arr = nil
			return apply_parts(@last_parts[character], chs_data.cell_width, chs_data.cell_height, chs_data.sex_cell_width, chs_data.sex_cell_height)
		end
		arr = nil
		return @chs_chars[character.chs_name]
	end
	def self.apply_parts(parts_arr, cell_width, cell_height, sex_cell_width, sex_cell_height)
		sex_mode = parts_arr[0]
		parts = parts_arr[1...parts_arr.length]
		if sex_mode
			chs_bitmap=Bitmap.new(sex_cell_width*3,sex_cell_height*8)
		else
			chs_bitmap=Bitmap.new(cell_width*12,cell_height*8)
		end
		parts.each{|part|
			part_bitmap=part[0]
			chs_bitmap.blt(0,0,part_bitmap,part_bitmap.rect,part[1])
		}
		return chs_bitmap
	end

  def self.print_cache_keys
	@cache.keys.each{|key| p "cahce content=>#{key}"}
	print_chs_char_keys
  end

  def self.print_chs_char_keys
	@chs_chars.keys.each{|key| p "chs_character content=>#{key}"}
  end



  def self.chs_material(filename)
	@chs_materials ||= {}
	return @chs_materials[filename] if @chs_materials.include?(filename)
	return @chs_materials[filename]=Bitmap.new(filename)
  end

  def self.load_part(folder_name, filename, hue = 0)
    @parts_cache ||= {}
	full_name=folder_name+filename
	return @parts_cache[full_name] if @parts_cache.include?(full_name)
	return @parts_cache[full_name]=Bitmap.new(full_name)
  end

  def self.clear_chs(ignore_lona=false)
	#p "Cache.clear_chs  TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
	lona_chs=@chs_chars["Lona"] if ignore_lona
	clear_chs_character
	clear_chs_material
	@chs_chars["Lona"]=lona_chs if ignore_lona
	#GC.start
	#p "Cache.clear_chs  end TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
  end

  #圖片組完後刪除組織chs用的素材，組織完所有圖片後，由外部呼叫
  def self.clear_chs_material(gc=false)
		@chs_material ||={}
		@parts_cache ||={}
		if @chs_material.length > MAX_ENTRIES_TO_STORE || @parts_cache.length > MAX_ENTRIES_TO_STORE
			p "Cache.clear_chs_material gc=>#{gc} TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
			@chs_materials ||= {}
			@parts_cache ||= {}
			@chs_materials={} if $LonaINI["Cache"]["DisableChsMaterialClear"] != 1
			if $LonaINI["Cache"]["DisableChsDataCacheClear"] != 1
				$chs_data.each{|k,data|
					data.dispose_cached_bitmap
				}
			end
			$game_portraits.dispose_portrait_mat if gc
			@parts_cache={} if $LonaINI["Cache"]["DisablePartsClear"] != 1
			GC.start if gc
			p "Cache.clear_chs_material end TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
		end
  end

  def self.set_email(key,bitmap)
	@emails ||={}
	@emails[key]=bitmap
  end

  def self.clear_email
	#p "Cache.clear_email TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
	@emails ||={}
	@emails.clear
	#p "Cache.clear_email end TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
  end

  def self.email(key)
	@emails ||={}
	@emails[key]
  end
######################################################################## Pre Cache
	#def self.precache_lona_prt_bitmap(tgtPRT="all")
	#	$data_lona_portrait[1].each{|tmpCG_name,tmpCG_data| #tmpCG_name ex chcg1 and pose5
	#	                            msgbox "#{tmpCG_name}"
	#		next unless tmpCG_name.include?(tgtPRT) && tgtPRT != "all"
	#		tmpCG_data.each{|tmpPart|
	#			tmpPart.bitmaps.each{|tmpPartName,tmpPartFileName|
	#				$loading_screen.update("Precache LONA portrait #{tmpCG_name}") if $loading_screen
	#				precache_tgt_prt(tmpPart,tmpPartFileName)
	#			}
	#		}
	#		p "Precached => #{tmpCG_name} finished"
	#	}
	#end
	def self.precache_lona_prt_bitmap(tgtPRT="all", debug=false)
		$data_lona_portrait[1].each do |tmpCG_name, tmpCG_data|

			# Skip only if tgtPRT is not "all" and tmpCG_name does NOT include tgtPRT
			if tgtPRT != "all" && !tmpCG_name.include?(tgtPRT)
				next
			end

			tmpCG_data.each do |tmpPart|
				tmpPart.bitmaps.each do |tmpPartName, tmpPartFileName|
					$loading_screen.update("Precache LONA portrait #{tmpCG_name}") if $loading_screen && !debug
					precache_tgt_prt(tmpPart, tmpPartFileName , debug)
				end
			end

			p "Precached => #{tmpCG_name} finished"
		end
	end
	def self.precache_npc_prt_bitmap(debug=false)
		$data_npc_portraits.each{|tmpPortrait|
			next unless tmpPortrait
			next unless tmpPortrait.prts
			tmpPortrait.prts.each{|tmpPart|
				tmpPart.bitmaps.each{|tmpPartName,tmpPartFileName|
					$loading_screen.update("Precache NPC portrait") if $loading_screen && !debug
					precache_tgt_prt(tmpPart,tmpPartFileName, debug)
				}
			}
		}
	end
	def self.precache_tgt_prt(tmpPart,tmpPartFileName,debug=false)
		if debug && !FileTest.exist?("#{tmpPart.root_folder}/#{tmpPartFileName}")
			p "error #{tmpPart.root_folder}/#{tmpPartFileName}"
			return msgbox "error #{tmpPart.root_folder}/#{tmpPartFileName}"
		end
		load_part(tmpPart.root_folder, "/"+tmpPartFileName)
		if debug
			p "Check = >#{tmpPart.root_folder}/#{tmpPartFileName}"
		else
			p "Precached = >#{tmpPart.root_folder}/#{tmpPartFileName}"
		end
	end
	#def self.asdasdasd
	#	@parts_cache
	#end
end
