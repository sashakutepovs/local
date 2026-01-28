
class Game_Player
	attr_reader :integrity_vag
	attr_reader :integrity_anal
	attr_reader :integrity_mouth
	#attr_reader :integrity_all
	#====================================
	# 掙脫sex
	#====================================
	def calc_integrity
		if actor.action_state==:sex
			calc_integrity_sex
		elsif actor.action_state==:grabbed
			calc_integrity_grabbed
		elsif actor.action_state==:grabber
			clear_integrity_record
		else
			clear_integrity_record
		end
	end
	
	def calc_integrity_grabbed
		clear_integrity_record
		@fuckers.each{
			|fker|
			@integrity_all+=fker.actor.battle_stat.get_stat("constitution")
		}
	end
	
	def calc_integrity_sex
		@fucker_vag=nil
		@fucker_anal=nil
		@fucker_mouth=nil
		clear_integrity_record
		
		@fuckers.each{
			|fker|
			case chs_definition.get_holename(fker)
				when "vag";@fucker_vag=fker
				when "anal";@fucker_anal=fker
				when "mouth";@fucker_mouth=fker
			end
		}
		@integrity_vag	 =@fucker_vag.nil? ? 0 : @fucker_vag.actor.battle_stat.get_stat("constitution")
		@integrity_anal  =@fucker_anal.nil? ? 0 : @fucker_anal.actor.battle_stat.get_stat("constitution")
		@integrity_mouth =@fucker_mouth.nil? ? 0 : @fucker_mouth.actor.battle_stat.get_stat("constitution")
		@integrity_all = @integrity_vag + @integrity_anal + @integrity_mouth
		
	end
	
	def clear_integrity_record
		@integrity_vag	 =0
		@integrity_anal  =0
		@integrity_mouth =0
		@integrity_all	=0
	end	
	
	
	def integrity_all
		calc_integrity if @integrity_all.nil? || @integrity_all==0
		@integrity_all
	end
	
	
	
end
