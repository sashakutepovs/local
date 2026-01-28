
class Game_BattlerBase
  
	def max_state_stack?(state_id) ## Determines if the state is at max stacks.
		state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		return prp "max_state_stack? #{state_id} not found",1 if !state_id
		state_stack(state_id) >= $data_states[state_id].max_stacks
	end
  
	def state_stack(state_id) ## Gets the number of times the state is stacked.
		state_id = $data_StateName[state_id].id if state_id.is_a?(String)
		return prp "state_stack #{state_id} not found",1 if !state_id
		(@states.count(state_id) || 0)
	end
end


class RPG::State < RPG::BaseItem
	def max_stacks  ## Modified state class to add stack capabilities.
		@max_stacks
		#create_stack_regs
		#@max_stacks || 1
	end
  
  #alias :cp_stack_states :icon_index
  #def icon_index(stacks = 1)  ## Added an argument to get icons from stacks.
  #  create_stack_regs
  #  #@stack_icons[stacks] || cp_stack_states
  #end
  
 #def create_stack_regs
 #  return if @finished_up_stack_icons
 #  @finished_up_stack_icons = true
 #  #@stack_icons = {}
 #  note.split(/[\r\n]+/).each do |line|
 #    case line
 #    when /max stacks?\[(\d+)\]/i
 #      @max_stacks = $1.to_i
 #   # when /stack icons?\[(\d+),? (\d+)\]/i
 #   #   @stack_icons[$1.to_i] = $2.to_i
 #    end
 #  end
 #end
end


