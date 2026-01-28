#==============================================================================
# This script is created by Kslander 
#==============================================================================
#處理overmap相關的內容


module Overmap

	def update_overmap
		deduct_lona_sta
		handle_on_move_overmap #可操作方法，在overmap上移動成功時呼叫
	end
	#更新overMap相關的內容
	def update_normalmap
		handle_on_move #可操作方法，每次移動成功時呼叫
	end
end