#==============================================================================
# This script is created by Kslander 
#==============================================================================
#這個模組主要用來處理懷孕及月經相關的事件，被引用到Game_Actor中


module Reproduction

	SAFE_DAY=0
	#PRE_MENSES=1
	MENSES_DAY=2
	#POST_MENSES=3
	OVUL_DAY=4
	
	PREG_LV_1=6
	PREG_LV_2=7
	PREG_LV_3=8
	PREG_LV_4=9
	PREG_LV_5=10  #只在出產日出現
	PREG_LVS=[PREG_LV_1,PREG_LV_2,PREG_LV_3,PREG_LV_4,PREG_LV_5]
	
	
	PREG_RATE_SAFE=[0.0,0.0,0.0]
	PREG_RATE_MENS=[0.08]
	PREG_RATE_OVUL=[0.15,0.3,0.4,0.6,0.8,0.6,0.4,0.2]
	
	
	MISCARRIAGE_DOOR=0
	attr_reader :prev_status_log#上個週期的狀況記錄
	attr_reader :status_log 
	attr_reader :menses_schedule
	attr_reader :prev_menses_schedule
	attr_reader :currentDay
	attr_reader :preg_rate
	attr_reader :baby_race
	attr_reader :preg_day
	attr_reader :preg_date
	attr_reader :labor_date
	attr_reader :preg_cycle
	attr_reader :cycle_start
	attr_reader :preg_level
	attr_reader	:preg_rates
	attr_reader :cycle_number
	
	#log variables
	attr_reader :current_log_no
	#log variables
	
	
=begin
	menses 週期為16天+ rand(5)
	menses 發生在2+rand(2)天
	週期結束後設定安全日
	排卵日發生在 8+rand(3)-上一個月的安全日-上個月的月經日+1
	安全日=第一天+rand(2)
=end
	

	def setup_first_cycle
		p "setting up first menses cycle"
		@menses_schedule=System_Settings::FIRST_MENSES_CYCLE
		@status_log=Array.new(18,nil) #每天狀況的紀錄
		
		@preg_rates=System_Settings::FIRST_PREG_RATE
		@currentDay=System_Settings::MENSES_START_DAY #現在在循環中的第幾天。從1開始計算
		@preg_day=-1 #懷孕天數
		@preg_race=nil #使女主角懷孕的東西的種族
		@preg_cycle=nil  #主角懷孕物種的懷孕周期(第幾天進入lv2之類的)
		@preg_level=0  #懷孕等級
		@forcePreg=0 #forcePreg，強制懷孕有效天數，單位day
		@labor_date=nil
		self.baby_health=0
		@preg_rate=0
		@current_log_no = @currentDay-1 # 0-17 當下在週期上的第幾天
		@cycle_start= $game_date.offspring.decDays(@currentDay).date#這個cycle的位置
		
		setup_first_prev_status
		update_reproduction
	end
	
	
	def setup_first_prev_status
		@prev_menses_schedule=System_Settings::FIRST_PREV_MENSES_CYCLE
		@prev_status_log=System_Settings::FIRST_PREV_STATUS_LOG
		
		#製造假的status log
		for i in 0...@currentDay
			case @menses_schedule[i]
				when 0; @status_log[i] = :fine
				when 2; @status_log[i] = :menses
				when 4; @status_log[i] = :ovul
				else @status_log[i] = :fine
			end
		end
	end
	
	def new_cycle
		day= $game_date.day
		@prev_menses_schedule=@menses_schedule
		@prev_preg_rates=@preg_rates
		@currentDay=0
		@cycle_start=$game_date.date
		generateCycle
	end
	
	
	#更換新的status_log，並把當下的@status_log設定為@prev_status_log
	def switch_status_log
		@current_log_no = 0
		@prev_status_log=@status_log
		@status_log=Array.new(18,nil)		
	end
	
	
	def empregnanted?
		return true if @preg_day!=-1
		return false
	end
	def get_preg_rate_on_date(date)
		return 0 if !@preg_rates[date]
		@preg_rates[date]
	end


	def generateCycle
		p "generating new cycle"
		cycle_length=16+rand(5)
		safe_days=Array.new(1+rand(2),SAFE_DAY)
		preg_rate_safe=Array.new(safe_days.length,0.0)
		menses_days=Array.new(1+rand(3),MENSES_DAY)
		#menses_days=Array.new(1,MENSES_DAY)
		ovul_length=cycle_length-safe_days.length-menses_days.length
		ovul_days=Array.new(ovul_length,OVUL_DAY)
		preg_rate_safe=Array.new(safe_days.length,PREG_RATE_SAFE[0])
		preg_rate_ovul=PREG_RATE_OVUL
		preg_rate_ovul+=Array.new(ovul_length,0.0) if PREG_RATE_OVUL.length<ovul_length
		preg_rate_menses=PREG_RATE_MENS
		preg_rate_menses+=Array.new(menses_days.length-PREG_RATE_MENS.length,0.0) if PREG_RATE_MENS.length<menses_days.length
		@preg_rates=preg_rate_safe+preg_rate_ovul+preg_rate_menses
		@menses_schedule=safe_days+ovul_days+menses_days
		@days_changed=false
	end
	
	#只有在nap的時候才呼叫這個方法。
	def update_reproduction
		update_day
		if(empregnanted?)
			update_pregnancy
		else
			update_preg_rate
			check_preg
		end
	end
	
	def update_day
		@currentDay = $game_date.daysSince(@cycle_start,true)
		p "@currentDay>= @menses_schedule.length =>#{@currentDay >= @menses_schedule.length} ,@currentDay=>#{@currentDay} @menses_schedule.length=>#{@menses_schedule.length}"
		if  @currentDay >= @menses_schedule.length
			record_day_log
			new_cycle 
		else
			record_day_log
		end
	end
	
	def record_day_log
		p "record_day_log"
		current_log_day = $game_date.date[2]
		return if @last_update_day == current_log_day
		@last_update_day = current_log_day
		rate_today = @menses_schedule[@currentDay-1]
		last_preg_rate = @menses_schedule[@currentDay-1].nil? ? @prev_menses_schedule.last : @menses_schedule[@currentDay-1]
		#vag_cums=self.getVagCumsAmt
		if self.nth_day_in_period(2) ==0 && self.menses_status == 2
			@status_log[@current_log_no]=:menses
		elsif  self.nth_day_in_period(2) >=1 && self.menses_status == 2
			@status_log[@current_log_no]=:bad
		elsif self.preg_rates[@currentDay-1].nil?
			@status_log[@current_log_no]=:error
		elsif self.preg_rates[@currentDay-1] >= 0.7
			@status_log[@current_log_no]=:ovul
		#elsif self.preg_level != 0 && vag_cums > 500
		#	@status_log[@current_log_no]=:active_plus
		#elsif self.preg_level != 0 && vag_cums > 0
		#	@status_log[@current_log_no]=:active
		#elsif self.preg_level != 0
		#	@status_log[@current_log_no]=:fine
		#elsif vag_cums > 500
		#	@status_log[@current_log_no]=:active_plus
		#elsif vag_cums > 0
		#	@status_log[@current_log_no]=:active
		else 
			p "uncaught status log condition"
			#@status_log[@current_log_no]=:fine
			@status_log[@current_log_no]=genCommonRecord
		end
		#p "***==================================================================================================***"
		#p "@current_log_no=>#{@current_log_no}  record_day_log status =>#{@status_log[@current_log_no]}"
		#p "========================================================================================================"
		#p "self.nth_day_in_period(2)=>#{self.nth_day_in_period(2)}"
		#p "self.menses_status=>#{self.menses_status}"
		#p "@currentDay =>#{@currentDay}"
		#p "@current_log_no =>#{@current_log_no}"
		#p "self.preg_rates[@currentDay]=>#{self.preg_rates[@currentDay-1]}"
		#p "self.preg_rates=>#{self.preg_rates}"
		#p "self.menses_schedule=>#{self.menses_schedule}"
		#p "self.preg_level=>#{self.preg_level}"
		#p "vag_cums=>#{vag_cums}"
		#p "========================================================================================================"
		@current_log_no += 1
		switch_status_log if @current_log_no >17
	end
	def genCommonRecord
		#tmpRecord = [:fine,]
		tmpHardRecord = []
		tmpHardRecord << :active_plus if self.getVagCumsAmt > 500
		tmpHardRecord << :active if self.getVagCumsAmt > 0
		tmpHardRecord << :preg_level2 if self.preg_level == 2
		tmpHardRecord << :preg_level3 if self.preg_level == 3
		tmpHardRecord << :preg_level4 if self.preg_level == 4
		tmpHardRecord << :sick if self.stat["FeelsSick"] >= 1
		return tmpHardRecord.sample if !tmpHardRecord.empty?
		return :fine
	end
	


	def update_pregnancy
		@preg_day=preg_day_passed
		update_preg_level
	end

	def update_preg_rate
		p "update_preg_rate"
		return alter_preg_rate(@preg_rate) if @forcePreg>0
		@preg_rate = @preg_rates[@currentDay-1] 
	end
	
	def alter_preg_rate(value=1.0)
		@forcePreg-=1 
		@preg_rate=value
		@forcePreg=0 if @forcePreg<0
	end
	
	def menses_status
		@menses_schedule[@currentDay-1]
	end
	


	def check_preg
		return p "already pregnanted with race #{@preg_race}" unless @preg_race.nil? #先看有無懷孕
		@preg_rate += self.state_preg_rate-10
		return p "is on safe_days" if @preg_rate <= 0.0 #|| @menses_schedule[@currentDay]==SAFE_DAY 再看是否為SAFE DAY
		return p "no cums in vag" if  vag_cums.length==0
		cum_race=Hash.new
		cumsTotal=0
		vag_cums.each{
			|cum|
			
			tmpRace = cum.race
			tmpRace = "Others" if System_Settings::RACE_SEX_SETTING[tmpRace].nil?
			cum_race[tmpRace]= 0 if cum_race[tmpRace].nil?
			cum_race[tmpRace]+=cum.amt
			#old
			#cum_race[cum.race]= 0 if cum_race[cum.race].nil?
			#cum_race[cum.race]+=cum.amt
			cumsTotal+=cum.amt
		}
		raceChance=Array.new
		cum_race.each{
			|race,amt|
			chance=(amt.to_f/cumsTotal)*10 
			raceChance+=Array.new(chance,race)
		}
		preg_race=raceChance[rand(raceChance.length)]

		#判斷是否懷孕
		preg_value=cumsTotal*@preg_rate # (get_cums_capacity-cumsTotal)*@preg_rate
		preg_doorstep=rand(1000)
		if  preg_value > preg_doorstep
			set_preg(preg_race) 
			end
		
	end
	
	#period= 週期單位
	def nth_day_in_period(period=nil)
		return -1 if period.nil?
		return -1 unless @menses_schedule.include?(period)
		return -1 if (index=@menses_schedule.index(period)) > @currentDay
		@currentDay-(index+1)
	end

	#def set_seedbed_level?
	#	case @preg_race
	#		when "Human";		return false
	#		when "Moot";		return false
	#		when "Deepone";		return false
	#		when "Others";		return false
	#		when "Fishkind";	return false
	#		when "Orkind";		return true
	#		when "Goblin";		return true
	#		when "Abomination";	return true
	#	else
	#		return false
	#	end
	#end
	
	def set_preg(race,day=0)
		p "set preg with race #{race} "
		return p"already pregnented" if empregnanted?
		$story_stats["dialog_preg_exped"] = 1
		@preg_date=$game_date.date
		@preg_race=race
		set_baby_race
		set_baby_health
		self.add_state("WombSeedBed") if System_Settings::RACE_PREG_GEN_SEEDBED_LEVEL[@preg_race]
		@preg_day=day
		@preg_cycle=create_preg_cycle
		set_preg_schedule
		update_preg_level
	end
	
	#記錄出產時間並重寫現在的menses_schedule為懷孕時程，
	def	set_preg_schedule
		totalPregDays=0
		preg_schedule=Array.new
		for d in 0...@preg_cycle.length
			totalPregDays+=@preg_cycle[d]
			preg_schedule+=Array.new(@preg_cycle[d],PREG_LVS[d])
		end
		@preg_rates=Array.new(totalPregDays,0.0)
		@menses_schedule=preg_schedule
		year,month,day,timeshift=@preg_date
		labor_date=Game_Date.new(year,month,day,timeshift)
		@cycle_start = labor_date.date
		labor_date.addDays(totalPregDays)
		@labor_date=labor_date.date
		$story_stats["dialog_ready_to_birth"] = 1 
	end
	
	
	def preg_day_passed
		return 0 if @preg_date == []
		return $game_date.daysSince(@preg_date)
	end
	
	def preg_whenGiveBirth?
		return 50000 if self.preg_level <= 0
		return 50000 if !@preg_cycle
		tmpTotalDayFromCricle = 0
		@preg_cycle.each{|tmp|
			tmpTotalDayFromCricle += tmp
		}
		return tmpTotalDayFromCricle-preg_day_passed
	end
	
	#決定嬰兒的種族
	def set_baby_race
		raceChoice=System_Settings::CROSS_BREEDING_RESULT[self.race][@preg_race]
		baby_chance=Array.new
		raceChoice.each{
			|race,chance|
			baby_chance+=Array.new(chance,race)
		}
		@baby_race=baby_chance[rand(baby_chance.length)]
	end


	#強制操控preg數值，forceValue : 目標值 ，duration : 持續多久(單位:天)
	def force_preg_rate(forceValue,duration)
		@preg_rate=forceValue
		@forcePreg=duration
	end
	
	def create_preg_cycle
		#依照苗床化程度決定減低出產所需天數。
		seedbed_level = self.stat["WombSeedBed"]
		seedbed_level_deduction=System_Settings::RACE_SEX_SETTING[@baby_race][1][seedbed_level]
		cycle_template = System_Settings::RACE_SEX_SETTING[@baby_race][0][$story_stats["Setup_Hardcore"]]
		preg_cycle=Array.new
		for i in 0...cycle_template.length-1
			daysNeeded = [cycle_template[i].to_a.sample-seedbed_level_deduction, 1].max # line changed
			preg_cycle.push(daysNeeded)
		end
		preg_cycle.push(cycle_template.last.to_a.sample)
		preg_cycle
	end
	
	#更新中檢查是否符合流產條件
	def miscarriage?
		return false if labor? || !empregnanted? #未懷孕或即將出產時不會發生流產事件
		return self.baby_health==0 
	end
	
	#流產事件的事後處理
	def miscarriage_event
		@preg_day= -1
		@baby_race=nil
		self.baby_health=0
		@preg_race=nil
		@preg_cycle=[]
		@preg_date=nil
		@preg_level =0
	end


	#是否即將生產,用日期比對
	def labor?
		return false unless @preg_level==5
		return $game_date.date==@labor_date
	end
	
	def laborDate_to_dateAmt
		return nil if !@labor_date
		return $game_date.getDateUnit(*@labor_date)
	end
	

	#出產後處理
	def cleanup_after_birth
		remove_state("PregState")
		healCums("CumsCreamPie",1000)
		@preg_cycle=[]
		@preg_day=-1
		@baby_race=""
		self.stat["displayBabyHealth"] = 0
		self.baby_health=0
		@preg_race=nil
		@baby_birth_dialog =0
		@pain_value_preg =0
		@puke_value_preg =0
		$story_stats["dialog_ready_to_birth"]=0
		@preg_date=nil
		@preg_level=0
		#new_cycle ############################################# test
	end
	
	def set_baby_health(multiplier=1,update_current=true)
		race_health_bouns =0
		#case @baby_race
		#	when "Human";		race_health_bouns = self.stat["WombSeedBed"] * 5
		#	when "Moot";		race_health_bouns = self.stat["WombSeedBed"] * 5
		#	when "Deepone";		race_health_bouns = self.stat["WombSeedBed"] * 5
		#	when "Others";		race_health_bouns = self.stat["WombSeedBed"] * 1
		#	when "Fishkind";	race_health_bouns = self.stat["WombSeedBed"] * 50
		#	when "Orkind";		race_health_bouns = self.stat["WombSeedBed"] * 100
		#	when "Goblin";		race_health_bouns = self.stat["WombSeedBed"] * 50
		#	when "Abomination";	race_health_bouns = self.stat["WombSeedBed"] * 600
		#	when "troll";		race_health_bouns = self.stat["WombSeedBed"] * 400
		#end
		race_health_bouns = System_Settings::RACE_PREG_SEEDBED_HP_BOUNS[@baby_race] if System_Settings::RACE_PREG_SEEDBED_HP_BOUNS[@baby_race]
		val = ((self.attr_dimensions["health"][2]+self.attr_dimensions["sta"][2]+race_health_bouns)*multiplier).round
		self.battle_stat.set_stat_m("baby_health",val,[2,3])
		self.battle_stat.set_stat_m("baby_health",val,[0]) if update_current
		p "baby health setted #{battle_stat.get_stat_data("baby_health")}"
		#self.baby_health = ((self.attr_dimensions["health"][2]+self.attr_dimensions["sta"][2]+race_health_bouns)*multiplier).round
	end
	
	def update_preg_level
		return 	@preg_level=0 if @preg_day==-1
		@preg_level=0
		@preg_day=preg_day_passed
		days=@preg_day
		for i in 0...@preg_cycle.length
			days-=@preg_cycle[i]
			@preg_level+=1
			break if days<=0
		end
		@preg_level
	end
	
	def preg_rate
		@preg_rate[@currentDay-1]
	end
	
	def ovulate?
		self.preg_rate >=0.7
	end
	
	

	
	




end
