#==============================================================================
# This script is created by Kslander 
#==============================================================================
#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#基本怪物類型，視需求製造class並附寫
class Game_NonPlayerCharacter  < Game_Battler
	include Battle_System
	#===================================================================
	#Public instance variables
	#===================================================================
	attr_reader		:target
	attr_reader		:none
	attr_reader		:action_state			#NPC是否被grab/昏迷等狀態
	attr_reader		:npc_name
	attr_accessor	:ai_state
	attr_accessor	:immune_state_effect	#是否不受state影響(不會中任何負面狀態、不會被sap)
	attr_accessor	:immune_damage			#此物件不會受到任何傷害(ex: 地上的機關)
	attr_accessor	:ignore_projectile			#此物件不會受到任何傷害(ex: 地上的機關)
	attr_accessor	:sneak_scoutcraft
		
	#===================================================================
	#Controllers
	#*用來跟Game_Event溝通的物件
	#===================================================================
	attr_reader		:route 					#判斷target後設定的路線
	attr_reader		:movement_count			#一回合行動次數的依據
	attr_reader		:move_regen				#每回合回復多少movement_count數值
	attr_reader		:alert_level 			#0 : 一般狀態，未發現目標， 1 : 發現可疑目標(move_type= toward last known location) 2: 確認捕捉目標，move_type=toward_player)
	attr_accessor	:target_lost
	attr_accessor	:anomally
	attr_reader		:scoutcraft
	attr_accessor	:scoutcraft_basic
	attr_accessor	:debug_this_npc
	attr_reader		:health
	attr_accessor	:is_tiny
	attr_accessor	:is_small
	attr_accessor	:is_flyer
	attr_accessor	:is_boss
	attr_accessor	:is_object				#是否為物件(ex:寶箱)，若是，不會sense目標，alert永遠為0。
	attr_accessor	:exp_when_killed
	attr_accessor	:receiver_type			#是否為性戰士
	attr_reader		:skill					#當下腳色正在使用的技能，由Game_Event在setup_skill時使用
	attr_accessor	:grab_count
	attr_accessor	:current_animation
	attr_accessor	:event
	attr_reader 	:stat
	attr_reader 	:sensor_freq
	attr_accessor 	:sensor_freq_base
	attr_accessor 	:sensor_freq_rand
	attr_accessor 	:death_event			#從外部設定的deat_event，不為nil時召喚此事件=
	attr_accessor 	:friendly_aggro
	attr_accessor 	:fraction_mode
	attr_accessor 	:friendly_fire
	attr_reader 	:aggro_frame
	attr_accessor 	:fapping 				#是否正在自慰中並且有被記錄到任何腳色的fapper陣列
	attr_accessor	:user_redirect
	attr_accessor 	:master
	attr_accessor 	:shieldEV
	attr_accessor 	:no_aggro
	attr_reader		:npc_sound
	attr_reader		:sex
	attr_reader		:player_control_mode_switch
	attr_accessor	:fraction
	attr_accessor	:fated_enemy
	attr_accessor	:drop_list
	attr_accessor	:delete_when_death
	attr_accessor	:delete_when_frame
	attr_accessor	:sensor_work_mode
	attr_accessor	:hit_LinkToMaster
	attr_accessor	:killer_condition
	attr_accessor	:fucker_condition
	attr_accessor	:assaulter_condition
	attr_accessor	:skills_support
	attr_accessor	:skills_assaulter_list
	attr_accessor	:skills_killer_list
	attr_accessor	:skills_fucker_list
	attr_accessor	:targetLock_HP
	attr_accessor 	:immune_tgt_states #immune target state , array strings
	attr_accessor 	:immune_tgt_state_type #immune target state , array strings
	
	#===================================================================
	#Sex相關物件，視狀況搬移到新RB
	#===================================================================
	attr_accessor 	:fucker_target 			#fuck的目標，Game_Event/Game_Player
	
		
	#name :怪物在資料庫的名字	
	def initialize(name)
		prp "npc initialize=>#{name}",3
		@action_state=nil
		@ai_state=:none
		@npc_name=name
		@balloon=0
		@alert_level=0
		@target_lost=false
		@anomally=nil
		@master=nil
		@shieldEV=nil
		@debug_this_npc=false
		@npc_stat=nil
		@animation=nil
		@is_object=false
		@receiver_type=0
		@immune_state_effect=false
		@safe_distance=3
		@friendly_fire =true
		@fapping=false
		@fraction_mode=0
		initialize_battle_system
		@current_move_command = []
		@user_redirect=false
		@no_aggro = false
		@combatAggroTime = 300+$story_stats["Setup_Hardcore"]*150
		@hit_LinkToMaster = false
		@available_skill=Array.new(available_skill_size)
		@targetLock_HP = 10 #NPC鎖定目標之時間
		@npc_sound = {}
		super()
		setup_npc
	end
	
	#@avavilable_skill陣列的長度，如果可用技能超過這個數字彈出錯誤。
	def available_skill_size
		10
	end
	
	def npc_stats
		[	"sta",
			"health",
			"sexy",
			"weak",
			"atk",
			"atk_plus",
			"def",
			"def_plus",
			"move_speed",
			"sat",
			"mood",
			"arousal",
			"will",
			"constitution",
			"survival",
			"survival_plus",
			"wisdom",
			"wisdom_plus",
			"combat",
			"sex",
			"kinsey",
			"morality",
			"morality_plus"
		]
	end
	def setup_npc
		dataNpc=npc
		@hp=1 #給予1的hp以避免被寫入死亡
		@stat=NpcStat.new(
		{
			#attribute=> [current ,min,max,max_true,min_true]
			"constitution"=>dataNpc.constitution,
			"sta"=>dataNpc.sta,
			"health"=>dataNpc.health,
			"sexy"=>dataNpc.sexy,
			"weak"=>dataNpc.weak,
			"arousal"=>dataNpc.arousal,
			"will"=>dataNpc.will,
			"atk"=>dataNpc.atk,
			"def"=>dataNpc.def,
			"sex"=>dataNpc.sex,
			"kinsey"=>dataNpc.kinsey,
			"atk_plus"=>dataNpc.atk,
			"def_plus"=>dataNpc.def,
			"survival"=>dataNpc.survival,
			"survival_plus"=>dataNpc.survival,
			"wisdom"=>dataNpc.wisdom,
			"wisdom_plus"=>dataNpc.wisdom,
			"combat"=>dataNpc.combat,
			"move_speed"=>dataNpc.move_speed,
			"sat"=>dataNpc.sat,
			"mood"=>dataNpc.mood,
			"morality"=>dataNpc.morality,
			"morality_plus"=>dataNpc.morality
		})
		@morality = dataNpc.morality
		@sex = dataNpc.sex
		@stat.npc_name=@npc_name
		@scoutcraft=dataNpc.scoutcraft
		@scoutcraft_basic=dataNpc.scoutcraft_basic
		@tri_state=dataNpc.tri_state
		@is_tiny=dataNpc.is_tiny
		@is_small=dataNpc.is_small
		@is_flyer=dataNpc.is_flyer
		@is_boss=dataNpc.is_boss
		@is_object=dataNpc.is_object
		@exp_when_killed=dataNpc.exp_when_killed
		@receiver_type=dataNpc.receiver_type
		@fraction=dataNpc.fraction
		@fated_enemy=dataNpc.fated_enemy
		@delete_when_death=dataNpc.delete_when_death
		@delete_when_frame=dataNpc.delete_when_frame
		@drop_list=dataNpc.drop_list
		@fraction_mode=dataNpc.fraction_mode
		@friendly_aggro=dataNpc.friendly_aggro.nil? ? 60 : dataNpc.friendly_aggro
		@friendly_fire=dataNpc.friendly_fire unless dataNpc.friendly_fire.nil?
		@killer_condition=dataNpc.killer_condition
		@fucker_condition=dataNpc.fucker_condition
		@assaulter_condition=dataNpc.assaulter_condition
		@sensor_work_mode = dataNpc.sensor_work_mode #0 :循序模式，第一台沒有抓到後面的通通不運作  1: 全開模式，使用全部的sensor進行
		@ignore_projectile=dataNpc.ignore_projectile
		@immune_state_effect=dataNpc.immune_state_effect.nil? ? false : dataNpc.immune_state_effect
		@immune_tgt_states=dataNpc.immune_tgt_states.nil? ? [] : dataNpc.immune_tgt_states
		@immune_tgt_state_type=dataNpc.immune_tgt_state_type.nil? ? [] : dataNpc.immune_tgt_state_type
		@immune_damage=dataNpc.immune_damage.nil? ? false : dataNpc.immune_damage
		@sensor_freq_base=dataNpc.sensor_freq_base
		@sensor_freq_rand=dataNpc.sensor_freq_rand
		@sensor_freq=dataNpc.sensor_freq_base + rand(dataNpc.sensor_freq_rand)
		@ranged = dataNpc.ranged
		@skills_killer_list= dataNpc.skills_killer.nil? ? [] : Array.new(dataNpc.skills_killer)
		@skills_fucker_list= dataNpc.skills_fucker.nil? ? [] : Array.new(dataNpc.skills_fucker)
		@skills_assaulter_list= dataNpc.skills_assaulter.nil? ? [] : Array.new(dataNpc.skills_assaulter)
		@skills_support_list= dataNpc.skills_support.nil? ? [] : Array.new(dataNpc.skills_support)
		@stat["Race"] = dataNpc.race
	end

	#更新這些 def / atk 這些東西
	def refresh_combat_attribute
		@stat.set_stat("sta",@stat.get_stat("sta",ActorStat::MAX_STAT)) if @stat.get_stat("sta",ActorStat::CURRENT_STAT) >= @stat.get_stat("sta",ActorStat::MAX_STAT) + @stat.get_stat("sta",ActorStat::BUFF_TMAX)
		@stat.set_stat("health",@stat.get_stat("health",ActorStat::MAX_STAT)) if @stat.get_stat("health",ActorStat::CURRENT_STAT) >= @stat.get_stat("health",ActorStat::MAX_STAT) + @stat.get_stat("health",ActorStat::BUFF_TMAX)
		@stat.set_stat("atk",@stat.get_stat("atk_plus",ActorStat::MAX_STAT))
		@stat.set_stat("def",@stat.get_stat("def_plus",ActorStat::MAX_STAT))
		@stat.set_stat("move_speed",@stat.get_stat("move_speed",ActorStat::MAX_STAT))
		@stat.set_stat("morality",@stat.get_stat("morality_plus",ActorStat::MAX_STAT))
		@stat.set_stat("survival",@stat.get_stat("survival_plus",ActorStat::MAX_STAT))
		@stat.set_stat("wisdom",@stat.get_stat("wisdom_plus",ActorStat::MAX_STAT))
		#@stat.set_stat("will",@stat.get_stat("will",ActorStat::MAX_STAT))
		@stat.set_stat("weak",@stat.get_stat("weak",ActorStat::MAX_STAT))
		@stat.set_stat("sexy",@stat.get_stat("sexy",ActorStat::MAX_STAT))
		@event.set_move_speed
	end

	#reminder,  this wont update max min,  until next npc.refresh
	def sta;				@stat.get_stat("sta",ActorStat::CURRENT_STAT);end
	def health;				@stat.get_stat("health",ActorStat::CURRENT_STAT);end
	def atk;				@stat.get_stat("atk",ActorStat::CURRENT_STAT);end
	def def;				@stat.get_stat("def",ActorStat::CURRENT_STAT);end
	def move_speed;			@stat.get_stat("move_speed",ActorStat::CURRENT_STAT);end
	def morality;			@stat.get_stat("morality",ActorStat::CURRENT_STAT);end
	def survival;			@stat.get_stat("survival",ActorStat::CURRENT_STAT);end
	def wisdom;				@stat.get_stat("wisdom",ActorStat::CURRENT_STAT);end
	#def will;				@stat.get_stat("will",ActorStat::CURRENT_STAT);end
	def weak;				@stat.get_stat("weak",ActorStat::CURRENT_STAT);end
	def sexy;				@stat.get_stat("sexy",ActorStat::CURRENT_STAT);end

	def sta=(val);			@stat.set_stat("sta",val);end
	def health=(val);		@stat.set_stat("health",val);end
	def atk=(val);			@stat.set_stat("atk",val);end
	def def=(val);			@stat.set_stat("def",val);end
	def move_speed=(val);	@stat.set_stat("move_speed",val);end
	def morality=(val);		@stat.set_stat("morality",val);end
	def survival=(val);		@stat.set_stat("survival",val);end
	def wisdom=(val);		@stat.set_stat("wisdom",val);end
	#def will=(val);		@stat.set_stat("will",val);end
	def weak=(val);			@stat.set_stat("weak",val);end
	def sexy=(val);			@stat.set_stat("sexy",val);end

	def set_default_state(tmpImportData)
		return if !tmpImportData
		tmpImportData.each{|tmpStateName,tmpData|
			tmpData["times"].times{
				self.add_state(tmpStateName) if tmpData["chance"] > rand(100)
			}
		}
	end

	def set_extra_event_data
	end
	def set_fated_enemy(tmpTar) #a array
		@fated_enemy = tmpTar
		@fated_enemy = @fated_enemy.uniq
	end
	
	def add_fated_enemy(tmpTar) #a array
		@fated_enemy += tmpTar
		@fated_enemy = @fated_enemy.uniq
	end
	
	
	def add_skill(tmpType="killer",tmpName="")
		tmpSkill = $data_arpgskills[tmpName]
		return prp "add_skill:Skill Not Found #{tmpName}",1 if tmpSkill.nil?
		case tmpType
			when "killer"
				@skills_killer_list << tmpName
			when "assaulter"
				@skills_assaulter_list << tmpName
			when "fucker"
				@skills_fucker_list << tmpName
			when "support"
				@skills_support_list << tmpName
			else
				msgbox "add_skill:Unknow TYPE => #{tmpType}"
		end
		clear_cached_skill
	end
	
	def remove_skill(tmpType="killer",tmpName="")
		tmpSkill = $data_arpgskills[tmpName]
		return prp "add_skill:Skill Not Found #{tmpName}",1 if tmpSkill.nil?
		case tmpType
			when "killer"
				@skills_killer_list.delete(tmpName)
			when "assaulter"
				@skills_assaulter_list.delete(tmpName)
			when "fucker"
				@skills_fucker_list.delete(tmpName)
			when "support"
				@skills_support_list.delete(tmpName)
			else
				msgbox "add_skill:Unknow TYPE => #{tmpType}"
		end
		clear_cached_skill
	end
	
	def get_skill_list(tmpType="killer")
		#tmpSkill = $data_arpgskills[tmpName]
		case tmpType
			when "killer"
				@skills_killer_list
			when "assaulter"
				@skills_assaulter_list
			when "fucker"
				@skills_fucker_list
			when "support"
				@skills_support_list
			else
				msgbox "add_skill:Unknow TYPE => #{tmpType}"
		end
		
	end
	
	
	def skills_killer
		return @skills_killer if @skills_killer
		@skills_killer =Array.new(@skills_killer_list.length){
			|index|
			skill = $data_arpgskills[@skills_killer_list[index]]
			msgbox (prp "unknown killer skill #{@skills_killer_list[index]} \n npc=>#{@npc_name}",1) if skill.nil?
			skill
		}
		@skills_killer
	end
	def skills_assaulter
		return @skills_assaulter if @skills_assaulter
		@skills_assaulter =Array.new(@skills_assaulter_list.length){
			|index|
			skill = $data_arpgskills[@skills_assaulter_list[index]]
			msgbox(prp "unknown assaulter skill #{@skills_assaulter_list[index]} \n npc=>#{@npc_name}",1) if skill.nil?
			skill
		}
		@skills_assaulter
	end
	
	def skills_fucker
		return @skills_fucker if @skills_fucker
		@skills_fucker =Array.new(@skills_fucker_list.length){
			|index|
			skill=$data_arpgskills[@skills_fucker_list[index]]
			msgbox(prp "unknown fucker skill #{@skills_fucker_list[index]} \n npc=>#{@npc_name}",1) if skill.nil?
			skill
		}
		@skills_fucker
	end
	
	
	def skills_support
		return @skills_support if @skills_support
		@skills_support =Array.new(@skills_support_list.length){
			|index|
			skill=$data_arpgskills[@skills_support_list[index]]
			msgbox(prp "unknown support skill #{@skills_support_list[index]} \n npc=>#{@npc_name}",1) if skill.nil?
			skill
		}
		@skills_support
	end
	
	def clear_cached_skill
		@skills_assaulter	= nil
		@skills_fucker		= nil
		@skills_killer		= nil
		@skills_support		= nil
	end


	
	#需要還原時從此處取得資料庫中的原始數據
	def npc
		$data_npcs[@npc_name] #由怪物資料表毒入的內容
	end
	
	
	def sensors
		npc.sensors
	end
		
	#====================================================================================
	#
	#mode : 偵測目標的模式，選項 0 ,1 ,2 ,3
	#	0: 只針對player
	#	1: 所有怪物和player
	#	2: 所有怪物不包含player
	#	3: 僅目標(@target)
	#====================================================================================
	def sense_target(character,mode=0)
		detected=nil
		mode=3 unless @target.nil?
		case @sensor_work_mode
			when 0;		#全工作
				sensors.each{
					|sensor|
					case mode
						when 0 ; detection=sensor.get_signal(character,$game_player) #只尋找主角
						when 1 ; detection=sensor.sense(character,$game_map.all_characters) #所有腳色包含主角
						when 2 ; detection=sensor.sense(character,$game_map.npcs)
						when 3 ; detection=sensor.get_signal(character,@target,true)
					end
					next if detection==0 || detection[1] < 0 #[target,distance,signal_strength,sensortype]
					detected = detection if detected.nil? || detected[2]< detection[2]
				}
			when 1;		 #第一優先
				for i in 0...sensors.length
					detection=case mode
							when 0 ; detection=sensors[i].get_signal(character,$game_player) #只尋找主角
							when 1 ; detection=sensors[i].sense(character,$game_map.all_characters) #所有腳色包含主角
							when 2 ; detection=sensors[i].sense(character,$game_map.npcs)
							when 3 ; detection=sensors[i].get_signal(character,@target,true)
						end
					break if detection==0 && detected.nil?
					next if detection==0 || detection[1] < 0 #[target,distance,signal_strength,sensortype]
					detected = detection if detected.nil? || detected[2]< detection[2]
				end
			when 2;		
				for i in 0...sensors.length
					detection=case mode
							when 0 ; detection=sensors[i].get_signal(character,$game_player) #只尋找主角
							when 1 ; detection=sensors[i].sense(character,$game_map.all_characters) #所有腳色包含主角
							when 2 ; detection=sensors[i].sense(character,$game_map.npcs)
							when 3 ; detection=sensors[i].get_signal(character,@target,true)
						end
					break !detected.nil?
					next if detection==0 || detection[1] < 0 #[target,distance,signal_strength,sensortype]
					detected = detection if detected.nil? || detected[2]< detection[2]
				end
		end
		if detected.nil?
			return if @aggro_frame != 0
			if @alert_level==2 || @target
				return @targetLock_HP -= 1 if @targetLock_HP > 0 && @target && @target.actor && @target.actor.action_state != :death #npc will hold target for a short time
				process_target_lost
			end
		else
			process_target(*detected)
		end
	end	
	

	def char_spotted?(character,min_signal=1)
		sensors.each{
			|sensor|
			signal =sensor.get_signal(map_token,character)
			return true if signal!=0 && signal[2] >= min_signal
		}
		return false
	end
	
	def played_alert_sound_check #unused
		@played_alert_sound_chk = 5 if !@played_alert_sound_chk
		@played_alert_sound -= 1
		
	end
	
	def is_fatigue?
		@stat.get_stat("sta") <= 0
	end
	
	#處理抓到目標後又丟失的狀況
	def process_target_lost
		#p "npc_name =>#{@npc_name} ai=#{self.class.to_s} process_target_lost" if @debug_this_npc
		map_token.failedMoveRngMove = false
		map_token.failedMoveCount = 0
		set_action_state(nil)
		@skill=nil
		@anomally=nil
		@target_lost=true
		@aggro_frame=0
		@balloon=7+rand(2) if @alert_level > 0
		@ai_state=:none
		@alert_level=0 #沒有任何東西  1:問號之後 2: 驚嘆號之後
		play_sound(:sound_lost,map_token.report_distance_to_vol_close_npc_vol) if !@target.nil? && !is_fatigue? #&& @ai_state != :flee
		@target=nil
	end
	
	def process_target_lost_lite
		#p "npc_name =>#{@npc_name} ai=#{self.class.to_s} process_target_lost" if @debug_this_npc
		map_token.failedMoveRngMove = false
		map_token.failedMoveCount = 0
		set_action_state(nil)
		@skill=nil
		@aggro_frame=0
		@balloon=7+rand(2) if @alert_level > 0
		@ai_state=:none
		@alert_level=0 #沒有任何東西  1:問號之後 2: 驚嘆號之後
		play_sound(:sound_lost,map_token.report_distance_to_vol_close_npc_vol) if !@target.nil? && !is_fatigue? #&& @ai_state != :flee
		@target=nil
	end
	
	#state_stack(14) #Fatigue
	def set_alert_level(new_alert)
		if new_alert!=@alert_level
			@alert_level=new_alert 
			@anomally=nil if new_alert==2
			if !map_token.nil? && !is_fatigue? # && @ai_state != :flee
				if new_alert == 1 #projectile will crash without thid
					play_sound(:sound_alert1,map_token.report_distance_to_vol_close_npc_vol)
				elsif new_alert == 2 #projectile will crash without thid
					play_sound(:sound_alert2,map_token.report_distance_to_vol_close_npc_vol)
				end
			end
			@action_state_changed=true
			return true
		else
			return false
		end
	end
	
	
	#複寫區塊，在此設定npc的三態與行為模式，若無偵測到目標，則不進入。
	def process_target(target,distance,signal,sensor_type)
		return if @event.chk_skill_eff_reserved
		return process_target_lost if target.deleted? || (!$game_map.events.value?(target) && target != $game_player)
		return process_target_lost if target && target.actor.action_state==:death
		return if friendly?(target)
		process_ai_state(target,distance,signal,sensor_type)
		process_alert_level(target,distance,signal,sensor_type) if non_battle? && @ai_state !=:none
		return unless @alert_level == 2
		@targetLock_HP = 10
		case @ai_state
			when :fucker;process_fucker(target,distance,signal,sensor_type);
			when :killer;process_killer(target,distance,signal,sensor_type);
			when :assaulter;process_assulter(target,distance,signal,sensor_type);
			when :flee;process_flee(target,distance,signal,sensor_type);
			else set_alert_level(0) if @fraction_mode==1 || @fraction_mode==4 || @fraction_mode==2
		end
	end
	
	#linker to Event, process tells event what to do
	#return value [symbol(movement_method to call , [param1 ,param2...] )]
	#heavily overridden part check every single class
	def get_move_command
		#calling methods in Game_Event
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		return [:move_random] if tgt.nil?
		return [:move_toward_character,tgt] if @action_state==:fucker
		return [:move_away_from_character,tgt] if ranged? && @event.too_close?(tgt)
		return [:move_toward_character,tgt] if @event.dead_end?(tgt)
		return [:turn_toward_character,tgt] if !@event.faced_character?(tgt)
		return [:move_toward_character,tgt] if !tgt.nil?
	end
	
	def non_battle?
		@action_state==:none || @action_state.nil?
	end
	
	def process_flee(target,distance,signal,sensor_type)	
		process_target_lost if distance >= 3
	end
	
	def process_fucker(target,distance,signal,sensor_type)
		return if @action_state ==:skill || @action_state==:sex || @action_state == :grabbed
		return set_fucker_skill(distance) if @fucker_target.nil? && ![:sex,:grabber].include?(@action_state)
		launch_skill(masturbate_skill) if @fapping
	end
	
	def process_killer(target,distance,signal,sensor_type)
		return if @action_state==:skill
		set_killer_skill(distance)
	end
	
	#assulter狀態下的AI判斷
	def process_assulter(target,distance,signal,sensor_type)
		#要殺傷還是控場的隨機判斷，Asuulter暫定為 控場 3 : 殺傷 1  , >75時為殺傷
		return if @action_state==:skill
		set_assaulter_skill(distance)
	end
	
	
	def process_alert_level(target,distance,signal,sensor_type)
		return if @aggro_frame!=0
		return process_npc_target(target,distance,signal,sensor_type) if target != $game_player
		return process_player_target(target,distance,signal,sensor_type)
	end
	
	def process_npc_target(target,distance,signal,sensor_type)
		if (signal > target.scoutcraft*1.5)
			@target_lost=false
			@target=target
			@balloon=1 if set_alert_level(2)
			@balloon= 6 if @ai_state==:flee
			set_action_state(:none)
		elsif (signal > target.scoutcraft)
			@anomally=Struct::FakeTarget.new(target.x,target.y)
			@target=nil
			@target_lost=true
			set_action_state(:none)
			@balloon=2 if set_alert_level(1)
		end
		
	end
	
	def process_player_target(target,distance,signal,sensor_type)
		if (signal > target.scoutcraft*1.5)
			@target_lost=false
			@target=target
			@balloon=1 if set_alert_level(2)
			set_action_state(:none)
		elsif (signal > target.scoutcraft)
			@anomally=Struct::FakeTarget.new(target.x,target.y)
			@target=nil
			@target_lost=true
			set_action_state(:none)
			@balloon=2 if set_alert_level(1)
		end
	end
	
	def combo_start_record_tgt #on each combo skill init
		@combo_prev_tgt = @target
		@combo_prev_ai_state = @ai_state
		@combo_prev_alert_level = @alert_level
		@combo_prev_aggro_frame = @aggro_frame
	end

	def combo_end_target_reset
		refresh
		@alert_level = 0
		process_target_lost
		@target =  @combo_prev_tgt if @combo_prev_tgt
		@ai_state = @combo_prev_ai_state if @combo_prev_ai_state
		@alert_level = @combo_prev_alert_level if @combo_prev_alert_level
		@aggro_frame = @combo_prev_aggro_frame if @combo_prev_aggro_frame
		@target_lost =  false if @combo_prev_tgt
		@targetLock_HP = 10 if @combo_prev_tgt && @targetLock_HP <10
		@combo_prev_tgt = nil
		@combo_prev_ai_state = nil
		@combo_prev_alert_level = nil
		@combo_prev_aggro_frame = nil
		set_action_state(:none)
	end
	
	#==================================================================================
	#進行AI三態判斷
	#==================================================================================
	def process_ai_state(target,distance,signal,sensor_type)
		prev_ai = @ai_state
		is_friend = friendly?(target)
		if flee?(target,is_friend)
			@ai_state=:flee
		elsif @fated_enemy.include?(target.actor.fraction)
			@ai_state=:killer
		elsif fucker?(target,is_friend)
			@ai_state=:fucker
		elsif killer?(target,is_friend)
			@ai_state=:killer
		elsif assulter?(target,is_friend)
			@ai_state=:assaulter
		else
			@ai_state=:none
		end
		ai_state_changed = !(prev_ai == @ai_state)
		set_ai_state_balloon if ai_state_changed
		set_action_state(:none,ai_state_changed) ##mv b  asdasdasdasdasd  :none to nil
	end
	
	def check_ai_state(target,distance,signal,sensor_type) #Check only
		is_friend=friendly?(target)
		return :flee if flee?(target,is_friend)
		return :killer if @fated_enemy.include?(target.actor.fraction)
		return :fucker if fucker?(target,is_friend)
		return :killer if killer?(target,is_friend)
		return :assaulter if assulter?(target,is_friend)
		return :none
	end
	
	def set_ai_state_balloon
		case @ai_state
			when :flee; @balloon=6;
			when :fucker; @balloon=4;
			when :killer; @balloon=15;
			when :assaulter; @balloon=5;
		end
	end
	
	
	#判斷是否為killer，回傳boolean的true或false，覆寫用
	def killer?(target,friendly)
		#p "@aggro_frame=>#{@aggro_frame}"
		return true if @aggro_frame!=0 && !friendly
		return true if @killer_condition.nil?
		actor=target.actor
		@killer_condition.all?{
			|attr,comparer|
			attribute=actor.battle_stat.get_stat(attr)			
			case comparer[1]
				when ">";	;attribute> comparer[0];
				when ">=";  ;attribute>= comparer[0];
				when "=";   ;attribute == comparer[0];
				when "<";   ;attribute<comparer[0];
				when "<=";  ;attribute<= comparer[0];
				else  false;
			end
		}
	end
	
	#判斷是否為fucker，回傳boolean的true或false,覆寫用
	def fucker?(target,friendly)
		return false if @aggro_frame!=0
		return  true if @fucker_condition.nil? 
		actor=target.actor
		@fucker_condition.all?{
			|attr,comparer|
			attribute=actor.battle_stat.get_stat(attr)			
			case comparer[1]
				when ">";	;attribute> comparer[0];
				when ">=";  ;attribute>= comparer[0];
				when "=";   ;attribute == comparer[0];
				when "<";   ;attribute<comparer[0];
				when "<=";  ;attribute<= comparer[0];
				else  false;
			end
			
		}
	end
	
	#判斷是否為assulter，回傳boolean的true或false,覆寫用
	def assulter?(target,friendly)
		return true if @fraction_mode==3
		return true if @fraction_mode==2 && master_target(target)
		return true if @aggro_frame!=0 && friendly
		return true if @assaulter_condition.nil? 
		actor=target.actor
		@assaulter_condition.all?{
			|attr,comparer|
			attribute=actor.battle_stat.get_stat(attr)			
			case comparer[1]
				when ">";	;attribute> comparer[0];
				when ">=";  ;attribute>= comparer[0];
				when "=";   ;attribute == comparer[0];
				when "<";   ;attribute<comparer[0];
				when "<=";  ;attribute<= comparer[0];
				else  false;
			end
		}
	end
	
	def flee?(target,friendly)
		return unless @stat.get_stat("sta") <= 0
		@balloon=6
		@target==target
	end
	#進行死亡時的處理(action_state==death)
	def process_death
		return p" nothing to do @event.id=>#{@event.id}" if @action_state == :death
		ded_unset_chs_sex
		return if @action_state == :sex
		player_control_mode_off
		@target=nil
		add_state(1)
		set_alert_level(0)
		#if glory_death? || player_glory_kill?
		#	if @action_state != :sex && !@is_object
		#		@event.jump_to(@event.x,@event.y) if self.move_speed != 0
		#		@event.setup_cropse_graphics(2)
		#		@animation=:animation_overkill_melee_reciver
		#	end
		#elsif normal_death?
		#	if @action_state !=:sex && !@is_object
		#		@event.jump_to(@event.x,@event.y) if self.move_speed != 0
		#		@event.setup_cropse_graphics(1)
		#		@animation=:animation_kill_reciver
		#	end
		#elsif overfatigue_death?
		#	if @action_state !=:sex && !@is_object
		#		@event.jump_to(@event.x,@event.y) if self.move_speed != 0
		#		@event.setup_cropse_graphics(0)
		#		@animation=:animation_kill_reciver
		#	end
		#else
		#	msgbox "no matching death type , check death condition"
		#end
		play_sound(:sound_death,map_token.report_distance_to_vol_close_npc_vol) if @action_state != :death
		set_action_state(:death,true)
	end
	
	def pick_death_animation
		return if !@event.use_chs?
		if glory_death? || player_glory_kill?
				@event.jump_to(@event.x,@event.y) if self.move_speed != 0
				@event.setup_cropse_graphics(2)
				@animation=:animation_overkill_melee_reciver #call with event.setup_npc_death_animation
		elsif normal_death?
				@event.jump_to(@event.x,@event.y) if self.move_speed != 0
				@event.setup_cropse_graphics(1)
				@animation=:animation_kill_reciver #call with event.setup_npc_death_animation
		elsif overfatigue_death?
				@event.jump_to(@event.x,@event.y) if self.move_speed != 0
				@event.setup_cropse_graphics(0)
				@animation=:animation_kill_reciver #call with event.setup_npc_death_animation
		else
			p "#{self.npc_name} no matching death type , check death condition"
		end
	end
	def set_dedAnimPlayed(val)
		@dedAnimPlayed = val
	end
	
	def ded_unset_chs_sex
		if @fucker_target && @fucker_target.grabbed?
			@fucker_target.unset_chs_sex
			map_token.unset_chs_sex
		end
	end 
	def dedAnimPlayed
		@dedAnimPlayed
	end
	def dedAnimPlayed_reset
		@dedAnimPlayed = nil
	end
	def summon_death_event
		$game_player.actor.gain_exp(@exp_when_killed) if @exp_when_killed && @last_attacker == $game_player
		$game_map.reserve_summon_event(*death_event_data) if !npc.death_event.nil? && !npc.death_event.empty?
	end
	
	def normal_death?
		@stat.get_stat("health") <= @stat.get_stat("health",ActorStat::MIN_STAT) 
	end
	
	
	#要傳送給death_event的資料回傳陣列、覆寫用。
	#回傳規格[ev_name,x,y,summoner_id,data] 
	def death_event_data
		ev=@death_event ? @death_event : npc.death_event
		[ev,@event.x,@event.y,@event.id,{:user=>self.map_token,:death_event=>true}]
	end
	
	def overfatigue_death?
		@stat.get_stat("sta")<=-100 
	end
	
	def set_last_attacker(attacker)
		super(attacker)
		if @last_attacker == $game_player
			return if @master == $game_player
			return if @is_object == true
			return if @action_state == :death
			$game_player.target = self.map_token
		end
	end
	
	
	def player_glory_kill?
		@last_attacker == $game_player && $game_player.actor.stat["BloodyMess"] >= 1
	end
	
	
	def glory_death?
		!@is_object && @stat.get_stat("health") <= @stat.get_stat("health",ActorStat::MIN_STAT) && @stat.get_stat("health").abs >= @stat.get_stat("health",ActorStat::MAX_STAT) * 0.5
	end
	

	def launch_skill(skill,force=false)
		return if !super
		@sensor_freq = @sensor_freq_base + rand(@sensor_freq_rand) #apply when slow NPC got unique skills
		true
	end

	def set_assaulter_skill(dist)
		skills=select_assualter_skill(skills_assaulter,dist)
		return launch_skill(skills[0]) if (skills.length-1)==skills.count(nil) #only one skill available #skills.length==1
		launch_skill(select_ai_weighted_skill(skills))
		play_sound(:sound_skill,map_token.report_distance_to_vol_close_npc_vol) if @skill && rand(100) > 60
	end
	
	def set_killer_skill(dist)
		skills=select_killer_skill(skills_killer,dist)
		return launch_skill(skills[0]) if (skills.length-1)==skills.count(nil) #only one skill available #skills.length==1
		launch_skill(select_ai_weighted_skill(skills))
		#play_sound(:sound_skill,map_token.report_distance_to_vol_close_npc_vol) if @skill && rand(100) > 60
	end
	
	def set_fucker_skill(dist)
		skills=select_fucker_skill(skills_fucker,dist)
		return launch_skill(skills[0]) if (skills.length-1)==skills.count(nil) #only one skill available #skills.length==1
		launch_skill(select_ai_weighted_skill(skills))
		play_sound(:sound_skill,map_token.report_distance_to_vol_close_npc_vol) if @skill
	end
	
	
	def select_assualter_skill(skillset,distance)
		select_skill(skillset,distance)
	end
	
	def select_killer_skill(skillset,distance)
		select_skill(skillset,distance)
	end
	
	def select_fucker_skill(skillset,distance)
		select_skill(skillset,distance)
	end
	
	def clear_available_skill
		@available_skill.length.times{|i|@available_skill[i]=nil}
	end
	
	def select_skill(skillset,distance)
		@skill=nil
		clear_available_skill
		avs_index=0
		skillset.each{
			|skill|
			if distance < 2 && skill.blocking?
				@available_skill[avs_index]=skill
				avs_index+=1
			elsif @target.through && skill.projectile_type != 1 && skill.range >= distance			#遇到小型生物只用肉搏或曲射攻擊，直射無效。
				@available_skill[avs_index]=skill
				avs_index+=1
			elsif skill.range >=distance
				@available_skill[avs_index]=skill
				avs_index+=1
			end
		}
		@available_skill
	end
	
	def select_ai_weighted_skill(skill_set)
		range=0
		first_nil_index=skill_set.index(nil)
		first_nil_index = skill_set.length if first_nil_index.nil?
		for i in 0...first_nil_index
			range+=skill_set[i].ai_value[@ai_state]
		end
		random_value=rand(range)
		for si in 0...first_nil_index
			random_value-=skill_set[si].ai_value[@ai_state]
			if random_value<=0
				random_skill=skill_set[si]
				break
			end
		end
		random_skill
	end
	
	def npc_death?
		@stat.get_stat("health") <=0 && @action_state!=:death
	end
	
	def get_drop_list
		item_count=rand(max_drop_amt+1)+min_drop_amt
		item_list=@drop_list
		tmp_drop_list=Array.new 
		for i in 0...item_count
			tmp_drop_list[i]=item_list.sample
		end
		tmp_drop_list
	end
	
	def get_animation
		return nil if @animation.nil?
		ani=@animation
		@animation=nil
		return ani
	end
	
	#用來告訴Game_Event要放驚嘆號還是問號，數字，0: 不需要 1:問號, 2:驚嘆號 
	#回傳awareness後即將awareness歸0達到紀錄是否已發現的效果
	def balloon_id
		#p "balloon_id =>#{@balloon} ,@ai_state=>#{@ai_state}"
		balloon_id=@balloon
		@balloon=0 if @balloon!=0
		balloon_id
	end
	
	def npc_dead?
		@stat.get_stat("health")<=0 || @stat.get_stat("sta") <= -100
	end
	
	def update_npc_stat
		return if @event.combo_original_move_route
		return process_death if npc_dead? && @action_state != :death
		@stat.reset_definition
		@stat.check_stat
		refresh_state_effects
		refresh_combat_attribute
		@event.set_move_speed
	end
	
	#fraction_list:
	#fraction" 0 player
	#fraction" 3 neutural mankind 
	#fraction" 4 neutural object#地雷/動物等屬此類
	#fraction" 5 goblin/orkind
	#fraction" 6 human enemy
	#fraction" 7 human crazy enemy
	#fraction" 8 fishkind/deepone
	#fraction" 9 Abomination
	# >99 :whatever you want to make them fight
	#<0 打不同陣營>
	#<1 只看三態>
	#<2 只攻擊 mark 或 aggro >
	#<3 chaos destroy everything, ai 遇到3強制killer>
	#<4 只看三態、不打同fraction>
	def friendly?(character)
		return false if !character.npc? && character != $game_player
		if @master && character.npc.master
			return true if @master == character.npc.master
			return true if @master.npc.master == character.npc.master && @master.npc.master && character.npc.master
			return true if @master == character.npc.master.npc.master && character.npc.master.npc.master
		end
		return false if @aggro_frame != 0 && character == @target
		return false if @fated_enemy.include?(character.actor.fraction)
		return true if character.npc.master == self.map_token
		return true if character.npc.master != nil && character.npc.master == @master
		case @fraction_mode
			when 0,4;
				return character.actor.fraction == @fraction  # || character.actor.fraction== 4
			when 2;
				return true if character == @master
				return false if master_target(character)
				return character.actor.fraction == @fraction  # || character.actor.fraction== 4
			when 1,3;return false;
		end
	end
	
	def master_target(character)
		return false if @master.nil?
		if @master == $game_player
			character == @master.target
		else
			character == @master.actor.target
		end
	end
	
	def refresh
		reset_fapper_status
		update_npc_stat
	end
	
	def reset_fapper_status
		return if @action_state == :sex
		return if @event.eventSexMode || @event.story_mode_sex
		if !@fucker_target.nil? && !@fapping && @action_state !=:grabbed
			@fucker_target.quit_sex_gang(map_token)
			@fucker_target = nil
		end
		@fapping = false if self.ai_state != :fucker
	end
	
	def refresh_state_effects
		#計算所有狀態的數值影響
		@states.each{
			|state|		
			next if state.nil?
			next if $data_states[state].lona_effect.nil?
			$data_states[state].lona_effect.each{|le|
				next unless npc_stats.include?(le.attr)
				next unless effect_allowed?(le) #added npc stat since 2024 9 30  #commit everything because NPC have no self.stat keys
				attrVal=@stat.get_stat(le.attr,le.attr_type)
				@stat.set_stat(le.attr,self.get_affected_attr(le),le.attr_type)
			}
		}
	end
  
	
	
	  
	def min_drop_amt
		if glory_death?
			return npc.drop_amt["min"].to_i+1
		else
			return npc.drop_amt["min"].to_i
		end
	end
	  
	def max_drop_amt
		if glory_death?
			return npc.drop_amt["max"].to_i+1
		else
			return  npc.drop_amt["max"].to_i
		end
	end
	  

	def wandering?
		@action_state==:none
	end
	
	def change_acknowledged
		@action_state_changed=false
	end
	
	def battle_stat
		@stat
	end
	
	#操作用的捷徑
	def get_b_stat(stat_name,type=ActorStat::CURRENT_STAT)
		@stat.get_stat(stat_name,type)
	end
	
	def map_token
		@event
	end
	
	def stat_exist?(stat_name)
		npc_stats.include?(stat_name)
	end
	
	def fraction
		@fraction
	end
	
	def move_speed
		@stat.get_stat("move_speed")
	end
	
	def show_states
		p @states
	end
	
	#是否在死亡時同時將自己刪除，主要用在Missile ex:arrow上面。
	def self_destruct?
		false
	end
	
	#每一步進行的update,主要用來處理狀態移除等等
	def update_npc_steps
		states.uniq.each{|state|update_state_steps(state)}
	end

	def effective?
		true 
	end
	
	#測試NPCstat用的
	def alter_npc_stat(stat_name,value,type=ActorStat::CURRENT_STAT)
		@stat.set_stat(stat_name,value,type)
		update_npc_stat
	end
	
	def safe_distance
		npc.safe_distance || 3
	end
	
	def ranged?
		@ranged
	end

	#obsolete
	def set_fraction(fraction) 
		@fraction=fraction
	end
	def set_sex(sex)
		@stat.set_stat("sex",sex)
		@sex=sex
	end
	
	def set_morality(tmpVal)
		@stat.set_stat_m("morality",tmpVal,[0,2])
		@stat.set_stat_m("morality_plus",tmpVal,[0,2,3])
	end
	
	def set_survival(tmpVal)
		@stat.set_stat_m("survival",tmpVal,[0,2,3])
		@stat.set_stat_m("survival_plus",tmpVal,[0,2,3])
	end
	
	def set_constitution(tmpVal)
		@stat.set_stat_m("constitution",tmpVal,[0,2,3])
	end
	
	def set_wisdom(tmpVal)
		@stat.set_stat_m("wisdom",tmpVal,[0,2,3])
		@stat.set_stat_m("wisdom_plus",tmpVal,[0,2,3])
	end
	def set_atk(tmpVal)
		@stat.set_stat_m("atk",tmpVal,[0,2,3])
		@stat.set_stat_m("atk_plus",tmpVal,[0,2,3])
	end
	def set_def(tmpVal)
		@stat.set_stat_m("def",tmpVal,[0,2,3])
		@stat.set_stat_m("def_plus",tmpVal,[0,2,3])
	end
	def set_health(tmpVal)
		@stat.set_stat_m("health",tmpVal,[0,2,3])
	end
	def set_sta(tmpVal)
		@stat.set_stat_m("sta",tmpVal,[0,2,3])
	end
	def set_move_speed(tmpVal)
		@stat.set_stat_m("move_speed",tmpVal,[0,2,3])
	end
	def set_fraction_mode(fraction)
		@fraction_mode=fraction
	end
	
	def update_frame
		return if [:skill,:sex,:stun].include?(@action_state)
		if @aggro_frame != 0
			@aggro_frame -= 1
			process_target_lost if @aggro_frame == 0 || @target.nil? || !@target.actor || @target.actor.action_state==:death
		end
	end
	
	#accept dynamic change params
	def play_sound(symbol,*param)
		snd = @npc_sound[symbol].nil? ? npc.sound[symbol] : @npc_sound[symbol]
		eval("SndLib::#{snd}(*param)") if !snd.nil?
	end

	
	#覆寫，增加aggro
	def take_aggro(attacker,skill,no_action_change=false)
		return if !aggro_allowed?(attacker,skill)
		set_aggro(attacker,skill,frame_count=@combatAggroTime,no_action_change)
		play_sound(:sound_aggro,map_token.report_distance_to_vol_close_npc_vol) if rand(100) >=65 && @action_state != :stun
	end
	
	def aggro_allowed?(attacker,skill)
		return false if skill.no_aggro || @no_aggro
		return false if @action_state==:grabbed || map_token.sex_receiver?
		if friendly?(attacker.map_token) && (rand(100) > @friendly_aggro) && @aggro_frame==0
			return true if @target.nil? || [0,1].include?(@alert_level)# || @event.actor.target#若為友善狀態 且無目標 或非戰鬥或警戒  則AGGRO
			return false
		end
		return true
	end
	def set_aggro(attacker,skill,frame_count=@combatAggroTime,no_action_change = false)
		
		#若本體有GRAB目標且目標是被GRABBED 則解鎖 #2022_11_16
		if self.fucker_target && self.action_state == :grabber
			self.fucker_target.unset_chs_sex if self.fucker_target.actor.action_state == :grabbed
		end
		
		#若有AGGRO重新導向?
		if attacker.user_redirect 
			@target=attacker.map_token.summon_data[:user]
		else
			@target=attacker.map_token
		end
		
		return if @action_state == :skill && actor_skill_no_interrupt? #line add for block no_interrupt
		@aggro_frame=frame_count
		@alert_level=2
		return if with_ShieldEV?
		@action_state_changed = true if [:none,nil].include?(@action_state) #部分未知情況下單位會卡死在:None 強迫用動作轉換
		set_action_state(:none) unless @action_state == :stun if !no_action_change #this if IS NOT A BUG
	end
	
	def delete_immediately?
		@delete_when_death==0
	end
	
	
	def race
		npc.race
	end
	
	def set_race(tarRace)
		npc.race = tarRace
	end

	def avoid_friendly_fire?(skill)
		super && !@friendly_fire
	end
	
	def process_skill_cost(skill)
		super
	end
	
	def update_state_steps(state)
		if state.remove_by_walking && state_stack(state.id)> 0
			@state_steps[state.id] -= 1 if @state_steps[state.id] > 0
			if @state_steps[state.id] <= 0
				@state_frames[state.id] = state.steps_to_remove * 60 #if state_stack(state.id) >=1
				@state_steps[state.id] = state.steps_to_remove #if state_stack(state.id) >=1
				remove_state_stack(state.id)
			end
		end
	end

	def update_state_frames
		state_removed=false
		states.uniq.each{|state|
			if state.remove_by_walking && state_stack(state.id)> 0
				@state_frames[state.id] -= 1 if @state_frames[state.id] > 0
				if @state_frames[state.id] <= 0
					@state_frames[state.id] = state.steps_to_remove * 60 #if state_stack(state.id) >=1
					@state_steps[state.id] = state.steps_to_remove #if state_stack(state.id) >=1
					state_removed=true
					remove_state_stack(state.id)
					next # or it will remove all stack
				end
			end
		}
		if state_removed
			update_npc_stat
			set_action_state(@action_state,true)
		end
	end
  
  #debug用
  def show_states
    p @states
  end
  
  #由hit_event呼叫，設定自己的fuck目標
  def set_fuck_target(skill,fuck_target)
	return @fucker_target=nil if fuck_target.actor.action_state==:death
	#按照自己的性別做grab時的處理
	case battle_stat.get_stat("sex")
		when 0;set_fucker_target_receiver(skill,fuck_target)			#女性，自身為Receiver
		when 1;set_fucker_target_attacker(skill,fuck_target)			#男性，目標為Receiver
		when 2;set_fucker_target_attacker(skill,fuck_target)			#扶他，暫時用Attacker版本處理
	end
  end
  
  
  def set_fucker_target_attacker(skill,fuck_target)
  	@fucker_target=fuck_target
	if fuck_target.grabbed? 
		#加入sex_gang，目標已經被Grab但還沒有進入sex狀態，滾去旁邊打手槍
		if fuck_target.add_sex_gang(map_token)
			set_action_state(:sex)
		else
			@fucker_target.add_fapper(map_token)
			launch_skill(masturbate_skill)
		end
	elsif fuck_target.sex?
		if fuck_target.add_sex_gang(map_token) #如果成功加入sex集團
			set_action_state(:sex)
		else
			@fucker_target.add_fapper(map_token)
			launch_skill(masturbate_skill)
		end
	else #沒有被grab、沒有在sex中
		if @fucker_target.grab(map_token)
			set_action_state(:grabber) 
		else
			@fucker_target.add_fapper(map_token)
			launch_skill(masturbate_skill)
		end
	end
  end
  
  
  def set_fucker_target_receiver(skill,fuck_target)
  	@fucker_target=fuck_target
	if fuck_target.grabbed? || fuck_target.sex?
		#已經被開幹的情況下自己去旁邊打手槍
		@fucker_target=nil
		launch_skill(masturbate_skill)
	else #沒有被grab、沒有在sex中
		if @fucker_target.grab(map_token,false) && map_token.add_sex_gang(@fucker_target)
		@fucker_target.actor.fucker_target=self.map_token
		set_action_state(:grabber)
		else
		 launch_skill(masturbate_skill)
		end
	end
  end
  
  
  def masturbate_skill
	 case battle_stat.get_stat("sex")
	 when 1;
		return $data_arpgskills["NpcMasturbationMale"];
	when 2;#Futa，可以用男性或女性自慰技能
		return rand(2) == 0 ? $data_arpgskills["NpcMasturbationMale"] : $data_arpgskills["NpcMasturbationFemale"]
	 when 0
		return $data_arpgskills["NpcMasturbationFemale"];
	 end
  end
  
  

	def same_xy?(temp_tgt)
		@event.x == temp_tgt.x && @event.y == temp_tgt.y
	end

	def same_line?(temp_tgt)
		@event.x == temp_tgt.x || @event.y == temp_tgt.y
	end
	

   def statMap
	map_token.chs_configuration
   end
   
   
   def sex_fetish
	npc.sex_fetish
   end
   
   def reset_aggro
	@alert_level=0
	@aggro_frame=0
   end
   
   def male?
	@stat.get_stat("sex")== 1
   end
   
   def female?
	@stat.get_stat("sex")== 0
   end
   
   def futanari?
	@stat.get_stat("sex")== 2
   end
   
   def get_data_scoutcraft
	@scoutcraft
   end
   def set_data_scoutcraft(tmpVal)
	@scoutcraft = tmpVal
   end
   
	def scoutcraft
		@scoutcraft_basic
	end
   
	def get_target
		@target
	end
   
   def player_sighted?
	return false if @target!=$game_player || @sapped || @action_state == :death
	true
   end
   
	def tracking_player?
		return false if @action_state == :death
		return false if @action_state == :skill && @skill == masturbate_skill && @event.report_range($game_player)>6
		return false if friendly?($game_player)
		return false unless player_sighted?
		return false if @alert_level < 2
		true
	end
	
	def holding_curved_sight_check(targetEV,val=1)
		#用以檢測曲射續力技之COVER
		#return true if sensors.length <= 1 && sensors[0].type == :support
		tmp_Selected_Sensor = sensors.select{|sen| #ignore support skill sensors
			next if sen.type == :support
			sen
		}
		return true if tmp_Selected_Sensor.empty?
		tmp_Selected_Sensor[0].get_signal(self.map_token,targetEV)[2] < val
	end
	def player_control_mode(on_off=true,canUseSkill=false,withModeCancel=false,withTimer=false,stunWhenCancel=false,aggroWhenCancel=false,onHitCancel=false)
		return player_control_mode_off if on_off == false
		player_control_mode_hack_data
		process_target_lost_lite
		player_control_mode_create_skill_roster(withModeCancel)
		if withModeCancel
			@player_control_mode_original_x						= @event.original_x ? @event.original_x : @event.x
			@player_control_mode_original_y						= @event.original_y ? @event.original_y : @event.y
			@player_control_mode_original_move_route			= @event.original_move_route ? @event.original_move_route : @event.move_route
			@player_control_mode_original_move_route_index		= @event.original_move_route_index ? @event.original_move_route_index : @event.move_route_index
		end
		$game_player.actor.master = @event
		$game_player.cannot_control = true
		$game_player.mind_control_on_hit_cancel = true if onHitCancel
		$game_player.actor.skill_changed = true
		$game_map.cam_target = @event.id
		@player_control_mode_switch 					= true
		@player_control_mode_stunWhenCancel 			= stunWhenCancel
		@player_control_mode_aggroWhenCancel 			= aggroWhenCancel
		@player_control_mode_saved_manual_move_type 	= @event.get_manual_move_type
		@player_control_mode_saved_no_aggro 			= @no_aggro
		@player_control_mode_saved_fucker_condition		= @fucker_condition
		@player_control_mode_saved_killer_condition		= @killer_condition
		@player_control_mode_saved_assaulter_condition	= @assaulter_condition
		@event.player_control_mode_timer				= withTimer if withTimer
		
		canUseSkill ? tmpType = :control_this_event_with_skill  : tmpType = :control_this_event
		
		@event.move_type			= tmpType
		@event.manual_move_type		= tmpType
		@event.move_frequency		= 5
		@no_aggro					= true
		@fucker_condition			={"sex"=>[65535, "="]}
		@killer_condition			={"sex"=>[65535, "="]}
		@assaulter_condition		={"sex"=>[65535, "="]}
	end
	
	def player_control_mode_hack_data
		#do something in AI
	end
	def player_control_mode_hack_data_restore
		#do something in AI
	end
	
	def player_control_mode_off
		return if !@player_control_mode_switch
		player_control_mode_hack_data_restore
		tmpDo_Stun	= @player_control_mode_stunWhenCancel
		tmpDo_Aggro	= @player_control_mode_aggroWhenCancel
		tmpTGT		= $game_player.actor.master
		$game_player.actor.master = nil
		$game_player.cannot_control = false
		$game_player.mind_control_on_hit_cancel = false
		$game_player.actor.skill_changed = true
		$game_map.set_display_pos($game_player.x - $game_player.center_x, $game_player.y - $game_player.center_y)
		$game_map.cam_target = 0
		take_skill_cancel if @player_control_mode_skills
		@event.player_control_mode_timer	= nil
		@event.manual_move_type 			= @player_control_mode_saved_manual_move_type
		@event.move_speed					= @event.page.move_speed
		@event.move_frequency				= @event.page.move_frequency
		@no_aggro 							= @player_control_mode_saved_no_aggro
		@fucker_condition					= @player_control_mode_saved_fucker_condition
		@killer_condition					= @player_control_mode_saved_killer_condition
		@assaulter_condition				= @player_control_mode_saved_assaulter_condition
		@event.original_x                   = @player_control_mode_original_x 			if @player_control_mode_original_x
		@event.original_y                   = @player_control_mode_original_y    			   if @player_control_mode_original_y
		@event.original_move_route          = @player_control_mode_original_move_route                if @player_control_mode_original_move_route
		@event.original_move_route_index    = @player_control_mode_original_move_route_index                if @player_control_mode_original_move_route_index
		
		
		@player_control_mode_stunWhenCancel 			= nil
		@player_control_mode_aggroWhenCancel 			= nil
		@player_control_mode_saved_manual_move_type 	= nil
		@player_control_mode_saved_no_aggro 			= nil
		@player_control_mode_saved_fucker_condition		= nil
		@player_control_mode_saved_killer_condition		= nil
		@player_control_mode_saved_assaulter_condition	= nil
		@player_control_mode_skills 					= nil
		@player_control_mode_switch 					= nil
		@player_control_mode_original_x						= nil
		@player_control_mode_original_y						= nil
		@player_control_mode_original_move_route			= nil
		@player_control_mode_original_move_route_index		= nil
		process_target_lost
		
		if tmpTGT && tmpDo_Aggro && tmpTGT.actor
			tmpTGT.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
		end
		if tmpTGT && tmpDo_Stun && tmpTGT.actor && [nil,:none,:skill,:stun].include?($game_player.actor.action_state) && [nil,:none,:skill,:stun].include?(tmpTGT.actor.action_state)
			$game_player.jump_to($game_player.x,$game_player.y)
			$game_player.actor.force_stun("Stun3")
			SndLib.sound_punch_hit
			tmpTGT.actor.force_stun("Stun1")
			tmpTGT.jump_to(tmpTGT.x,tmpTGT.y)
			SndLib.sound_punch_hit(tmpTGT.report_distance_to_vol_close)
			EvLib.sum("EffectHeartFade",$game_player.x,$game_player.y)
			EvLib.sum("EffectHeartFade",tmpTGT.x,tmpTGT.y)
		end
	end
	
	def player_control_mode_skills
		return [] if !@player_control_mode_skills
		@player_control_mode_skills
	end
	def player_control_mode_create_skill_roster(withModeCancel=false)
		return if @player_control_mode_skills
		@player_control_mode_skills = []
		tmpSkillAry = []
		tmpSkillAry += self.get_skill_list("killer")
		tmpSkillAry += self.get_skill_list("assaulter")
		tmpSkillAry += self.get_skill_list("fucker")
		tmpSkillAry = tmpSkillAry.uniq
		tmpSkillAry.each{|skillName|
			next if !$data_arpgskills[skillName].icon_index
			next if !$data_arpgskills[skillName].is_mind_control_usable
			@player_control_mode_skills << skillName
		}
		@player_control_mode_skills << "PlayerControlModeCancel" if withModeCancel
	end
	def take_sap(user)
		return false if !super(user)
		SndLib.BonkHitSap(@event.report_distance_to_vol_close-20)
		play_sound(:sound_aggro,@event.report_distance_to_vol_close_npc_vol) if rand(100) >= 80
		true
	end
	def age
		return 1
	end
end
