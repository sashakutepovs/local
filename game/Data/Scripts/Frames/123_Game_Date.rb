#==============================================================================
# This script is created by Kslander 
#==============================================================================

class Game_Date
	DATE_START=1 #時間起始
	YEAR_LENGTH=12 #單位:月
	MONTH_LENGTH=16 #單位:day
	DAY_LENGTH=2 #單位:基本時間單位
	
	YEAR_START=1
	MONTH_START=1
	DAY_START=1

	DAYTIME_DEF=1 #白天的定義
	NIGHTIME_DEF=2 #夜晚的定義

	attr_reader :date #取得當下的時間
	attr_reader :year
	attr_reader :month
	attr_reader :day
	attr_reader :timeShift
	attr_reader	:day_count
	attr_reader :area_weather_list
	attr_reader :area_night_list
	attr_reader :current_weather
	attr_reader :current_night_light
	attr_reader :prev_date
	#attr_reader	:current_date_RGBO
	#attr_reader	:current_night_RGBO


	def initialize(year=YEAR_START,month=MONTH_START,day=DATE_START,dateShift=DAYTIME_DEF)
		raise "Invalid month number" if month>YEAR_LENGTH || month<=0
		raise "Invalid day number" if day>MONTH_LENGTH || day<=0
		raise "Invalid dateShift " if dateShift!=DAYTIME_DEF && dateShift!=NIGHTIME_DEF
		yearUnits=(year-YEAR_START)*YEAR_LENGTH*MONTH_LENGTH*DAY_LENGTH
		monthUnits=(month-MONTH_START)*MONTH_LENGTH*DAY_LENGTH
		dayUnits=(day-1)*DAY_LENGTH+dateShift
		@day_count=0
		@date=yearUnits+monthUnits+dayUnits
		@area_weather_list = Array.new(10){|index|rand(15)} 
		@area_night_list = [0,1,2,3,4,5,6,7,8,9,10,11,12,13]
		@current_weather = 0
		@current_night_light = 0
		@prev_date = @date
		#@current_date_RGBO=[0,0,0,0]
		#@current_night_RGBO=[0,0,0,0]
		calculateDate
	end
	
	def expireTradeHashCheck
		tmpDateAmt = self.dateAmt
		$story_stats["CharacterItems"].each{|charStoreExpireDate|
			next $story_stats["CharacterItems"].delete(charStoreExpireDate[0]) if charStoreExpireDate[1][2].nil?
			next if charStoreExpireDate[1][2] > tmpDateAmt
			$story_stats["CharacterItems"].delete(charStoreExpireDate[0])
		}
		$story_stats["CharacterSteal"].each{|charStoreExpireDate|
			next $story_stats["CharacterSteal"].delete(charStoreExpireDate[0]) if charStoreExpireDate[1][0].nil?
			next if charStoreExpireDate[1][0] > tmpDateAmt
			$story_stats["CharacterSteal"].delete(charStoreExpireDate[0])
		}
	end
	
	def date(debug=false)
		calculateDate(debug)
		[@year,@month,@day,@timeShift]
	end
	
	
	#取得純數量日期
	def dateAmt
		@date
	end
	
	
	#將指定的日期轉換為dateunit
	def getDateUnit(year=@year,month=@month,day=@day,timeShift=@timeShift)
		yearUnits=(year-YEAR_START)*YEAR_LENGTH*MONTH_LENGTH*DAY_LENGTH
		monthUnits=(month-MONTH_START)*MONTH_LENGTH*DAY_LENGTH
		dayUnits=(day-1)*DAY_LENGTH+timeShift
		return yearUnits+monthUnits+dayUnits
	end
	
	def reserve_yesterday
		@yesterday=@date
	end
	

	def calculateDate(debug=false)
		dateShift=@date-DATE_START
		dayNumber=DAY_START
		yearNumber=YEAR_START
		monthNumber=MONTH_START
		
		#取得總共幾日
		while dateShift>=DAY_LENGTH
			dayNumber+=1
			dateShift-=DAY_LENGTH
		end
		
		while dayNumber>MONTH_LENGTH
			monthNumber+=1
			dayNumber-=MONTH_LENGTH
		end
		
		while monthNumber>YEAR_LENGTH
			yearNumber+=1
			monthNumber-=YEAR_LENGTH
		end
		dateShift=getTime(dateShift)
		
		p "calculated Date---YEAR: #{yearNumber} MONTH : #{monthNumber}  DAY:  #{dayNumber} currentTime :  #{dateShift} , amt : #{@date}" if debug
		@year= yearNumber
		@month=monthNumber
		@day=dayNumber
		@timeShift=dateShift 
	end
	
	def getTime(timeInDay=@date%2)
		case timeInDay
		when 0 
			return DAYTIME_DEF
		when 1 
			return NIGHTIME_DEF
		when -1
			return DAYTIME_DEF
		when 2
			return NIGHTIME_DEF
		else 
			raise "Unknown DAYTIME_DEFINITION #{timeInDay}"
		end
	end
	
	
	#將時間向後移動一天
	def oneDayForward(preserveTime=false)
		reserve_yesterday
		curTime=getTime
		reserve_yesterday
		case curTime
		when DAYTIME_DEF
			@date+=2 
		when NIGHTIME_DEF
			if (preserveTime)
				@date+=2
				else
				@date+=1
			end
		else 
			raise "Unknown error during move"
		end
		calculateDate
	end
	
	#將時間向前移動一天
	def oneDayBackward(preserveTime=false)
		curTime=getTime
		case curTime
		when DAYTIME_DEF
			@date-=2 
		when NIGHTIME_DEF
			if (preserveTime)
				@date-=3
				else
				@date-=2
			end
		else 
			raise "Unknown error during move"
		end
		calculateDate
	end
	
	#設定時間為當天的早晨
	def setMorning
		curTimeShift=@date%2
		p "curTimeShift Mor #{curTimeShift}"
		if(curTimeShift==1)
			return 
		elsif(curTimeShift==0)
			@date-=1
		end
	end
	
	#設定時間為當天的晚上
	def setNight
		curTimeShift=@date%2
		p "curTimeShift Night #{curTimeShift}"
		if(curTimeShift==1)
			@date+=1
		elsif(curTimeShift==0)
			return
		end
	end
	
	#向後移動一個時間單位(如日變夜、夜變日)
	def shift
		@date+=1
		calculateDate
	end
	
	#時間逆流一個單位
	def rshift
		@date-=1
		calculateDate
	end
	
	#將時間向前移動指定天數，tgtShift:目標時間單位，如果沒有傳入，則保留當下時間(假設當下為夜晚，則移動後也為夜晚)
	def decDays(days,tgtShift=getTime)
		raise "Invalid days parameter" if days<0
		@date-=days*DAY_LENGTH
		setMorning if tgtShift==DAYTIME_DEF
		setNight if tgtShift==NIGHTIME_DEF
		calculateDate
		return self
	end
	
	
	#將時間向前移動指定天數，tgtShift:目標時間單位，如果沒有傳入，則保留當下時間(假設當下為夜晚，則移動後也為夜晚)
	def addDays(days,tgtShift=getTime)
		raise "Invalid days parameter" if days<0
		@date+=days*DAY_LENGTH
		setMorning if tgtShift==DAYTIME_DEF
		setNight if tgtShift==NIGHTIME_DEF
		calculateDate
		return self
	end
	
	#將時間向前移動指定月份數，tgtShift:目標時間單位，如果沒有傳入，則保留當下時間(假設當下為夜晚，則移動後也為夜晚)
	def addMonths(months,tgtShift=getTime)
		raise "Invalid months parameter" if months<0
		@date+=months*MONTH_LENGTH*DAY_LENGTH
		setMorning if tgtShift==DAYTIME_DEF
		setNight if tgtShift==NIGHTIME_DEF
		calculateDate
		return self
	end
	
	#將時間向前移動指定年數，tgtShift:目標時間單位，如果沒有傳入，則保留當下時間(假設當下為夜晚，則移動後也為夜晚)
	def addYears(years,tgtShift=getTime)
		raise "Invalid years parameter" if years<0
		@date+=years*YEAR_LENGTH*MONTH_LENGTH*DAY_LENGTH
		setMorning if tgtShift==DAYTIME_DEF
		setNight if tgtShift==NIGHTIME_DEF
		calculateDate
		return self
	end
	
	
	#計算自某個日期到現在日期經過的日數，接受格式：[year,month,days.timeshift]，simple=false會使用嚴格模式，不足一天的時間及不視為一天。simple=true使用簡單模式，不足一天以一天計算
	def daysSince(sinceDate,simple=false)
		#轉換為純數值日期
		return -1 if sinceDate.nil?
		yearAmt=(sinceDate[0]-YEAR_START)*YEAR_LENGTH*MONTH_LENGTH*DAY_LENGTH
		monthAmt=(sinceDate[1]-MONTH_START)*MONTH_LENGTH*DAY_LENGTH
		dayAmt=(sinceDate[2]-1)*DAY_LENGTH
		timeAmt=yearAmt+monthAmt+dayAmt+sinceDate[3]
		return daysSinceDateSimple(timeAmt) if simple
		return daysSinceDate(timeAmt)
	end
	
	def daysSinceDateSimple(sinceDate)
		#p "sinceDate #{sinceDate} currentDate #{@date}"
		return -1 if sinceDate.nil?
		sinceDate=@date-sinceDate
		days=0
		while sinceDate>0
			break if sinceDate<0
			sinceDate-=DAY_LENGTH
			days+=1
		end
		days
	end
	
	#取得一個時間與狀況完全相同的物件
	def offspring
		self.class.new(@year,@month,@day,@timeShift)
	end
	

	#計算自某個日期到現在日期經過的日數，接受raw數字
	def daysSinceDate(sinceDate,simple=false)
		#p "sinceDate #{sinceDate} currentDate #{@date}"
		sinceDate=@date-sinceDate
		days=0
		while sinceDate>0
			sinceDate-=DAY_LENGTH
			break if sinceDate<0
			days+=1
		end
		days
	end
	
	
	
	#取得當下是否為白天
	def dayTime
		return NIGHTIME_DEF if night?
		return DAYTIME_DEF if day?
	end
	
	#取得當下是否為夜晚
	def night?
		@timeShift==NIGHTIME_DEF
	end
	
	def day?
		@timeShift==DAYTIME_DEF || @timeShift==0
	end
	
	#def get_weather #unused
	#	@area_weather_list = Array.new(10){|index|rand(20)} if @area_weather_list.empty?
	#	@current_weather=@area_weather_list.shift
	#	case @current_weather
	#		when 0..2;		return "sun"
	#		when 3..6;		return "full_sun"
	#		when 7;			return "light_rain"
	#		when 8;			return "middle_rain"
	#		when 9;			return "heavy_rain"
	#		when 10..12;	return "fog_sun"
	#		when 13..16;	return "fog_full_sun"
	#		when 17;		return "fog_light_rain"
	#		when 18;		return "fog_middle_rain"
	#		when 19;		return "fog_heavy_rain"
	#		else ;			return "sun"
	#	end
	#end
	#
	#def get_date_light
	#	@area_night_list = [0,1,2,3,4,5,6,7,8,9,10,11,12,13] if @area_weather_list.empty?
	#	if @prev_date-@data >=2
	#	current_night_light = @area_night_list.shift
	#	@prev_date=@date
	#	end
	#	#@current_night_light = @area_night_list.shift
	#	case @current_night_light
	#		when 0 ;return "half_moon"
	#		when 1 ;return "mid_moon"
	#		when 2 ;return "full_moon"
	#		when 3 ;return "mid_moon"
	#		when 4 ;return "half_moon"
	#		else   ;return "no_moon"
	#	end
	#end

end
