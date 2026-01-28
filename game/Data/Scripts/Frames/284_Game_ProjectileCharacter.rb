#==============================================================================
# This script is created by Kslander 
#==============================================================================
#基本投擲物(ex:石頭、弓箭)使用的class，ai_state永遠為killer
class Game_PorjectileCharacter  < Game_NonPlayerCharacter
	
	attr_reader	:effect_since
	attr_reader :is_projectile
	attr_reader :projectile_type
	def initialize(name)
		super
		@is_projectile = true
		@alert_level=2
		@mileage=0 #這個projectile已經移動了多遠，主要用來判定是否有效
		@strand_count=0 #這個projectile沒有移動的frame數，用來處理直接面對無法穿透物件發射時的卡死問題。
		@leave_launcher =false
	end
	
	def setup_npc
		super
		@stall_boundary=self.move_speed * 0.3
		@action_state=:none
		@action_state_changed=true
		set_alert_level(2)
	end
	
	def set_target(target)
		p "target=>#{target.to_s}"
		p "target.x=>#{target.x} target.y=>#{target.y}"
		@anomally=Struct::FakeTarget.new(target.x,target.y)
	end
	
	def set_projectile_start(x,y)
		@start_x= x
		@start_y= y
	end
	
	def set_projectil_prop(skill)
		@effect_since=skill.effect_since
		@max_distance=skill.range
		@projectile_type=skill.projectile_type
		@range=skill.range
	end
	
	def target
		@anomally
	end
	
	def get_target
		@anomally
	end
	
	#投射物基本上全部都是killer
	def killer?(target,friendly);true;end
	
	def fucker?(target,friendly);false;end
	
	def assulter?(target,friendly);false;end
	
	#本身感測器不做任何事情，因為這會導致系統變成追蹤導彈
	def sense_target(character,mode=0)
	end
	
	def master_of_user
		return @master = @event.summon_data[:user].actor.master unless @master
		@master
	end
	
	def friendly?(character)
		self.fraction== character.actor.fraction || master_of_user==character
	end
	
	def effective?
		return true if @projectile_type==1
		return @mileage > @effect_since
	end
	

	#覆蓋來自BattleSystem的方法，一律回傳true
	def can_launch_skill?(skill)
		true
	end

	def self_destruct?
		true
	end

	def cur_mileage
		@mileage = (@event.x - @start_x).abs + (@event.y - @start_y).abs
		@mileage
	end
	def update_npc_steps
		super
		#撞到任何東西、或速度小於一定值引爆
		@strand_count+= 1 if !@event.move_succeed
		miles=cur_mileage
		tmpFakeEV = nil
		targetedNPC = select_npc
		if targetedNPC != nil || (!@event.move_succeed && effective?) || @strand_count>=3 || self.move_speed < @stall_boundary || miles>=@range 
			if targetedNPC != nil
				@event.opacity = 0
				#@event.moveto(targetedNPC.real_x.round,targetedNPC.real_y.round)
				@event.syncToTargetXY(targetedNPC)
			end
			set_killer_skill(0)
			missile_auto_ded
		end
	end
	
	def missile_auto_ded
		set_action_state(:death)
		summon_death_event
		@event.delete
	end
	
	def summon_skill_hit_efx(skill,target,damage=0)
		super
		missile_auto_ded
	end
	
	def select_npc
		tmpTar = nil
		return tmpTar = $game_player if @event.summon_data[:user] != $game_player && $game_player.x == @event.x && $game_player.y == @event.y && !@event.summon_data[:user].actor.friendly?($game_player)
		$game_map.events_xy(@event.x,@event.y).any?{|ev|
			next if ev == @event
			next if ev == @event.summon_data[:user]
			next if !ev.npc?
			next if ev.actor.is_a?(Game_PorjectileCharacter)
			next if ev.actor.ignore_projectile
			next if ev.actor.immune_damage
			next if @event.summon_data[:user].actor.friendly?(ev)
			next if ev.actor.action_state == :death
			next if ev.actor.is_a_ProtectShield && ev.actor.master == @event.summon_data[:user] #ev is a shield and on user
			tmpTar = ev
		}
		tmpTar
	end
	
	#這邊用舊版的處理，因為這個類型的target有被覆寫
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
	
	def get_move_command
		[:move_toward_xy,@anomally.x,@anomally.y,false]
	end


end
