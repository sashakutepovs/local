#==============================================================================
# This script is created by Kslander 
#==============================================================================#???????
#????Game_Event?Game_Player?,????????????


module Battle_System
		Struct.new("FakeTarget",:x,:y)
		attr_accessor	:current_animation #??????
		attr_accessor	:action_state
		attr_accessor	:skill
		attr_accessor	:dodged
		attr_accessor	:blocked
		attr_reader  	:holding_count
		attr_accessor	:holding_efx #???holding??????holding??????
		attr_accessor	:sapped
		attr_accessor	:target
		attr_accessor	:shieldEV
		attr_accessor	:custom_hit_efx #with custom efx?
		attr_accessor	:is_a_ProtectShield #if its shield.  use shield effect
		attr_reader		:accumulated_damage
		attr_reader		:is_projectile
		attr_reader		:skill_wait
		attr_reader		:stun_state_id
		attr_reader		:last_holding_count
		attr_accessor	:last_attacker
		attr_accessor	:last_hitted_target
		attr_accessor	:last_used_skill
		attr_accessor	:last_hit_by_skill
		attr_accessor	:banned_receiver_holes
		#attr_accessor	:banned_supported_fucker #unused
		
		
		def initialize_battle_system
			@skill_wait=0
			@current_skill_launched=false
			@totalTargetedUnit = 0
			@dodged=false
			@blocked=false
			@last_attakcer=nil
			@last_holding_count = 0 #???????
			@skill_charging_state=0 #??????????? 0 :? 1:??? 2: ?????
			@holding_count=-1 #??????holding??????holding????-1??holding?>=0
			@aggro_frame=0
			@sapped=false
		end
		
		#?????character?????????????
		def map_token
		 raise  "map_token is not implemented"
		end
		
		#?????????????
		def battle_stat
			raise "method battle_stat is not implemented"
		end
		
		def launch_skill(skill,force=false)
			return if skill.nil?
			return if @action_state == :skill && @skill_wait>0
			return set_action_state(:none) if avoid_friendly_fire?(skill)
			return set_action_state(:none) if !force && !can_launch_skill?(skill)
			@current_skill_launched = false
			if skill.holding?
				launch_holding_skill(skill)
			else
				launch_effect_skill(skill)
			end
			true
		end
		
		
		def launch_effect_skill(skill)
			set_action_state(:skill)
			process_skill_cost(skill) unless skill.holding?
			@skill_wait_chs_eff_reserved=!skill.wait_hit_frame
			@skill_charging_state=2
			tmpHitFrame = skill.hit_frame
			if tmpHitFrame===0
				@skill=skill
				@skill_wait=0
				################################################# add if @is_projectile to fix double skill hit ? force_update_actor  is for combo skills
				process_skill_result(skill) if @is_projectile || !map_token.force_update_actor # since theres hit_cancel for combo,
			else
				@skill=skill
				@skill_wait=tmpHitFrame
				map_token.set_animation(skill.chs_animation) if !@skill_wait_chs_eff_reserved && skill.chs_animation
			end
			summon_skill_user_efx
		end
		
		def launch_holding_skill(skill)
			set_action_state(:skill)
			process_skill_cost(skill)
			@holding_count = 0
			@last_holding_count = 0
			@current_skill_launched = false
			@skill=skill
			@skill_wait=skill.hit_frame 
			@skill_wait_chs_eff_reserved=!skill.wait_hit_frame
			@holding_max = 20+ rand(70) if skill.blocking?
			@blocked=skill.blocking?
			@skill_charging_state=0
			summon_skill_user_efx(true)
			map_token.set_animation(skill.hold_animation) if skill.hold_animation
			#map_token.jump_to_low(map_token.x,map_token.y) #fix target XY when holding
		end
		
		def process_skill_cost(skill)
			skill.cost.each{|cost|
				cost_val = self.battle_stat.get_stat(cost.base.attr,cost.base.attr_type)
				cost_val = get_affected_attr(cost.base) + get_affected_attr(cost.compare)#get_affected_attr(cost.base) by AleDerXan 2024 10 23
				self.battle_stat.set_stat(cost.base.attr,cost_val,cost.base.attr_type)
			}
		end
		def process_skill_cost_reverse(skill)
			skill.cost.each{
				|cost|
				cost_val1=self.battle_stat.get_stat(cost.base.attr,cost.base.attr_type)
				cost_val2= cost_val1 - ( get_affected_attr(cost.base) + get_affected_attr(cost.compare) )#get_affected_attr(cost.base) by AleDerXan 2024 10 23
				cost_val2= (cost_val2*0.5).to_i
				cost_val3=cost_val1+cost_val2
				self.battle_stat.set_stat(cost.base.attr,cost_val3,cost.base.attr_type)
			}
		end
		
		
		#def summon_void_efx(skill,skilltarget)
		#	return if skill.is_support || skill.no_aggro || skill.no_action_change
		#	SndLib.sound_BloodMagicCasting(skilltarget[0].report_distance_to_vol_close-20,200)
		#	skilltarget[0].zoom_x = skilltarget[0].zoom_x*0.7
		#	skilltarget[0].zoom_y = skilltarget[0].zoom_y*0.7
		#	skilltarget[0].mirror = !skilltarget[0].mirror
		#	skilltarget[0].opacity = 80
		#end
		
		
		
		def summon_parry_efx(skill,skilltarget)
			return if skill.no_parry
			data={
			:user => map_token,
			:target=> skilltarget[0],
			:skill => skill
			}
			$game_map.summon_skill("EffectParryHit",data)
		end
		
		def can_launch_skill?(skill)
			target_in_range?(skill) && cost_affordable?(skill) 
		end
		
		def target_in_range?(skill)
			return true if skill.blocking?
			return false if @target.nil? || skill.hit_detection.get_signal(map_token,@target)==0
			return true
		end
		
		def cost_affordable?(skill)
			return true if skill.cost.empty?
			tmpAMP = true
			skill.cost.any?{|cost|
				current_stat=self.battle_stat.get_stat(cost.base.attr,ActorStat::CURRENT_STAT)
				tmpAMP = !(current_stat <= cost.base.lowest_req  || current_stat >= cost.base.highest_req)
				break if tmpAMP == false
				}
			tmpAMP
		end
		
		
		def stat_exist?(stat_name)
			true
		end
		

		
		def select_skill(skillset,distance)
			@skill=nil
			selected=skillset.select{
				|skill| 
				next if skill.nil?
				if skill.blocking?
					distance < 2 
				else
					skill.range >=distance
				end
			}
			selected
		end
		
	def summon_skill_user_efx(holding=false)
		return if @skill.nil?
		#p "Character:::#{map_token.id}-summon_skill_user_efx holding=>#{holding} , skill.name=>#{@skill.name}"  if $debug_battle
		data={
			:user => map_token,
			:target=> target,
			:skill => @skill
		}
		if holding
			return if !@skill.summon_hold
			$game_map.summon_skill(@skill.summon_hold,data)
		else
			return if !@skill.summon_user
			$game_map.summon_skill(@skill.summon_user,data)
		end
		
	end
	

	def summon_skill_hit_efx(skill,target,damage=0)
		return if !skill.summon_hit
		data={
			:user => map_token,
			:target=> target[0],
			:skill => skill,
			:damage=> damage
		}
		$game_map.summon_skill(skill.summon_hit,data)
	end
	
	
	def update_skill_eff
		#return if @skill.nil? || $game_map.interpreter.running? || $game_message.busy?
		return if $game_map.interpreter.running? || $game_message.busy?
		return if set_action_state(:none) if @skill.nil?
		update_energizing
		if @skill_charging_state==2 #??????????launch??????2
			@skill_wait -= 1
			if (@skill_wait <= 0)
				if !@current_skill_launched
					process_skill_result(@skill)
					cancel_holding(true) if @skill && @skill.holding? && @holding_count!=-1
					@current_skill_launched = true
				end
				return if check_skill_hit_cancel(@skill)
				set_action_state(:none) if @skill && !@skill.chs_animation
				@last_used_skill = @skill
				@skill=nil #MG42
				map_token.skill_eff_reserved = false
				@skill_wait=-1 
				reset_skill
			end
		end
	end
	
	def check_skill_hit_cancel(skill)
		#p @last_hitted_target
		#p "asdlkjaskdjalsjdlaskjd #{skill.hit_cancel_mode} #{skill.hit_cancel_req_a_tgt}" if @last_used_skill
		#p "asdlkjaskdjalsjdlaskjd #{skill.hit_cancel_mode} #{@last_hitted_target.actor.last_hit_by_skill.name} == #{skill.name}" if @last_hitted_target 
		return false if !skill
		return false if skill.hit_cancel_mode == 0 && !skill.hit_cancel_req_a_tgt #Always
		skillCompare = !skill.hit_cancel_req_a_tgt || (@last_hitted_target && @last_hitted_target.actor.last_hit_by_skill == skill)
		return false if skill.hit_cancel_mode == 1 && skillCompare && @last_used_skill != skill #Differen
		return false if skill.hit_cancel_mode == 2 && skillCompare && @last_used_skill && skill.hit_cancel_req_last_skill == @last_used_skill.name #Last
		return false if skill.hit_cancel_mode == 0 && skillCompare #Always
		return true if map_token.chk_skill_eff_reserved
		false
	end
	
	def update_energizing
		return if @skill_charging_state==2
		@holding_count+=1
		map_token.set_animation(@skill.hold_animation) if !map_token.animation && @skill && self.action_state == :skill
		if over_energized?
			@skill_charging_state=2
			cancel_holding(true)
		elsif @holding_count>= @skill.launch_since
			@skill_charging_state= 1
		end
	end
	
	
	def cancel_holding(release=false)
		return if @skill.nil? || @holding_count == -1
		if @skill.energizing? && @skill_charging_state >= 1 && release
			@last_holding_count = @holding_count
			launch_effect_skill(@skill)
		elsif @skill.blocking?
			map_token.animation=nil
			@skill_wait=0
			@current_skill_launched = false
			reset_skill(true) #true include actionstate = :none , fix a bug, player not able to dash after blocking
		elsif @skill.energizing?
			map_token.animation=nil
			@skill_wait=0
			@current_skill_launched = false
			@skill=nil
			set_action_state(:none)
		elsif @skill.simply_holding?
			map_token.animation=nil
			map_token.set_animation(@skill.chs_animation) if release && skill.chs_animation
			summon_skill_user_efx if release
			@last_used_skill = @skill if release #selector skill have no where to place this shit. let it be.
			@skill=nil
			@skill_wait=0
			@current_skill_launched = false
			set_action_state(:none)
		end
		if @holding_efx
			@holding_efx.summon_data["released"]=release
			@holding_efx.move_type = 3
			if self != $game_player.actor
				map_token.unset_fapper if @fapping
				@holding_efx.delete
			else #is player
				@holding_efx.start
			end
			#self!= $game_player.actor ? @holding_efx.delete : @holding_efx.start
			@holding_efx=nil
		end
		@holding_max=nil
		@blocked=false
		@holding_count=-1
	end

	
	def set_action_state(action_state,force=false)
		return if @action_state==:death && !force
		return if action_state==@action_state && !force
		@action_state_changed=true
		@action_state=action_state
	end
	
	def action_changed?
		@action_state_changed
	end
	
	def change_acknowledged
		@action_state_changed=false
	end
	
	def state_order
		[nil,:death,:sex,:grabbed,:grabber,:stun,:skill,:none]
	end
	
	def can_change_action_state?(action_state)
		return true if action_state==:death
		return true if action_state.nil?
		cur_id = state_order.index(@action_state)
		new_id = state_order.index(action_state)
		cur_id < new_id
	end
	
	def with_ShieldEV?
		@shieldEV && !@shieldEV.deleted? 
	end
	
	def take_skill_effect(user,skill,can_sap=false,force_hit=false)
		return map_token.perform_dodge if @dodged && !skill.no_dodge
		return take_skill_hit_aggro(user,skill,can_sap=false,force_hit=false) if with_ShieldEV? && !skill.is_support && !skill.ignore_shieldEV
		back_stabed =(@action_state==:stun && !@is_object) || (skill.back_stab && back_stab?(user))
		check_skill_cancel_by_hit(user,skill) if !skill.no_action_change
		remove_stun_by_chance if !skill.no_action_change
		take_damage(user,skill,force_hit,back_stabed) unless self.immune_damage
		apply_skill_state_effect(skill,user) if (!self.immune_state_effect && !blocked?(user)) || skill.is_support
		take_sap(user) if skill.sap? && !@sapped && can_sap && !self.immune_state_effect && !self.immune_damage
		take_skill_hit_aggro(user,skill,can_sap=false,force_hit=false)
		set_last_attacker(user) if !skill.is_support
		refresh
		if hit_LinkToMaster
			master.actor.set_last_attacker(user)
			master.actor.refresh
		end
	end	

	def process_skill_result(skill)
		return if skill.blocking?
		return if @current_skill_launched
		@current_skill_launched = true
		if @skill_wait_chs_eff_reserved
			map_token.set_animation(skill.chs_animation) if skill.chs_animation
			@skill_wait_chs_eff_reserved=false
		end
		if skill.is_projectile?
			if skill.is_support
				summon_skill_hit_efx(skill,[@target])
			else
				summon_skill_hit_efx(skill,[map_token.get_fake_target()])
			end
			return
		end
		targets=skill.hit_detection.scan(map_token)
		if skill.hit_DecreaseDamage
			targets=targets.shuffle
			@totalTargetedUnit = 0 #???????? ???SHARE DAMAGE AOE ????????-1
		end
		targets.each{|tgt|
			next if skill_result_check_ignore_tgt(character=tgt[0],skill)
			summon_parry_efx(skill,tgt) if tgt[0].actor.check_blocked && tgt[0].skill_blocked?(map_token)
			tgt[0].actor.take_skill_effect(self,skill,do_sap)
			if tgt[0].actor.with_ShieldEV? && !skill.is_support && !skill.ignore_shieldEV #withshield  shield master do nothing
				#do nothing
			elsif tgt[0].actor.custom_hit_efx #a ev with unique hit EFFECT.  like shield
				tgt[0].actor.exec_custom_hit_efx(skill)
			else
				#summon_skill_hit_efx(skill,tgt,tgt[0].actor.accumulated_damage) unless tgt[0].actor.blocked || tgt[0].actor.immune_damage
				summon_skill_hit_efx(skill,tgt,tgt[0].actor.accumulated_damage) if (!tgt[0].actor.check_blocked || skill.is_support)# && !tgt[0].actor.immune_damage
			end
		}
		refresh
	end
	
	#def skill_result_check_break(character,skill)
	#	false
	#end
	def skill_result_check_ignore_tgt(character,skill)
		return true if character.nil?
		return true if character.actor.action_state==:death || character.missile
		return true if character.actor.dodged && !skill.no_dodge
		return true if character.actor.immune_damage
	end
	
	def take_skill_hit_aggro(user,skill,can_sap=false,force_hit=false)
		take_aggro(user,skill,blocked?(user)) unless self.immune_damage || skill.no_aggro || user.is_object
	end
	
	def actor_skill_no_interrupt?
		return false if @skill.nil?
		@skill.no_interrupt
	end
	def check_skill_cancel_by_hit(user,skill)
			if !blocked?(user) && !actor_skill_no_interrupt?
				map_token.animation= nil if @action_state == :skill && @skill
				take_skill_cancel(skill)
			end
	end
	
	def set_last_attacker(attacker)
		if attacker.user_redirect
			@last_attacker = attacker.map_token.summon_data[:user]
			attacker.map_token.summon_data[:user].actor.last_hitted_target = @event
		else
			@last_attacker = attacker.map_token
			attacker.last_hitted_target = @event
		end
	end
	
	def take_skill_cancel(skill=$data_arpgskills["BasicNormal"])
		if !@skill.nil?
			if !skill.no_action_change
				if skill.no_parry || !@skill.blocking?
					cancel_holding
					reset_skill(true)
				end
			end
		else
			reset_skill if !skill.no_action_change
		end
	end
	
	def blocked?(attacker)
		check_blocked && map_token.skill_blocked?(attacker.map_token)
	end
	
	def check_blocked
		@blocked
	end
	
	def totalTargetedUnit
		@totalTargetedUnit
	end
	def totalTargetedUnit=(val)
		@totalTargetedUnit = val
	end
	def exportResultWithMultiHitDecrease(result,user)
		result = ([result/user.totalTargetedUnit,1].max).to_i if user.totalTargetedUnit >= 2
		result
	end

	def export_affected_attr(effect)
		@stat.get_stat(effect.attr,effect.attr_type)
	end
	def calc_affected_attr(attribute,effect)
		case effect.type
			when "+";attribute += effect.adjust
			when "-";attribute -= effect.adjust
			when "*";attribute *= effect.adjust
			when "/";attribute /= effect.adjust
		end
		attribute
	end
	def get_affected_attr(effect)
		attribute=export_affected_attr(effect)
		attribute=calc_affected_attr(attribute,effect)
		attribute
	end
	def take_damage(user,skill,force_hit=false,back_stabed=false)
		@accumulated_damage=0
		skill_blocked=blocked?(user)
		advantaged = back_stabed
		user.totalTargetedUnit += 1 if skill.hit_DecreaseDamage
		skill.effect.each{|eff|
			if (eff.race_only && !eff.race_only.include?(self.race)) || (eff.race_skip && eff.race_skip.include?(self.race))
				next #fully ignore damage
				#skill_effect=0
				#receive_eff =0
			else
				skill_effect=user.get_affected_attr(eff.base)
				receive_eff=get_affected_attr(eff.compare)
			end
			if !@skill.nil? && (skill_blocked && !skill.no_parry)
				@skill.effect.each{|blocker|
					receive_eff = calc_affected_attr(receive_eff,blocker.base) if blocker.base.attr.eql?(eff.compare.attr)
				}
			else
				cancel_holding if !skill.no_action_change && !actor_skill_no_interrupt?
			end
			
			line = [1-($game_map.terrain_tag(self.map_token.x,self.map_token.y)*0.25),0].max
			line = 1 if skill.is_support && line > 0
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
			
			#????????attribute??
			attribute= battle_stat.get_stat(eff.damage.attr,eff.damage.attr_type)
			battle_stat.set_stat(eff.damage.attr,get_affected_damage(eff,attribute,result),eff.damage.attr_type)
			#DEBUG??????????????????
			if hit_LinkToMaster && master.actor.action_state !=:death
				attribute = master.actor.battle_stat.get_stat(eff.damage.attr,eff.damage.attr_type)
				master.actor.battle_stat.set_stat(eff.damage.attr,get_affected_damage(eff,attribute,result),eff.damage.attr_type)
				if self.map_token != user.map_token
					popup_str = 1+[rand(result)*0.01,0.3].min
					$game_damage_popups.add(result, master.x, master.y, user.map_token.direction,eff.popup_type,str=popup_str)
				end
			elsif self.map_token != user.map_token #&& eff.popup_type !=0 #None
				popup_str = 1+[rand(result)*0.01,0.3].min
				$game_damage_popups.add(result, self.map_token.x, self.map_token.y, user.map_token.direction,eff.popup_type,str=popup_str)
			end
			@last_hit_by_skill = skill
		}
	end
	
	def get_affected_damage(eff,current_val,damage)
		case eff.damage.type
			when "+";
				current_val += damage;
				@accumulated_damage+=damage.abs
			when "-";
				current_val -= damage;
				@accumulated_damage+=damage.abs
			when "*";
				cur_val_or=current_val
				current_val *= damage;
				@accumulated_damage+=(cur_val_or-current_val).abs 
			when "/";
				cur_val_or=current_val
				current_val /= damage;
				@accumulated_damage+=(cur_val_or-current_val).abs 
		end
		current_val
	end
	
	def back_stab?(user)
		return false if @is_object
		return false if !user.map_token.near_the_target?(map_token,2) 
		return false if user.map_token.direction != map_token.direction
		return true
	end

	def apply_skill_state_effect(skill,user)
		skill.add_state.each{|state|
			next if rand(100) > state.chance
			state_to_add=state.states.sample
			next if @immune_tgt_states.include?(state_to_add)
			next if @immune_tgt_state_type.include?($data_StateName[state_to_add].type)
			@stun_state=state #??stun????
			add_state(state_to_add)
			$game_damage_popups.add($data_StateName[state_to_add].icon_index , self.map_token.x, self.map_token.y, user.map_token.direction,state.popup_type) if self.map_token != user.map_token
			apply_stun_effect(state_to_add) if !@sapped || !skill.no_action_change
		}
	end
	def apply_force_CC_effect(stun_eff_id)
		#stun_eff_id = $data_StateName[stun_eff_id].id if stun_eff_id.is_a?(String)
		self.map_token.unset_chs_sex
		@stun_state = stun_eff_id
		add_state(stun_eff_id)
	end
	
	def force_stun(stun_eff_id)
		#stun_eff_id = $data_StateName[stun_eff_id].id if stun_eff_id.is_a?(String)
		apply_force_CC_effect(stun_eff_id)
		apply_stun_effect(stun_eff_id)
	end
	
	def force_fap(stun_eff_id)
		#stun_eff_id = $data_StateName[stun_eff_id].id if stun_eff_id.is_a?(String)
		apply_force_CC_effect(stun_eff_id)
		apply_fap_effect(stun_eff_id)
	end
	
	def force_shock(stun_eff_id)
		#stun_eff_id = $data_StateName[stun_eff_id].id if stun_eff_id.is_a?(String)
		apply_force_CC_effect(stun_eff_id)
		apply_shock_effect(stun_eff_id)
	end
	
	def force_pindown(stun_eff_id)
		#stun_eff_id = $data_StateName[stun_eff_id].id if stun_eff_id.is_a?(String)
		apply_force_CC_effect(stun_eff_id)
		apply_pindown_effect(stun_eff_id)
	end
	
	def force_cuming(stun_eff_id)
		#stun_eff_id = $data_StateName[stun_eff_id].id if stun_eff_id.is_a?(String)
		apply_force_CC_effect(stun_eff_id)
		apply_cuming_effect(stun_eff_id)
	end
	
	
	def remove_stun_by_chance
		return unless @action_state == :stun
		return if !@sapped &&  rand(100) > @unstun_chance 
		remove_stun_effect
	end


	def remove_stun_effect
		remove_stun_verbs
		map_token.cancel_stun_effect
		set_action_state(:none,true)
	end

	def remove_stun_verbs
		remove_state(@stun_state_id)
		@unstun_chance=nil
		@stun_count=nil
		@stun_state_id=nil
		@sapped=false
	end

	def update_stun
		return unless @action_state==:stun
		@stun_count -=1
		remove_stun_effect if @stun_count==0
	end
	
	def apply_stun_effect(state_id)
		return if @action_state==:sex || @action_state==:grabbed
		state=$data_StateName[state_id]
		return unless state.stun? && !@sapped
		cancel_holding if !@skill.nil? && @skill.holding? #addon in 2022 1 4, because no_interrupt
		map_token.jump_to_low(map_token.x,map_token.y) if map_token.moving?
		remove_stun_effect
		@stun_state_id=state_id
		@skill=nil
		@skill_wait_chs_eff_reserved=false
		@blocked=false
		@holding_max=nil
		@stun_count=state.steps_to_remove*60  #?????stun??frame
		@unstun_chance=state.chance_by_damage  #???????stun???
		set_action_state(:stun,true)
	end
	
	def apply_fap_effect(state_id)
		apply_stun_effect(state_id)
	end
	
	def apply_shock_effect(state_id)
		apply_stun_effect(state_id)
	end
	
	def apply_pindown_effect(state_id)
		apply_stun_effect(state_id)
	end
	
	def apply_cuming_effect(state_id)
		apply_stun_effect(state_id)
	end
	
	def take_sap(user)
		return false if @action_state == :sex
		user = user.find_redirect_user.actor if user.user_redirect #used to ptotect when user isnt player.(skillDummy) but seens can be replace by SapImmune
		if @no_aggro_sap_check
			@target = user.map_token
			return @no_aggro_sap_check = nil  # do not use @sap_immune in else where but there unlike @sapped.  this is for protect sap lock
		end
		return false unless map_token.behind_me?(user.map_token) && @target != user.map_token #already aggroed  target locked lona.  u cant sap lock
		return @sapped = false if @sapped
		@target=nil
		process_target_lost
		apply_stun_effect("Stun30")
		add_state("Stun30")
		@sapped=true
		@no_aggro_sap_check = true if @no_aggro
		return true
	end
	
	#??????????????????????
	def reset_skill(force=false)
		#p "reset_skill @event.id=>#{@event.id} force=>#{force}" if @debug_this_npc
		@skill=nil
		@skill_wait=0
		@current_skill_launched = false
		@skill_charging_state=0
		@blocked=false
		@holding_count=-1
		set_action_state(:none)	if force
	end
	
	#?????????holding???
	def over_energized?
		if @skill.energizing?
			return @holding_count >= @skill.launch_max if @skill.ai_hold_to_max? #????????
			@holding_count >= @skill.launch_since #???????
		elsif @skill.blocking?
			@holding_count >= @holding_max  #npc ????
		else 
			false
		end
	end
	
	def take_aggro(attacker,skill,no_action_change=false)
		@target = attacker
	end
	
	
	#???????????????????????????
	def avoid_friendly_fire?(skill)
		return false if skill.blocking? || skill.is_support
		return false if [2,3].include?(skill.projectile_type)
		skill.hit_detection.any_friendly_inrange?(map_token)
		#skill.hit_detection.scan(map_token).any?{|signal| 
		#	firendly_signal?(signal)}#any friendly in hit region
	end
	
	def friendly_signal?(signal)
		return false if signal[0].actor.is_object && (signal[0].through || [0,2].include?(signal[0].priority_type))
		friendly?(signal[0])
	end
	
	def do_sap
		return false if !@user_redirect
		return true if find_redirect_user == $game_player
		false
	end	


	def find_redirect_user #chatgpt ver.  original code is a shit
		current_user = map_token
		while current_user.summon_data && current_user.summon_data[:user]
			current_user = current_user.summon_data[:user]
		end
		current_user
	end
	def with_std?
		self.states.any? { |s| 
			next if !s
			s.type.include?("STD")
		}
	end
	
end #Battle_System	
