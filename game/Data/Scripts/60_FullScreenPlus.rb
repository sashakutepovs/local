# Fullscreen++ v2.2 for VX and VXace by Zeus81
# Free for non commercial and commercial use
# Licence : http://creativecommons.org/licenses/by-sa/3.0/
# Contact : zeusex81@gmail.com
# (fr) Manuel d'utilisation : http://pastebin.com/raw.php?i=1TQfMnVJ
# (en) User Guide           : http://pastebin.com/raw.php?i=EgnWt9ur
 
class << Graphics
  #Disable_VX_Fullscreen = true
 
	CreateWindowEx            = Win32API.new('user32'  , 'CreateWindowEx'           , 'ippiiiiiiiii', 'i')
	GetClientRect             = Win32API.new('user32'  , 'GetClientRect'            , 'ip'          , 'i')
	GetDC                     = Win32API.new('user32'  , 'GetDC'                    , 'i'           , 'i')
	GetSystemMetrics          = Win32API.new('user32'  , 'GetSystemMetrics'         , 'i'           , 'i')
	GetWindowRect             = Win32API.new('user32'  , 'GetWindowRect'            , 'ip'          , 'i')
	FillRect                  = Win32API.new('user32'  , 'FillRect'                 , 'ipi'         , 'i')
	FindWindow                = Win32API.new('user32'  , 'FindWindow'               , 'pp'          , 'i')
	ReleaseDC                 = Win32API.new('user32'  , 'ReleaseDC'                , 'ii'          , 'i')
	SendInput                 = Win32API.new('user32'  , 'SendInput'                , 'ipi'         , 'i')
	SetWindowLong             = Win32API.new('user32'  , 'SetWindowLong'            , 'iii'         , 'i')
	SetWindowPos              = Win32API.new('user32'  , 'SetWindowPos'             , 'iiiiiii'     , 'i')
	ShowWindow                = Win32API.new('user32'  , 'ShowWindow'               , 'ii'          , 'i')
	SystemParametersInfo      = Win32API.new('user32'  , 'SystemParametersInfo'     , 'iipi'        , 'i')
	UpdateWindow              = Win32API.new('user32'  , 'UpdateWindow'             , 'i'           , 'i')
	CreateSolidBrush          = Win32API.new('gdi32'   , 'CreateSolidBrush'         , 'i'           , 'i')
	DeleteObject              = Win32API.new('gdi32'   , 'DeleteObject'             , 'i'           , 'i')
	HWND     = FindWindow.call('RGSS Player', 0)
	BackHWND = CreateWindowEx.call(0x08000008, 'Static', '', 0x80000000, 0, 0, 0, 0, 0, 0, 0, 0)
	private
	def initialize_fullscreen_rects
		@borders_size    ||= borders_size
		@fullscreen_rect ||= screen_rect
		@workarea_rect   ||= workarea_rect
	end
	
	
	def borders_size
		GetWindowRect.call(HWND, wrect = [0, 0, 0, 0].pack('l4'))
		GetClientRect.call(HWND, crect = [0, 0, 0, 0].pack('l4'))
		wrect, crect = wrect.unpack('l4'), crect.unpack('l4')
		Rect.new(0, 0, wrect[2]-wrect[0]-crect[2], wrect[3]-wrect[1]-crect[3])
	end
	
	def screen_rect
		Rect.new(0, 0, GetSystemMetrics.call(0), GetSystemMetrics.call(1))
	end
	
	def workarea_rect
		SystemParametersInfo.call(0x30, 0, rect = [0, 0, 0, 0].pack('l4'), 0)
		rect = rect.unpack('l4')
		Rect.new(rect[0], rect[1], rect[2]-rect[0], rect[3]-rect[1])
		#Rect.new(rect[0], rect[1], 1920*2, 1080) ################################################### test
	end
	def hide_borders() SetWindowLong.call(HWND, -16, 0x14000000) end
	def show_borders() SetWindowLong.call(HWND, -16, 0x14CA0000) end
	def hide_back()    ShowWindow.call(BackHWND, 0)              end
	def show_back
		ShowWindow.call(BackHWND, 3)
		UpdateWindow.call(BackHWND)
		dc    = GetDC.call(BackHWND)
		rect  = [0, 0, @fullscreen_rect.width, @fullscreen_rect.height].pack('l4')
		brush = CreateSolidBrush.call(0)
		FillRect.call(dc, rect, brush)
		ReleaseDC.call(BackHWND, dc)
		DeleteObject.call(brush)
	end
	def resize_window(w, h)
		if @fullscreen
			x = (@fullscreen_rect.width-w)/2
			y = (@fullscreen_rect.height-h)/2
			#Doc edit:
			z = -1 #-1 #higher than window, -2 if u want lower then windows
		else
			w += @borders_size.width
			h += @borders_size.height
			x = @workarea_rect.x + (@workarea_rect.width  - w) / 2
			y = @workarea_rect.y + (@workarea_rect.height - h) / 2
			z = -2
		end
		SetWindowPos.call(HWND, z, x, y, w, h, 0)
	end
	def release_alt
		inputs = [1,18,2, 1,164,2, 1,165,2].pack('LSx2Lx16'*3)
		SendInput.call(3, inputs, 28)
	end
public
	def load_fullscreen_settings
		@fullscreen       =  $LonaINI["Screen"]["Fullscreen"] == 1
		@fullscreen_ratio =  $LonaINI["Screen"]["FullscreenRatio"] ?  $LonaINI["Screen"]["FullscreenRatio"] : 0
		@windowed_ratio   =  $LonaINI["Screen"]["WindowedRatio"] ?  $LonaINI["Screen"]["WindowedRatio"] : 1
		fullscreen? ? fullscreen_mode : windowed_mode
	end
	
	def save_fullscreen_settings
		$LonaINI["Screen"]["Fullscreen"]=@fullscreen ? 1 : 0
		$LonaINI["Screen"]["FullscreenRatio"]=@fullscreen_ratio
		$LonaINI["Screen"]["WindowedRatio"]=@windowed_ratio
		$LonaINI.save
	end
  
	def fullscreen?
		@fullscreen
	end
  
	def fullscreen_mode
		initialize_fullscreen_rects
		show_back
		#hide_back # z-2 if u want windowed fullscreen
		hide_borders
		@fullscreen = true
		self.ratio += 0 # refresh window size
	end
  
	def windowed_mode
		initialize_fullscreen_rects
		hide_back
		
		show_borders
		@fullscreen = false
		self.ratio += 0 # refresh window size
	end
  
	def ratio
		@fullscreen ? @fullscreen_ratio : @windowed_ratio
	end
  
	def ratio=(r)
		initialize_fullscreen_rects
		r = 0 if r < 0
		if @fullscreen
			@fullscreen_ratio = 0
			w_max, h_max = @fullscreen_rect.width, @fullscreen_rect.height
			########################this part do fullscreen
				val = w_max.to_f/h_max.to_f
				val2 = 16.0/9.0
				digi=2
				currentVAL = ((val * (10 ** digi)).to_i).to_f / (10 ** digi)
				compareVAL = ((val2 * (10 ** digi)).to_i).to_f / (10 ** digi)
				w_max = (h_max * 16 / 9).to_i if currentVAL > compareVAL
			###############################################
		else
			@windowed_ratio = r
			w_max = @workarea_rect.width  - @borders_size.width
			h_max = @workarea_rect.height - @borders_size.height
		end
		if r == 0 && !@fullscreen
			w, h = w_max, w_max * height / width
			h, w = h_max, h_max * width / height if h > h_max
		elsif @fullscreen
			w, h = w_max, w_max * height / width
			########################this part do windowed fullscreen
				val = w.to_f/h.to_f
				val2 = 16.0/9.0
				digi=2
				currentVAL = ((val * (10 ** digi)).to_i).to_f / (10 ** digi)
				compareVAL = ((val2 * (10 ** digi)).to_i).to_f / (10 ** digi)
				w = (h * 16 / 9).to_i if currentVAL > compareVAL
			###############################################
		else
			w, h = width * r, height * r
			@stableRatio = true if @stableRatio.nil?
			if (w > @workarea_rect.width or h > @workarea_rect.height) && @stableRatio
				hide_borders
				########################this part do windowed fullscreen
					val = @workarea_rect.width.to_f/@workarea_rect.height.to_f
					val2 = 16.0/9.0
					digi=2
					currentVAL = ((val * (10 ** digi)).to_i).to_f / (10 ** digi)
					compareVAL = ((val2 * (10 ** digi)).to_i).to_f / (10 ** digi)
					if currentVAL > compareVAL
						w = (@workarea_rect.height * 16 / 9).to_i
					else
						w = @workarea_rect.width
						h = @workarea_rect.height
					end
				###############################################
				@stableRatio = false
			elsif @stableRatio == false
				@stableRatio = true
				show_borders
				return self.ratio = 0
			else
				show_borders
			end
			#return self.ratio = 0 if (w > w_max or h > h_max) && !@stableRatio#original
		end
		resize_window(w, h)
		save_fullscreen_settings
	end
	def toggle_ratio(val=1)
		return if fullscreen?
		self.ratio += val
		#tmp_print_detail
	end
	def self.stableRatio
		@stableRatio
	end

	def set_ratio(val=1)
		return if fullscreen?
		self.ratio=val
	end
	def getCurrentRatio
		self.ratio
	end

	def check_screen_fullhd
	end


	def toggle_fullscreen
		fullscreen? ? windowed_mode : fullscreen_mode
		#tmp_print_detail
	end
  
	def get_fullscreenRect
		[@fullscreen_rect.width,@fullscreen_rect.height]
	end
	def get_workareaRect
		[@workarea_rect.width,@workarea_rect.height]
	end
  
  
	#def update
	#	zeus_fullscreen_update
	#end
  
	def getScaleTextFull
		tmpScaleText = ""
		if fullscreen?
			tmpScaleText = "#{get_fullscreenRect[0]} x #{get_fullscreenRect[1]}"
		elsif self.ratio >= 1
			if (self.ratio*width >  @workarea_rect.width) || (self.ratio*height > @workarea_rect.height)
				tmpScaleText = "#{@workarea_rect.width} x #{@workarea_rect.height}"
			else
				tmpScaleText = "#{self.ratio*width} x #{self.ratio*height}"
			end
		else 
			tmpScaleText = "#{get_workareaRect[0]} x #{get_workareaRect[1]}"
		end
		tmpScaleText
	end
	
	def getScaleTextHalf
		tmpScaleText = ""
		if fullscreen?
			tmpScaleText = get_fullscreenRect[1]
		elsif self.ratio >= 1
			if self.ratio*height > @workarea_rect.height
				tmpScaleText = @workarea_rect.height
			else
				tmpScaleText = self.ratio*height
			end
		else 
			tmpScaleText = get_workareaRect[1]
		end
		tmpScaleText
	end
	def checkScreenScale
		if $LonaINI["Screen"]["ScreenScale"] == "4:3"
			Graphics.resize_screen(544,416) #4:3
		elsif $LonaINI["Screen"]["ScreenScale"] == "16:10"
			#Graphics.resize_screen(608 , 380) #16:10
			Graphics.resize_screen(640,400) #16:10
		else
			Graphics.resize_screen(640,360) #16:9
		end
	end
end

Graphics.checkScreenScale
#Graphics.load_fullscreen_settings #move to DataManager self.load_peripheral_devices
