class Game_Player
	def set_follower_reset
		prp "$game_player.set_follower_reset",2
		@follower_list = Array.new #if @follower_list.nil? || @follower_list == 0
	end
	
	def set_follower(temp_id)
		set_follower_reset if @follower_list.nil? || @follower_list == 0
		@follower_list.delete(temp_id)
		@follower_list << temp_id
	end
	
	def delete_follower(id)
		@follower_list.delete(id)
	end
	
	def reset_companion_and_delete
		$game_map.events[get_companion_id(1)].delete if   ![0,nil].include?(get_companion_id(1))
		$game_map.events[get_companion_id(0)].delete if   ![0,nil].include?(get_companion_id(0))
		$game_map.events[get_companion_id(-1)].delete if  ![0,nil].include?(get_companion_id(-1))
		reset_companion
	end
	
	def get_companion_id(tmpSlot)
		tmpTarget = 0
		tmpSlotSYM = :none
		case tmpSlot
		 when "front",1 ; tmpSlot=1
			tmpSlotSYM = :followerFRONT
		 when "back",0 ; 	tmpSlot=0
			tmpSlotSYM = :followerBACK
		 when "ext",-1 ; 	tmpSlot=-1
			tmpSlotSYM = :followerEXT
		end
		tmpTarget = $game_map.npcs.select{|tmpEvent|
			next unless tmpEvent.npc.master == self
			next unless [self.record_companion_name_front,self.record_companion_name_back,self.record_companion_name_ext].include?(tmpEvent.name)
			next if !tmpEvent.summon_data || !tmpEvent.summon_data[tmpSlotSYM]
			tmpTarget
		}
		return nil if !tmpTarget || tmpTarget.empty?
		#tmpTarget.each{|ev| p ev.id}
		tmpTarget = tmpTarget.sample
		tmpTarget ? tmpTarget.id : nil
	end
	
	#same function.... same as get_companion_id?!
	def get_followerID(slot)
		get_companion_id(slot)
	end

	def reset_companion(skipExt=false)
		self.record_companion_name_front = nil
		self.record_companion_front_date= nil
		self.record_companion_name_back = nil
		self.record_companion_back_date= nil
		self.record_companion_name_ext = nil	if !skipExt
		self.record_companion_ext_date= nil		if !skipExt
	end
	
	def with_companion(skipExt=false)
		return true if self.record_companion_name_front != nil
		return true if self.record_companion_name_back != nil
		return true if self.record_companion_name_ext != nil && !skipExt
		return false
	end
	
	def set_companion_front(tmpX=self.x,tmpY=self.y,fadein=true)
		return if self.record_companion_name_front == nil
		return if $story_stats["UniqueChar#{self.record_companion_name_front}"] == -1
		return self.record_companion_name_front = nil if $story_stats["Captured"] == 1
		return self.record_companion_name_front = nil if $story_stats["Kidnapping"] == 1
		tmpName = $game_map.isOverMap ? "#{self.record_companion_name_front}_OM" : tmpName = self.record_companion_name_front
		EvLib.sum(tmpName,tmpX,tmpY,{:fadein => fadein})
		p "set_companion_front =>#{tmpName})"
	end
	
	def set_companion_back(tmpX=self.x,tmpY=self.y,fadein=true)
		return if self.record_companion_name_back == nil
		return if $story_stats["UniqueChar#{self.record_companion_name_back}"] == -1
		return self.record_companion_name_back = nil if $story_stats["Kidnapping"] == 1
		return self.record_companion_name_back = nil if $story_stats["Captured"] == 1
		tmpName = $game_map.isOverMap ? "#{self.record_companion_name_back}_OM" : tmpName = self.record_companion_name_back
		EvLib.sum(tmpName,tmpX,tmpY,{:fadein => fadein})
		p "set_companion_back =>#{tmpName}"
	end
	
	def set_companion_ext(tmpX=self.x,tmpY=self.y,fadein=true)
		return if self.record_companion_name_ext == nil
		return if $story_stats["UniqueChar#{self.record_companion_name_ext}"] == -1
		return self.record_companion_name_ext = nil if $story_stats["Kidnapping"] == 1
		return self.record_companion_name_ext = nil if $story_stats["Captured"] == 1
		tmpName = $game_map.isOverMap ? "#{self.record_companion_name_ext}_OM" : tmpName = self.record_companion_name_ext
		EvLib.sum(tmpName,tmpX,tmpY,{:fadein => fadein})
		p "set_companion_ext =>#{tmpName}"
	end
	
	#def set_companion_ShiftCall(slot=0,mode=Input.press?(:SHIFT))
	#	tmpID = self.get_followerID(slot)
	#	case slot
	#		when 1 	; tmpSlotSYM = :followerFRONT
	#		when 0 	; tmpSlotSYM = :followerBACK
	#		when -1 ; tmpSlotSYM = :followerEXT
	#	end
	#	return if tmpID == nil
	#	tmpEV = $game_map.events[tmpID]
	#	return if tmpEV.nil?
	#	return if !tmpEV.npc?
	#	return if !tmpEV.summon_data && tmpEV.summon_data[tmpSlotSYM]
	#	return if tmpEV.npc.master != self
	#	if mode == true
	#		tmpEV.follower[1] = 0
	#	else
	#		tmpEV.follower[1] = 1
	#		tmpEV.call_balloon(0)
	#		tmpEV.summon_data[:CallMarked] = nil
	#		tmpEV.summon_data[:CallMarkedX] = nil
	#		tmpEV.summon_data[:CallMarkedY] = nil
	#	end
	#end

	def check_companion_assemblyCall?
		actor.skill == $data_arpgskills["BasicAssemblyCall"] && @crosshair && @crosshair.summon_data && !@crosshair.summon_data[:shift]
	end

	def check_mouse_shift_companion_assemblyCall?
		actor.skill == $data_arpgskills["BasicAssemblyCall"] && @crosshair && @crosshair.summon_data && @crosshair.summon_data[:shift]
	end
	
	#set player target to a npc in XY.  not friendly or follower
	
	
	def set_player_target_in_a_XY(x,y,noResetMarkAfterAction=Input.press?(:SHIFT))
		target = get_player_target_in_a_XY(x,y)
		set_player_target_to_follower(target,noResetMarkAfterAction) if target
		
	end
	def get_player_target_in_a_XY(x,y)
		target = $game_map.npcs.select{|event|
			next if event.actor.immune_damage
			next if event.deleted?
			#next if event.actor.is_object ########################
			next if event.actor.is_a?(Game_PorjectileCharacter)
			next if event.actor.is_a?(Npc_ProtectShield)
			#next if event.actor.is_a?(GameTrap) 
			#next if event.actor.friendly?(self) ########################
			next if event.actor.master == self
			next if event.actor.action_state == :death
			event.pos?(x,y)
		}.sample
		target
	end
	def set_player_target_to_follower(target,noResetMarkAfterAction=Input.press?(:SHIFT))
		withFollower = false
		$game_map.npcs.each{|follower|
			next if follower.actor.master != self
			next if follower.actor.action_state == :death
			next unless follower.summon_data && (follower.summon_data[:followerFRONT] || follower.summon_data[:followerBACK])
			withFollower = true
			if noResetMarkAfterAction
				if follower.summon_data[:CallMarked]
					#follower.follower[1] = 0
					#follower.summon_data[:CallMarkedX] = follower.x if !follower.summon_data[:CallMarkedX]
					#follower.summon_data[:CallMarkedY] = follower.y if !follower.summon_data[:CallMarkedY]
					follower.turn_toward_character(target)
					follower.actor.take_skill_cancel($data_arpgskills["BasicNormal"]) if follower.actor.action_state == :skill
					follower.actor.set_aggro(target.actor,$data_arpgskills["BasicNormal"],300,false)
				end
			else
				follower.follower[1] = 1
				follower.summon_data[:CallMarked] = nil #if !noResetMarkAfterAction
				follower.summon_data[:CallMarkedX] = nil
				follower.summon_data[:CallMarkedY] = nil
				follower.turn_toward_character(target)
				follower.actor.take_skill_cancel($data_arpgskills["BasicNormal"]) if follower.actor.action_state == :skill
				follower.actor.set_aggro(target.actor,$data_arpgskills["BasicNormal"],300,false)
			end
		}
		self.target = target
		target.call_balloon(19) if withFollower
	end
	
	def get_a_follower_in_a_XY(x,y)
		target = $game_map.npcs.select{|event|
			next if event.actor.master != self
			next if event.actor.action_state == :death
			#next unless event.actor.target.nil?
			next unless event.summon_data && (event.summon_data[:followerFRONT] || event.summon_data[:followerBACK])
			#next unless event.follower[1] == 0
			event.pos?(x,y)
		}.sample
	end #get_a_follower_in_a_XY
	
	def set_target_follower_goto_XY(x,y,noResetMarkAfterAction=false)
		$game_map.npcs.each{|event|
			next if event.actor.master != self
			next if event.actor.action_state == :death
			next unless event.summon_data && (event.summon_data[:followerFRONT] || event.summon_data[:followerBACK])
			next unless event.summon_data && event.summon_data[:CallMarked] == true
			event.actor.play_sound(:sound_aggro,80)
			event.actor.process_target_lost if [:none,nil].include?(event.actor.action_state)
			if x == self.x && y ==self.y
				event.follower[1] = 1
				event.call_balloon(20)
				event.summon_data[:CallMarked] = nil
				event.summon_data[:CallMarkedX] = nil
				event.summon_data[:CallMarkedY] = nil
			else
				event.follower[1] = 0
				event.call_balloon(20) #if !noResetMarkAfterAction
				event.summon_data[:CallMarked] = nil if !noResetMarkAfterAction
				event.summon_data[:CallMarkedX] = x
				event.summon_data[:CallMarkedY] = y
			end
		}
	end #set_target_follower_goto_XY
	
	def click_a_target(target)
		target.summon_data[:CallMarked] ? target.summon_data[:CallMarked] = false :  target.summon_data[:CallMarked] = true
		target.actor.process_target_lost if [:none,nil].include?(target.actor.action_state)
		#p "target.summon_data[:CallMarked] #{target.summon_data[:CallMarked]}"
		if target.summon_data[:CallMarked]
			target.actor.play_sound(:sound_skill,80)
			target.call_balloon(11,-1)
		else
			target.summon_data[:CallMarkedX] = nil
			target.summon_data[:CallMarkedY] = nil
			target.actor.play_sound(:sound_lost,80)
			target.call_balloon(8)
		end
	end #click_a_target
	
end#class game_player

class Game_Event < Game_Character

	def is_follower?
		@follower[0] == 1
	end
	def is_follower_stand_mode?
		@follower[0] == 1 && @follower[1] == 0
	end
	
	def batch_BasicAssemblyCall
		if Input.press?(:SHIFT)
				p "adasdasdasd1"
			$game_map.npcs.each{|event|
				next if event.actor.master != $game_player
				next if event.actor.action_state == :death
				#next unless event.actor.target.nil?
				#next unless event.follower[1] == 0
				next unless event.summon_data
				next unless event.summon_data[:followerFRONT] || event.summon_data[:followerBACK]
				event.batch_set_companion_ShiftCall(0,true) if event.summon_data[:followerBACK]
				event.batch_set_companion_ShiftCall(1,true) if event.summon_data[:followerFRONT]
				next unless event.summon_data[:CallMarked] == true
				event.call_balloon(11,-1)
			}
			@blend_type =1
			@summon_data[:shift] = true
			@summon_data[:user].call_balloon(6)
			SndLib.Whistle(report_distance_to_vol_close-20,80)
		else
			$game_map.npcs.each{|event|
				next if event.actor.master != $game_player
				next if event.actor.action_state == :death
				#next unless event.actor.target.nil?
				#next unless event.follower[1] == 0
				next unless event.summon_data
				next unless event.summon_data[:followerFRONT] || event.summon_data[:followerBACK]
				event.batch_set_companion_ShiftCall(0,false) if event.summon_data[:followerBACK]
				event.batch_set_companion_ShiftCall(1,false) if event.summon_data[:followerFRONT]
			}
			@summon_data[:shift] = false
			@summon_data[:user].call_balloon(20)
			#$game_player.set_companion_ShiftCall(0,false)
			#$game_player.set_companion_ShiftCall(1,false)
			SndLib.Whistle(report_distance_to_vol_close-20)
		end
		@summon_data[:user].actor.holding_efx=self
		$game_player.set_crosshair(self)# if @summon_data[:user]==$game_player
		#@selector_range=@summon_data[:skill].range
		@selector_range=20
		@selector = true
		@selector_ignore_range = true
		@selector_limited_screen_edge = true
		@forced_y = 4
		@manual_move_speed = 8 if Mouse.enable?
	end
	def batch_set_companion_ShiftCall(slot=0,mode=Input.press?(:SHIFT))
		case slot
			when 1 	; tmpSlotSYM = :followerFRONT
			when 0 	; tmpSlotSYM = :followerBACK
			when -1 ; tmpSlotSYM = :followerEXT
		end
		return if self.nil?
		return if !self.npc?
		return if !self.summon_data && self.summon_data[tmpSlotSYM]
		return if self.npc.master != $game_player
		if mode == true
			self.follower[1] = 0
		else
			self.follower[1] = 1
			self.call_balloon(0)
			self.summon_data[:CallMarked] = nil
			self.summon_data[:CallMarkedX] = nil
			self.summon_data[:CallMarkedY] = nil
		end
	end
	def set_this_event_follower(follow_type=0)
		self.follower = [1,0,follow_type,0]
		self.npc.master = $game_player if self.npc?
		$game_player.set_follower(self.event.id)
	end
	
	def set_this_event_follower_remove
		self.npc.master = nil if self.npc? && self.npc.master == $game_player
		$game_player.delete_follower(self.event.id)
	end
	
	def set_this_companion_disband(temp_delete=true,force_name=false,slot=self.follower[2])
		tmpName = self.npc.npc_name if self.npc?
		tmpName = self.name if tmpName == nil
		tmpName = force_name if force_name !=false
		if self.follower[0] ==1
			$game_player.record_companion_name_front = nil 		if slot ==1
			$game_player.record_companion_front_date = nil		if slot ==1
			$game_player.record_companion_name_back = nil		if slot ==0
			$game_player.record_companion_back_date = nil		if slot ==0
			$game_player.record_companion_name_ext = nil		if slot ==-1
			$game_player.record_companion_ext_date = nil		if slot ==-1
			@summon_data[:followerBACK] = nil if @summon_data &&  slot ==0
			@summon_data[:followerFRONT] = nil if @summon_data &&  slot ==1
			@summon_data[:followerEXT] = nil if @summon_data &&  slot ==-1
		else
			$game_player.record_companion_name_front = nil if tmpName == $game_player.record_companion_name_front
			$game_player.record_companion_front_date = nil if tmpName == $game_player.record_companion_name_front
			$game_player.record_companion_name_back = nil if tmpName == $game_player.record_companion_name_back
			$game_player.record_companion_back_date = nil if tmpName == $game_player.record_companion_name_back
			$game_player.record_companion_name_ext = nil if tmpName == $game_player.record_companion_name_ext
			$game_player.record_companion_ext_date = nil if tmpName == $game_player.record_companion_name_ext
			@summon_data[:followerBACK] = nil if @summon_data && tmpName == $game_player.record_companion_name_back
			@summon_data[:followerFRONT] = nil if @summon_data && tmpName == $game_player.record_companion_name_front
			@summon_data[:followerEXT] = nil if @summon_data && tmpName == $game_player.record_companion_name_ext
		end
			p "companion #{tmpName} disbanded"
			self.follower =[0,0,0,0]
			set_this_event_follower_remove
			if temp_delete == true
				self.delete
			else
				if @summon_data
					@summon_data[:followerFRONT] = nil
					@summon_data[:followerBACK] = nil
					@summon_data[:followerEXT] = nil
				end
			end
			p "companion #{tmpName} disbanded2"
	end
	
	
		#name = EventLib name 
		#tmp_write=是否是這隻 否為其他隻
		#date = nil 為無限  相等時解散GROUP
	def set_this_event_companion_front(temp_name=self.name,temp_write=true,date_amt=$game_player.record_companion_front_date)
		@follower = [1,1,1,0] if temp_write
		if !@summon_data
			@summon_data = {:followerFRONT => true}
		else
			@summon_data[:followerFRONT] = true
		end
		if !$game_map.isOverMap && temp_write && self.npc?
			self.setup_follower_default_move_type
			self.npc.master = $game_player
		end
		$game_player.set_follower(self.event.id) if temp_write
		$game_player.record_companion_name_front = temp_name
		$game_player.record_companion_front_date = date_amt
	end
	
	def set_this_event_companion_back(temp_name=self.name,temp_write=true,date_amt=$game_player.record_companion_back_date )
		@follower = [1,1,0,0] if temp_write
		if !@summon_data
			@summon_data = {:followerBACK=>true}
		else
			@summon_data[:followerBACK] = true
		end
		if !$game_map.isOverMap && temp_write && self.npc?
			self.setup_follower_default_move_type
			self.npc.master = $game_player
		end
		$game_player.set_follower(self.event.id) if temp_write
		$game_player.record_companion_name_back = temp_name
		$game_player.record_companion_back_date = date_amt
	end
	
	def set_this_event_companion_back_lite
		@follower = [1,1,0,0]
		@summon_data = {} if !@summon_data
		@summon_data[:followerBACK] = true
		self.setup_follower_default_move_type
		self.npc.master = $game_player
		$game_player.set_follower(self.event.id)
	end
	
	def set_this_event_companion_front_lite
		@follower = [1,1,1,0]
		@summon_data = {} if !@summon_data
		@summon_data[:followerFRONT] = true
		self.setup_follower_default_move_type
		self.npc.master = $game_player
		$game_player.set_follower(self.event.id)
	end
	
	def remove_this_companion_lite
		@follower = [0,0,0,0]
		@summon_data = {} if !@summon_data
		@summon_data[:followerFRONT] = nil
		@summon_data[:followerBACK] = nil
		@summon_data[:followerBACK] = nil
		self.npc.master = nil
		$game_player.delete_follower(self.event.id)
		self.setup_follower_default_move_type
	end
	
	def set_this_event_companion_ext(temp_name=self.name,temp_write=true,date_amt=$game_player.record_companion_ext_date )
		@follower = [1,1,-1,0] if temp_write
		if !@summon_data
			@summon_data = {:followerEXT=>true}
		else
			@summon_data[:followerEXT] = true
		end
		if !$game_map.isOverMap && temp_write && self.npc?
			self.setup_follower_default_move_type
			self.npc.master = $game_player
		end
		$game_player.set_follower(self.event.id) if temp_write
		$game_player.record_companion_name_ext = temp_name
		$game_player.record_companion_ext_date = date_amt
	end
	
	def set_this_event_follower_reset
		@follower = [0,0,0,0]
	end
	
	def get_follower_default_move_type
		return 3 if !@summon_data
		return :companion_chase_character_ext if @summon_data[:followerEXT]
		return :companion_chase_character_back if @summon_data[:followerBACK]
		return :companion_chase_character_front if @summon_data[:followerFRONT]
	end

	def setup_follower_default_move_type
		self.set_move_frequency(@move_frequency)
		self.set_manual_move_type(get_follower_default_move_type)
		self.process_npc_DestroyForceRoute
		self.npc.process_target_lost
		self.setup_return # return to default move_route
	end
	
	def setup_follower_summoned(removeDropList=true,fadein=true)
		@npc.master = $game_player
		@npc.drop_list = [] if removeDropList
		@npc.fraction_mode =2
		@opacity = 0 if fadein == true
		@effects=["FadeIn",0,false,nil,nil,false] if fadein == true
		self.moveto($game_player.x,$game_player.y)
	end
	

end



module GIM_ADDON
		def AssemblyCallCommand(ev)
			return $game_player.cancel_crosshair if ev.summon_data[:MouseClicked]
			skill_released = ev.summon_data["released"]
			user = ev.summon_data[:user]
			tmpShiftMode = ev.summon_data[:shift]
			tmpGetEnemyTgt = $game_player.get_player_target_in_a_XY(ev.x,ev.y)
			if skill_released && ev==$game_player.crosshair
				if tmpShiftMode
					tmpWithFollower = $game_player.get_a_follower_in_a_XY(ev.x,ev.y)
					if tmpWithFollower
						$game_player.click_a_target(tmpWithFollower)
					elsif tmpGetEnemyTgt
						$game_player.set_player_target_to_follower(tmpGetEnemyTgt,tmpShiftMode)
					else
						$game_player.set_target_follower_goto_XY(ev.x,ev.y)
						$game_player.set_player_target_in_a_XY(ev.x,ev.y)
					end
				else
					$game_player.set_player_target_in_a_XY(ev.x,ev.y)
					$game_player.turn_toward_character(ev)
					$game_player.cancel_crosshair
				end #shift
			end #skill_released
		end #def

	def remove_companion(slot)
		case slot
		when 1  ;
			$game_player.record_companion_name_front = nil
			$game_player.record_companion_front_date= nil
		when 0  ;
			$game_player.record_companion_name_back = nil
			$game_player.record_companion_back_date= nil
		when -1 ;
			$game_player.record_companion_name_ext = nil
			$game_player.record_companion_ext_date= nil
		else
			$game_player.record_companion_name_front = nil
			$game_player.record_companion_front_date= nil
			$game_player.record_companion_name_back = nil
			$game_player.record_companion_back_date= nil
			$game_player.record_companion_name_ext = nil
			$game_player.record_companion_ext_date= nil
		end
	end
	
	def summon_companion(tmpX=$game_player.x,tmpY=$game_player.y,skipExt=false,slot=nil,fadein=true)
	$game_player.set_follower_reset
	#$game_date.dateAmt
		return if !$game_player.with_companion(skipExt)
		tmpF_d = $game_player.record_companion_front_date
		tmpB_d = $game_player.record_companion_back_date
		tmpE_d = $game_player.record_companion_ext_date
		if tmpF_d != nil && $game_date.dateAmt >= tmpF_d
			call_msg("common:Lona/Follower_disbanded")
			$game_player.record_companion_name_front = nil
			$game_player.record_companion_front_date= nil
		end
		if tmpB_d != nil && $game_date.dateAmt >= tmpB_d
			call_msg("common:Lona/Follower_disbanded")
			$game_player.record_companion_name_back = nil
			$game_player.record_companion_back_date= nil
		end
		if tmpE_d != nil && $game_date.dateAmt >= tmpE_d
			call_msg("common:Lona/FollowerExt_disbanded")
			$game_player.record_companion_name_ext = nil
			$game_player.record_companion_ext_date= nil
		end
		if $story_stats["Captured"] == 1 ||  $story_stats["Kidnapping"] == 1
			$game_player.record_companion_name_front = nil
			$game_player.record_companion_front_date= nil
			$game_player.record_companion_name_back = nil
			$game_player.record_companion_back_date= nil
			$game_player.record_companion_name_ext = nil
			$game_player.record_companion_ext_date= nil
		end
		$game_player.set_companion_front(tmpX,tmpY,fadein) if slot == 1 || ![1,0,-1].include?(slot)
		$game_player.set_companion_back(tmpX,tmpY,fadein) if slot == 0  || ![1,0,-1].include?(slot)
		$game_player.set_companion_ext(tmpX,tmpY,fadein) if slot == -1  || ![1,0,-1].include?(slot)
	end
	


	def check_companion_outdate?
	#$game_date.dateAmt
		return if !$game_player.with_companion
		tmpF_d = $game_player.record_companion_front_date
		tmpB_d = $game_player.record_companion_back_date
		tmpE_d = $game_player.record_companion_ext_date
		if tmpF_d != nil && $game_date.dateAmt >= tmpF_d
			call_msg("common:Lona/Follower_disbanded")
			$game_player.record_companion_name_front = nil
			$game_player.record_companion_front_date= nil
		end
		if tmpB_d != nil && $game_date.dateAmt >= tmpB_d
			call_msg("common:Lona/Follower_disbanded")
			$game_player.record_companion_name_back = nil
			$game_player.record_companion_back_date= nil
		end
		if tmpE_d != nil && $game_date.dateAmt >= tmpE_d
			call_msg("common:Lona/FollowerExt_disbanded")
			$game_player.record_companion_name_ext = nil
			$game_player.record_companion_ext_date= nil
		end
	end
	
	
	def follower_in_range?(followerID,range)
		return false if $game_player.get_followerID(followerID).nil?
		return false if !get_character($game_player.get_followerID(followerID))
		get_character($game_player.get_followerID(followerID)).report_range($game_player) < range
	end
end #module GIM_ADDON
