#==========================================================================================================================
#因為LonaStat已經被其他東西拿去用了，所以這邊為了避免撞名改用LonaActorStat
#==========================================================================================================================
class LonaActorStat < ActorStat

	#there are a lot of set_stat calls, and there should be a way to hook to them in place where you know who your actor is.
	attr_accessor :actor
	attr_accessor :stats
	attr_accessor :regualr_stats
	attr_accessor :reality_stats
	attr_accessor :ground_stats
	attr_accessor :unknown_behave_stats

	PROCESS_TYPE=1
	DEFINITION =0

	TYPE_REGULAR=0 #標準屬性，上下限都檢查。
	TYPE_REALITY=1	#實數值
	TYPE_GROUND=2	#可無限上綱、有下限
	TYPE_UNKNOWN_BEHAVE=9  #特殊類型，完全不處理上下限問題
	def initialize()
		act_stat={}
		@regualr_stats=[]#type=0
		@reality_stats=[]#type=1
		@ground_stats=[]#type=2
		@unknown_behave_stats=[]#type=9
		@dirt_opt			=0
		LONA_STAT_DEFAULT.keys.each{|key|
			act_stat[key]=LONA_STAT_DEFAULT[key][DEFINITION]
			case LONA_STAT_DEFAULT[key][PROCESS_TYPE]
				when TYPE_REGULAR;				@regualr_stats.push(key)
				when TYPE_REALITY;				@reality_stats.push(key)
				when TYPE_GROUND; 				@ground_stats.push(key)
				when TYPE_UNKNOWN_BEHAVE;		@unknown_behave_stats.push(key)
			end
		}
		super(act_stat)
	end

	def reset_reality_stats
		#@reality_stats.each{|key|
		#	@stat[key]=Array.new(@default_stat[key])
		#}
		@reality_stats.each{
			|stat_name|
			@stat[stat_name]=Array.new(@default_stat[stat_name])
		}
	end



	def unknown_behave_stats?(key)
		@unknown_behave_stats.include?(key)
	end

	def regualr_stats?(key)
		@regualr_stats.include?(key)
	end

	def ground_stats?(key)
		@ground_stats.include?(key)
	end

	def reality_stats?(key)
		@reality_stats.include?(key)
	end

	def sync_max(key)
		@stat[key][CURRENT_STAT]=@stat[key][MAX_STAT]
	end


#0 min<= current <=max, min_true<=min  , max_true>=max ，正常屬性   <=regualr_stats
#1 current = max; max = Tmax if	max >Tmax ，實數直，ex:pry_plus	<=reality_stats
#2 可無限上綱、有下限 ex:sexy										<=ground_stats
#

	def check_stat
		#If situation of Player getting hit and speed getting stuck at slowed is possible then uncomment next line.
		#check_single_stat("move_speed")
	end
	##檢查個數值是否在範圍內
	def check_stat_old
		@stat.keys.each{|key|
		next if unknown_behave_stats?(key) #|| !stat_changed?(key)
			sync_max(key) if reality_stats?(key) || ground_stats?(key)
			check_max_def_within_range(key) if regualr_stats?(key)   						||	reality_stats?(key)
			check_min_def_within_range(key) if regualr_stats?(key)	||	ground_stats?(key) 	||	reality_stats?(key)
			check_def_cross_section(key)
			check_max_within_range(key)     if regualr_stats?(key)   						||	reality_stats?(key)
			check_min_within_range(key)     if regualr_stats?(key)	||	ground_stats?(key)	||	reality_stats?(key)
			remove_changed_mark(key)
		}
	end

	def set_stat(stat_name, value, type=CURRENT_STAT)
		#return if !stat_name
		return p "stats not exist on PlayerActor stat_name=>#{stat_name} V=>#{value} t=>#{type}" if @stat[stat_name].nil?
		value=value.round(3) if value.is_a?(Float)
		@stat[stat_name][type]=value
		#when setting MAX_STAT or MIN_STAT we need to not check them in order to prevent situation when we first increase MAX_STAT, then round to MAX_TRUE, then apply reduction by decreasing MAX_STAT
		#setting MAX_TRUE and MIN_TRUE will break whole chain of checks with how they're made anyway, so it'll be applied only on next refresh.
		check_current_stat(stat_name) if type == CURRENT_STAT

		#those calls were in update_state_frames each frame
		if type == CURRENT_STAT && !@actor.nil? then
			if stat_name == "health".freeze then
				@actor.check_prev_health_to_mood
				@actor.check_prev_health_to_BabyHealth
				@actor.prev_health = @actor.health
			elsif stat_name == "sta".freeze then
				@actor.stat["sta".freeze]=value
				@actor.check_prev_sta_to_arousal
				@actor.check_prev_sta_to_exp
				@actor.check_prev_sta_to_BabyHealth
				@actor.prev_sta = @actor.sta
			elsif stat_name == "mood".freeze
				@actor.stat["mood".freeze]=value
				@actor.check_mood_to_state
			elsif stat_name == "dirt".freeze
				@actor.stat["dirt".freeze]=value
				@actor.check_dirt_to_state
				if (@dirt_opt - value).abs > 25 then #Only update portrait and chs if dirt changed by more than 1% (25/255) opacity
					@dirt_opt = value
					$game_player.refresh_chs
					if $statPortraitOptimize==true && @actor.portrait
						@actor.portrait.set_stat("dirt".freeze, value)
						@actor.portrait.assemble_portrait
					end
				end
			end
		end
		if type == MAX_STAT && !@actor.nil?
			if stat_name == "sta".freeze then
				@actor.calculate_weight_carried
			end
		end
	end

	def check_single_stat(key)
		return if unknown_behave_stats?(key) #|| !stat_changed?(key)
		sync_max(key) if reality_stats?(key) || ground_stats?(key)
		if reality_stats?(key) || regualr_stats?(key) then
			check_max_def_within_range(key)
			check_min_def_within_range(key)
			check_def_cross_section(key)
			check_max_within_range(key)
			check_min_within_range(key)
		else
			if ground_stats?(key) then
				check_min_def_within_range(key)
				check_def_cross_section(key)
				check_min_within_range(key)
			end
		end
		remove_changed_mark(key)
	end

	def check_current_stat(key)
		return if unknown_behave_stats?(key)
		sync_max(key) if reality_stats?(key) || ground_stats?(key)
		if reality_stats?(key) || regualr_stats?(key) then
			check_def_cross_section(key)
			check_max_within_range(key)
			check_min_within_range(key)
		else
			if ground_stats?(key) then
				check_def_cross_section(key)
				check_min_within_range(key)
			end
		end
	end

	def check_def_cross_section(key)
		@stat[key][MAX_STAT]=@stat[key][MIN_STAT] if @stat[key][MIN_STAT]>@stat[key][MAX_STAT]
	end


	#does exactly what reset_definition does with a typo (MAX_STAT=MAX_TRUE twice) and only place it's called is right after it
	def reset_stat_def
	end


	#should also check that value is in range.
	def set_stat_m(stat_name,value,types=nil)
		types=[CURRENT_STAT,MAX_STAT,MAX_TRUE,BUFF_TMAX,BUFF_TMIN] if types.nil?
		raise "set_stat_m requires array of types" if !types.kind_of?(Array)
		types.each{|type|
			@stat[stat_name][type]=value
		}
		check_single_stat(stat_name)
	end

	#this is called before check_stat each update_npc_stat so I do what check_stat did here
	def reset_definition
		@stat.keys.each{|key|
			next if reality_stats?(key)
			next if unknown_behave_stats?(key)
			#p "#{key} #{@stat[key]}   #{@stat[key][MIN_TRUE]}  #{@stat[key][BUFF_TMIN]}"
			@stat[key][MIN_STAT]=@stat[key][MIN_TRUE] + @stat[key][BUFF_TMIN]
			@stat[key][MAX_STAT]=@stat[key][MAX_TRUE] + @stat[key][BUFF_TMAX]
			check_single_stat(key)
			reset_true_buff(key)
		}
		@actor.calculate_weight_carried if !@actor.nil?
	end
	def patch_single_stat(key,setting) #patch
		@stat[key] =setting
		case LONA_STAT_DEFAULT[key][PROCESS_TYPE]
			when TYPE_REGULAR;				@regualr_stats.push(key)
			when TYPE_REALITY;				@reality_stats.push(key)
			when TYPE_GROUND; 				@ground_stats.push(key)
			when TYPE_UNKNOWN_BEHAVE;		@unknown_behave_stats.push(key)
		end
	end


	def get_stat_default
		LONA_STAT_DEFAULT
	end

	#		"morality_prison_labor"=>	[[50,			-50,	50, 	50,			-50		0,		0,],		2],
	#		"morality_prison_guard"=>	[[50,			-50,	50, 	50,			-50		0,		0,],		2],
	#		"morality_fishkind"=>		[[50,			-50,	50, 	50,			-50		0,		0,],		2],
	#also in def recalculate_stats @stat[stat_name][7] if for STAT_CHANGED update check,  check class ActorStat
	#0 min<= current <=max, min_true<=min  , max_true>=max ，正常屬性 =>regualr_stats
	#1 current = max; max = Tmax if	max >Tmax ，實數直，ex:pry_plus  =>reality_stats
	#2 current= max; min =min_true if min < min_true,不處理max/max-true
	#9 for persona, do nothing
	LONA_STAT_DEFAULT={
	   #"attribute"=> 				[current,	min,		max,	Tmax,	Tmin		BTmax,	BTmin],		"type"]
		"health"=>					[[200,		-100,		200,	200,	-100,		0,		0],			0],
		"sta"=>						[[100,		-100,		100,	100,	-100,		0,		0],			0],
		"sat"=>						[[100,			0,		100,	100,		0,		0,		0],			0],
		"mood"=>					[[95, 		-100,		100,	100,	-100,		0,		0],			0],
		"move_speed"=>				[[4.3,			0,		4.3,	4.3,		1,		0,		0],			2],
		"will"=>					[[800,			0,		800,	800,		0,		0,		0],			2],
		"weak"=>					[[50,			0,		50,		50,			0,		0,		0],			2],
		"sexy"=>					[[50,			0,		50,		50,			0,		0,		0],			2],
		"state_preg_rate"=>			[[10,			0,		10,		10,			0,		0,		0],			2],
		"morality"=>				[[0,			-1000,	1000,	1000,		-1000,	0,		0],			0],
		"morality_plus"=>			[[200,			0,		200,	200,	0,			0,		0],			2],
		"morality_lona"=>			[[50,			0,		100,	100,	0,			0,		0],			0],
		"dodge_frame"=>				[[28,			5,		28,		28,		5,			0,		0],			2],
		"baby_health"=>				[[0,			0,		65535,	65535,	0,			0,		0],			0],

		"sex_vag_atk"=>				[[0,			0,		150,	150,	0,			0,		0],			0],
		"sex_anal_atk"=>			[[0,			0,		150,	150,	0,			0,		0],			0],
		"sex_mouth_atk"=>			[[0,			0,		150,	150,	0,			0,		0],			0],
		"sex_limbs_atk"=>			[[0,			0,		150,	150,	0,			0,		0],			0],

		"dirt"=>					[[0,			0,		255,	255,	0,			0,		0],			0],
		"constitution"=>			[[0,			0,		100,	100,	0,			0,		0],			0],
		"survival"=>				[[0,			0,		100,	100,	0,			0,		0],			0],
		"wisdom"=>					[[0,			0,		100,	100,	0,			0,		0],			0],
		"combat"=>					[[0,			0,		100,	100,	0,			0,		0],			0],
		"scoutcraft"=>				[[0,			0,		100,	100,	0,			0,		0],			0],

		"constitution_trait"=>		[[0,			0,		99,		99,		0,			0,		0],			0],			#紀錄trait實際數字
		"survival_trait"=>			[[0,			0,		99,		99,		0,			0,		0],			0],
		"wisdom_trait"=>			[[0,			0,		99,		99,		0,			0,		0],			0],
		"combat_trait"=>			[[0,			0,		99,		99,		0,			0,		0],			0],
		"scoutcraft_trait"=>		[[0,			0,		99,		99,		0,			0,		0],			0],

		"melaninNipple"=>			[[0, 			0, 		255,	255,	0,			0,		0],			0],
		"melaninVag"=>				[[0, 			0, 		255,	255,	0,			0,		0],			0],
		"melaninAnal"=>				[[0, 			0, 		255,	255,	0,			0,		0],			0],
		"arousal"=>					[[0, 			0,		5000,	5000,	0,			0,		0],			0],

		"atk"=>						[[0, 			0, 		100,	10000,0,0,0],0],
		"def"=>						[[0, 			0, 		100,	10000,0,0,0],0],


		"atk_plus"=>				[[0,0,0,100,0,0,0],1],
		"def_plus"=>				[[0,0,0,100,0,0,0],1],

		"constitution_plus"=>		[[0,	0,		0,100,0,0,0],1],
		"combat_plus"=>				[[0,	0,		0,100,0,0,0],1],
		"survival_plus"=>			[[0,	-100,	0,100,-100,0,0],1],
		"wisdom_plus"=>				[[0,	-100,	0,100,-100,0,0],1],
		"scoutcraft_plus"=>			[[0,	-100,	0,100,-100,0,0],1],
		"urinary_level"=>			[[0,0,5000,5000,0,0,0],0],
		"lactation_level"=>			[[0,0,5000,5000,0,0,0],0],
		"defecate_level"=>			[[0,0,5000,5000,0,0,0],0],
		"itch_level"=>				[[0,0,5000,5000,0,0,0],0],
		"vag_damage"=>				[[0,0,10000,10000,0,0,0],0],
		"urinary_damage"=>			[[0,0,10000,10000,0,0,0],0],
		"anal_damage"=>				[[0,0,10000,10000,0,0,0],0],
		"puke_value_normal"=>		[[0,0,10000,10000,0,0,0],0],
		"drug_addiction_level"=>	[[0,0,5000,5000,0,0,0],0],
		"ograsm_addiction_level"=>	[[0,0,5000,5000,0,0,0],0],
		"semen_addiction_level"=>	[[0,0,5000,5000,0,0,0],0],
		"drug_addiction_damage"=>	[[0,0,5000,5000,0,0,0],0],
		"ograsm_addiction_damage"=>	[[0,0,5000,5000,0,0,0],0],
		"semen_addiction_damage"=>	[[0,0,5000,5000,0,0,0],0],
		"sex"=>						[[0,0,0,0,0,0,0],0],
		"persona"=>					[["typical",nil,nil,nil,nil,nil,nil],9], #從新的stat中刪除，但保留9的特殊屬性，記得補上$lona_stats的init
		"race"=>					[["Human",nil,nil,nil,nil,nil,nil],9] #從新的stat中刪除，但保留9的特殊屬性，記得補上$lona_stats的init
	}
		#LONA_STAT_DEFAULT.each do |key, (stats, type)|
		#	# Insert true between Tmin (index 4) and BTmax (index 5)
		#	stats.insert(5, true)
		#end
end


class Game_Actor < Game_Battler

	#Freezing strings to not allocate them each time getter and setter is used.
	#getter
	def health; @actStat.get_stat("health".freeze);end
	def always; @actStat.get_stat("always".freeze);end
	def mood; @actStat.get_stat("mood".freeze);end
	def sta; @actStat.get_stat("sta".freeze);end
	def sat; @actStat.get_stat("sat".freeze);end
	def weak; @actStat.get_stat("weak".freeze);end
	def will; @actStat.get_stat("will".freeze);end
	def sexy; @actStat.get_stat("sexy".freeze);end
	def dodge_frame; @actStat.get_stat("dodge_frame".freeze);end
	def baby_health; @actStat.get_stat("baby_health".freeze);end
	def morality; @actStat.get_stat("morality".freeze);end
	def morality_plus; @actStat.get_stat("morality_plus".freeze);end
	def morality_lona; @actStat.get_stat("morality_lona".freeze);end
	def dirt; @actStat.get_stat("dirt".freeze);end
	def sex_vag_atk; @actStat.get_stat("sex_vag_atk".freeze);end
	def sex_anal_atk; @actStat.get_stat("sex_anal_atk".freeze);end
	def sex_mouth_atk; @actStat.get_stat("sex_mouth_atk".freeze);end
	def sex_limbs_atk; @actStat.get_stat("sex_limbs_atk".freeze);end
	def constitution; @actStat.get_stat("constitution".freeze);end
	def survival; @actStat.get_stat("survival".freeze);end
	def wisdom; @actStat.get_stat("wisdom".freeze);end
	def combat; @actStat.get_stat("combat".freeze);end
	def scoutcraft; @actStat.get_stat("scoutcraft".freeze);end

	def constitution_trait; @actStat.get_stat("constitution_trait".freeze);end
	def survival_trait; @actStat.get_stat("survival_trait".freeze);end
	def wisdom_trait; @actStat.get_stat("wisdom_trait".freeze);end
	def combat_trait; @actStat.get_stat("combat_trait".freeze);end
	def scoutcraft_trait; @actStat.get_stat("scoutcraft_trait".freeze);end

	def melaninNipple; @actStat.get_stat("melaninNipple".freeze);end
	def melaninVag; @actStat.get_stat("melaninVag".freeze);end
	def melaninAnal; @actStat.get_stat("melaninAnal".freeze);end
	def arousal; @actStat.get_stat("arousal".freeze);end
	def atk; @actStat.get_stat("atk".freeze);end
	def def; @actStat.get_stat("def".freeze);end
	def move_speed; @actStat.get_stat("move_speed".freeze);end
	def atk_plus; @actStat.get_stat("atk_plus".freeze);end
	def def_plus; @actStat.get_stat("def_plus".freeze);end
	def constitution_plus; @actStat.get_stat("constitution_plus".freeze);end
	def combat_plus; @actStat.get_stat("combat_plus".freeze);end
	def survival_plus; @actStat.get_stat("survival_plus".freeze);end
	def wisdom_plus; @actStat.get_stat("wisdom_plus".freeze);end
	def scoutcraft_plus; @actStat.get_stat("scoutcraft_plus".freeze);end
	def persona; @actStat.get_stat("persona".freeze);end
	def race; @actStat.get_stat("race".freeze);end
	def urinary_level; @actStat.get_stat("urinary_level".freeze);end
	def lactation_level; @actStat.get_stat("lactation_level".freeze);end
	def defecate_level; @actStat.get_stat("defecate_level".freeze);end
	def itch_level; @actStat.get_stat("itch_level".freeze);end
	def vag_damage; @actStat.get_stat("vag_damage".freeze);end
	def urinary_damage; @actStat.get_stat("urinary_damage".freeze);end
	def anal_damage; @actStat.get_stat("anal_damage".freeze);end
	def state_preg_rate; @actStat.get_stat("state_preg_rate".freeze);end
	def puke_value_normal; @actStat.get_stat("puke_value_normal".freeze);end
	def drug_addiction_level; @actStat.get_stat("drug_addiction_level".freeze);end
	def ograsm_addiction_level; @actStat.get_stat("ograsm_addiction_level".freeze);end
	def semen_addiction_level; @actStat.get_stat("semen_addiction_level".freeze);end
	def drug_addiction_damage; @actStat.get_stat("drug_addiction_damage".freeze);end
	def ograsm_addiction_damage; @actStat.get_stat("ograsm_addiction_damage".freeze);end
	def semen_addiction_damage; @actStat.get_stat("semen_addiction_damage".freeze);end
	def sex; @actStat.get_stat("sex".freeze);end



	#setter
	def health=(val);@actStat.set_stat("health".freeze,val);end
	def always=(val);@actStat.set_stat("always".freeze,val);end
	def mood=(val);@actStat.set_stat("mood".freeze,val);end
	def sta=(val);@actStat.set_stat("sta".freeze,val);end
	def sat=(val);@actStat.set_stat("sat".freeze,val);end
	def weak=(val);@actStat.set_stat("weak".freeze,val);end
	def will=(val);@actStat.set_stat("will".freeze,val);end
	def dodge_frame=(val);@actStat.set_stat("dodge_frame".freeze,val);end
	def baby_health=(val);@actStat.set_stat("baby_health".freeze,val);end
	def morality=(val);@actStat.set_stat("morality".freeze,val);end
	def morality_plus=(val);@actStat.set_stat("morality_plus".freeze,val);end
	def morality_lona=(val);@actStat.set_stat("morality_lona".freeze,val);end
	def dirt=(val); @actStat.set_stat("dirt".freeze,val);end
	def sex_vag_atk=(val);@actStat.set_stat("sex_vag_atk".freeze,val);end
	def sex_anal_atk=(val);@actStat.set_stat("sex_anal_atk".freeze,val);end
	def sex_mouth_atk=(val);@actStat.set_stat("sex_mouth_atk".freeze,val);end
	def sex_limbs_atk=(val);@actStat.set_stat("sex_limbs_atk".freeze,val);end
	def constitution=(val);@actStat.set_stat("constitution".freeze,val);end
	def survival=(val);@actStat.set_stat("survival".freeze,val);end
	def wisdom=(val);@actStat.set_stat("wisdom".freeze,val);end
	def combat=(val);@actStat.set_stat("combat".freeze,val);end
	def scoutcraft=(val);@actStat.set_stat("scoutcraft".freeze,val);end

	def constitution_trait=(val);@actStat.set_stat("constitution_trait".freeze,val);end
	def survival_trait=(val);@actStat.set_stat("survival_trait".freeze,val);end
	def wisdom_trait=(val);@actStat.set_stat("wisdom_trait".freeze,val);end
	def combat_trait=(val);@actStat.set_stat("combat_trait".freeze,val);end
	def scoutcraft_trait=(val);@actStat.set_stat("scoutcraft_trait".freeze,val);end

	def melaninNipple=(val);@actStat.set_stat("melaninNipple".freeze,val);end
	def melaninVag=(val);@actStat.set_stat("melaninVag".freeze,val);end
	def melaninAnal=(val);@actStat.set_stat("melaninAnal".freeze,val);end
	def arousal=(val);@actStat.set_stat("arousal".freeze,val);end
	def move_speed=(val);@actStat.set_stat("move_speed".freeze,val);end
	def atk_plus=(val);@actStat.set_stat("atk_plus".freeze,val);end
	def def_plus=(val);@actStat.set_stat("def_plus".freeze,val);end
	def atk=(val);@actStat.set_stat("atk".freeze,val);end
	def def=(val);@actStat.set_stat("def".freeze,val);end
	def scoutcraft_plus=(val);@actStat.set_stat("scoutcraft_plus".freeze,val);end
	def constitution_plus=(val);@actStat.set_stat("constitution_plus".freeze,val);end
	def combat_plus=(val);@actStat.set_stat("combat_plus".freeze,val);end
	def survival_plus=(val);@actStat.set_stat("survival_plus".freeze,val);end
	def wisdom_plus=(val);@actStat.set_stat("wisdom_plus".freeze,val);end
	def persona=(val);@actStat.set_stat("persona".freeze,val);end
	def race=(val);@actStat.set_stat("race".freeze,val);end
	def urinary_level=(val);@actStat.set_stat("urinary_level".freeze,val);end
	def lactation_level=(val);@actStat.set_stat("lactation_level".freeze,val);end
	def defecate_level=(val);@actStat.set_stat("defecate_level".freeze,val);end
	def itch_level=(val);@actStat.set_stat("itch_level".freeze,val);end
	def vag_damage=(val);@actStat.set_stat("vag_damage".freeze,val);end
	def urinary_damage=(val);@actStat.set_stat("urinary_damage".freeze,val);end
	def anal_damage=(val);@actStat.set_stat("anal_damage".freeze,val);end
	def state_preg_rate=(val);@actStat.set_stat("state_preg_rate".freeze,val);end
	def puke_value_normal=(val);@actStat.set_stat("puke_value_normal".freeze,val);end
	def drug_addiction_level=(val);@actStat.set_stat("drug_addiction_level".freeze,val);end
	def ograsm_addiction_level=(val);@actStat.set_stat("ograsm_addiction_level".freeze,val);end
	def semen_addiction_level=(val);@actStat.set_stat("semen_addiction_level".freeze,val);end
	def drug_addiction_damage=(val);@actStat.set_stat("drug_addiction_damage".freeze,val);end
	def ograsm_addiction_damage=(val);@actStat.set_stat("ograsm_addiction_damage".freeze,val);end
	def semen_addiction_damage=(val);@actStat.set_stat("semen_addiction_damage".freeze,val);end
	def sex=(val);@actStat.set_stat("sex".freeze,val);end

	def subtraction_health(value)
		max_health = self.battle_stat.get_stat("health", ActorStat::MAX_STAT)
		mult = [max_health / 200.0, 1].min
		result = [(value * mult).round, 1].max
		return result
	end
	def fetishPeePee(tmpOnOff=true)
		if tmpOnOff
			self.battle_stat.set_stat_m("urinary_level".freeze,5000,[2,3])
		else
			self.battle_stat.set_stat_m("urinary_level".freeze,1,[2,3])
		end
	end

	def fetishPooPoo(tmpOnOff=true)
		if tmpOnOff
			self.battle_stat.set_stat_m("defecate_level".freeze,5000,[2,3])
		else
			self.battle_stat.set_stat_m("defecate_level".freeze,1,[2,3])
		end
	end

	def fetishHardcore(tmpOnOff=true)
		if tmpOnOff
			#self.battle_stat.set_stat_m("puke_value_normal".freeze,10000,[2,3])
			self.battle_stat.set_stat_m("drug_addiction_level".freeze,5000,[2,3])
			self.battle_stat.set_stat_m("ograsm_addiction_level".freeze,5000,[2,3])
			self.battle_stat.set_stat_m("semen_addiction_level".freeze,5000,[2,3])
			self.battle_stat.set_stat_m("drug_addiction_damage".freeze,5000,[2,3])
			self.battle_stat.set_stat_m("ograsm_addiction_damage".freeze,5000,[2,3])
			self.battle_stat.set_stat_m("semen_addiction_damage".freeze,5000,[2,3])
		else
			#self.battle_stat.set_stat_m("puke_value_normal".freeze,0,[2,3])
			self.battle_stat.set_stat_m("drug_addiction_level".freeze,0,[2,3])
			self.battle_stat.set_stat_m("ograsm_addiction_level".freeze,0,[2,3])
			self.battle_stat.set_stat_m("semen_addiction_level".freeze,0,[2,3])
			self.battle_stat.set_stat_m("drug_addiction_damage".freeze,0,[2,3])
			self.battle_stat.set_stat_m("ograsm_addiction_damage".freeze,0,[2,3])
			self.battle_stat.set_stat_m("semen_addiction_damage".freeze,0,[2,3])
		end
	end


end
