#==============================================================================
# This script is created by Kslander 
#==============================================================================
class Dialog_Timer < Game_Timer
	attr_reader :count
  def initialize
    @count = 0
    @working = false
	@time=0 #記錄這個物件被設定的timeout時間
	@mode=""
  end

  #--------------------------------------------------------------------------
  #覆寫，增加已sec為單位的處理
  #unit : 計時單位數
  #frame_mode : 模式，true或false，
  #--------------------------------------------------------------------------
  def start(unit ,mode="sec")
	raise "未設定timeout時間 "if unit.nil?
	case mode
		when "sec"
			@count = unit * Graphics.frame_rate
		when "frame"
			@count=unit 
		else
			@count=unit 
	end
		@mode=mode if !mode.eql?("continue") #將傳入的參數存起來以供未來restart使用，夾如mode="continue"時不更新
		@time=unit
		@working = true
  end
  
  def update
    if @working && @count > 0
      @count -= 1
      on_expire if @count <= 0
    end
  end
  
  #--------------------------------------------------------------------------
  #重新開始計時，
  #refresh : 是否將count歸零，true：將count歸零，false，以現有的count繼續計算
  #(假如已timeout則強制重新計算)
  #--------------------------------------------------------------------------
  def restart(refresh=true)
		return start(@count,"continue") if !refresh && !timeout?
		return start(@time,@mode) 
  end
  
  def on_expire
	@working=false
  end
  
  #檢查是否已timeout
  def timeout?
	@count==0
  end
  
end
