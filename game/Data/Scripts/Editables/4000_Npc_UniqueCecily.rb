#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁
class Sensors::Eyes_follower_cecily < Sensors::Eyes
	def self.lona_trying_to_do_bad_thing?(tgt)
		return false if tgt != $game_player
		return false if $game_player.actor.action_state != :sex
		return false if $game_player.actor.fucker_target.nil?
		return $game_player.actor.fucker_target.actor.is_a?(Npc_UniqueGrayRat)
	end
	def self.grayrat_trying_to_do_bad_thing?(tgt)
		return false unless tgt
		return false unless tgt.actor.is_a?(Npc_UniqueGrayRat)
		return tgt.actor.action_state == :sex
	end
	def self.ignore_obj_chk(character,target)
		return false if lona_trying_to_do_bad_thing?(target)
		return false if grayrat_trying_to_do_bad_thing?(target)
		return false if character.actor.master && character.actor.master == $game_player && $game_player.target == target
		return true if super
	end
end
class Npc_UniqueCecily < Game_NonPlayerCharacter
	def update_frame
		@event.call_balloon(11,-1) if @event.balloon_id == 0 && @event.summon_data && @event.summon_data[:CallMarked] == true
		super
	end
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		assemble = self.master == $game_player && $game_player.check_companion_assemblyCall?
		tgt = get_target
		self.process_target_lost if !tgt.nil? && (@target == master || @fraction == tgt.actor.fraction || tgt.actor.npc_name == "UniqueGrayRat") && !lona_trying_to_do_bad_thing?(@target)
		if event.follower[0] == 1 && assemble
			return [:move_goto_xy,$game_player.crosshair.x,$game_player.crosshair.y] if $game_player.crosshair.x != @event.x || $game_player.crosshair.y != @event.y
			return if tgt.nil?
			return [:turn_toward_character,tgt]
		end
		return if tgt.nil?
		near = @event.near_the_target?(tgt,safe_distance)
		case @ai_state
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:turn_toward_character,tgt] if event.follower[1] == 0 && event.summon_data && event.summon_data[:CallMarkedX] == @event.x && event.summon_data[:CallMarkedY] == @event.y
				return [:move_toward_XY_SmartAI,event.summon_data[:CallMarkedX],event.summon_data[:CallMarkedY]] if event.follower[1] == 0 && event.summon_data && event.summon_data[:CallMarkedX] && event.summon_data[:CallMarkedY]
				return [:move_random] if same_xy?(tgt) && !(event.follower[0] == 1 && event.follower[1] ==0) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !near && !(event.follower[0] == 1 && event.follower[1] ==0)
				return [:turn_toward_character,tgt]
		end
	end
	def friendly?(character)
		return false if lona_trying_to_do_bad_thing?(character)
		return false if grayrat_trying_to_do_bad_thing?(character)
		return super
	end
	def lona_trying_to_do_bad_thing?(tgt)
		return false if tgt != $game_player
		return false if $game_player.actor.action_state != :sex
		return false if $game_player.actor.fucker_target.nil?
		return $game_player.actor.fucker_target.actor.is_a?(Npc_UniqueGrayRat)
	end
	#end
	def grayrat_trying_to_do_bad_thing?(tgt)
		return false unless tgt
		return false unless tgt.actor.is_a?(Npc_UniqueGrayRat)
		return tgt.actor.action_state == :sex
	end

	def assulter?(target,friendly)
		return true if grayrat_trying_to_do_bad_thing?(target)
		return true if lona_trying_to_do_bad_thing?(target)
		return super
	end
end
