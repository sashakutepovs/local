#==============================================================================
# This script is created by Kslander 
#==============================================================================
#以模組的方式盡可能在不影響內建Game_Interpreter的狀況下增加功能
#以include方式在Game_Interpreter中被引用
#這個模組有另一個分身在Editables/41.......
#引用後即可直接在事件編輯頁的視窗中以Script的方式呼叫定義的方法。


module GIM_OM
  #處理nap的狀況，注意此處會反載入所有的地圖SPRITESET   以及僅能呼叫一個中斷器執行續   除了記憶體控制外的資訊  不可新增其他CODE
	def handleNap(type=:normal,map_id=$game_map.map_id_rec,*param)
		p "GIM_OM handleNap"
		$game_pause = true
		chcg_background_color(0,0,0,0,7)
		screen.start_tone_change(Tone.new(0,0,0,0),0)
		$game_portraits.lprt.hide
		$game_player.release_chs_group
		call_msg("common:Lona/nap") if !$game_map.isOverMap
		$game_map.pre_nap  
		$game_map.nap						#處理game_map相關的內容，像是主角重新設置事件、主角留在定位等。
		$game_player.actor.process_nap_change
		$game_map.setup(map_id)
		case type
			when :normal;
				tgtx=$game_player.x
				tgty=$game_player.y
			when :transport
				tgtx,tgty=param
			when :point;
				tgtx,tgty=$game_map.get_storypoint(param[0])
			when :region;
				tgtx,tgty=$game_map.get_random_region(param[0])
		end
		$game_player.moveto(tgtx,tgty)
		SceneManager.scene.dispose_spriteset #test
		SceneManager.scene.create_spriteset
		$game_map.refresh #因為nap必須保留部分事件不重新初始化，所以需要額外呼叫一次refresh來讓事件翻頁功能正常運作
		Cache.clear_chs_material(true) #Cache.clear
		$game_map.aft_nap
		check_wakeup_event
		wait_for_message
		$game_pause = false
		achCheckDate
		p "GIM_OM handleNap end"
	end
	
end
