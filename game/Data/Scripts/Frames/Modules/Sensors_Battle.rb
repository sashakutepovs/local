#==============================================================================
# This script is created by Kslander 
#==============================================================================
#這個檔案室Lona遊戲裡面使用的Sensor的雛型

module Sensors
	
	
	class Battle_Sensor < Basic_Sensor
		
		def self.type;							"battle";	end
		def self.use_iff?;						false;		end
		def self.ignore_object?;				false;		end
		def self.water_only?;					false;		end
		def self.ignore_user?;					false;		end
		def self.ignore_sex_reciver?;			true;		end
		#def self.smart_select_when_same_xy?;	false;		end
		#覆寫，針對Battle_Sensor的特殊規格進行調整。
		def self.center
			return @center if @center
			d_array=detection_array
			for iy in 0...d_array.length
				for ix in 0...d_array[iy].length
					point=d_array[iy][ix]
					if (point.is_a?(Array) && ["u","v"].include?(point[0]))
						@target_self= point[0].eql?("v")
						@center=[iy,ix]
						break
					end
				end
			end
			@center
		end
		
		def self.signal_IgnoreCheck(character,target,track_mode=false)
			return true if super
			return true if ignore_user? && character.summon_data && character.summon_data[:user] == target
			return true if water_only? && !target.on_water_floor?
			return true if ignore_sex_reciver? && check_ignore_sex_reciver(character,target)
		end
		
		def self.same_char?(character,target)
			return false if target_self?
			return true if super
			return false
		end
		
		#def check_smart_select_when_same_xy(character,target)
		#end
		
		def self.check_ignore_sex_reciver(character,target)
			if target.sex_mode? && target.actor.action_state == :sex && target.sex_receiver?
				if target.actor.fucker_target
					return true if character.actor.master == target #is raper. but hit by slave
					return true if character.actor.find_redirect_user.actor.master == target
					return true if character.actor.find_redirect_user.actor.master && character.actor.find_redirect_user.actor.master.actor && character.actor.find_redirect_user.actor.master.actor.find_redirect_user == target
				else
					return true #not raper  ignore
				end
			end
			return nil
		end
		def self.target_self?
			@target_self
		end
		
		
		def self.detection_array
		[
			[0	, ["u",1]	,0],
			[0	,	 1 		,0],
			[0	,	 1 		,0],
			[0	,	 1 		,0],
			[0	,	 1 		,0],
			[0	,	 1 		,0]
		]
		end
		
		def self.mine_number(character,target,track_mode)
			mine_number=super(character,target,track_mode)
			mine_number=mine_number[1] if mine_number.is_a?(Array)
			mine_number=nil if mine_number==0
			mine_number
		end
	end

end
	


