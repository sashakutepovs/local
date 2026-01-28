#v for trap?
class Sensors::SpinAttack < Sensors::Battle_Sensor
	def self.type;				"SpinAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0.7,	0.7	,0.7],
			[0.7,["u",1],0.7],
			[0.7,	0.7	,0.7]
		]
	end
end


class Sensors::SpinNuke < Sensors::Battle_Sensor
	def self.type;				"NukeSpin";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0	,	0.4,	0.4	,0.4,	0],
			[0.4,	0.5,	0.7	,0.5,	0.4],
			[0.4,	0.7,["u",1]	,0.7,	0.4],
			[0.4,	0.5,	0.7	,0.5,	0.4],
			[0	,	0.4,	0.4	,0.4,	0]
		]
	end
end

class Sensors::SpinFront < Sensors::Battle_Sensor
	def self.type;				"SpinAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	0	,0	],
			[0.7,["u",1],0.7],
			[0.7,	0.7	,0.7]
		]
	end
end
class Sensors::SpinFrontHeavy < Sensors::Battle_Sensor
	def self.type;				"SpinAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	0	,0],
			[1,["u",1]	,1],
			[1,		1	,1]
		]
	end
end
class Sensors::SpinAttackNoUser < Sensors::Battle_Sensor
	def self.type;				"SpinAttack";	end
	def self.sight_hp;			10;			end
	def self.ignore_user?;			true;		end
	def self.detection_array
		[
			[0.5,	  0.5	,  0.5],
			[0.5,["u",0.5],0.5],
			[0.5,	  0.5	,  0.5]
		]
	end
end

class Sensors::Kabom < Sensors::Battle_Sensor
	def self.type;				"Kabom";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[1	,	1	,	1],
			[1	,["v",2],	1],
			[1	,	1	,	1]
		]
	end
end


class Sensors::BasicAttack < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[["u",1]],
			[	1	]
		]
	end
end

class Sensors::BackAttack < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[	1	],
			[["u",1]]
		]
	end
end

class Sensors::BasicBox < Sensors::Battle_Sensor
	def self.type;				"BasicBox";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[1	,	1	,	1],
			[1	,["u",1],	1],
			[1	,	1	, 	1]
		]
	end
end

class Sensors::FrontRad < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",1],	0],
			[1	,	1	, 	1]
		]
	end
end

class Sensors::CleaveAttackMH < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0.3,["u",1],	0],
			[0.6,	1	, 	0]
		]
	end
	
end


class Sensors::CleaveAttackSH < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",1],0.3],
			[0	,	1	, 0.6]
		]
	end
	
end


class Sensors::CleaveAttackFull < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",0],	0],
			[0.6,	1	, 0.6]
		]
	end
	
end

class Sensors::BasicCross < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	1	,	0],
			[1	,["u",1],	1],
			[0	,	1	, 	0]
		]
	end
end

class Sensors::SelfCross < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	1	,	0],
			[1	,["v",1],	1],
			[0	,	1	, 	0]
		]
	end
end


class Sensors::BasicAttackLong < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",1],	0],
			[0	,	1	, 	0],
			[0	,	1	, 	0]
		]
	end
end

class Sensors::BasicAttackAngle1 < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",1],	0],
			[0	,	0	, 	1]
		]
	end
end

class Sensors::BasicAttackAngle2 < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",1],	0],
			[1	,	0	, 	0]
		]
	end
end


class Sensors::SmallAttack < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",0],	0],
			[0	,	1	, 	0]
		]
	end
end


class Sensors::SmallAttackNoUser < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.ignore_user?;			true;		end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",0],	0],
			[0	,	1	, 	0]
		]
	end
end


class Sensors::SelfSmallAttack < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[["v",1]]
			
		]
	end
	
end



class Sensors::SelfSmallAttackIgnoreUser < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.ignore_user?;		true;		end
	def self.detection_array
		[
			[["v",1]]
			
		]
	end
	
end


class Sensors::AbomAcidAreaAttack < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.use_iff?;			true;		end
	def self.signal_IgnoreCheck(character,target,track_mode=false)
		return true if target == $game_player && $game_player.actor.stat["RaceRecord"] == "Abomination"
		return true if super
	end
	def self.detection_array
		[
			[["v",1]]
			
		]
	end
end

class Sensors::BasicHeavy < Sensors::Battle_Sensor
	def self.type;				"BasicHeavy";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",1],	0],
			[0	,	1	,	0]
		]
	end
end

class Sensors::FrontAE < Sensors::Battle_Sensor
	def self.type;				"FrontAE";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",0],	0],
			[0.5,	1,	  0.5],
			[0.5,	0.5	, 0.5]
		]
	end
end


class Sensors::BasicOnSelf < Sensors::Battle_Sensor
	def self.type;				"BasicOnSelf";	end
	def self.sight_hp;			100;			end
	def self.detection_array
		[
			[["v",1]]
		]
	end
end

class Sensors::FrontSummonUnit < Sensors::Battle_Sensor
	def self.type;				"BasicOnSelf";	end
	def self.sight_hp;			100;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",0],	0],
			[0	,	0,		0],
			[0	,	0	,	0],
			[1	,	1	,	1],
			[1	,	1	,	1],
		]
	end
end

class Sensors::Piercing < Sensors::Battle_Sensor
	def self.type;				"Piercing";	end
	def self.sight_hp;			10;			end
	def self.use_iff?;			true;		end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",0],	0],
			[0	,	0.75,	0],
			[0	,	1.25,	0]
		]
	end
end
class Sensors::Front2Tile < Sensors::Battle_Sensor
	def self.type;				"Piercing";	end
	def self.sight_hp;			10;			end
	def self.use_iff?;			true;		end
	def self.detection_array
		[
			[	0	],
			[["u",0]],
			[	1	],
			[	1	]
		]
	end
end

#0520 ver
class Sensors::TeslaFront < Sensors::Battle_Sensor
	def self.type;				"Piercing";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",0],	0],
			[0	,	1.0,	0],
			[0.7,	0.8,  0.7],
			[0.5,	0.7,  0.5]
		]
	end
end

class Sensors::TeslaAoe < Sensors::Battle_Sensor
	def self.type;				"Piercing";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[  0, 0.4,    0.6,  0.4,    0],
			[0.4, 0.6,    0.8,  0.6,  0.4],
			[0.6, 0.8,    1  ,  0.8,  0.6],
			[0.8,   1,["u",1],    1,  0.8],
			[0.6, 0.8,    1.0,  0.8,  0.6],
			[0.4, 0.6,    0.8,  0.6,  0.4],
			[  0, 0.4,    0.6,  0.4,    0]
		]
	end
end
class Sensors::TeslaAoeIFF < Sensors::Battle_Sensor
	def self.type;				"Piercing";	end
	def self.sight_hp;			4;			end
	def self.ignore_user?;			true;		end
	def self.detection_array
		[
			[  0, 0.4,    0.6,  0.4,    0],
			[0.4, 0.6,    0.8,  0.6,  0.4],
			[0.6, 0.8,    1  ,  0.8,  0.6],
			[0.8,   1,["u",1],    1,  0.8],
			[0.6, 0.8,    1.0,  0.8,  0.6],
			[0.4, 0.6,    0.8,  0.6,  0.4],
			[  0, 0.4,    0.6,  0.4,    0]
		]
	end
end
class Sensors::TeslaAoeWater < Sensors::Battle_Sensor
	def self.type;				"Piercing";	end
	def self.sight_hp;			4;			end
	def self.water_only?;		true;		end
	def self.detection_array
		[
			[  0, 0.4,    0.6,  0.4,    0],
			[0.4, 0.6,    0.8,  0.6,  0.4],
			[0.6, 0.8,    1  ,  0.8,  0.6],
			[0.8,   1,["u",1],    1,  0.8],
			[0.6, 0.8,    1.0,  0.8,  0.6],
			[0.4, 0.6,    0.8,  0.6,  0.4],
			[  0, 0.4,    0.6,  0.4,    0]
		]
	end
end

class Sensors::BasicCharge < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",1],	0],
			[0	,	1	,	0]
		]
	end
end

class Sensors::LargeFrontAE < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			3;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",0],	0],
			[1	,	1	,	1],
			[1	,	1	,	1],
			[1	,	1	,	1]
		]
	end
end

class Sensors::LargeFrontAE2 < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			3;			end
	def self.detection_array
		[
			[0	,	0	,	0],
			[0	,["u",0],	0],
			[1	,	1	,	1],
			[1	,	1	,	1],
			[1	,	1	,	1],
			[1	,	1	,	1]
		]
	end
end

class Sensors::LargeFrontSector < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			3;			end
	def self.detection_array
		[
			[0,	0	,	0	,	0,	0],
			[0,	0	,["u",0],	0,	0],
			[0,	1	,	1	,	1,	0],
			[0,	1	,	1	,	1,	0],
			[1,	1	,	1	,	1,	1],
			[1,	1	,	1	,	1,	1]
		]
	end
end

class Sensors::GeneralProjectileHit < Sensors::Battle_Sensor
	def self.type;				"GeneralProjectileHit";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[["u",1]]
		]
	end
end
class Sensors::GeneralProjectileHit2Back < Sensors::Battle_Sensor #for fireball
	def self.type;				"GeneralProjectileHit";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[	1	],
			[["u",1]],
			[	0	]
		]
	end
end
class Sensors::GeneralProjectileHit2front < Sensors::Battle_Sensor
	def self.type;				"GeneralProjectileHit";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[["u",1]],
			[	1	]
		]
	end
end
class Sensors::GeneralProjectileHit3 < Sensors::Battle_Sensor
	def self.type;				"GeneralProjectileHit";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[	1	],
			[["u",1]],
			[	1	]
		]
	end
end

class Sensors::GeneralProjectile < Sensors::Battle_Sensor
	def self.type;				"GeneralProjectile";	end
	def self.sight_hp;			10;			end
	def self.detection_array
		[
			[["v",1]]
		]
	end

	
end


#class Sensors::IndirectMissile < Sensors::Battle_Sensor
#	def self.type;				"Missile";	end
#	def self.sight_hp;			4;			end
##	def self.ignore_object?;	true;		end
#	def self.detection_array
#		[
#			[["u",1]],
#			[0],
#			[0],
#			[0],
#			[0],
#			[1],
#			[1]
#		]
#	end
#end

class Sensors::Missile < Sensors::Battle_Sensor
	def self.type;				"Missile";	end
	def self.sight_hp;			4;			end
#	def self.ignore_object?;	true;		end
	def self.detection_array
		[
			[["u",0]],
			[0],
			[1],
			[1],
			[1],
			[1],
			[1],
			[1]
		]
	end
end

class Sensors::CloseMissile < Sensors::Battle_Sensor
	def self.type;				"Missile";	end
	def self.sight_hp;			4;			end
#	def self.ignore_object?;	true;		end
	def self.detection_array
		[
			[["u",0]],
			[1],
			[1],
			[1]
		]
	end
end

class Sensors::SnipeMissile < Sensors::Battle_Sensor
	def self.type;				"Missile";	end
	def self.sight_hp;			4;			end
	def self.use_iff?;			true;		end
	def self.detection_array
		[
			[["u",1]],
			[1],
			[1],
			[1],
			[1],
			[1],
			[1],
			[1],
			[1]
		]
	end
end
class Sensors::SnipeLasCannon < Sensors::Battle_Sensor
	def self.type;				"Missile";	end
	def self.sight_hp;			4;			end
	def self.use_iff?;			true;		end
	def self.detection_array
		[
			[0,["u",1],0],
			[0.5,	1	,0.5],
			[0.5,	1	,0.5],
			[0.5,	1	,0.5],
			[0.5,	1	,0.5],
			[0.5,	1	,0.5],
			[0.5,	1	,0.5],
			[0.5,	1	,0.5],
			[0.5,	1	,0.5],
			[0.5,	1	,0.5],
			[0.5,	1	,0.5],
			[0.5,	1	,0.5],
			[0.5,	1	,0.5],
			[0.5,	1	,0.5]
		]
	end
end


class Sensors::ChargeBig < Sensors::Battle_Sensor
	def self.type;				"Missile";	end
	def self.sight_hp;			4;			end
	def self.use_iff?;			true;		end
	def self.detection_array
		[
			[0,["u",0],	0],
			[0,		0,	0],
			[1,		1,	1],
			[1,		1,	1],
			[1,		1,	1],
			[1,		1,	1],
			[1,		1,	1],
			[1,		1,	1]
		]
	end
end


class Sensors::ChargeSmall < Sensors::Battle_Sensor
	def self.type;				"Missile";	end
	def self.sight_hp;			4;			end
	def self.use_iff?;			true;		end
	def self.detection_array
		[
			[["u",0]],
			[	0],
			[	1],
			[	1],
			[	1],
			[	1],
			[	1],
			[	1]
		]
	end
end

class Sensors::Nova < Sensors::Battle_Sensor
	def self.type;					"Nova";		end
	def self.sight_hp;				4;			end
	def self.ignore_user?;			true;		end
	def self.detection_array
		[
			[0	,	0.7,	0.7	,	0.7,	0],
			[0.7,	1,		1	,	1,		0.7],
			[0.7,	1,	["u",1],	1,		0.7],
			[0.7,	1,		1	,	1,		0.7],
			[0	,	0.7,	0.7	,	0.7,	0]
		]
	end
end

class Sensors::Nuclear < Sensors::Battle_Sensor
	def self.type;				"Nuclear";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0,	1,		1	,	1,	0],
			[1,	1,		2	,	1,	1],
			[1,	2,	["u",2],	2,	1],
			[1,	1,		2	,	1,	1],
			[0,	1,		1	,	1,	0]
		]
	end
end

class Sensors::MarkSkill < Sensors::Battle_Sensor
	def self.type;				"MarkSkill";	end
	def self.sight_hp;			4;			end
#	def self.ignore_object?;	true;		end
	def self.detection_array
		[
			[0,		0,		100,	100,		100	,	100,	100,	0,		0],
			[0,		100,	100,	100,		100	,	100,	100,	100,	0],
			[100,	100,	100,	100,		100	,	100,	100,	100,	100],
			[100,	100,	100,	100,		100	,	100,	100,	100,	100],
			[100,	100,	100,	100,	["u",100],	100,	100,	100,	100],
			[100,	100,	100,	100,		100	,	100,	100,	100,	100],
			[100,	100,	100,	100,		100	,	100,	100,	100,	100],
			[0,		100,	100,	100,		100	,	100,	100,	100,	0],
			[0,		0,		100,	100,		100	,	100,	100,	0,		0]
		]
	end
end

class Sensors::FriendlyAOE < Sensors::Battle_Sensor
	def self.type;				"MarkSkill";end
	def self.sight_hp;			4;			end
	def self.ignore_object?;	true;		end
	def self.friendly_only?;	true;		end
	def self.ignore_user?;		true;		end
	def self.detection_array
		[
			[1  ,	1  ,	1  ,		1  	,	1  ,	1  ,	1],
			[1  ,	1  ,	1  ,		1  	,	1  ,	1  ,	1],
			[1  ,	1  ,	1  ,		1  	,	1  ,	1  ,	1],
			[1  ,	1  ,	1  ,	["u",1  ],	1  ,	1  ,	1],
			[1  ,	1  ,	1  ,		1  	,	1  ,	1  ,	1],
			[1  ,	1  ,	1  ,		1  	,	1  ,	1  ,	1],
			[1  ,	1  ,	1  ,		1  	,	1  ,	1  ,	1]
		]
	end
end

class Sensors::MarkSkillMid < Sensors::Battle_Sensor
	def self.type;				"MarkSkill";	end
	def self.sight_hp;			4;			end
#	def self.ignore_object?;	true;		end
	def self.detection_array
		[
			[0	,	0,		100,		100	,	100,	0,		0],
			[0	,	100,	100,		100	,	100,	100,	0],
			[100,	100,	100,		100	,	100,	100,	100],
			[100,	100,	100,	["u",100],	100,	100,	100],
			[100,	100,	100,		100	,	100,	100,	100],
			[0	,	100,	100,		100	,	100,	100,	0],
			[0	,	0,		100,		100	,	100,	0,		0]
		]
	end
end

class Sensors::MarkSkillMidDed < Sensors::Battle_Sensor
	def self.type;				"MarkSkill";	end
	def self.sight_hp;			4;			end
	def self.ignore_dead?;		false;		end
#	def self.ignore_object?;	true;		end
	def self.detection_array
		[
			[0	,	0,		100,		100	,	100,	0,		0],
			[0	,	100,	100,		100	,	100,	100,	0],
			[100,	100,	100,		100	,	100,	100,	100],
			[100,	100,	100,	["u",100],	100,	100,	100],
			[100,	100,	100,		100	,	100,	100,	100],
			[0	,	100,	100,		100	,	100,	100,	0],
			[0	,	0,		100,		100	,	100,	0,		0]
		]
	end
end

class Sensors::ActionSkillSight < Sensors::Battle_Sensor
	def self.type;				"ActionSkillSight";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0,	0,	1,	1,		1,		1,	1,	0,	0],
			[0,	1,	1,	1,		1	,	1,	1,	1,	0],
			[1,	1,	1,	1,		1	,	1,	1,	1,	1],
			[1,	1,	1,	1,		1	,	1,	1,	1,	1],
			[1,	1,	1,	1,	["u",1],	1,	1,	1,	1],
			[1,	1,	1,	1,		1	,	1,	1,	1,	1],
			[1,	1,	1,	1,		1	,	1,	1,	1,	1],
			[0,	1,	1,	1,		1,		1,	1,	1,	0],
			[0,	0,	1,	1,		1,		1,	1,	0,	0]
		]
	end
end

class Sensors::ActionSkillIgnoreClose < Sensors::Battle_Sensor
	def self.type;				"ActionSkillIgnoreClose";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0,	0,	1,	1,		1,		1,	1,	0,	0],
			[0,	1,	1,	1,		1	,	1,	1,	1,	0],
			[1,	1,	1,	1,		1	,	1,	1,	1,	1],
			[1,	1,	1,	1,		0	,	1,	1,	1,	1],
			[1,	1,	1,	0,	["u",0],	0,	1,	1,	1],
			[1,	1,	1,	1,		0	,	1,	1,	1,	1],
			[1,	1,	1,	1,		1	,	1,	1,	1,	1],
			[0,	1,	1,	1,		1,		1,	1,	1,	0],
			[0,	0,	1,	1,		1,		1,	1,	0,	0]
		]
	end
end

class Sensors::ActionSkillIgnoreCloseShort < Sensors::Battle_Sensor
	def self.type;				"ActionSkillIgnoreCloseShort";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0,	1,		1	,	1,	0],
			[1,	1,		0	,	1,	1],
			[1,	0,	["u",0],	0,	1],
			[1,	1,		0	,	1,	1],
			[0,	1,		1	,	1,	0]
		]
	end
end

class Sensors::NpcRangeArtillery < Sensors::Battle_Sensor
	def self.type;				"NpcRangeArtillery";	end
	def self.sight_hp;			4;			end
#	def self.ignore_object?;	true;		end
	def self.detection_array
		[
			[0,	0,	0,	["u",0],	0,		0,	0],
			[0,	0,	0,		0	,	0,		0,	0],
			[0,	1,	1,		1	,	1,		1,	0],
			[1,	1,	1,		1	,	1,		1,	1],
			[1,	1,	1,		1	,	1,		1,	1],
			[1,	1,	1,		1	,	1,		1,	1],
			[1,	1,	1,		1	,	1,		1,	1],
			[0,	1,	1,		1	,	1,		1,	0],
			[0,	0,	1,		1	,	1,		0,	0]
		]
	end
end

class Sensors::NpcHiveArtillery < Sensors::Battle_Sensor
	def self.type;				"NpcRangeArtillery";	end
	def self.sight_hp;			4;			end
#	def self.ignore_object?;	true;		end
	def self.use_iff?;			false;		end
	def self.detection_array
		[
			[0,	0,	0,	0,	0,	1,	1,	1,		1	,	1,	1,	1,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	0,	0,	0,	0],
			[0,	0,	0,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	0,	0,	0],
			[0,	0,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	0,	0],
			[0,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	0],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	0,		0	,	0,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	0,	["u",0],	0,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[0,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	0],
			[0,	0,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	0,	0],
			[0,	0,	0,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	0,	0,	0],
			[0,	0,	0,	0,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	1,	1,	1,		1	,	1,	1,	1,	0,	0,	0,	0,	0]
		]
	end
end

class Sensors::NpcNoCoreArtillery < Sensors::Battle_Sensor
	def self.type;				"NpcRangeArtillery";	end
	def self.sight_hp;			4;			end
#	def self.ignore_object?;	true;		end
	def self.use_iff?;			false;		end
	def self.detection_array
		[
			[0,	0,	0,	0,	0,	1,	1,	1,		1	,	1,	1,	1,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	0,	0,	0,	0],
			[0,	0,	0,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	0,	0,	0],
			[0,	0,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	0,	0],
			[0,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	0],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	0,		0	,	0,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	0,	["u",0],	0,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	0,		0	,	0,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[0,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	0],
			[0,	0,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	0,	0],
			[0,	0,	0,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	0,	0,	0],
			[0,	0,	0,	0,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	1,	1,	1,		1	,	1,	1,	1,	0,	0,	0,	0,	0]
		]
	end
end

class Sensors::NpcCoreArtillery < Sensors::Battle_Sensor
	def self.type;				"NpcRangeArtillery";	end
	def self.sight_hp;			4;			end
#	def self.ignore_object?;	true;		end
	def self.use_iff?;			false;		end
	def self.detection_array
		[
			[0,	0,	0,	0,	0,	1,	1,	1,		1	,	1,	1,	1,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	0,	0,	0,	0],
			[0,	0,	0,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	0,	0,	0],
			[0,	0,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	0,	0],
			[0,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	0],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,	["u",1],	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[0,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	0],
			[0,	0,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	0,	0],
			[0,	0,	0,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	0,	0,	0],
			[0,	0,	0,	0,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	1,	1,	1,		1	,	1,	1,	1,	0,	0,	0,	0,	0]
		]
	end
end

class Sensors::NpcRangeArtilleryType2 < Sensors::Battle_Sensor
	def self.type;				"NpcRangeArtilleryType2";	end
	def self.sight_hp;			4;			end
#	def self.ignore_object?;	true;		end
	def self.detection_array
		[
			[0,	0,	0,	0,	["u",0],	0,	0,	0,	0],
			[0,	0,	1,	1,		0	,	1,	1,	0,	0],
			[0,	1,	1,	1,		1	,	1,	0,	1,	0],
			[0,	1,	1,	1,		1	,	1,	1,	1,	0],
			[0,	1,	1,	1,		1	,	1,	1,	1,	0],
			[0,	1,	1,	1,		1	,	1,	1,	1,	0]
		]
	end
end

class Sensors::MarkSkillSM < Sensors::Battle_Sensor
	def self.type;				"MarkSkill";	end
	def self.sight_hp;			4;			end
#	def self.ignore_object?;	true;		end
	def self.detection_array
		[
			[0,		0,			100	,	0,		0],
			[0,		100,		100	,	100,	0],
			[100,	100,	["u",100],	100,	100],
			[0,		100,		100	,	100,	0],
			[0,		0,			100	,	0,		0]
		]
	end
end

class Sensors::BasicTrap < Sensors::Battle_Sensor
	def self.type;				"BasicTrap";	end
	def self.sight_hp;			4;			end
	def self.use_iff?;			false;		end
	def self.detection_array
		[
			[["u",1]]
			
		]
	end
end

class Sensors::ShieldTargetInThisXY < Sensors::Battle_Sensor
	def self.type;				"BasicTrap";	end
	def self.sight_hp;			4;			end
	def self.ignore_object?;	true;		end
	def self.ignore_user?;		true;		end
	def self.use_iff?;			false;		end
	def self.detection_array
		[
			[["u",1]]
			
		]
	end
end


class Sensors::BasicTrapV < Sensors::Battle_Sensor
	def self.type;				"BasicTrapV";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[["v",1]]
			
		]
	end
end



class Sensors::NoRangeMap < Sensors::Battle_Sensor
	def self.type;				"SexStruggle";	end
	def self.sight_hp;			-1;			end
	def self.detection_array
		[
			[["u",0]]
			
		]
	end
end




