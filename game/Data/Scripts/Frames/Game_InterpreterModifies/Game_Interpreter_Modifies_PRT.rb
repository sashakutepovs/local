#==============================================================================
# This script is created by Kslander 
#==============================================================================
# 以模組的方式盡可能在不影響內建Game_Interpreter的狀況下增加功能
#以 include方式在Game_Interpreter中被引用
#注意include會讓GIM變成父類別，方法撞名時會以Game_interpreter中的為主
#引用後即可直接在事件編輯頁的視窗中以Script的方式呼叫定義的方法。

#這個腳本相依於module GIM_GO
#20190816後與GIM_GO的內容轉移到此腳本，GIM_GO消滅


module GIM_PRT

  #--------------------------------------------------------------------------
  # * 取得女主角的物件參考
  #--------------------------------------------------------------------------
  def lona
    $game_player.actor
  end
  
  def create_drop_items(droped_items,evx,evy)
	droped_items.each{
		|item|
		$game_map.summon_event(item,evx-rand(3),evy-rand(3))
	}
  end
	
	#portrait Controler when combat hit.
	def lona_HitWhenCombat(moodName)
		#return lona_unshow if $data_PrtFocusMode >= 1
		lona_mood(moodName)
		$game_player.actor.portrait.shake
	end
	
  #主角專用，召喚主角的立繪，支援特殊狀況只更新不顯示
	def lona_mood(moodName,forceShow=true)
		p "set mood to #{moodName}"
		lona.prtmood(moodName)
		lona_show if forceShow 
	end
  
  #主角專用
  #position :將主角顯示在哪個位置上，預設右邊(0 :左 ,1:右)
  def lona_show(position=1)
    return setLprt("Lona") if position==0
    return setRprt("Lona") if position==1
  end
  
  #主角專用
  def lona_unshow
    $game_portraits.portraitDownStage($game_portraits.getPortrait("Lona"))
  end
  
  def lona_stat
    $game_player.actor.stat
  end
  
  #將圖像設定成Focus狀態並顯示在畫面上
  def setLprt(name)
    $game_portraits.setLprt(name)
  end
  
  def setRprt(name)
    $game_portraits.setRprt(name)
  end 
    
  #將腳色設定成Fade狀態並顯示在畫面上
  def fLprt(name)
    $game_portraits.getPortrait(name).setFade
    $game_portraits.setLprt(name)    
  end
  
  def fRprt(name)
    $game_portraits.getPortrait(name).setFade
    $game_portraits.setRprt(name)
  end
  
  def swap
    $game_portraits.swap
  end
  
  def swprt
    $game_portraits.swprt
  end
  
  def lprt
    $game_portraits.lprt
  end 
  
  def rprt
    $game_portraits.rprt
  end
  

end
