=begin
  Output ErrorLog（for VX Ace） ver 1.0.0.0
          by Han-Nama
    http://www.tktkgame.com/

■ Outline
・ The various output that might help debug log at the end of an error.
・ Log is output as "error_log{date}.txt" in the game folder.

■ How to use
・ More copies on the [Main] to open the script editor
・ If you no longer need the log output, etc. for each item removed when the public


■ Revision History
ver 1.0.0.0 (2012/02/27)
Published.

=end




module TKG;end
module TKG::ErrorLog
  # Whether to print a list of switches
  OUTPUT_SWITCHES  = false
  # Whether to print the list of variables
  OUTPUT_VARIABLES = false
end


module TKG::ErrorLog
  REGEX_BT = /^\{(\d+)\}\:(\d+)/
  @error_events = []
  @error_script = ""
  @indent = "  "
  
  module_function
  
  def set_error_script(code)
    @error_script = code
  end
  
  def set_error_event(map_id, event_id, commonevent_id, troop_page)
    if commonevent_id > 0
      @error_events.push "CommonEvent: #{commonevent_id}"
    elsif troop_page > 0
      @error_events.push "TroopEvent: #{troop_page} page"
    else
      @error_events.push "MapEvent: #{map_id}:#{event_id}"
    end
  end
  
  # Replace the section name, the name of the script
  def replace_section_name(message)
    message.sub(REGEX_BT) {|item|
      section = $RGSS_SCRIPTS[$1.to_i]
      if section.nil?
        item
      else
        "\"#{section[1]}\"(#{$2})"
      end
    }
  end
  
  def error_script_info
    return "" if @error_script == ""
    info = "\n■ ScriptCode\n"
    script_lines = @error_script.gsub("\r","").split("\n")
    script_lines.each_with_index do |code, index|
      info += @indent + sprintf("% 2d: %s\n", index + 1,code)
    end
    info += "\n"
    return info
  end
  
  
	def switches_log
		return "" unless OUTPUT_SWITCHES
		log = "■ Switches List\n"
		$data_system.switches.each_with_index do |name,index|
			next if index == 0
			sw = $game_switches[index]
			log += @indent + sprintf("\[%04d:%s\] :\t%s\n", index, name, sw.to_s)
		end
		log += "\n"
		return log
	end
  
  def variables_log
    return "" unless OUTPUT_VARIABLES
    log = "■ Variavles List\n"
    $data_system.variables.each_with_index do |name,index|
      next if index == 0
      var = $game_variables[index]
      log += @indent + sprintf("\[var%04d:%s\] :\t%s\n", index, name, var.to_s)
    end
    log += "\n"
    return log
  end
  
  # Battler Status
  def battler_info(battler, depth=0)
    tab = @indent * depth
    msg  = ""
	battler.battle_stat.stat.each do |key,value| msg += tab + sprintf("%-30s: [cur : %s , min : %s , max : %s , Tmax : %s , Tmin : %s ] \n",key,*value);end
	
	msg += "\n\n"+tab+"States:\n\n"
	battler.states.uniq.each do  
	|state| 
	msg += tab + sprintf("[id : %5d , stack : %d , remove_by_walking : %5s ,step_remove: %d , frame_remove: %d]\n" , state.id, battler.state_stack(state.id),state.remove_by_walking.to_s,battler.state_steps[state.id],battler.state_frames[state.id]) ;
	end 
	msg += "\n\n"+tab+"Battle System:\n\n"
	msg += tab+"action_state :   #{battler.action_state} \n"
	msg += tab+"skill        :   #{battler.skill} \n"
	
	msg += "\n\n"+tab+"PregAndMenses:\n\n"
	msg += tab+"menses_schedule   :    #{battler.menses_schedule} \n"
	msg += tab+"prev_status_log   :    #{battler.prev_status_log} \n"
	msg += tab+"status_log        :    #{battler.status_log} \n"
	msg += tab+"preg_rates        :    #{battler.preg_rates} \n"
	msg += tab+"cycle_start       :    #{battler.cycle_start} \n"
	msg += tab+"baby_race         :    #{battler.baby_race} \n"
	msg += tab+"currentDay        :    #{battler.currentDay} \n"
    return msg
  end

  # Battler Actions
  def battler_actions(battler, depth=0)
    msg = ""
    tab = @indent * depth
    battler.actions.each_with_index do |action, i|
      msg += tab + "Action#{i+1}:\n"
      case action.item
      when RPG::Skill # Skill
        msg += tab + @indent + sprintf("Action: Skill: [%03d:%s]\n",action.item.id, action.item.item_name)
      when 2 # Item
        msg += tab + sprintf("Action: Item: [%03d:%s]\n",action.item.id, action.item.item_name)
      end
      msg += tab + @indent + "TargetIndex: #{action.target_index.to_s}\n"
      msg += tab + @indent + "Forced?: #{action.forcing}\n"
    end
    return msg
  end
  
  # Actor Info
  def actor_info(actor, index=0, depth=0, with_battle_info=false)
    tab = @indent * depth
    if actor.dead?
      info = " :Dead"
    else
      info = ""
    end
    msg  = tab + sprintf("%03d: [%03d: %s]%s\n",index,actor.id, actor.name, info)
    msg += battler_info(actor, depth + 1)
    msg += battler_actions(actor, depth + 1) if with_battle_info
    return msg
  end

  def event_backlog
    return '' if @error_events.size == 0
    msg  = "■ EventBacklog:\n"
    @error_events.each do |error_event|
      msg += @indent + error_event + "\n"
    end
    return msg
  end
  
  
  # Map Info
	def map_info
		msg  = "■ Map:\n"
		msg += @indent + "MAP_ID: #{$game_map.map_id.to_s}\n"
		msg += @indent + "Player: [#{$game_player.x}, #{$game_player.y}]\n"
		msg += @indent + "Events:\n"
		$game_map.events.each do |eid, ge|

		ev = ge.instance_variable_get(:@event)
		page = ge.instance_variable_get(:@page)
		msg += @indent * 2 + sprintf("[%03d:%s](%d,%d):\n", eid, ev.name, ge.x,ge.y)
		# draw PageNO
		if page
			page_no = ev.pages.index(page) + 1
		else
			page_no = 0
		end
		msg += @indent * 3 + "Page: #{page_no}\n"
		# draw SelfSwitches
		msg += @indent * 3 + "SelfSW: ["
		['A','B','C','D'].each do |alpha|
			key = [$game_map.map_id, eid, alpha]
			msg += " #{alpha}:" + ($game_self_switches[key] ? 'ON' : 'OFF')
		end
		msg += " ]\n"
		end
		return msg
	end
  
	# Saved to a file the error log
	def save(filename=nil, exception=$!)
		if filename.nil?
			filename = "error_log" + Time.now.strftime("%Y%m%d_%H%M_%S") + ".txt"
		end
		msg  = "◆ #{Time.now.strftime('%Y-%m-%dT%H:%M:%S')}\n"
		msg += "■ Error Type :\n"
		msg += @indent + "#{exception.class.to_s}\n"
		msg += "\n"
		if exception.message
			msg += "■ Message :\n"
			msg += @indent + "#{self.replace_section_name(exception.message)}\n"
			msg += "\n"
		end

		begin
			@error_events.each do |error_event|
			msg += error_event + "\n"
			end
		rescue => ex
			msg += "Events can't be logged: #{ex}"
		end

		begin
			msg += self.event_backlog()
		rescue => ex
			msg += "event_backlog can't be logged: #{ex}"
		end
		msg += "\n"

		begin
			msg += self.error_script_info()
		rescue => ex
			msg += "error_script_info can't be logged: #{ex}"
		end

		if exception.backtrace.size > 0
			msg += "■ Backtrace :\n"
			exception.backtrace.map do |bt|
				msg += @indent + "#{self.replace_section_name(bt)}\n"
			end
			msg += "\n"
		end

		msg+= "■ Current In-Game Date :\n\n"
		if $game_date.nil?
			msg+=@indent+ "Game Not Started"
		else
			msg+= @indent+$game_date.date.to_s + "\n"
		end
		msg+= "\n\n"

		begin
			msg+= "■ MOD LOAD ORDER :\n"
			if $mod_manager.output_data_to_array.empty?
				msg+=@indent+ "$mod_manager is empty"
			else
				data = $mod_manager.output_data_to_array
				data.each do |mod_name, attributes|
					version_line = attributes.find { |line| line.include?('"version"=') }
					version = version_line[/\"version\"=(.*)/, 1] || "unknown"
					msg += "  #{mod_name.ljust(30)} :version=#{version},\n"
				end
			end
		rescue
			msg += "$mod_manager can't be logged."
		end
		msg+= "\n\n"

		begin
			msg+= "■ $PRP_REC trace :\n"
			if $PRP_REC.nil? || $PRP_REC.empty?
				msg+=@indent+ "$PRP_REC is empty"
			else
				$PRP_REC.each{|log,color|
					msg += @indent + "#{log}\n"
				}
			end
		rescue => ex
			msg += "$story_stats can't be logged: #{ex}"
		end
		msg+= "\n\n"

		begin
			msg+= "■ Story Stats :\n"
			if $story_stats.nil?
				msg+=@indent+ "Game Not Started"
			else
				$story_stats.keys.each{|key|
					next if key == "logTxt"
					next if key == "logNarr"
					next if key == "logBoard"
					next if key == "sex_record_first_mouth"
					next if key == "sex_record_first_vag"
					next if key == "sex_record_first_anal"
					next if key == "CharacterSteal"
					next if key == "CharacterItems"
					#next if key == "record_current_married_partner"
					msg+=@indent + sprintf("%-30s : %s \n",key,$story_stats[key])
				}
			end
		rescue => ex
			msg += "$story_stats can't be logged: #{ex}"
		end
		msg+= "\n\n"



		begin
			sw_log  = self.switches_log
		rescue => ex
			sw_log = "switches can't be logged: #{ex}"
		end

		begin
			var_log = self.variables_log
		rescue => ex
			var_log = "variables can't be logged: #{ex}"
		end
			open(filename,"w") do |log|
			log.print msg
			log.print sw_log
			log.print var_log
			end
		end

	end

module TKG::ErrorLog::Extend_Interpreter
	attr_accessor :troop_page
	attr_accessor :commonevent_id
	def eval(*args)
		begin
			super
		rescue
			TKG::ErrorLog.set_error_script(args[0])
			raise
		end
	end
	def clear
		@troop_page = 0
		@commonevent_id = 0
		super
	end
	def run
		begin
			result = super
		rescue
			TKG::ErrorLog.set_error_event(@map_id, @event_id, @commonevent_id, @troop_page)
			raise
		end
		return result
	end
end
#module TKG::ErrorLog::Extend_GameTroop
#  def conditions_met?(page)
#    result = super(page)
#    if result
#      @interpreter.troop_page = $game_troop.troop.pages.index(page) + 1
#    end
#    return result
#  end
#end

class Game_Interpreter
	unless private_method_defined?('_tkg_debuglog__initialize')
		alias _tkg_debuglog__initialize initialize
	end
	def initialize(*args)
		_tkg_debuglog__initialize(*args)
		self.extend TKG::ErrorLog::Extend_Interpreter
	end
end

#class Game_Troop
#  unless private_method_defined?('_tkg_debuglog__initialize')
#    alias _tkg_debuglog__initialize initialize
#  end
#  def initialize(*args)
#    _tkg_debuglog__initialize(*args)
#    self.extend TKG::ErrorLog::Extend_GameTroop
#  end
#end
#
#class RPG::CommonEvent
#  def list
#    _list = @list
#    if trigger != 2
#      command = RPG::EventCommand.new(355,0,["@commonevent_id = #{@id}"])
#      _list.unshift(command)
#    end
#    return _list
#  end
#end

module SceneManager
	unless respond_to?('_debug__run')
		class << self
			alias _tkg_debug__run run
		end
	end
	def self.run
		begin
			_tkg_debug__run
		rescue
			TKG::ErrorLog.save()
			raise
		end
	end
end
