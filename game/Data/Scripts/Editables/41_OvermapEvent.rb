=begin



=end

module GIM_OM

	#監聽overmap相關的按鍵
	def listen_overmap_inputs
		
	end
	

	#按下這些確定鍵時視region_id不同跳出不同的選項。
	def trigger_explore_event
		return unless $game_map.isOverMap
		rndEvent=get_random_encounter_event
		return if rndEvent.nil?
		load_script(rndEvent)
	end

	#overmap移動時檢查是否發生overmap事件
	def check_overmap_event
		return unless $game_map.isOverMap
		rndEvent=get_random_encounter_event
		return load_script(rndEvent) unless rndEvent.nil?
	end
	
	def get_random_encounter_event
		rndEventList=@overMapEventList["encounter_events"]
		return if rndEventList.nil?
		return get_random_event(rndEventList)
	end
	
	def get_random_explore_event
		explEventList=@overMapEventList["explore_events"]
		return if explEventList.nil?
		return get_random_event(explEventList)
	end

	
	def get_random_event(eventList)
		eventScript=nil
		return if eventList.nil?
		randIndex=(rand(100)+1).to_i
		for x in  0...eventList.length
			randIndex-=eventList[x][1]
			return eventScript=eventList[x][0] if randIndex<=0
		end
		return nil
	end
	
	#由Game_Map呼叫，setup時傳入該地圖所屬的reion_id/event list Unused
	#def setOverMapEventList(eventList)
	#	@overMapEventList=eventList
	#end


end