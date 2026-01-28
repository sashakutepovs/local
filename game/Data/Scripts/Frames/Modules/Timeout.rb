#==============================================================================
# This script is created by Kslander 
#==============================================================================
#這個module主要用來處理Dialog及選項的timeout功能。依賴124_Dialog_Timer.rb


module Timeout

	attr_reader :timer
	#time：timeout的時間，單位sec
	def set_timeout(time,tgt_symbol=:on_timeout)
		#p "setting timeout time=#{time} tgt=#{tgt_symbol.to_s}"
		@timer=Dialog_Timer.new if @timer.nil?
		@timer.start(time)
		@tgt_symbol=tgt_symbol
	end
	
	def set_timeout_frame(time,tgt_symbol=:on_timeout)
		#p "setting timeout time=#{time} tgt=#{tgt_symbol.to_s}"
		@timer=Dialog_Timer.new if @timer.nil?
		@timer.start(time,"frame")
		@tgt_symbol=tgt_symbol
	end
	
	def update_timeout
		return unless timeout_set?
		@timer.update
		send @tgt_symbol if @timer.timeout?
	end
	
	#檢查是否已設定timeout
	def timeout_set?
		!@timer.nil? && @timer.working?
	end
	
	def reset_timer
		#p "reset_timer"
		@timer.restart
	end

	
	def on_timeout
		@timer.stop
		#p "running on_timeout original at module/Timeout.rb"
	end
	
	#===============================================================================================
	#強制timeout，並停止計數器，@timer為nil或timer已停止時不動作。
	# execute_ev  :true 或 false ，為true的時候停止計數器並強制呼叫後續事件。為false時只停止計數器不呼叫任何事件。
	#===============================================================================================
	def force_timeout(execute_ev=false)
		return if !timeout_set?
		@timer.stop 
		send @tgt_symbol if execute_ev
	end
	
end