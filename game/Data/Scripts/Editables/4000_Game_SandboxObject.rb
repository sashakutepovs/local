

class Game_SandboxObject < Game_DestroyableObject
	
	def back_stab?(user)
		return false if !user.map_token.near_the_target?(map_token,2) 
		return false if user.map_token.direction != map_token.direction
		return true
	end
	def take_damage(user,skill,force_hit=false)
		@accumulated_damage=0
		skill_blocked=blocked?(user)
		advantaged = (skill.back_stab && back_stab?(user)) #自己被 stun 或back_stab?
		user.totalTargetedUnit += 1
		skill.effect.each{|eff|
			skill_effect=user.get_affected_attr(eff.base)
			receive_eff=get_affected_attr(eff.compare)
	
			line = [1-($game_map.terrain_tag(self.map_token.x,self.map_token.y)*0.25),0].max
			shp_left= 10*line
			if force_hit
				mine_value = 1
				ratio = 1
			else
				mine_value=skill.hit_detection.mine_number(user.map_token,self.map_token,false)
				return set_action_state(:none) if mine_value.nil?
				ratio=shp_left.to_f/ skill.hit_detection.sight_hp
			end
	
			#skill_effect = exportResultWithMultiHitDecrease(skill_effect,user) if skill.hit_DecreaseDamage
			result=((skill_effect-receive_eff)* ratio * mine_value).to_i
			result=1 if result < 1 || (skill_blocked && !skill.no_parry)
			result = (result*= skill.back_stab).to_i if advantaged
			result = exportResultWithMultiHitDecrease(result,user) if skill.hit_DecreaseDamage
	
			if self.map_token != user.map_token #&& eff.popup_type !=0 #None
				popup_str = 1+[rand(result)*0.01,0.3].min
				$game_damage_popups.add(result, self.map_token.x, self.map_token.y, user.map_token.direction,eff.popup_type,str=popup_str)
			end
			@last_hit_by_skill = skill
		}
	end
	def take_skill_effect(user,skill,can_sap=false,force_hit=false)
		take_damage(user,skill,force_hit)
		apply_skill_state_effect(skill,user)
		set_last_attacker(user) if !skill.is_support
		#map_token.effects=["CutTree",0,false,nil,nil,[true,false].sample]
		refresh
	end	
	
	
	def set_last_attacker(attacker)
		if attacker.user_redirect
			@last_attacker = attacker.map_token.summon_data[:user]
			attacker.map_token.summon_data[:user].actor.last_hitted_target = @event
		else
			@last_attacker = attacker.map_token
			attacker.last_hitted_target = @event
		end
		if @last_attacker == $game_player
			return if @master == $game_player
			return if @action_state == :death
			$game_player.target = self.map_token
		end
	end
	def apply_skill_state_effect(skill,user)
		skill.add_state.each{|state|
			next if rand(100) > state.chance
			state_to_add=state.states.sample
			next if @immune_tgt_states.include?(state_to_add)
			next if @immune_tgt_state_type.include?($data_StateName[state_to_add].type)
			#@stun_state=state #當下stun這些東西
			add_state(state_to_add)
			$game_damage_popups.add($data_StateName[state_to_add].icon_index , self.map_token.x, self.map_token.y, user.map_token.direction,state.popup_type) if self.map_token != user.map_token #&& eff.popup_type !=0 #None
			#apply_stun_effect(state_to_add) if !@sapped || !skill.no_action_change
		}
	end

	def apply_stun_effect(state_id)
		return
	end
end
