#==============================================================================
# This script is created by Kslander 
#==============================================================================
class Game_OvermapChar < Game_NonPlayerCharacter
	
		def setup_npc
		dataNpc=npc
		@hp=1 #給予1的hp以避免被寫入死亡
		@health=dataNpc.sta
		@stat=OvermapCharStat.new(
		{	
			#attribute=> [current ,min,max,max_true,min_true]
			"sta"=>dataNpc.sta,
			"health"=>dataNpc.sta,
			"atk"=>dataNpc.atk,
			"def"=>dataNpc.def,
			"weak"=>dataNpc.weak,
			"sexy"=>dataNpc.sexy,
			"morality"=>dataNpc.morality,
			"scoutcraft"=>10000,
			"move_speed"=> 8
		})
		@scoutcraft=10000
		@scoutcraft_basic=0
		@sensor_work_mode = 0
		@processor=dataNpc.ai
		@tri_state=dataNpc.tri_state
		@is_object=false
		@actions=[]
		@skill_stun=[]
		@skill_damage=[]
		@immune_tgt_states = []
		@skill_sex =[]
		@fated_enemy =[]
		@delete_when_death =-1
		@delete_when_frame =-1
		@drop_list = []
		@grab_count=0
	end
	
	#判斷是否為killer，回傳boolean的true或false，覆寫用
	def killer?(target,friendly)
		false
	end
	
	#判斷是否為fucker，回傳boolean的true或false,覆寫用
	def fucker?(target,friendly)
		false
	end
	
	#判斷是否為assulter，回傳boolean的true或false,覆寫用
	def assulter?(target,friendly)
		false
	end
	
	def move_speed
		@stat.get_stat("move_speed")
	end
	
	def process_flee(target,distance,signal,sensor_type)	
	end
	
	def process_fucker(target,distance,signal,sensor_type)
	end
	
	def process_killer(target,distance,signal,sensor_type)
	end
	
	#assulter狀態下的AI判斷
	def process_assulter(target,distance,signal,sensor_type)
	end
	
	
	def process_target(target,distance,signal,sensor_type)
		return if !$game_map.isOverMap
		process_alert_level(target,distance,signal,sensor_type) if non_battle?
	end
	
	def process_target_lost
		p "process_target_lost"
		@event.opacity =0
		set_action_state(nil)
		@skill=nil
		@target=nil
		@anomally=nil
		@target_lost=true
		@aggro_frame=0
		@balloon=7+rand(2) if @alert_level > 0
		@ai_state=:none
		@alert_level=0 #沒有任何東西  1:問號之後 2: 驚嘆號之後
	end
	
	def get_move_command
		#calling methods in Game_Event
		tgt = get_target
		return [:move_goto_xy,tgt.x,tgt.y] if !tgt.nil? && @event.my_turn? && $story_stats["Setup_Hardcore"] >= 1
		return [:turn_toward_character,tgt] if !tgt.nil? && @event.my_turn?
	end
	def scoutcraft
		@scoutcraft
	end
end
