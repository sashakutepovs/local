class Game_Actor
	
	#記錄行屬性未來集中於此檔案處理，被其他系統使用到的(如戰鬥系統、懷孕系統)另外處理。
	
	attr_accessor  :record_HairColor
	#attr_accessor  :record_lona_race
	attr_accessor  :record_lona_title
	attr_accessor  :preg_level
	attr_accessor  :preg_birth_date
	attr_accessor  :preg_date
	attr_accessor  :preg_race
	
	attr_accessor  :sensitivity_basic_vag
	attr_accessor  :sensitivity_basic_anal
	attr_accessor  :sensitivity_basic_mouth
	attr_accessor  :sensitivity_basic_breast
	attr_accessor  :sensitivity_vag
	attr_accessor  :sensitivity_anal
	attr_accessor  :sensitivity_mouth
	attr_accessor  :sensitivity_breast
	attr_accessor  :exp_vag
	attr_accessor  :exp_anal
	attr_accessor  :exp_mouth
	attr_accessor  :exp_limbs
	
	attr_accessor  :trait_point

	
	attr_accessor  :movement_count
	attr_accessor  :move_speedTB_plus
	attr_accessor  :move_speedTB
	attr_accessor  :hud_weight_count
	
	attr_accessor  :pain_value_preg
	attr_accessor  :puke_value_preg
	
	
	CUM_LEVEL_DEFINITION=	{
		"CumsMoonPie"=>			[250,500,750],
		"CumsCreamPie"=>		[250,500,750],
		"CumsHead"=>			[250,500,750],
		"CumsTop"=>				[250,500,750],
		"CumsMid"=>				[250,500,750],
		"CumsBot"=>				[250,500,750],
		"CumsMouth"=>			[70,140,210]
	}
	
	CUM_MAX_AMT={
		"CumsMoonPie"=>		1000,
		"CumsCreamPie"=>	1000,
		"CumsHead"=>		1000,
		"CumsTop"=>			1000,
		"CumsMid"=>			1000,
		"CumsBot"=>			1000,
		"CumsMouth"=>		300
	}
	
	
	 def init_rec_stats
		# init_dialog_recs
		init_sexstates
		init_other_stats
		init_lona_step_counter
		init_PubicHair_stats
		update_sex_exp
		update_melanin_eff
		update_melanin
		update_sex_sensitivity
	 end
	 
	
	def init_sexstates
		self.stat["RaceRecord"]			= self.race
		@record_lona_title				= "basic/common_people"
		@record_HairColor				=0
		
		
		@exp_vag		=0
		@exp_anal		=0
		@exp_mouth		=0
		@exp_limbs		=0
		
		@sensitivity_basic_vag		=4			#基礎感度設定 創角時可修改 10點自由分配
		@sensitivity_basic_anal		=2
		@sensitivity_basic_mouth		=2
		@sensitivity_basic_breast		=2
		@sensitivity_vag		=0				#追加感度設定  於遊戲開始後自動變更 請勿修改此處
		@sensitivity_anal		=0
		@sensitivity_mouth		=0
		@sensitivity_breast		=0
		
		##########################hidden data, those data will now show up in game###################################33
		@preg_date				=0 #when == birth date, birth
		@preg_birth_date		=0 #when == preg_data, birth
		@preg_race				="" #record preg race
		@preg_level				=0 #for real preglevel, use for preg overevent level
		###############################################################################################################
		
		##########################trait data###########################################################################33
		###############################################################################################################
		
		
	end
	
	def update_sex_sensitivity
		@sensitivity_vag 		= [@sensitivity_basic_vag	+@exp_vag	,15].min.round
		@sensitivity_anal 		= [@sensitivity_basic_anal	+@exp_anal	,15].min.round
		@sensitivity_mouth 		= [@sensitivity_basic_mouth	+@exp_mouth	,15].min.round
		@sensitivity_breast		= [@sensitivity_basic_breast+@exp_limbs	,15].min.round
	end
	
	
	
	def init_other_stats
		@urinary_level			= 0
		@lactation_level		= 0
		@defecate_level			= 0
		@vag_damage				= 0
		@urinary_damage			= 0
		@anal_damage			= 0
		@trait_point			= 0
	end
	
	def init_PubicHair_stats
		@pubicHair_Vag_GrowCount = 0 #pubicHair Grow Chk, reset to 0 if grow a lvl
		@pubicHair_Vag_GrowRate = 3+rand(10) #howmany Nap to Grow a LVL
		@pubicHair_Vag_GrowMAX = 2+rand(3) #max Lvl
		@pubicHair_Anal_GrowCount = 0
		@pubicHair_Anal_GrowRate = 3+rand(10)
		@pubicHair_Anal_GrowMAX = 2+rand(3)
		self.stat["PubicHairVag"] = 0
		self.stat["PubicHairAnal"] = 0
	end
	
	def init_lona_step_counter
		@movement_count			=5 #步數紀錄
		@move_speedTB				= 100
		@move_speedTB_plus				= 0
		@pain_value_preg				=0	#陣痛
		@puke_value_preg				=0 #孕吐
	end
	
	def update_sex_exp
		@exp_vag				= [Math.log2(1+$story_stats["sex_record_vaginal_count"]).round,25].min
		@exp_anal				= [Math.log2(1+$story_stats["sex_record_anal_count"]).round,25].min
		@exp_mouth				= [Math.log2(1+$story_stats["sex_record_mouth_count"]+$story_stats["sex_record_kissed"]).round,25].min
		@exp_limbs				= [Math.log2(1+$story_stats["sex_record_boob_harassment"]).round,25].min
	end
	def update_sex_atk
		#"asd"=>			[[0,			0,		100,	100,	0,			0,		0],			0],
		#Nymph & Prostitute rise 25 all sex atk TBmin +25
		#self.battle_stat.get_stat("sex_vag_atk",4)
		#tmpSexAtkMax = 100+self.stat["Lilith"]*50 :default max = 100  lilith rise TBmax 50

		tmpSexAtk = (self.stat["Nymph"]+self.stat["Prostitute"])*25
		tmpSexAtkMax = 100+self.stat["Lilith"]*50
		sex_Con = self.constitution/2
		self.sex_vag_atk=		([sex_Con+(@exp_vag  *(2+self.stat["Lilith"]))+tmpSexAtk,tmpSexAtkMax].min - self.vag_damage/100).round
		self.sex_anal_atk=		([sex_Con+(@exp_anal *(2+self.stat["Lilith"]))+tmpSexAtk,tmpSexAtkMax].min - self.anal_damage/100).round
		self.sex_mouth_atk=		([sex_Con+(@exp_mouth*(2+self.stat["Lilith"]))+tmpSexAtk,tmpSexAtkMax].min * [0.01*self.sta,1].min).round
		self.sex_limbs_atk=		([sex_Con+(@exp_limbs*(2+self.stat["Lilith"]))+tmpSexAtk,tmpSexAtkMax].min * [0.01*self.sta,1].min).round
	end
	
	def update_melanin_eff
		tmpSeed=(self.stat["WombSeedBed"]*50)
		tmpVag=(self.stat["PubicHairVag"]*50)+tmpSeed
		tmpAnal=(self.stat["PubicHairAnal"]*50)+tmpSeed
		self.melaninNipple	= [(@preg_level*10)+(self.stat["Lactation"]*50)+tmpSeed+(@lactation_level/20).round+($story_stats["sex_record_baby_birth"]*5),255].min
		self.melaninVag		= [($story_stats["sex_record_vaginal_count"]/2).round+tmpVag+(($story_stats["sex_record_baby_birth"]+$story_stats["sex_record_miscarriage"])*2),255].min
		self.melaninAnal	= [($story_stats["sex_record_anal_count"]/2).round+tmpAnal+($story_stats["sex_record_defecate_incontinent"]*2),255].min
	end
	
	def check_TB_parameters_stats
		@move_speedTB_plus = 1		if ![:dash, :dash_fatigue, :dash_cuffed, :dash_overfatigue].include?($game_player.movement)
		@move_speedTB_plus = 3		if [:dash, :dash_fatigue, :dash_cuffed, :dash_overfatigue].include?($game_player.movement)
		@move_speedTB	= (0.04*(self.attr_dimensions["sta"][MAX_STAT]*@move_speedTB_plus)).round(3)
	end
	
	def update_melanin
		self.stat["MelaninNipple"]=self.melaninNipple
		self.stat["MelaninVag"]=self.melaninVag
		self.stat["MelaninAnal"]=self.melaninAnal
	end 
	
	
	#取得cum數量與等級的定義
	def get_cum_level_def
		CUM_LEVEL_DEFINITION
	end
	
	#取得cum數量與等級的定義
	def get_cums_max_def
		CUM_MAX_AMT
	end
		
	
end
