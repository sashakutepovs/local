
class Sensors::Nose < Sensors::Basic_Sensor
	
	def self.type;				"nose";		end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0.0,0.0,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.0,0.0],
			[0.0,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.0],
			[0.1,0.1,0.1,0.6,0.4,0.1,0.4,0.6,0.1,0.1,0.1],
			[0.1,0.1,0.4,0.8,0.6,0.4,0.6,0.8,0.4,0.1,0.1],
			[0.1,0.4,0.6,0.8,1.2,0.6,1.2,1.2,0.8,0.4,0.1],
			[0.1,0.4,0.6,1.0,4.0,999,4.0,1.0,0.6,0.4,0.1],
			[0.1,0.4,0.6,1.2,4.0,100,4.0,1.2,0.8,0.4,0.1],
			[0.1,0.4,0.8,1.0,1.2,1.4,1.2,1.2,0.8,0.4,0.1],
			[0.1,0.1,0.1,0.1,0.4,1.2,0.4,0.1,0.1,0.1,0.1],
			[0.0,0.1,0.1,0.1,0.1,0.4,0.1,0.1,0.1,0.1,0.0],
			[0.0,0.0,0.1,0.1,0.1,0.2,0.1,0.1,0.1,0.0,0.0]
		]
	end
	
end


class Sensors::Nose_follower < Sensors::Nose
	def self.ignore_obj_chk(character,target)
		return false if character.actor.master && character.actor.master == $game_player && $game_player.target == target
		return true if super
	end
end


class Sensors::Eyes< Sensors::Basic_Sensor
	
	def self.type;				"eyes";		end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0.0,0.0,0.1,0.1,0.1,0.1,0.1,0.0,0.0],
			[0.0,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.0],
			[0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1],
			[0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1],
			[0.1,0.3,1.0,4.0,999,4.0,1.0,0.3,0.1],
			[0.1,0.4,1.2,4.0,100,4.0,1.2,0.4,0.1],
			[0.1,0.6,1.0,3.0,100,3.0,1.0,0.6,0.1],
			[0.1,1.0,1.6,2.0,7.0,2.0,1.6,1.0,0.1],
			[0.1,0.1,0.5,0.8,6.0,0.8,0.5,0.1,0.1],
			[0.1,0.1,0.1,0.4,1.2,0.4,0.1,0.1,0.1],
			[0.1,0.1,0.1,0.1,1.0,0.1,0.1,0.1,0.1],
			[0.1,0.1,0.1,0.1,0.8,0.1,0.1,0.1,0.1],
			[0.0,0.1,0.1,0.1,0.4,0.1,0.1,0.1,0.0],
			[0.0,0.0,0.1,0.1,0.2,0.1,0.1,0.0,0.0]
		]
	end
end

class Sensors::Eyes_follower < Sensors::Eyes
	def self.ignore_obj_chk(character,target)
		return false if character.actor.master && character.actor.master == $game_player && $game_player.target == target
		return true if super
	end
end

class Sensors::Multi < Sensors::Basic_Sensor
	def self.type;				"multi";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0.0,0.0,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.0,0.0],
			[0.0,0.0,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.0,0.0],
			[0.0,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.0],
			[0.1,0.1,0.1,0.6,0.4,0.1,0.4,0.6,0.1,0.1,0.1],
			[0.1,0.1,0.4,0.8,0.6,0.1,0.6,0.8,0.4,0.1,0.1],
			[0.1,0.4,0.5,1.0,0.8,0.4,0.8,1.0,0.5,0.4,0.1],
			[0.1,0.4,0.6,1.2,3.0,999,3.0,1.2,0.6,0.4,0.1],
			[0.1,0.4,0.8,1.1,3.0,100,3.0,1.1,0.8,0.4,0.1],
			[0.1,0.4,0.6,0.8,1.0,100,1.0,0.8,0.6,0.4,0.1],
			[0.1,0.1,0.5,0.7,0.8,3.0,0.8,0.7,0.5,0.1,0.1],
			[0.1,0.1,0.1,0.1,0.4,2.0,0.4,0.1,0.1,0.1,0.1],
			[0.1,0.1,0.1,0.1,0.1,1.0,0.1,0.1,0.1,0.1,0.1],
			[0.0,0.1,0.1,0.1,0.1,0.6,0.1,0.1,0.1,0.1,0.0],
			[0.0,0.0,0.1,0.1,0.1,0.3,0.1,0.1,0.1,0.0,0.0],
			[0.0,0.0,0.1,0.1,0.1,0.2,0.1,0.1,0.1,0.0,0.0]
		]
	end
end

class Sensors::Multi_follower < Sensors::Multi
	def self.ignore_obj_chk(character,target)
		return false if character.actor.master && character.actor.master == $game_player && $game_player.target == target
		return true if super
	end
end

class Sensors::Multi_short < Sensors::Basic_Sensor
	def self.type;				"multi";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0.1,0.1,0.1,0.1,0.1,0.1,0.1],
			[0.1,0.6,0.4,0.1,0.4,0.6,0.1],
			[0.4,0.8,0.6,0.1,0.6,0.8,0.4],
			[0.5,1.0,0.8,0.4,0.8,1.0,0.5],
			[0.6,1.2,3.0,999,3.0,1.2,0.6],
			[0.8,1.1,3.0,100,3.0,1.1,0.8],
			[0.6,0.8,1.0,100,1.0,0.8,0.6],
			[0.5,0.7,0.8,1.0,0.8,0.7,0.5],
			[0.1,0.1,0.4,0.8,0.4,0.1,0.1],
			[0.1,0.1,0.1,0.6,0.1,0.1,0.1]
		]
	end
end


class Sensors::AllWay_long< Sensors::Basic_Sensor
	def self.type;				"multi";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0,	0,	0,	0,	0,	1,	1,	1,		1	,	1,	1,	1,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	0,	0,	0,	0],
			[0,	0,	0,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	0,	0,	0],
			[0,	0,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	0,	0],
			[0,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	0],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	0,	0,		0	,	0,	0,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	0,	0,		999,	0,	0,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	0,	0,		0	,	0,	0,	1,	1,	1,	1,	1,	1],
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

class Sensors::AbomHive< Sensors::Basic_Sensor
	def self.type;				"multi";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0,	0,	0,	0,	0,	1,	1,	1,		1	,	1,	1,	1,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	0,	0,	0,	0],
			[0,	0,	0,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	0,	0,	0],
			[0,	0,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	0,	0],
			[0,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	0],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	100,	999	,	100,1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	100,	100,	100,1,	1,	1,	1,	1,	1,	1],
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


class Sensors::BossBattle< Sensors::Basic_Sensor
	def self.type;				"multi";	end
	def self.sight_hp;			4;			end
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
			[1,	1,	1,	1,	1,	1,	1,	1,		999,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		100	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		100	,	1,	1,	1,	1,	1,	1,	1,	1],
			[1,	1,	1,	1,	1,	1,	1,	1,		100	,	1,	1,	1,	1,	1,	1,	1,	1],
			[0,	1,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	1,	0],
			[0,	0,	1,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	1,	0,	0],
			[0,	0,	0,	1,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	1,	0,	0,	0],
			[0,	0,	0,	0,	1,	1,	1,	1,		1	,	1,	1,	1,	1,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	1,	1,	1,		1	,	1,	1,	1,	0,	0,	0,	0,	0]
		]
	end
end

class Sensors::OvermapSight < Sensors::Basic_Sensor
	def self.type;				"OvermapSight";	end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
		[0	,0	,100,100,100,0	,0	],
		[0	,100,100,100,100,100,0	],
		[100,100,100,100,100,100,100],
		[100,100,100,999,100,100,100],
		[100,100,100,100,100,100,100],
		[0	,100,100,100,100,100,0	],
		[0	,0	,100,100,100,0	,0	]
		]
	end
end

class Sensors::RangeTurretVision< Sensors::Basic_Sensor
	
	def self.type;				"TurretVision";		end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0.0,0.0,1.0,1.0,1.0,0.0,0.0],
			[0.0,1.0,1.0,1.0,1.0,1.0,0.0],
			[1.0,1.0,1.0,1.0,1.0,1.0,1.0],
			[1.0,1.0,1.0,1.0,1.0,1.0,1.0],
			[1.0,1.0,1.0,999,1.0,1.0,1.0],
			[1.0,1.0,1.0,1.0,1.0,1.0,1.0],
			[1.0,1.0,1.0,1.0,1.0,1.0,1.0],
			[0.0,1.0,1.0,1.0,1.0,1.0,0.0],
			[0.0,0.0,0.0,1.0,1.0,0.0,0.0],
		]
	end
end

class Sensors::MeleeTurretVision< Sensors::Basic_Sensor
	
	def self.type;				"TurretVision";		end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[  0,  1,0.3,  1,  0],
			[100,1.5,0.6,1.5,100],
			[100,100,999,100,100],
			[100,100,100,100,100],
			[  0,100,100,100,  0]
		]
	end
end

class Sensors::LowRange< Sensors::Basic_Sensor
	
	def self.type;				"TurretVision";		end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[  0,0.3,0.3,0.3,  0],
			[1  ,1.5,0.6,1.5,1  ],
			[1  ,1  ,999,1  ,1  ],
			[1  ,1  ,1  ,1  ,1  ],
			[1  ,1  ,1  ,1  ,1	],
			[  0,1  ,1  ,1  ,  0],
			[  0,1  ,1  ,1  ,  0]
		]
	end
end

class Sensors::CloseNose< Sensors::Basic_Sensor
	
	def self.type;				"TurretVision";		end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[  0,  0,  1,  1,  1,  0,  0],
			[  0,  1,  1,  1,  1,  1,  0],
			[  1,  1,  1,  1,  1,  1,  1],
			[  1,  1,  1,999,  1,  1,  1],
			[  1,  1,  1,  1,  1,  1,  1],
			[  0,  1,  1,  1,  1,  1,  0],
			[  0,  0,  1,  1,  1,  0,  0]
		]
	end
end

class Sensors::TrapVision < Sensors::Basic_Sensor
	
	def self.type;				"TrapVision";		end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[999]
		]
	end
	
end

class Sensors::AbomManagerTrapVision< Sensors::Basic_Sensor
	
	def self.type;				"TurretVision";		end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[1,  1,  1],
			[1,999,  1],
			[1,  1,  1]
		]
	end
end

class Sensors::FishTrapVision< Sensors::Basic_Sensor
	
	def self.type;				"TurretVision";		end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[0,  0,  0],
			[0,999,  0],
			[1,  1,  1]
		]
	end
end


class Sensors::Rng3HeavyScan< Sensors::Basic_Sensor
	
	def self.type;				"TurretVision";		end
	def self.sight_hp;			4;			end
	def self.detection_array
		[
			[20,  20,  20],
			[20, 999,  20],
			[20,  20,  20]
		]
	end
end




###########################################################################################################################

#unused
#class Sensors::ThrowerSupportVision < Sensors::Rng3HeavyScan
#	def self.type;				:support;	end
#	def self.sight_hp;			4;			end
#	def self.use_iff?;			false;		end
#	def self.calc_signal_strength(character,target,sight_hp,mine_value)
#		return 0 if character.actor.eventEquiped && character.actor.eventEquiped.npc? && character.near_the_target?(character.actor.eventEquiped,3)
#		return 0 if !character.actor.friendly?(target)
#		return 0 if target.actor.master != character
#		character.actor.eventEquiped = target
#		character.actor.battle_stat.set_stat_m("mood",100,[0])
#		if [:skill,:sex,:grabbed].include?(character.actor.eventEquiped.actor.action_state)
#			character.actor.eventEquiped = nil
#		end
#		0 #####
#	end
#end
class Sensors::ExplorerTrapDestroyer < Sensors::LowRange
	def self.type;				"eyes";		end
	def self.sight_hp;			4;			end
	def self.ignore_object?;	false;		end
	def self.use_iff?;			true;		end
	def self.calc_signal_strength(character,target,sight_hp,mine_value)
		return 0 if target == $game_player
		return 0 if !target.actor.is_a?(GameTrap)
		return 0 if target.summon_data != nil && target.summon_data[:user] == $game_player
		strength=sight_hp * target.scoutcraft * mine_value
		strength
	end
end