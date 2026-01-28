#update2023-2-10
class Sensors::SexSkillFront < Sensors::Battle_Sensor
	def self.type;				"BasicAttack";	end
	def self.sight_hp;			10;			end
	def self.ignore_sex_reciver?;		false;		end
	def self.ignore_object?;	true;		end
	def self.detection_array
		[
			[["u",0]],
			[	1	]
		]
	end
	
	def self.sameXY_sex_pick_tgt(character,target)
		#msgbox "character == $game_player" if  character == $game_player
		return true if character.npc? && character.actor.target != target && target.actor.action_state == :sex #for npc.  if target isnt npc.target then it cannot hit
		return true if character == $game_player && target.sex_mode? && target.sex_receiver? #Lona only rape male
	end
	def self.signal_IgnoreCheck(character,target,track_mode=false)
		return true if sameXY_sex_pick_tgt(character,target)
		return true if super
	end
end

class Sensors::GeneralSexProjectileHit < Sensors::Battle_Sensor
	def self.type;						"GeneralProjectileHit";	end
	def self.sight_hp;					10;			end
	def self.ignore_sex_reciver?;		false;		end
	def self.detection_array
		[
			[["u",1]]
		]
	end
	def self.signal_IgnoreCheck(character,target,track_mode=false)
		return true if target.actor.action_state == :sex && !target.sex_receiver?#for npc.  if target isnt npc.target then it cannot hit
		return true if super
	end
end

class Sensors::SexStruggle < Sensors::Battle_Sensor
	def self.type;						"SexStruggle";	end
	def self.sight_hp;					4;			end
	def self.use_iff?;					false;		end
	def self.ignore_sex_reciver?;		false;		end
	def self.mine_number(character,target,track_mode);		1;		end #SexStruggle need
	def self.detection_array
		[
			[["u",1]]
			
		]
	end
end

class Sensors::SexLargeFrontAE < Sensors::Battle_Sensor
	def self.type;						"BasicAttack";	end
	def self.sight_hp;					3;			end
	def self.ignore_sex_reciver?;		false;		end
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