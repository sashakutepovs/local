#==============================================================================
# This script is created by Kslander 
#==============================================================================
#====================================================================================================
#	Sex系統的核心，處理grab跟sex(有沒有洞)的相關判斷
#	被引用到Game_Player / Game_Event
#====================================================================================================

module Sex
	
	attr_reader :fuckers #陣列，這個腳色正在被誰fuck，紀錄物件參考
	attr_reader :fappers #陣列，超過chs可容納量的部分
	attr_accessor :receiver #作為receiver的character
	attr_accessor :sex_snd 
	attr_accessor :grabber
	attr_accessor :sex_count
	attr_accessor :story_mode_sex
	
	def max_chs_capacity
		use_chs? ? $chs_data[@chs_type].max_capacity : 0
	end
	
	def init_sex_system
		@fuckers=Array.new
		@fappers=Array.new
		@grab_count=0
		@sex_state=-1 # 6 / 3 / 9 
		@sex_count=-1 # 已經進入sex狀態多久
		@grabber = nil
	end
	
	def update_grab_count
		@grab_count+=1
		if @grab_count >= 180
			@grab_count=0
			set_chs_sex_group
		end
		
	end
	
	
	#加入sex_gang，@fappers或 @fuckers
	#fappers : CHCG時負責提供屌、不加入CHSH
	#fuckers : CHSH參加者，有洞才可以加
	def add_sex_gang(char)
		p "add_sex_gang char.deleted?=>#{char.deleted?} !use_chs?=>#{!use_chs?}" if self==$game_player
		return false if char.deleted? || !use_chs?
		if @fuckers.include?(char) || @fappers.include?(char)
			p "add_sex_gang a" if self==$game_player
			return true 
		end
		@fuckers.select!{ |fucker| !fucker.deleted? && !fucker.actor.dead?}
		@fappers.select!{ |fapper| !fapper.deleted? && !fapper.actor.dead?}
		if @fuckers.length < max_chs_capacity && empty_slot_for?(char)
			p "add_sex_gang b" if self==$game_player
			@fuckers << char
			set_chs_sex_group if actor.action_state==:sex  #如果已經開幹，重設chsh
			return true
		elsif @fappers.length < 4
			p "add_sex_gang c" if self==$game_player
			@fappers << char
			return false
		end
		return false
	end
	
	def add_fucker(char)
		@fuckers << char
	end
	
	#因為任何理由必須離開sex_gang時呼叫此方法
	def quit_sex_gang(char)
		return if !use_chs?
		@fuckers.delete(char)
		@fappers.delete(char)
		unset_chs_sex if sex_mode? && @fuckers.empty? && sex_receiver?
	end
	
   #被grab，回傳是否成功grab。
   #passive => true : 一般狀況 , false : female grabber
	def grab(grabber,passive=true)
		return false if !use_chs? || @immue_grab || !@force_update_actor
		#p "grab @event.id=>#{@event.id} actor.fucker_target.id=>#{actor.fucker_target.id if actor.fucker_target}" if @debug_this_one
		unset_fapper if actor!=$game_player.actor &&  actor.fapping
		release_chs_group if sex_mode?
		add_sex_gang(grabber) if passive
		#搶人的狀況先確保自己(被搶的)沒有在別人的fuckers或fappers裡面以避免觸發unset chs 4 
		if !passive
			@grabber = grabber 
			@grabber.summon_appetizer_ev if @grabber==$game_player
		end
		actor.set_action_state(:grabbed)
		self.animation=animation_grabbed_qte
		return true
	end
	 
	#判斷腳色是否正被grab
	def grabbed?
		#這裡的actor相依於Battle_System.rb裡的方法
		return false if !use_chs?
		return false if !actor
		actor.action_state==:grabbed || actor.action_state==:sex
	end
   
   def passively_grabbed?
	grabbed? && !@grabber.nil?
   end
   
   #是否正在做愛
   def sex?
	actor.action_state==:sex
   end
   
   #是否正在自慰, 條件：holding_efx 不為nil 以及 ai_state==:fucker
   def masturbating?
	false
   end
   
   #檢查CHS支援性，如果根已存在的腳色有穴衝突就拒絕加入(滾去fapper)
	def empty_slot_for?(fucker)
		arr=Array.new(@fuckers) << fucker
		return false if @fuckers.length >1 && unique_slot_conflict?(arr)
		return !available_poses(arr).empty?
	end

	#取得receiver清單中、符合當下fucker現況的pos，若無，回傳false
	#only use in common sex
	def available_poses(fgroup)
		capatitable_poses= Array.new
		receiver = Array.new(self.chs_definition.supported_receiver)
		holename = Array.new(self.chs_definition.receiver_holename)
		#todo remove banned pose
		if self.actor && self.actor.banned_receiver_holes
			check_banned_slots(self.actor.banned_receiver_holes, receiver_holename=holename, supported_receiver=receiver)
		end
		for pose_index in 0...receiver.length
			next if receiver[pose_index].length < fgroup.length
			group=Array.new(fgroup.length){|index|
				fgroup[index].chs_definition.supported_fucker[pose_index]
			}
			if available_pose?(group,receiver[pose_index])
			 capatitable_poses << pose_index
			end
		end
		capatitable_poses
	end

	# Update the slot array based on the banned list.
	def check_banned_slots(banned_list, receiver_holename, supported_receiver)
		return supported_receiver if !banned_list && banned_list.empty?
		# Iterate over each row in the receiver_holename and supported_receiver arrays
		receiver_holename.each_with_index do |row, i|
			# Remove indices from supported_receiver[i] where receiver_holename[i] contains banned_list elements
			supported_receiver[i] = supported_receiver[i].reject { |index| banned_list.include?(row[index - 1]) }
		end
		supported_receiver
	end

	def available_pose?(group,pose)
	return false if pose.length < group.length
	current_pose=Array.new(pose)
	sgroup=group.sort_by{|fucker|fucker.length}
	for i in 0...group.length
		capatitable_pose= sgroup[i] & current_pose
		return false if capatitable_pose.empty?
		current_pose -= capatitable_pose if capatitable_pose.length==1
	end
	true
   end
   
   
   def unique_slot_conflict?(fucker)
	for fk in 0...fucker.length
		count = 0
		current_fker=fucker[fk]
		fucker.each{|fker|
			next unless fker.chs_definition.supported_fucker.length==1 
			next unless fker.chs_definition.supported_fucker == current_fker.chs_definition.supported_fucker
			count+=1
		}
		return true if count>1
	end
	false
   end
   
   
   #透過當下的資訊設定chsh_group
   #分配位置
   #receiver部分
	def set_chs_sex_group
		@fuckers.select!{|fker|!fker.npc.npc_dead? && !fker.deleted?}
		return unset_chs_sex if @fuckers.length == 0
		pose = available_poses(@fuckers).sample
		return unset_chs_sex if pose.nil? 
		if @grabber
			@grabber.unset_chs_sex
			@grabber=nil
		end
		@sex_count=0
		receiver_pos = Array.new(chs_definition.supported_receiver[pose])
		fgroup=@fuckers.sort_by{|fker|
			fker.chs_definition.supported_fucker[pose].length
		}
		fk_definitions=Array.new(fgroup.length){|index|
			fgroup[index].chs_definition.supported_fucker[pose]
		}
		for char_index in 0...fgroup.length
			#FEMDON 狀態時由女方強制指定姿勢
			if @femdonMode
				forcedPose = @femdonMode
				@femdonMode = nil #僅對第一人有效
				receiver_PoseList=Array.new(chs_definition.get_pos_by_holename(forcedPose,1))
				poses=Array.new
				for i in 0...receiver_PoseList.length
					tgt_hole_index = chs_definition.get_position_index(receiver_PoseList[i],forcedPose)
					next if tgt_hole_index.nil?
					next if fgroup[char_index].chs_definition.supported_fucker[receiver_PoseList[i]].index(tgt_hole_index+1).nil?
					poses << receiver_PoseList[i]
				end
				pose = poses.sample
				sel_position = chs_definition.get_position_index(pose,forcedPose)
				return prp "set_event_fuck_a_target error, pose = #{sel_position}" if !sel_position #若女角找無姿勢則QUIT
				return if !fgroup[char_index].chs_definition.supported_fucker[pose].include?(sel_position+1) #比對男角姿勢 若男角不支援則QUIT
				sel_position = sel_position+1
				
			#如果只支援一個位置就直接指定下去
			elsif fk_definitions[char_index].length==1
				sel_position=fk_definitions[char_index][0]
				receiver_pos-=fk_definitions[char_index]
				
			#正常單位的狀態 採取隨機取樣
			elsif char_index+1 == fgroup.length
				sel_position=(fk_definitions[char_index] & receiver_pos).sample
				receiver_pos.delete(sel_position)
			else
				sel_position=(fk_definitions[char_index] & receiver_pos & fk_definitions[char_index+1]).sample
				receiver_pos.delete(sel_position)
			end
			return fgroup[char_index].actor.launch_skill(fgroup[char_index].actor.masturbate_skill) if sel_position == nil #嘗試修正 available_pose? 回傳空職 不匹配的問題  強制單位打手槍
			fgroup[char_index].set_chs_sex_combat_move_to_tgt(self) if !@femdonMode #update2023-2-10
			fgroup[char_index].actor.fapping =false
			fgroup[char_index].set_chs_sex(pose,sel_position)
			fgroup[char_index].receiver=self
			fgroup[char_index].actor.set_action_state(:sex,true)
		end #for fgroup[char_index]
		actor.set_action_state(:sex,true) #設定自己的 action_state
		set_chs_sex(pose,0)
	end

	def set_chs_sex_combat_move_to_tgt(tgt)
		@jump_when_unset_chs_sex = true
		moveto(tgt.x,tgt.y) #update2023-2-10
	end
	
	def set_chs_sex_prev_zoomXY
		@prev_sex_zoom_x = @zoom_x if @zoom_x != 1
		@prev_sex_zoom_y = @zoom_y if @zoom_y != 1
		@zoom_x = 1
		@zoom_y = 1
	end
	
	def set_chs_sex_recover_zoomXY
		#msgbox @need_sex_jump
		if @jump_when_unset_chs_sex
			self.item_jump_to(tmpPeak= 10,skip_character=true) if self.all_way_block?
			self.item_jump_to(tmpPeak= 10,skip_character=true) if self.all_way_block?
			self.item_jump_to(tmpPeak= 10,skip_character=false)
			@jump_when_unset_chs_sex = nil
		end
		@need_sex_jump = nil
		@zoom_x = @prev_sex_zoom_x if @prev_sex_zoom_x
		@zoom_y = @prev_sex_zoom_y if @prev_sex_zoom_y
		@prev_sex_zoom_x = nil
		@prev_sex_zoom_y = nil
		@prev_sex_d = nil
	end
	#設定單體的chs姿勢
	def set_chs_sex(pose,position)
		p "set_chs_sex(#{pose},#{position})"
		set_chs_sex_prev_zoomXY
		actor.remove_stun_verbs if actor  #2024 8 28. to remove stun verb remain when sex
		@chs_configuration["sex_pos"]=pose
		@chs_configuration["sex_position"]=position
		@sex_state=1
		@tile_id=0
		@chs_need_update=true
	end
	
	def unset_chs_sex(release=false)
		set_chs_sex_recover_zoomXY
		self.animation=nil
		@chs_configuration["sex_pos"]=-1
		@chs_configuration["sex_position"]=-1
		@chs_need_update=true
		@story_mode_sex = nil
		@eventSexMode=nil
		@prev_action_state=nil
		if actor
			actor.fucker_target.quit_sex_gang(self) if !actor.fucker_target.nil? #unless actor.fucker_target.nil? 
			actor.fucker_target=nil
			actor.set_action_state(:none,true)
		end
		@sex_state=-1
		@grabber = nil
		actor.refresh if actor
	end
	
	def set_event_chs_sex(pose,position)
		set_chs_sex_prev_zoomXY
		@chs_configuration["sex_pos"]=pose
		@chs_configuration["sex_position"]=position
		@chs_need_update=true
	end
	
	def unset_event_chs_sex
		set_chs_sex_recover_zoomXY
		@chs_configuration["sex_pos"]=-1
		@chs_configuration["sex_position"]=-1
		@chs_need_update=true
		@story_mode_sex = nil
		@eventSexMode=nil
		self.animation=nil
	end
	
	
	
	
	def chs_definition
		$chs_data[@chs_type]
	end
   
   #檢查是否為sex_receiver(position==0)
   #因為開始H後節奏由Receiver掌握
   def sex_receiver?
	@chs_configuration["sex_position"]==0
   end
   
   
   def udpate_synced_character_animation
	@fuckers.each do |fucker|fucker.udpate_animation_synced;end 
   end
   
   #CHS_H結束後的處理，重設所有參加CHS_H的參加者狀態
	def release_chs_group
		p "release_chs_group self=>#{self.to_s} id=>#{self.id}"
		unset_chs_sex
		@grabber = nil
		release_chs_fucker
		release_chs_fapper
	end
   
	def release_chs_fapper
		@fappers.shift.unset_chs_sex(true) until @fappers.empty?
	end
	def release_chs_fucker
		@fuckers.shift.unset_chs_sex(true) until @fuckers.empty?
	end
   
   def cancel_sex_snd
	return if @sex_snd.nil?
	@sex_snd.delete
	@sex_snd=nil
   end
   
   
   #接收fapper
   def add_fapper(fapper)
	return false if @fappers.length >= 4
	@fappers << fapper
	return true
   end
   
	def unset_fapper
		actor.fucker_target.quit_sex_gang(self) unless actor.fucker_target.nil?
		actor.fucker_target=nil
	end
   
	def update_animation_synced
		return if !sex_mode? || !sex_receiver?
		return if @animation.nil?
		@fuckers.each do |fucker|  
		next  p "fucker gone nil"  if fucker.nil?
		next if fucker.animation.nil?
		fucker.animation.frame=self.animation.frame
		end
	end
  
	def animation_rand_masturbation
		return if self.animation
		self.animation = [animation_masturbation,animation_masturbation_fast,animation_masturbation_cumming].sample
	end
	def set_event_storymode_fuck_a_target(tmpReciver,temp_tar_slot="rand",forcePose=nil,tmpAniStage=0,teleToTGT=false)
		#p self.npc.ai_state
		return update_event_storymode_sex(tmpAniStage) if @story_mode_sex
		return self.animation_rand_masturbation if !tmpReciver
		return self.animation_rand_masturbation if !tmpReciver.use_chs?
		return self.animation_rand_masturbation if tmpReciver.deleted?
		return self.animation_rand_masturbation if tmpReciver.npc? && tmpReciver.actor.action_state == :death
		return self.animation_rand_masturbation if tmpReciver.npc? && ![:none,nil].include?(tmpReciver.actor.action_state)
		return self.animation_rand_masturbation if tmpReciver.npc? && tmpReciver.npc.anomally
		return self.animation_rand_masturbation if !tmpReciver.normal_move_type?
		return self.animation_rand_masturbation if tmpReciver.moving?
		self.moveto(tmpReciver.x,tmpReciver.y) if teleToTGT
		set_event_fuck_a_target(tmpReciver,temp_tar_slot,forcePose,tmpAniStage)
	end
	def update_event_storymode_sex(tmpAniStage)
		case tmpAniStage
		when 0 ; 
				SndLib.sound_chs_buchu(report_distance_to_vol_close-40)
				@wait_count = 40
		when 1 ; 
				SndLib.sound_chs_buchu(report_distance_to_vol_close-40)
				@wait_count = 20
		when 2 ; 
				SndLib.sound_chs_buchu(report_distance_to_vol_close-40)
				@wait_count = 50
		else
				SndLib.sound_chs_buchu(report_distance_to_vol_close-40)
				@wait_count = 30
		end
	end
	def set_event_fuck_a_target(tmpReciver,temp_tar_slot="rand",forcePose=nil,tmpAniStage=0)
			if temp_tar_slot ==  "rand"
				case rand(3)
					when 0; temp_tar_slot = "vag"
					when 1; temp_tar_slot = "anal"
					when 2; temp_tar_slot = "mouth"
				end
			end
			tmpFucker = self
			tmpFucker.actor.fucker_target = tmpReciver if tmpFucker.actor
			tmpReciver.add_fucker(tmpFucker)
			tmpFucker.story_mode_sex = true
			tmpReciver.story_mode_sex = true
			tmpReciver.fuckers.push(tmpFucker)
			defini=tmpReciver.chs_definition
			temp_pose=defini.get_pos_by_holename(temp_tar_slot,1)
			fker_defini=tmpFucker.chs_definition
			poses=Array.new
			for i in 0...temp_pose.length
				tgt_hole_index=defini.get_position_index(temp_pose[i],temp_tar_slot)
				next if tgt_hole_index.nil?	
				next if fker_defini.supported_fucker[temp_pose[i]].index(tgt_hole_index+1).nil?
				poses << temp_pose[i]
			end
			forcePose.nil? ? pose = poses.sample : pose = forcePose
			sel_position = defini.get_position_index(pose,temp_tar_slot)
			return prp "set_event_fuck_a_target error, pose = #{sel_position}" if !sel_position
			fker_posi = sel_position+1
			#tmpReciver.actor.set_action_state(:sex)
			tmpReciver.set_event_chs_sex(pose,0)
			case tmpAniStage
				when 0
					tmpReciver.animation = tmpReciver.animation_event_sex(tmpReciver,pose)
					tmpFucker.set_event_chs_sex(pose,fker_posi)
					tmpFucker.animation = tmpFucker.animation_event_sex(tmpReciver,pose)
				when 1
					tmpReciver.animation = tmpReciver.animation_event_sex_fast(tmpReciver,pose)
					tmpFucker.set_event_chs_sex(pose,fker_posi)
					tmpFucker.animation = tmpFucker.animation_event_sex_fast(tmpReciver,pose)
				when 2
					tmpReciver.animation = tmpReciver.animation_event_sex_cumming(tmpReciver,pose)
					tmpFucker.set_event_chs_sex(pose,fker_posi)
					tmpFucker.animation = tmpFucker.animation_event_sex_cumming(tmpReciver,pose)
			end
	end
	def state_sex_spread_to_fucker(tgtFuckers)
		return if !tgtFuckers
		return if tgtFuckers.empty?
		reciverStates = []
		reciverStates = self.actor.feature_objects.uniq
		reciverStates.each{|basedState|
			next unless basedState
			next unless basedState.item_name
			next unless basedState.spread_when_sex
			next unless basedState.spread_when_sex["chance"] > rand(100)
			tgtFuckers.each{|tmpFucker|
				next unless tmpFucker
				next unless tmpFucker.actor
				next unless !["nil",nil].include?(self.chs_definition.get_holename(tmpFucker))
				next unless self.chs_definition.get_holename(tmpFucker) == basedState.spread_when_sex["fucker_slot"] || basedState.spread_when_sex["fucker_slot"] == "all"
				spreadStateName = basedState.spread_when_sex["reciver_slot_"+self.chs_definition.get_holename(tmpFucker)]
				next unless spreadStateName
				next unless !tmpFucker.actor.max_state_stack?(spreadStateName) 
				next unless self.actor.state_stack(spreadStateName) > tmpFucker.actor.state_stack(basedState.item_name) || basedState.spread_when_sex["ignore_max_stack"]
				next if tmpFucker.actor.immune_tgt_states.include?(spreadStateName)
				next if tmpFucker.actor.immune_tgt_state_type.include?($data_StateName[spreadStateName].type)
				$game_damage_popups.add($data_StateName[spreadStateName].icon_index, tmpFucker.x, tmpFucker.y,[4,6].sample,4,rand(100)+1000)
				tmpFucker.actor.add_state(spreadStateName)
				if basedState.spread_when_sex["add_drop_list"] && tmpFucker.actor.drop_list
					num_elements_to_add = (1.0 / 5 * tmpFucker.actor.drop_list.length).to_i
					tmpFucker.actor.drop_list.fill(basedState.spread_when_sex["add_drop_list"], tmpFucker.actor.drop_list.length, num_elements_to_add)
				end
				eval("SndLib.#{basedState.spread_when_sex['add_state_SndLib']}(tmpFucker.report_distance_to_vol_close)") if basedState.spread_when_sex["add_state_SndLib"]
				EvLib.sum(basedState.spread_when_sex["add_evlib_sum"],tmpFucker.x,tmpFucker.y,{:user=>tmpFucker}) if basedState.spread_when_sex["add_evlib_sum"]
			}
		}
	end
	def state_sex_spread_to_reciver(tgtFuckers)
		return if !tgtFuckers
		return if tgtFuckers.empty?
		tgtFuckers.each{|tmpFucker|
			next unless tmpFucker
			next unless tmpFucker.actor
			next unless !["nil",nil].include?(self.chs_definition.get_holename(tmpFucker))
			tmpFucker.actor.feature_objects.uniq.each{|basedState|
				next unless basedState
				next unless basedState.item_name
				next unless basedState.spread_when_sex
				next unless basedState.spread_when_sex["chance"] > rand(100)
				next unless basedState.spread_when_sex["fucker_slot"] == "vag" || basedState.spread_when_sex["fucker_slot"] == "all"
				spreadStateName = basedState.spread_when_sex["reciver_slot_"+self.chs_definition.get_holename(tmpFucker)]
				next unless spreadStateName
				next unless !self.actor.max_state_stack?(spreadStateName)
				next unless tmpFucker.actor.state_stack(basedState.item_name) > self.actor.state_stack(spreadStateName) || basedState.spread_when_sex["ignore_max_stack"]
				next if self.actor.immune_tgt_states.include?(spreadStateName)
				next if self.actor.immune_tgt_state_type.include?($data_StateName[spreadStateName].type)
				$game_damage_popups.add($data_StateName[spreadStateName].icon_index, self.x, self.y,[8,2].sample,4,rand(100)+1)
				self.actor.add_state(spreadStateName)
				if basedState.spread_when_sex["add_drop_list"] && self.actor.drop_list
					num_elements_to_add = (1.0 / 5 * self.actor.drop_list.length).to_i
					self.actor.drop_list.fill(basedState.spread_when_sex["add_drop_list"], self.actor.drop_list.length, num_elements_to_add)
				end
				eval("SndLib.#{basedState.spread_when_sex['add_state_SndLib']}(tmpFucker.report_distance_to_vol_close)") if basedState.spread_when_sex["add_state_SndLib"]
				EvLib.sum(basedState.spread_when_sex["add_evlib_sum"],self.x,self.y,{:user=>self}) if basedState.spread_when_sex["add_evlib_sum"]
			}
		}
	end
end
