#==============================================================================
# This script is created by Kslander 
#==============================================================================
#砲台類使用的AI模型
class Npc_AbomHive  < Game_NonPlayerCharacter
	
	#override
	def process_target(target,distance,signal,sensor_type)
		super
		@event.turn_toward_character(target)
	end
	
	def setup_npc
		@stageH = [99,80,60,40,30,20,10]
		super
	end
	
	def overfatigue_death?
		@stat.get_stat("sta")<=0 
	end
	
	def npc_dead?
		@stat.get_stat("health")<=0 || @stat.get_stat("sta") <= 0
	end
	
	def process_skill_cost(skill)
		return true
	end
	
	def refresh
		super
		check_summon
	end
	def update_frame
		super
		@target = @target.actor.target if @target && @target.actor && @target.actor.master == @event
	end
	#def get_move_command
	#end
	def set_aggro(attacker,skill,frame_count=1800,no_action_change = false)
		attacker = attacker.target.actor if attacker.master == @event && attacker.target
		if attacker.user_redirect
			@target=attacker.map_token.summon_data[:user]
		else
			@target=attacker.map_token
		end
		@aggro_frame=frame_count=1800
		@alert_level=2
		add_fated_enemy([attacker.fraction]) if attacker.fraction != self.fraction
		set_action_state(:none) unless @action_state==:stun
	end
	
	def check_summon
		return if self.action_state == :death
		tmpCheck = @stat.get_stat("health",0).to_f / @stat.get_stat("health",3).to_f  * 100.0
		#tmpCheck =  @stat.get_stat("health",0).percent_of(@stat.get_stat("health",3))
		if !@stageH.empty? && tmpCheck <= @stageH.first
		@stageH.shift
		$game_map.npcs.any?{|ev| 
			next if !ev.summon_data
			next if !ev.summon_data[:AbomHeart]
			next if ev.actor.action_state == :death
			ev.npc.battle_stat.set_stat_m("health",-10,[0])
			ev.npc.refresh
		}
		end
	end
	

		def can_launch_skill?(skill)
			target_in_range?(skill)
		end
	#def set_killer_skill(dist)
	#	msgbox "Asdasdasd"
	#	skills=select_killer_skill(skills_killer,dist)
	#	return launch_skill(skills[0]) if (skills.length-1)==skills.count(nil) #only one skill available #skills.length==1
	#	launch_skill(select_ai_weighted_skill(skills))
	#	play_sound(:sound_skill,map_token.report_distance_to_vol_close_npc_vol) if @skill && rand(100) > 60
	#end
	#def avoid_friendly_fire?(skill)
	#	#Turret , 注意hit_detection要搬進來
	#	true
	#end

end
