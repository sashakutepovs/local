#==============================================================================
# This script is created by Kslander 
#==============================================================================
#這個檔案室Lona遊戲裡面使用的Sensor的雛型

module Graphics
	#def self.ScreenGridEdgeX
	#	source = self.width
	#	if source % 32 == 0
	#		source += 64
	#	end
	#	source = ((source - 32) / 32)
	#	source = source/2
	#end
	#
	#def self.ScreenGridEdgeY
	#	source = self.height
	#	#if source % 32 == 0
	#		#source += 32
	#	#end
	#	source = ((source+32)/ 32)
	#	source = source/2
	#end
	def self.ScreenGridEdgeX
		grid_size = 32
		source = self.width
		#source -= 64 if self.width % grid_size == 0
		num_grids_horizontal = source / grid_size
		screen_edge_width = num_grids_horizontal / 2
		screen_edge_width
	end
	
	def self.ScreenGridEdgeY
		grid_size = 32
		source = self.height
		#source += 64 if self.height % grid_size == 0
		num_grids_vertical = source / grid_size
		screen_edge_height = num_grids_vertical / 2
		screen_edge_height
	end
end


