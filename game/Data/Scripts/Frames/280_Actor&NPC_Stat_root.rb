#==============================================================================
# This script is created by Kslander 
#==============================================================================
#===============================================================================================================================
#用來處理Stat最大最小值計算的類別，主角用的版本放置在Editables/94_Game_Actor_Stats.rb。
#===============================================================================================================================
class ActorStat
	#BUFF_TMAX_STATS=[0,		-10000,		0		,10000,	-10000]
	#BUFF_TMIN_STATS=[0,		-10000,		0		,10000,	-10000]
	STAT_CHANGED=7
	BUFF_TMIN=6
	BUFF_TMAX=5
	MIN_TRUE=4
	MAX_TRUE=3
	MAX_STAT=2
	MIN_STAT=1
	CURRENT_STAT=0
	attr_reader	:stat
	attr_reader	:default_stat
	attr_accessor :npc_name
	
	#def initialize(default_stat)
	#	@default_stat=default_stat
	#	@stats=Hash.new
	#	@stat=Hash.new
	#	@default_stat.keys.each{|key|
	#		#attribute=> [current ,min,max,max_true,min_true]
	#		#在這邊把資料陣列塞入是否有改變的旗標，如果沒有，則不觸發相關改變事件
	#		#@stat[key] = Array.new(default_stat[key]).tap { |s| s[BUFF_TMAX] = 0; s[BUFF_TMIN] = 0; s[STAT_CHANGED] = true }
	#		@stat[key] = Array.new(default_stat[key])
	#		#@stat[key].push(*[0,0,true])#	BUFF_TMAX,BUFF_TMIN,STAT_CHANGED
	#		#p @stat[key]
	#		#msgbox @stat[key] if key == "atk_plus"
	#		@stat[key][STAT_CHANGED] = true
	#	}
	#end
	def initialize(default_stat)
		@default_stat=default_stat
		@stats=Hash.new
		@stat=Hash.new
		@default_stat.keys.each{|key|
			#attribute=> [current ,min,max,max_true,min_true]
			#在這邊把資料陣列塞入是否有改變的旗標，如果沒有，則不觸發相關改變事件
			@stat[key] = Array.new(default_stat[key]) << true
		}
	end

	def reset_stat(stat_name,type=CURRENT_STAT)
		@stat[stat_name][type]=@default_stat[stat_name][type]
	end
	
	def get_default_stat(stat_name,type=CURRENT_STAT)
		@default_stat[stat_name][type]
	end
	
	def set_stat_and_update(stat_name,value)
		set_stat(stat_name,value)
		check_stat
	end

	def set_stat(stat_name,value,type=CURRENT_STAT)
		return p "stats not exist on target stat_name=>#{stat_name}"if @stat[stat_name].nil?
		@stat[stat_name][STAT_CHANGED]= true
		value=value.round(3) if value.is_a?(Float)
		@stat[stat_name][type]=value
	end


	def get_stat(stat_name,type=CURRENT_STAT)
		return 0 if @stat[stat_name].nil?
		@stat[stat_name][type]
	end
	

	#檢查數值是否在最大最小值範圍內，如果沒有，進行壓制
	def check_max_def_within_range(stat_name)
		#p "asdasd #{stat_name} #{@stat[stat_name][BUFF_TMAX]}"
		if @stat[stat_name][MAX_STAT]>@stat[stat_name][MAX_TRUE] + @stat[stat_name][BUFF_TMAX]
			@stat[stat_name][MAX_STAT]=@stat[stat_name][MAX_TRUE] + @stat[stat_name][BUFF_TMAX]
		end
	end

	def check_min_def_within_range(stat_name)
		if @stat[stat_name][MIN_STAT]<@stat[stat_name][MIN_TRUE] + @stat[stat_name][BUFF_TMIN]
			@stat[stat_name][MIN_STAT]=@stat[stat_name][MIN_TRUE] + @stat[stat_name][BUFF_TMIN]
		end
	end
	def check_max_within_range(stat_name)
		if @stat[stat_name][CURRENT_STAT]>@stat[stat_name][MAX_STAT]
			@stat[stat_name][CURRENT_STAT]=@stat[stat_name][MAX_STAT]
		end
	end
	
	def check_min_within_range(stat_name)
		if @stat[stat_name][CURRENT_STAT]<@stat[stat_name][MIN_STAT]
			@stat[stat_name][CURRENT_STAT]=@stat[stat_name][MIN_STAT] 
		end
	end
	

	def stat_changed?(key)
		@stat[key][STAT_CHANGED]
	end
	
	#將STAT_CHANGED設為false
	def remove_changed_mark(key)
		@stat[key][STAT_CHANGED]=false
	end
	def reset_true_buff(key)
		@stat[key][BUFF_TMIN]=0
		@stat[key][BUFF_TMAX]=0
	end
	def reset_definition
		@stat.keys.each{|key|
			@stat[key][MIN_STAT]=@stat[key][MIN_TRUE] + @stat[key][BUFF_TMIN]
			@stat[key][MAX_STAT]=@stat[key][MAX_TRUE] + @stat[key][BUFF_TMAX]
			reset_true_buff(key)
		}
	end
	
	


	#檢查個數值是否在範圍內
	def check_stat
		@stat.keys.each{|key|
			begin
			#next if !stat_changed?(key)
			check_min_def_within_range(key)
			check_max_def_within_range(key)
			check_max_within_range(key)
			check_min_within_range(key)
			remove_changed_mark(key)
			rescue =>ex
				msgbox "missing stat #{@npc_name}'s #{key} "
				msgbox ex.message
			end
		}

	end
	

	#set_stat_m("wisdom",23,[0,2,3])
	def set_stat_m(stat_name,value,types=nil)
		types=[CURRENT_STAT,MAX_STAT,MAX_TRUE,BUFF_TMAX,BUFF_TMIN] if types.nil?
		raise "set_stat_m requires array of types" if !types.kind_of?(Array)
		types.each{
			|type|
			@stat[stat_name][type]=value
		}
	end
	def get_stat_data(stat_name)
		@stat[stat_name]
	end

	def [](key)
		@stats[key] || nil
	end
	def []=(key, value)
		@stats[key] = value
	end
end

class OvermapCharStat< ActorStat
	def initialize(default_stat)
		default_stat.keys.each{
			|key|						#[current,	      min,	  max,	       Tmax,	       Tmin]
			default_stat[key]=Array.new([default_stat[key],0,default_stat[key],default_stat[key],0])
			default_stat[key][BUFF_TMAX] = 0
			default_stat[key][BUFF_TMIN] = 0
			default_stat[key][STAT_CHANGED] = true
		}
		super(default_stat)
	end
end


class NpcStat < ActorStat
 
	def initialize(default_stat)
		default_stat.keys.each{|key|
			default_stat[key]=Array.new([default_stat[key],0,default_stat[key],default_stat[key],0])
			default_stat[key][BUFF_TMAX] = 0
			default_stat[key][BUFF_TMIN] = 0
			default_stat[key][STAT_CHANGED] = true
		}
		default_stat["mood"][MIN_TRUE]=-100
		default_stat["mood"][MIN_STAT]=-100
		default_stat["mood"][MAX_STAT]=1000
		default_stat["mood"][MAX_TRUE]=1000
		default_stat["sat"][MIN_TRUE]=0
		default_stat["sat"][MIN_STAT]=0
		default_stat["sat"][MAX_STAT]=1000
		default_stat["sat"][MAX_TRUE]=1000
		default_stat["arousal"][MIN_TRUE]=0
		default_stat["arousal"][MIN_STAT]=0
		default_stat["arousal"][MAX_STAT]=10000
		default_stat["arousal"][MAX_TRUE]=10000
		default_stat["sta"][MIN_STAT]=-100
		default_stat["sta"][MIN_TRUE]=-100
		default_stat["morality"][MIN_STAT]=-100
		default_stat["morality"][MIN_TRUE]=-100
		default_stat["morality"][MAX_TRUE]=200
		super(default_stat)
	end

end





