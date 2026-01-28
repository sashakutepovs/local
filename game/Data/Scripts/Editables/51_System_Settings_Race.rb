
#專門用來存放遊戲系統相關參數的位置，不准寫任何方法，也不應被引用到任何class中。
#遊戲系統相關參數請參照各自的class
#這個檔案專門用來儲存各種族的懷孕週期相關數值，未來可能移動到json中
module System_Settings
#===============================================================================================================
# 各種族懷孕周期，單位: 天
#===============================================================================================================

	#game difficult $story_stats["Setup_Hardcore"] hard hell doom, this hash use as race support list
						#[0]hc0 PREGNANCY_LENGTH		#[0]hc1 PREGNANCY_LENGTH		#[0]hc2 PREGNANCY_LENGTH			#[1]seedBedLvl		#[2]SemenItemID	#[3]semenAMT #[4]Unused(Violence)
	RACE_SEX_SETTING={
		"Human" =>		[[[2..2,4..4,4..4,4..4,1..1],	[10..10,7..10,7..10,7..10,1..1],[15..20,15..20,15..20,15..20,1..1]	],[0,0,1,1,2,2,3,3,4,4,5], "WasteSemenHuman"		,80		,999],
		"Moot"=>		[[[2..2,4..4,4..4,4..4,1..1],	[10..10,7..10,7..10,7..10,1..1],[14..19,14..19,14..19,14..19,1..1]	],[0,0,1,1,2,2,3,3,4,4,5], "WasteSemenHuman"		,100	,999],
		"Deepone"=>		[[[2..2,4..4,4..4,4..4,1..1],	[10..10,9..12,9..12,9..12,1..1],[18..23,18..23,18..23,18..23,1..1]	],[0,0,1,1,2,2,3,3,4,4,5], "WasteSemenFishkind"		,120	,999],
		"Fishkind"=>	[[[2..2,2..3,2..3,2..3,1..1],	[4..4,5..7,5..7,5..5,1..1],		[14..16,14..16,10..12,11..12,1..1]	],[0,1,2,3,4,5,6,7,8,9,10],"WasteSemenFishkind"		,120	,999],
		"Orkind"=>		[[[2..2,2..3,2..3,2..3,1..1],	[4..4,5..7,5..7,5..5,1..1],		[13..15,13..15,13..15,11..13,1..1]	],[0,1,2,3,4,5,6,7,8,9,10],"WasteSemenOrcish"		,200	,999],
		"Goblin"=>		[[[2..2,2..3,2..3,2..3,1..1],	[4..4,5..6,6..7,5..6,1..1],		[12..13,12..13,12..13,11..12,1..1]	],[0,1,2,3,4,5,6,7,8,9,10],"WasteSemenOrcish"		,130	,999],
		"Others"=>		[[[2..2,2..3,2..3,2..3,1..1],	[4..4,5..6,6..7,5..6,1..1],		[12..13,12..13,12..13,11..12,1..1]	],[0,0,1,1,2,2,3,3,4,4,5] ,"WasteSemenOther"		,80		,999],
		"Abomination"=>	[[[2..2,2..3,2..3,2..3,1..1],	[4..4,6..7,6..7,6..7,1..1],		[13..15,13..15,13..15,11..12,1..1]	],[0,1,2,3,4,5,6,7,8,9,10],"WasteSemenAbomination"	,180	,999]
	}

	# gen a seedBedLvl if race matched
	RACE_PREG_GEN_SEEDBED_LEVEL={
		"Human"			=> false,
		"Moot"			=> false,
		"Deepone"		=> false,
		"Others"		=> false,
		"Fishkind"		=> false,
		"Orkind"		=> true,
		"Goblin"		=> true,
		"Abomination"	=> true
	}
	#seedbedLvl * raceHpBouns
	RACE_PREG_SEEDBED_HP_BOUNS={
		"Human"			=> 5,
		"Moot"			=> 5,
		"Deepone"		=> 5,
		"Others"		=> 1,
		"Fishkind"		=> 50,
		"Orkind"		=> 100,
		"Goblin"		=> 50,
		"Abomination"	=> 600
	}


#===============================================================================================================
# 交叉配種機率矩陣
#===============================================================================================================
  CROSS_BREEDING_Human={
	#對象種族 :{出產種族 => 機率(總和不需要為100，但必須為整數)}
	"Human" =>{
			"Human" => 100,
			"Others" => 10
			},
	"Fishkind"=>{
			"Human" => 10,
			"Deepone" => 50,
			"Fishkind" => 50,
			"Others" => 10
		},
	
	"Moot" =>{
			"Moot"=> 50,
			"Human"=> 50,
			"Others" => 10
		},
		
	"Deepone" =>{
			"Deepone" => 50,
			"Human" => 50,
			"Others" => 10
		},
		
	"Orkind" =>{
			"Moot" => 10,
			"Goblin" => 90,
			"Orkind" => 90,
			"Others" => 10
		},
	"Goblin" =>{
			"Moot" => 10,
			"Goblin" => 90,
			"Orkind" => 90,
			"Others" => 10
		},
	"Others" =>{
			"Others" => 100
			},
		
	"Abomination" =>{
			"Moot" => 10,
			"Human" => 10,
			"Abomination" => 80,
			"Others" => 10
		}
  }
  
  CROSS_BREEDING_Moot={
	#對象種族 :{出產種族 => 機率(總和不需要為100，但必須為整數)}
	"Human" =>{
			"Moot"		=>50,
			"Human"		=> 50,
			"Others" => 10
			},
	"Fishkind"=>{
			"Human" => 10,
			"Moot" => 10,
			"Deepone" => 35,
			"Fishkind" => 35,
			"Others" => 10
		},
	
	"Moot" =>{
			"Moot"=> 100,
			"Others" => 10
		},
		
	"Deepone" =>{
			"Moot" => 50,
			"Deepone" => 70,
			"Human" => 10,
			"Others" => 10
		},
		
	"Orkind" =>{
			"Moot" => 30,
			"Orkind" => 80,
			"Goblin" => 80,
			"Others" => 10
		},
	"Goblin" =>{
			"Moot" => 30,
			"Goblin" => 80,
			"Orkind" => 80,
			"Others" => 10
		},
	"Others" =>{
			"Others" => 100
			},
		
	"Abomination" =>{
			"Moot" => 30,
			"Abomination" => 80,
			"Others" => 10
		}
  }
  
  CROSS_BREEDING_Deepone={
	#對象種族 :{出產種族 => 機率(總和不需要為100，但必須為整數)}
	"Human" =>{
			"Deepone" => 100,
			"Others" => 10
			},
	"Fishkind"=>{
			"Deepone" => 50,
			"Fishkind" => 50,
			"Others" => 10
		},
	
	"Moot" =>{
			"Moot"=> 50,
			"Deepone"=> 50,
			"Others" => 10
		},
		
	"Deepone" =>{
			"Deepone" => 100,
			"Others" => 10
		},
		
	"Orkind" =>{
			"Moot" => 10,
			"Goblin" => 90,
			"Orkind" => 90,
			"Others" => 10
		},
	"Goblin" =>{
			"Moot" => 10,
			"Goblin" => 90,
			"Orkind" => 90,
			"Others" => 10
		},
	"Others" =>{
			"Others" => 100
			},
		
	"Abomination" =>{
			"Moot" => 10,
			"Deepone" => 10,
			"Abomination" => 80,
			"Others" => 10
		}
  }
  
  CROSS_BREEDING_RESULT={
  #主角種族
	"Human" => CROSS_BREEDING_Human,
	"Moot" => CROSS_BREEDING_Moot,
	"Deepone" => CROSS_BREEDING_Deepone
  }
# SEEDBED_BREEDING_PLUS={
#	#苗床化 每級將機率乘上去
#	"Human" =>0.5,
#	"Moot"=>0.5,
#	"Deepone"=>0.5,
#	"Fishkind"=>2,
#	"Orkind"=>2,
#	"Goblin"=>2,
#	"Abomination"=>2
#	}
end

