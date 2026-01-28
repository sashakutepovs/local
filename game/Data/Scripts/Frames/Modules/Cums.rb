#==============================================================================
# This script is created by Kslander 
#==============================================================================

module Cums
  #這個模組主要用來處理cums，被引用到Game_Actor中  
    attr_reader :cumsMeters
	CUMS_CAPACITY= 1000
	
	#對ACTOR本體的連接器
  def init_cums
    @vag_cums=[]#當前身上的Cums內容
    @cumsMeters=makeCumsAmt
    @cumsNumber=0 #計數器，用來做為每個cums的分辨及排序依據
  end
  
  #初始cums總量紀錄
  def makeCumsAmt
    {
      "CumsMoonPie"=>0,
      "CumsCreamPie"=>0, #vag
      "CumsHead"=>0,
      "CumsTop"=>0,
      "CumsMid"=>0,
      "CumsBot"=>0,
      "CumsMouth"=>0
      }
  end

  def get_cums_capacity
	CUMS_CAPACITY
  end
  
  def vag_cums
	 @vag_cums
  end


	def vag_cums_race
		cums=Hash.new
		@vag_cums.each{
			|cum|
			cums[cum.race]=0 if cums[cum.race].nil?
			cums[cum.race]+=cum.amt
		}
		cums
	end
  #part : 哪個部位，傳入字串ex: "body"  race :種族、字串  、amt 數量，單位ml
  def addCums(part,amt=(1+rand(100)),race=@stat["EventVagRace"])
	race="Human" if race.nil?
    if(part.eql?("CumsCreamPie"))
    addVagCums(part,amt,race)
    @cumsMeters[part]=getVagCumsAmt
    else
    @cumsMeters[part]+=amt
    end
	check_cum_maximum
    update_cum_state
  end
  
  #針對vag的特殊處理
  def addVagCums(part,amt,race)
  	@cumsNumber+=1
    @vag_cums.push(Cum.new(part,race,amt,@cumsNumber))
  end
 
  
  #取得顯示用的數值
  def getDisplayCumsAmt
    {
      "vag"	 =>getVagCumsAmt,
      "anal"   =>@cumsMeters["CumsMoonPie"],
      "mouth"   =>@cumsMeters["CumsMouth"],
      "body"   =>@cumsMeters["CumsHead"]+@cumsMeters["CumsTop"]+@cumsMeters["CumsMid"]+@cumsMeters["CumsBot"]
    }
  end
  
  def getVagCumsAmt
    cumsAmt=0
      @vag_cums.each{
    |cum|
     cumsAmt+=cum.amt
    }
	cumsAmt
  end
  
  
  
  #取得part名稱跟狀態編號的對應表。
  def cumsMap
    {
      "CumsCreamPie"=>18,
      "CumsMoonPie"=>19,
      "CumsHead"=>20,
      "CumsTop"=>21,
      "CumsMid"=>22,
      "CumsBot"=>23,
      "CumsMouth"=>24
     }
  end
  
  
  #取得全身上下所有的精液總量
  def getTotalCumsAmt
    cumsAmt=0
    @cumsMeters.each{
		|key,val|
		cumsAmt+=val
	}
    cumsAmt
  end
  
  #檢查當下的精液量，並調整state與之相符
  def update_cum_state
	@cumsMeters.each{
		|key,val|
		levelDef=get_cum_level_def[key]
		amt=@cumsMeters[key]
		level=0
		for i in 0...levelDef.length
			if amt>levelDef[i] && amt!=0
				level+=1
			end	
		end
		setup_state(cumsMap[key],level)
	}

  end
  
  def check_cum_maximum
		max_def=get_cums_max_def
		@cumsMeters.each{
			|key,val|
			next if key.eql?("CumsCreamPie")
			dispatch_cum_to_body(key) if val> max_def[key];
			@cumsMeters[key]=0 if val<0
			@cumsMeters[key]=max_def[key] if val>max_def[key]
		}
		check_vag_cum_maximum;
		
  end
  
  
  
  
  def dispatch_cum_to_body(partDis)
	max_def=get_cums_max_def
	extraCum=@cumsMeters[partDis]-max_def[partDis]
	max_def=get_cums_max_def
	partCandidate=["CumsHead","CumsTop","CumsMid","CumsBot"]-[partDis]
	while extraCum>0 && partCandidate.length>0
		tgt_part=partCandidate.sample
		if (@cumsMeters[tgt_part]>=max_def[tgt_part])
		  partCandidate-=[tgt_part]
		  next
		end
		@cumsMeters[tgt_part]+=extraCum
		leftover=@cumsMeters[tgt_part]-max_def[tgt_part]
		extraCum=leftover
	end
  end
  
  def check_vag_cum_maximum
		vag_max=get_cums_max_def["CumsCreamPie"]
		invalidCums=[]
		return unless @cumsMeters["CumsCreamPie"]> vag_max
		extraCum=@cumsMeters["CumsCreamPie"]-vag_max
		for k in 0...@vag_cums.length
			leftover=@vag_cums[k].deduct(extraCum)
			invalidCums.push(@vag_cums[k]) unless @vag_cums[k].valid
			break if leftover>=0
			extraCum=leftover.abs
		end
		dispatch_cum_to_body("CumsCreamPie")
		@cumsMeters["CumsCreamPie"]=getVagCumsAmt
		@vag_cums-=invalidCums
  end
  
  
  
  #計算每日減少量，
  #並將vag_cums計算後總量低於0的移除
  def dailyDeduction
    invalidCums=[]
    @vag_cums.each{
    |cum|
      cum.dailyDeduction
      invalidCums.push(cum) unless cum.valid
    }
    @vag_cums-=invalidCums
  end
  

  
  #減少身上裝載的精液量。
  def healCums(partName,healAmt=(50+rand(50)))
	return p "no cums added" if @vag_cums.length==0 && partName.eql?("CumsCreamPie")
	partName=@cumsMeters.keys.sample if partName.nil?
	@cumsMeters[partName]-=healAmt
	
	if !partName.eql?("CumsCreamPie")
		update_cum_state 
		return check_cum_maximum
	end
	
	leftover=healAmt
	while leftover>0
		tgt_cum=@vag_cums.sample
		leftover=tgt_cum.deduct(leftover)
		@vag_cums-=[tgt_cum] unless tgt_cum.valid
		p "leftover #{leftover}"
		break if leftover>=0
		leftover=leftover.abs		
	end
	@cumsMeters["CumsCreamPie"]=getVagCumsAmt
	@cumsMeters.each{
		|part,val|
		@cumsMeters[part]=0 if val<0
	}
	p "healing cums creampie #{@CumsMeters}"
	check_cum_maximum
    update_cum_state
  end
    
  def show_cums
   p @cumsMeters
  end
  
  
  class Cum
    attr_reader :part
    attr_reader :race
    attr_reader :amt
    attr_reader :sort
    
    def initialize(part,race,amt,sort=0)
      @part=part
      @race=race
      @amt=amt
      @sort=sort
    end
    
    #減少，並且回傳增減後的數值，減少的值可能要考慮從其他地方拿來
    def deduct(value=100)
      @amt=@amt-value
	  @amt.abs
    end
    
    #隨機減少1到maxvalue數量的cum
    def deductRandomly(maxvalue=STAT_SETTINGS::MAX_CUM_RAND_DEDUCTION)
      @amt-=(1+rand(maxvalue)).to_i
    end
    
    def halfDeduction
      @amt=@amt/2
    end
    
    def valid
      @amt>0
    end

    
    
    
    
  end
  
  
  
  
  
  
end