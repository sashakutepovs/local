class Portrait_System
=begin
  這個類別用來統合處理所有portrait物件
  包含Alona_Portrait跟Portrait
  對外用$game_portraits取得
  基本上是單體存在(singleton)
=end
	attr_accessor :prevLprt
	attr_accessor :prevRprt
	def set_canvas
	end
	def initialize
		$game_player.actor if $game_player #making sure $game_player.actor is created before we request lona portrait
		#if .json files in condition had $game_player.actor it caused crash when returning to title menu.
		clear_updatequeue
		@portraits={}
		@portrait_idle={}#portrait的閒置時間
		@lprt_show=false
		@rprt_show=false
		fetch_all_portraits #grab only, no file IO , throws exception if $data_npc_portraits or $data_lona_portrait is gone
	end
	
	def fetch_all_portraits
		$data_npc_portraits.each{|prt|addPortrait(prt)}
		fetch_lona_portrait
		dispose_portrait_mat
	end
	
	
	def fetch_lona_portrait
		lona= $game_actors[1]
		addPortrait(Lona_Portrait.new(lona,$data_lona_portrait[1],lona.statMap["pose"],$data_lona_portrait[0],lona.statMap["canvas"][lona.statMap["pose"]]))
		addPortrait(NPC_layer_Portrait.new($game_NPCLayerMain,$data_lona_portrait[1],$game_NPCLayerMain.statMap["pose"],$data_lona_portrait[0],$game_NPCLayerMain.statMap["canvas"][$game_NPCLayerMain.statMap["pose"]]))
		addPortrait(NPC_layer_Portrait.new($game_NPCLayerSub,$data_lona_portrait[1],$game_NPCLayerSub.statMap["pose"],$data_lona_portrait[0],$game_NPCLayerSub.statMap["canvas"][$game_NPCLayerSub.statMap["pose"]]))
	end
	
    
	def lona_position
		lona=getPortrait("Lona")
		p "x: #{lona.portrait.x}  y: #{lona.portrait.y}" if $degug_portrait
	end
    
	def getPortrait(name)
		p "Missing Portrait #{name}, using character:\"nil\" instead" if @portraits[name].nil? if $degug_portrait
		return @portraits["nil"] if@portraits[name].nil?
		return @portraits[name]
	end
	
	def hasPortrait?(name)
		!@portraits[name].nil?
	end
    

	def addPortrait(prt)
		@portraits[prt.charName]=prt
	end

    def allPortrait
		p @portraits.keys
    end
    
	def portraitOnStage(prt)
		prt.update
		prt.show
		@all_portraits.push(prt)
		update
	end
	
	def resume_portraits
		lprt.portrait.show if @lprt_show
		rprt.portrait.show if @rprt_show
	end
	
	#離開畫面前記錄當下portrait的狀況
	def save_and_hideportraits
		@lprt_show=lprt.portrait.visible
		@rprt_show=rprt.portrait.visible
		lprt.hide
		rprt.hide
	end
    
    
    def portraitDownStage(prt)
      prt.unshow unless prt.nil?
      p "down stage #{prt}" if $degug_portrait
      @all_portraits-=[prt]
    end
    
    def clear_updatequeue
      @all_portraits=Array.new
    end
    
    def hideAllPortrait
      @portrait.each{|key,prt| prt.unshow}
    end
	
    

    def update
      @all_portraits.each{
        |prt|
        prt.update_position
        update_auto_hide(prt)
      }
    end
    
    
    
	def update_auto_hide(portrait)
		return if $game_message.busy? || $game_map.interpreter.running?
		@portrait_idle[portrait]=0 if @portrait_idle[portrait].nil?
		@portrait_idle[portrait]+=1
		if(getSec(@portrait_idle[portrait])>=System_Settings::PORTRAIT_AUTO_HIDE_SEC)
			portrait.hide
			portraitDownStage(portrait)
			@portrait_idle.delete(portrait)
			portrait.delete_sprite
		end
	end
	
	def executeAutoHide(portrait)
		portrait.hide
		portraitDownStage(portrait)
		@portrait_idle.delete(portrait)
	end
    
	def getSec(number)
		(number/Graphics.frame_rate).round
	end
    
  #交換兩個portrait的位置，如果沒有傳值，預設左右互換。
  def swap_prt(left=@lprt,right=@rprt)
    @rprt=left
    @lprt=right
    @lprt.setFlipped(true)  unless @lprt.nil? 
    @rprt.setFlipped(false)  unless @rprt.nil?
  end
  
	def setLprt(name)
		portraitDownStage(@lprt) unless @lprt.nil?
		@lprt=getPortrait(name)
		@rprt=nil if @lprt==@rprt
		@lprt.setFlipped(true) unless @lprt.nil?
		@lprt.reset_to_default
		portraitOnStage(@lprt)
		@portrait_idle[@lprt]=0
		@prevLprt = name if !["nil",nil].include?(name)
	end
  
	def setRprt(name)
		portraitDownStage(@rprt) unless @rprt.nil?
		@rprt=getPortrait(name)
		@lprt=nil if @lprt==@rprt
		@rprt.setFlipped(false) unless @rprt.nil?
		@rprt.reset_to_default
		portraitOnStage(@rprt)
		@portrait_idle[@rprt]=0 
		@prevRprt = name if !["nil",nil].include?(name)
	end
    
	def getLprt_idle_time
		return @portrait_idle[@lprt] if @portrait_idle[@lprt]
		0
	end
	def getRprt_idle_time
		return @portrait_idle[@rprt] if @portrait_idle[@rprt]
		0
	end
	def swprt
		swap(@lprt)
		swap(@rprt)
	end
  
  def swap(prt)
    return if prt.nil?
    return prt.fade		if prt.focused?
    return prt.focus	if prt.faded?
  end
  
  def lprt
    return getPortrait(nil) if @lprt.nil?
    @lprt
  end
  
  def rprt
    return getPortrait(nil) if @rprt.nil?
    @rprt
  end
  
  def hide_all_portraits(instant=false)
	if @lprt
		@lprt.hide
		@lprt.skip_animation if instant
	end
	if @rprt
		@rprt.hide
		@rprt.skip_animation if instant
	end
	
  end
  
  def dispose_portrait_mat
	#p "dispose_portrait_mat TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
	p "dispose_portrait_mat "
	@all_portraits.each{
		|portrait|
		next if portrait.is_a?(Lona_Portrait)
		portrait.dispose_part
	}
	#p "dispose_portrait_mat end TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
  end
  


end
