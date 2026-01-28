#==============================================================================
# This script is created by Kslander 
#==============================================================================
class Window_SaveOverview < Window_Base
   
	def initialize(x,y,width,height)
		super
		@file_index = 0
		Cache.clear_savefile_bitmap
	end
	
	def refresh
		tmpMaxIndex = DataManager.saveFileMAX
		tmpMaxIndex = tmpMaxIndex -1
		p "max save = #{tmpMaxIndex}    current index = #{@file_index}"
		if !@file_index.between?(0,tmpMaxIndex)
			p "File index error"
			return @file_index = 0
		end
		p "Window_SaveOverview refresh on contents.clear => Save0#{@file_index+1}.rvdata2"
		contents.clear
		#RM 內建是用每項都去開檔案讀檔的方式處理，不確定這樣處理的用意
		#如果發生穩定性問題優先考慮把下面的方法通通改成各自讀取。
		header = DataManager.load_header(@file_index)
		return unless header || DataManager.saveFileExistsRGSS_slot?(@file_index+1)
		p "Window_SaveOverview refresh on draw_screen_shot => #{@file_index} #{DataManager.make_filename_screenshot(@file_index)}"
		header = Hash.new("ERR") if !header

		draw_screenshot("#{DataManager.make_filename_screenshot(@file_index)}",header)
		p "Window_SaveOverview refresh on draw_save_date => #{@file_index}"
		draw_save_date(header)
	end
  
	def draw_screenshot(screenShotName,header)
		tmpSaveVer = header[:ver]
		tmpModded = header[:mod_data] && !header[:mod_data].empty?
		tmpSaveVer = "ERROR" if !tmpSaveVer
		tmpCurrVer = DataManager.export_full_ver_info
		tmpSaveVer = tmpSaveVer.to_s
		tmpCurrVer = tmpCurrVer.to_s
		old_screenShotName = screenShotName
		screenShotName = "Graphics/System/SaveNotFound.png" if !FileTest.exist?(screenShotName)
		screen_shot = Cache.savefile_bitmap(screenShotName)
		contents.blt(0,0,screen_shot,screen_shot.rect)
		if tmpCurrVer != tmpSaveVer
			contents.font.outline=true
			contents.font.size = System_Settings::FONT_SIZE::WINDOW_FILE_VER_OUTDATED
			if FileTest.exist?(old_screenShotName)
				contents.draw_text(0,0,contents.width,50,"VERSION OUTDATED",1)
			else
				contents.draw_text(0,0,contents.width,50,"WUT?",1)
			end
			contents.font.size = System_Settings::FONT_SIZE::WINDOW_FILE_VER_INFO
			if tmpSaveVer != "ERR"
				contents.draw_text(0,0,contents.width,contents.height-35,"Curr:#{tmpCurrVer}",1)
			end
			contents.draw_text(0,0,contents.width,contents.height-5,"Save:#{tmpSaveVer}",1)
			contents.font.size = 12
			contents.draw_text(0,0,contents.width,contents.height,"Modded",2) if tmpModded
		end
	end
  
  def draw_save_date(header)
	tmpL_Height = System_Settings::FONT_SIZE::WINDOW_FILE_ACTOR_STATS_INFO
	contents.font.outline=false
	contents.font.size = 16
	contents.draw_text(10+0,		150+tmpL_Height*1,contents.width,30,$game_text["menu:core_stats/hp"],0)
	contents.draw_text(10+0,		150+tmpL_Height*2,contents.width,30,$game_text["menu:core_stats/sta"],0)
	contents.draw_text(10+0,		150+tmpL_Height*3,contents.width,30,$game_text["menu:core_stats/sat"],0)
	contents.draw_text(10+0,		150+tmpL_Height*4,contents.width,30,$game_text["menu:main_stats/mood"],0)
	contents.draw_text(10+0,		150+tmpL_Height*5,contents.width,30,$game_text["menu:equip/atk"],0)
	contents.draw_text(10+0,		150+tmpL_Height*6,contents.width,30,$game_text["menu:equip/def"],0)
	contents.draw_text(10+0,		150+tmpL_Height*7,contents.width,30,$game_text["menu:equip/com"],0)
	contents.draw_text(10+50,		150+tmpL_Height*1,contents.width,30,":",0)
	contents.draw_text(10+50,		150+tmpL_Height*2,contents.width,30,":",0)
	contents.draw_text(10+50,		150+tmpL_Height*3,contents.width,30,":",0)
	contents.draw_text(10+50,		150+tmpL_Height*4,contents.width,30,":",0)
	contents.draw_text(10+50,		150+tmpL_Height*5,contents.width,30,":",0)
	contents.draw_text(10+50,		150+tmpL_Height*6,contents.width,30,":",0)
	contents.draw_text(10+50,		150+tmpL_Height*7,contents.width,30,":",0)
	begin ;tmpTar = "#{header[:stat_health]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(10+60,		150+tmpL_Height*1,contents.width,30,"#{tmpTar}",0)
	begin ;tmpTar = "#{header[:stat_sta]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(10+60,		150+tmpL_Height*2,contents.width,30,"#{tmpTar}",0)
	begin ;tmpTar = "#{header[:stat_sat]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(10+60,		150+tmpL_Height*3,contents.width,30,"#{tmpTar}",0)
	begin ;tmpTar = "#{header[:stat_mood]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(10+60,		150+tmpL_Height*4,contents.width,30,"#{tmpTar}",0)
	begin ;tmpTar = "#{header[:stat_atk]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(10+60,		150+tmpL_Height*5,contents.width,30,"#{tmpTar}",0)
	begin ;tmpTar = "#{header[:stat_def]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(10+60,		150+tmpL_Height*6,contents.width,30,"#{tmpTar}",0)
	begin ;tmpTar = "#{header[:stat_combat]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(10+60,		150+tmpL_Height*7,contents.width,30,"#{tmpTar}",0)
	
	contents.draw_text(-10,		150+tmpL_Height*1,contents.width,30,$game_text["menu:equip/scu"],2)
	contents.draw_text(-10,		150+tmpL_Height*2,contents.width,30,$game_text["menu:equip/wis"],2)
	contents.draw_text(-10,		150+tmpL_Height*3,contents.width,30,$game_text["menu:equip/con"],2)
	contents.draw_text(-10,		150+tmpL_Height*4,contents.width,30,$game_text["menu:equip/sur"],2)
	contents.draw_text(-10,		150+tmpL_Height*5,contents.width,30,$game_text["menu:equip/sexy"],2)
	contents.draw_text(-10,		150+tmpL_Height*6,contents.width,30,$game_text["menu:equip/weak"],2)
	contents.draw_text(-10,		150+tmpL_Height*7,contents.width,30,$game_text["menu:equip/mori"],2)
	contents.draw_text(-10-50,		150+tmpL_Height*1,contents.width,30,":",2)
	contents.draw_text(-10-50,		150+tmpL_Height*2,contents.width,30,":",2)
	contents.draw_text(-10-50,		150+tmpL_Height*3,contents.width,30,":",2)
	contents.draw_text(-10-50,		150+tmpL_Height*4,contents.width,30,":",2)
	contents.draw_text(-10-50,		150+tmpL_Height*5,contents.width,30,":",2)
	contents.draw_text(-10-50,		150+tmpL_Height*6,contents.width,30,":",2)
	contents.draw_text(-10-50,		150+tmpL_Height*7,contents.width,30,":",2)
	begin ;tmpTar = "#{header[:stat_scoutcraft]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(-10-60,		150+tmpL_Height*1,contents.width,30,"#{tmpTar}",2)
	begin ;tmpTar = "#{header[:stat_wisdom]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(-10-60,		150+tmpL_Height*2,contents.width,30,"#{tmpTar}",2)
	begin ;tmpTar = "#{header[:stat_constitution]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(-10-60,		150+tmpL_Height*3,contents.width,30,"#{tmpTar}",2)
	begin ;tmpTar = "#{header[:stat_survival]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(-10-60,		150+tmpL_Height*4,contents.width,30,"#{tmpTar}",2)
	begin ;tmpTar = "#{header[:stat_sexy]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(-10-60,		150+tmpL_Height*5,contents.width,30,"#{tmpTar}",2)
	begin ;tmpTar = "#{header[:stat_weak]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(-10-60,		150+tmpL_Height*6,contents.width,30,"#{tmpTar}",2)
	begin ;tmpTar = "#{header[:stat_morality]}" ;rescue ;tmpTar= "ERR" ;end
	contents.draw_text(-10-60,		150+tmpL_Height*7,contents.width,30,"#{tmpTar}",2)
	
	
  end
  
  def set_file_index(file_index)
	#p "1111111---------------------------------------------111111111"
	#p "Window_SaveOverview refresh on set_file_index => #{@file_index}"
	@file_index = file_index
	refresh
  end
  
 end
