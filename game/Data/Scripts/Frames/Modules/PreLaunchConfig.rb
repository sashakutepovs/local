#==============================================================================
# This script is created by Kslander 
#==============================================================================

#這個模組主要用來處理init頁籤的內容，由於Game_Event不一定會有專屬
#的Game_Interpreter所以必須這樣使用。這個模組被引用到Game_Event中

module PreLaunchConfig
  
  LABEL_INIT="init"   #初始化頁面的Label
  LABEL_NIGHT="night" #夜晚頁面的Label
  LABEL_DAY="day"     #白天頁面的Label
  LABEL_INIT_END="end_"+LABEL_INIT
  LABEL_DAY_END="end_"+LABEL_DAY
  LABEL_NIGHT_END="end_"+LABEL_NIGHT
  
  
  attr_accessor :isOverMapToken           #是否為OVERMAP事件(包含營地跟腳色)
  attr_accessor :portraits                #portrait陣列...效能考量用陣列
  attr_reader :overMapChar
  attr_reader :overMapCamp
  attr_reader :allow_trigger		 #是否允許這個事件被以一班方式觸發，只有@monster不為nil的時候才有意義
  attr_accessor :ev_terrain_tag
  attr_accessor :ev_water_floor
  attr_reader :page_index
  attr_accessor :custom_page
  
  #初始化時必須呼叫super以避免初始化斷掉
	def initialize()
		super() 
		@isOverMapToken=false
		@allow_trigger=true
		@portraits=Array.new(2)
		@page_index=0
		@custom_page = nil
		@refresh_on_nap=true
	end
  
  #檢查傳入的page是否為init頁面
  def isLabeledEvent?
    return false unless @event.pages[0].list[0].code==118  
    return false unless containsLabel(@event.pages[0],LABEL_INIT)
    return true
  end
  
  #找出現在所屬狀況的event，日期資訊從Game_Map取得。
  def find_current_labeled_page
	return get_current_label_page
  end
  
	def get_current_label_page
		return @event.pages[0] if @use_current_page || single_page?
		return getCustomPage if !@custom_page.nil?
		return getDayPage if $game_date.dayTime==Game_Date::DAYTIME_DEF
		return getNightPage if $game_date.dayTime==Game_Date::NIGHTIME_DEF
	end
	
	
  def single_page?
	@page_index=0
	@event.pages.length==1
  end
  
  
  def containsLabel(page,label)
    page.list[0].parameters[0].eql?(label)
  end
  
# def getCustomPage
#	for i  in 0...@event.pages.length
#		if containsLabel(@event.pages[i],@custom_page)
#			@page_index=i
#			return @event.pages[i]
#		end
#	end
#	return nil
# end
  def getCustomPage
	tmpTarPage = @custom_page-1
	return nil if @event.pages[tmpTarPage].nil?
	@page_index=tmpTarPage
	return @event.pages[tmpTarPage]
  end
  
  #取得標記為白天內容的頁面
  def getDayPage
	for i  in 0...@event.pages.length
		if containsLabel(@event.pages[i],LABEL_DAY)
			@page_index=i
			return @event.pages[i]
		end
	end
	return nil
  end
  
  
  #取得標記為夜晚內容的頁面
  def getNightPage
	for i in 0...@event.pages.length
		if containsLabel(@event.pages[i],LABEL_NIGHT)
			@page_index=i
			return @event.pages[i]
		end
	end
	return nil
  end
  
  #取得標記為初始化內容的頁面
  def getInitPage
	@page_index=1
    @event.pages.find{|page| containsLabel(page,LABEL_INIT)}
  end
  
  
  def setupInitJumpPage
	@page_index=1
    @event.pages.find{|page| containsLabel(page,LABEL_INIT)}
  end
  
  #傳回一個全新的空page，主要是當只有日或只有夜的時候使用。
	def getEmptyPage
		return RPG::Event::Page.new()
	end
  
  
  #設定此事件為地圖的nap event(將nap event的id設定到$game_map中)
	def set_as_nap_event(event)
		$game_map.setNapEvent(event)
	end
  
  #設定事件使用當下頁面，不去尋找日夜頁面
	def use_current_page
		@page_index=0
		@use_current_page=true
	end

	def set_event_terrain_tag(terrainTag)
		@ev_terrain_tag = terrainTag
		@ev_terrain_tag = nil if terrainTag <= 0
	end

	def set_event_water_floor(water_floor=true)
		@ev_water_floor = water_floor
	end
  
  
  #=========================================================
  #
  #以下開始是setupExtraContents及由其
  #呼叫的方法，其他Utility方法都應該放在這之前。
  #且不應該出現在這之後。
  #
  #=========================================================
  
=begin  
============================================================

  傳入page並且讀取其中的所有內容並執行之
  傳入事件頁籤的執行內容並且執行之。
  使用與PortraitMovement相似的機制。
  預計會加入錯誤處理機制。
  這段是從Game_Interpreter裡搬出來的，
  應該可以正常處理沒有問題。
  這邊的方法也可以透過取得Game_Event物件的方式在遊戲中呼叫。

============================================================

  使用方式：
    label "init"
	label "common"
		script ... 
		通用初始化，不論日夜都會執行。
	label "end_common"
    label "night"
      script...   
        假設進行初始化時的時間為夜間
        此處的腳本將會被執行
    label "end_night"
     
    label "day"
      script...
        假設進行初始化時的時間為夜間
        此處的腳本將會被執行
    label "end_day"
 
    有開始標籤就必須要有結束標籤，否則不會停。
    若無錯誤仍會執行但結果可能與預期有落差。
    兩種標籤可以只有其中一種，若無夜間標籤，
    則夜間時此事件不會有任何動作。(應該要移除此事件或設定到空白頁)
    無標籤則不會有任何內容被執行
    要有init標籤才會走這個程序，不然就是一般事件的程序。
    

==========================================================
=end

	#mode: -1:全部處理(init+當下時間帶),0: 忽略common，只處理 (只處理當下時間帶的init)未實作==> 1:日 only(只處理白天的init)2:夜 only(只處理晚上的init)
	
	def setupExtraContents(page,mode=-1)
		return if page.nil? || @initialized
		common_start=get_label_index(page,"common")
		common_end=get_label_index(page,"end_common")
		label,closeLabel= getLabels
		label_start_index=get_label_index(page,label)
		label_end_index=get_label_index(page,closeLabel)
		eval_init_scripts(page,common_start+1,common_end-1) if(common_start!=-1 && common_end!=-1 && mode==-1) if init_allowed?(mode)
		eval_init_scripts(page,label_start_index+1,label_end_index-1) if(label_start_index!=-1 && label_end_index!=-1 && init_allowed?(mode))
	end
	def setupExtraLateContents(page,mode=-1)
		return if page.nil? || @late_initialized || self.deleted?
		common_start=get_label_index(page,"late_common")
		common_end=get_label_index(page,"end_late_common")
		label,closeLabel= getLabels
		label_start_index=get_label_index(page,label)
		label_end_index=get_label_index(page,closeLabel)
		eval_init_scripts(page,common_start+1,common_end-1) if(common_start!=-1 && common_end!=-1 && mode==-1) if init_allowed?(mode)
		eval_init_scripts(page,label_start_index+1,label_end_index-1) if(label_start_index!=-1 && label_end_index!=-1 && init_allowed?(mode))
		@late_initialized = true
	end
  
  def init_allowed?(mode)
	return false if mode==3  
	return true if mode<=0
	return true if ($game_date.day? && mode==1) || ($game_date.night? && mode==2)
	return false
  end
  
	def eval_init_scripts(page,start_index,end_index)
		#p "eval_init_scripts #{@name} #{@x} #{@y}"
		init_script=""
		for i in start_index..end_index
			init_script+=page.list[i].parameters[0]+"\n"
		end
		eval(init_script)
	end
  
  def get_label_index(page,label)
	count= page.list.length
	for index in 0...count
		return index if page.list[index].code==118 && page.list[index].parameters[0].eql?(label)
	end
	return -1
  end
  
  
  def filter_list(list)
	new_list=[]
	isInBlock=false
	for i in 0...list.length
		skip_this=false
		if(list[i].code==118)
			skip_this=list[i].parameters[0].eql?("init")
			["day","night","common","late_common"].each{
				|label|
				 if label.eql?(list[i].parameters[0])
				 isInBlock=true
				 break
				 end
			}
			["end_day","end_night","end_common","end_late_common"].each{
				|label|
				break if !isInBlock
				if label.eql?(list[i].parameters[0])
				isInBlock=false
				skip_this=true
				break
				end
			}
		end	
		new_list.push(list[i]) if !isInBlock && !skip_this
	end
	new_list
  end
  
  def getLabels(reverse=false)
      case $game_date.dayTime
        when Game_Date::DAYTIME_DEF
          label=LABEL_DAY
          closeLabel=LABEL_DAY_END
        when Game_Date::NIGHTIME_DEF
          label=LABEL_NIGHT
          closeLabel=LABEL_NIGHT_END
      end
      return [label,closeLabel]
  end
  

  
end
