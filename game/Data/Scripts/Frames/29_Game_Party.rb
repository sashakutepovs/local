#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Game_Party
#------------------------------------------------------------------------------
#  This class handles parties. Information such as gold and items is included.
# Instances of this class are referenced by $game_party.
#==============================================================================

class Game_Party < Game_Unit
  #--------------------------------------------------------------------------
  # * Constants
  #--------------------------------------------------------------------------
  ABILITY_ENCOUNTER_HALF    = 0           # halve encounters
  ABILITY_ENCOUNTER_NONE    = 1           # disable encounters
  ABILITY_CANCEL_SURPRISE   = 2           # disable surprise
  ABILITY_RAISE_PREEMPTIVE  = 3           # increase preemptive strike rate
  ABILITY_GOLD_DOUBLE       = 4           # double money earned
  ABILITY_DROP_ITEM_DOUBLE  = 5           # double item acquisition rate
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_reader   :gold                     # party's gold
  attr_reader   :steps                    # number of steps
  attr_reader   :last_item                # for cursor memorization:  item
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    super
    @gold = 0
    @steps = 0
    @last_item = Game_BaseItem.new
    @menu_actor_id = 0
    @target_actor_id = 0
    @actors = []
    init_all_items
  end
  #--------------------------------------------------------------------------
  # * Initialize All Item Lists
  #--------------------------------------------------------------------------
	def init_all_items
		@items   = {}
		@weapons = {}
		@armors  = {}
	end
	
	def get_items
		@items
	end
	def get_weapons
		@weapons
	end
	def get_armors
		@armors
	end
	
	
	def set_items(tmpItems)
		@items   = tmpItems
	end
	def set_weapons(tmpWeapons)
		@weapons = tmpWeapons
	end
	def set_armors(tmpArmors)
		@armors  = tmpArmors
	end
  #--------------------------------------------------------------------------
  # * Determine Existence
  #--------------------------------------------------------------------------
  def exists
    !@actors.empty?
  end
  #--------------------------------------------------------------------------
  # * Get Members
  #--------------------------------------------------------------------------
  def members
    in_battle ? battle_members : all_members
  end
  #--------------------------------------------------------------------------
  # * Get All Members
  #--------------------------------------------------------------------------
  def all_members
    @actors.collect {|id| $game_actors[id] }
  end
  #--------------------------------------------------------------------------
  # * Get Battle Members
  #--------------------------------------------------------------------------
  def battle_members
    all_members[0, max_battle_members].select {|actor| actor.exist? }
  end
  #--------------------------------------------------------------------------
  # * Get Maximum Number of Battle Members
  #--------------------------------------------------------------------------
  def max_battle_members
    return 4
  end
  #--------------------------------------------------------------------------
  # * Get Leader
  #--------------------------------------------------------------------------
  def leader
    battle_members[0]
  end
  #--------------------------------------------------------------------------
  # * Get Item Object Array 
  #--------------------------------------------------------------------------
  def items
    @items.keys.sort.collect {|id| $data_items[id] }
  end
  #--------------------------------------------------------------------------
  # * Get Weapon Object Array 
  #--------------------------------------------------------------------------
  def weapons
    @weapons.keys.sort.collect {|id| $data_weapons[id] }
  end
  #--------------------------------------------------------------------------
  # * Get Armor Object Array 
  #--------------------------------------------------------------------------
  def armors
    @armors.keys.sort.collect {|id| $data_armors[id] }
  end
  #--------------------------------------------------------------------------
  # * Get Array of All Equipment Objects
  #--------------------------------------------------------------------------
  def equip_items
    weapons + armors
  end
  #--------------------------------------------------------------------------
  # * Get Array of All Item Objects
  #--------------------------------------------------------------------------
  def all_items
    items + equip_items
  end
  #--------------------------------------------------------------------------
  # * Get Container Object Corresponding to Item Class
  #--------------------------------------------------------------------------
  def item_container(item_class)
    return @items   if item_class == RPG::Item
    return @weapons if item_class == RPG::Weapon
    return @armors  if item_class == RPG::Armor
    return nil
  end
  #--------------------------------------------------------------------------
  # * Initial Party Setup
  #--------------------------------------------------------------------------
  def setup_starting_members
    @actors = $data_system.party_members.clone
  end
  #--------------------------------------------------------------------------
  # * Get Party Name
  #    If there is only one, returns the actor's name.
  #    If there are more, returns "XX's Party".
  #--------------------------------------------------------------------------
  def name
    return ""           if battle_members.size == 0
    return leader.name  if battle_members.size == 1
    return sprintf(Vocab::PartyName, leader.name)
  end
  #--------------------------------------------------------------------------
  # * Set Up Battle Test
  #--------------------------------------------------------------------------
  def setup_battle_test
    setup_battle_test_members
    setup_battle_test_items
  end
  #--------------------------------------------------------------------------
  # * Get Highest Level of Party Members
  #--------------------------------------------------------------------------
  def highest_level
    lv = members.collect {|actor| actor.level }.max
  end
  #--------------------------------------------------------------------------
  # * Add an Actor
  #--------------------------------------------------------------------------
  def add_actor(actor_id)
    @actors.push(actor_id) unless @actors.include?(actor_id)
    $game_player.refresh
    $game_map.need_refresh = true
  end
  #--------------------------------------------------------------------------
  # * Remove Actor
  #--------------------------------------------------------------------------
  def remove_actor(actor_id)
    @actors.delete(actor_id)
    $game_player.refresh
    $game_map.need_refresh = true
  end
  #--------------------------------------------------------------------------
  # * Increase Gold
  #--------------------------------------------------------------------------
	def gain_gold(amount)
		$story_stats["record_TotalGain_TP"] += amount
		@gold = [[@gold + amount, 0].max, max_gold].min
	end
	def set_gold(amount) #use in storage box
		$story_stats["record_TotalGain_TP"] += amount
		@gold = amount
	end
  #--------------------------------------------------------------------------
  # * Decrease Gold
  #--------------------------------------------------------------------------
	def lose_gold(amount)
		gain_gold(-amount)
	end
  #--------------------------------------------------------------------------
  # * Get Maximum Value of Gold
  #--------------------------------------------------------------------------
  def max_gold
    return 99999999
  end
  #--------------------------------------------------------------------------
  # * Increase Steps
  #--------------------------------------------------------------------------
  def increase_steps
    @steps += 1
  end
  #--------------------------------------------------------------------------
  # * Get Number of Items Possessed
  #--------------------------------------------------------------------------
	def item_number(item)
		item = $data_ItemName[item] if item.is_a?(String)
		container = item_container(item.class)
		container ? container[item.id] || 0 : 0
	end
  #--------------------------------------------------------------------------
  # * Get Maximum Number of Items Possessed
  #--------------------------------------------------------------------------
  def max_item_number(item)
    return 65534
  end
  #--------------------------------------------------------------------------
  # * Determine if Maximum Number of Items Are Possessed
  #--------------------------------------------------------------------------
  def item_max?(item)
    item_number(item) >= max_item_number(item)
  end
  #--------------------------------------------------------------------------
  # * Determine Item Possession Status
  #     include_equip : Include equipped items
  #--------------------------------------------------------------------------
	def has_item?(item, include_equip = false)
		item = $data_ItemName[item] if item.is_a?(String)
		return true if item_number(item) > 0
		return include_equip ? members_equip_include?(item) : false
	end
  #--------------------------------------------------------------------------
  # * Determine if Specified Item Is Included in Members' Equipment
  #--------------------------------------------------------------------------
  def members_equip_include?(item)
    members.any? {|actor| actor.equips.include?(item) }
  end
  #--------------------------------------------------------------------------
  # * Increase/Decrease Items
  #     include_equip : Include equipped items
  #--------------------------------------------------------------------------
	#def item_container(item_class)
	#	return @items   if item_class == RPG::Item
	#	return @weapons if item_class == RPG::Weapon
	#	return @armors  if item_class == RPG::Armor
	#	return nil
	#end
	def gain_item_core(item, amount, include_equip = false)
		item = $data_ItemName[item] if item.is_a?(String)
		container = item_container(item.class)
		return unless container
		last_number = item_number(item)
		new_number = last_number + amount
		container[item.id] = [[new_number, 0].max, max_item_number(item)].min
		container.delete(item.id) if container[item.id] == 0
		if include_equip && new_number < 0
			discard_members_equip(item, -new_number)
		end
	end
	def gain_item(item, amount, include_equip = false)
		gain_item_core(item, amount, include_equip)
		refresh_ext_item
	end
  #--------------------------------------------------------------------------
  # * Discard Members' Equipment
  #--------------------------------------------------------------------------
  def discard_members_equip(item, amount)
    n = amount
    members.each do |actor|
      while n > 0 && actor.equips.include?(item)
        actor.discard_equip(item)
        n -= 1
      end
    end
	$game_actors[1].calculate_weight_carried #更新負重量數字
  end
  #--------------------------------------------------------------------------
  # * Lose Items
  #     include_equip : Include equipped items
  #--------------------------------------------------------------------------
	def lose_item(item, amount, include_equip = false)
		gain_item(item, -amount, include_equip)
	end
  #--------------------------------------------------------------------------
  # * Consume Items
  #    If the specified object is a consumable item, the number in investory
  #    will be reduced by 1.
  #--------------------------------------------------------------------------
  def consume_item(item)
		lose_item(item, 1) if item.consumable && !item.key_item?
		#lose_item(item, 1) if item.is_a?(RPG::Item) && item.consumable #original
  end
  #--------------------------------------------------------------------------
  # * Determine Skill/Item Usability
  #--------------------------------------------------------------------------
  def usable?(item)
    members.any? {|actor| actor.usable?(item) }
  end
  #--------------------------------------------------------------------------
  # * Determine Command Inputability During Battle
  #--------------------------------------------------------------------------
  #def inputable?
  #  members.any? {|actor| actor.inputable? }
  #end
  #--------------------------------------------------------------------------
  # * Determine if Everyone is Dead
  #--------------------------------------------------------------------------
  def all_dead?
    super && ($game_party.in_battle || members.size > 0)
  end
  #--------------------------------------------------------------------------
  # * Processing Performed When Player Takes 1 Step
  #--------------------------------------------------------------------------
  def on_player_walk
    members.each {|actor| actor.on_player_walk }
  end
  #--------------------------------------------------------------------------
  # * Get Actor Selected on Menu Screen
  #--------------------------------------------------------------------------
  def menu_actor
    $game_actors[@menu_actor_id] || members[0]
  end
  #--------------------------------------------------------------------------
  # * Set Actor Selected on Menu Screen
  #--------------------------------------------------------------------------
  def menu_actor=(actor)
    @menu_actor_id = actor.id
  end
  #--------------------------------------------------------------------------
  # * Select Next Actor on Menu Screen
  #--------------------------------------------------------------------------
  def menu_actor_next
    index = members.index(menu_actor) || -1
    index = (index + 1) % members.size
    self.menu_actor = members[index]
  end
  #--------------------------------------------------------------------------
  # * Select Previous Actor on Menu Screen
  #--------------------------------------------------------------------------
  def menu_actor_prev
    index = members.index(menu_actor) || 1
    index = (index + members.size - 1) % members.size
    self.menu_actor = members[index]
  end
  #--------------------------------------------------------------------------
  # * Get Actor Targeted by Skill/Item Use
  #--------------------------------------------------------------------------
  def target_actor
    $game_actors[@target_actor_id] || members[0]
  end
  #--------------------------------------------------------------------------
  # * Set Actor Targeted by Skill/Item Use
  #--------------------------------------------------------------------------
  def target_actor=(actor)
    @target_actor_id = actor.id
  end
  #--------------------------------------------------------------------------
  # * Change Order
  #--------------------------------------------------------------------------
  def swap_order(index1, index2)
    @actors[index1], @actors[index2] = @actors[index2], @actors[index1]
    $game_player.refresh
  end
  #--------------------------------------------------------------------------
  # * Character Image Information for Save File Display
  #--------------------------------------------------------------------------
  def characters_for_savefile
    battle_members.collect do |actor|
      [actor.character_name, actor.character_index]
    end
  end
  #--------------------------------------------------------------------------
  # * Determine Party Ability
  #--------------------------------------------------------------------------
  def party_ability(ability_id)
    battle_members.any? {|actor| actor.party_ability(ability_id) }
  end
  #--------------------------------------------------------------------------
  # * Halve Encounters?
  #--------------------------------------------------------------------------
  def encounter_half?
    party_ability(ABILITY_ENCOUNTER_HALF)
  end
  #--------------------------------------------------------------------------
  # * Disable Encounters?
  #--------------------------------------------------------------------------
  def encounter_none?
    party_ability(ABILITY_ENCOUNTER_NONE)
  end
  #--------------------------------------------------------------------------
  # * Disable Surprise?
  #--------------------------------------------------------------------------
  def cancel_surprise?
    party_ability(ABILITY_CANCEL_SURPRISE)
  end
  #--------------------------------------------------------------------------
  # * Increase Preemptive Strike Rate?
  #--------------------------------------------------------------------------
  def raise_preemptive?
    party_ability(ABILITY_RAISE_PREEMPTIVE)
  end
  #--------------------------------------------------------------------------
  # * Double Money Earned?
  #--------------------------------------------------------------------------
  def gold_double?
    party_ability(ABILITY_GOLD_DOUBLE)
  end
  #--------------------------------------------------------------------------
  # * Double Item Acquisition Rate?
  #--------------------------------------------------------------------------
  def drop_item_double?
    party_ability(ABILITY_DROP_ITEM_DOUBLE)
  end
  #--------------------------------------------------------------------------
  # * Calculate Probability of Preemptive Attack
  #--------------------------------------------------------------------------
  def rate_preemptive(troop_agi)
    (agi >= troop_agi ? 0.05 : 0.03) * (raise_preemptive? ? 4 : 1)
  end
  #--------------------------------------------------------------------------
  # * Calculate Probability of Surprise
  #--------------------------------------------------------------------------
  def rate_surprise(troop_agi)
    cancel_surprise? ? 0 : (agi >= troop_agi ? 0.03 : 0.05)
  end
  
def gain_items_by_price(cur_vol=1,good=["ItemCoin1","ItemCoin2","ItemCoin3"],summon=false) #以價格為基準取得DATA ITEMS 物品價格建議由高至低
	cur_vol = 1 if cur_vol < 1
	cur_vol = cur_vol.round
	item_list = Array.new
	tmpResultReport = Array.new
	good.each do |comp_item|
			item_list.push($data_ItemName[comp_item])
	end
	item_list.sort_by!{| obj | obj.price}
	item_list.reverse!
	total_vol = cur_vol
	item_list.each do |tar_item|
		item_price = tar_item.price
		next if cur_vol < item_price || item_price == nil || item_price == 0
		item_num = cur_vol / item_price
		next if item_num < 1
		cur_vol -= item_price * item_num
		if summon == false
			item_num = item_num.to_i
			gain_item(tar_item,item_num)
			tmpResultReport << [tar_item.icon_index,item_num]
		else
			item_num = item_num.to_i
			temp_loop = 0
			until temp_loop == item_num
				temp_loop +=1
				$game_map.reserve_summon_event(tar_item.item_name,$game_player.x,$game_player.y,-1,{:user=>$game_player})
			end
		end
	end
	cur_vol = cur_vol.to_i
	if cur_vol > 0
		gain_gold(cur_vol)
		tmpResultReport << [261,cur_vol]
	end
	tmpResultReport
end
  
	def force_use_item_type(type_name)
		operation_tar_type=type_name
		all_items.each{
			|item|
			next if !item.type.eql?(operation_tar_type)
			tmpDisplayItem = item
			tmpDisplayItemNum = item_number(tmpDisplayItem)
			item_number(item).times {
				$game_player.actor.itemUseBatch(item)
			}
			$game_map.popup(0,"-#{tmpDisplayItemNum}",tmpDisplayItem.icon_index,-1)
		}
	end
	
	
	def has_item_type(type_name)
		temp_val=0
		all_items.each{
			|item|
			next if !item.type.eql?(type_name)
			amt=item_number(item)
			for i in 0...amt
			temp_val += item_number(item)
			end
		}
			return false if temp_val == 0
			return true if temp_val > 0
	end
	
	def item_type_HowMany(type_name)
		temp_val=0
		all_items.each{
			|item|
			next if !item.type.eql?(type_name)
			amt=item_number(item)
			for i in 0...amt
			temp_val += 1
			end
		}
			temp_val
	end
	
	def item_tag_HowMany(type_name)
		temp_val=0
		all_items.each{
			|item|
			next if !item.type_tag.eql?(type_name)
			amt=item_number(item)
			for i in 0...amt
			temp_val += 1
			end
		}
		temp_val
	end
	
	
	def item_has_common_tag_and_report(tarData)
		temp_val=0
		all_items.any?{
			|item|
			next unless item.common_tags
			next unless item.common_tags[tarData]
			temp_val = item.common_tags[tarData]
		}
		temp_val
	end
	
	
	def item_PotData_HowMany(tarData)
		temp_val=0
		all_items.each{
			|item|
			next unless item.pot_data
			next unless item.pot_data[tarData]
				amt=item_number(item)*item.pot_data[tarData].to_i
				for i in 0...amt
					temp_val += 1
				end
		}
		temp_val
	end
	
	def decrease_item_type(type_name,tmpNum)
		temp_val=0
		all_items.any?{
			|item|
			next if item.type != type_name
			lose_item(item,tmpNum,true)
			return
		}
	end
	
	def get_item_type_price(type_name)
		operation_tar_type=type_name
		temp_val=0
		all_items.each{
			|item|
			next if !item.type.eql?(operation_tar_type)
			amt=item_number(item)
			for i in 0...amt
			temp_val += item.price
			end
		}
		return temp_val
	end
	
	def get_item_type_to_array(type_name)
		operation_tar_type=type_name
		temp_val=[]
		all_items.each{
			|item|
			next if !item.type.eql?(operation_tar_type)
			amt=item_number(item)
			for i in 0...amt
			temp_val.push(item)
			end
		}
		return temp_val
	end
	
	def lost_item_type(type_name)
		operation_tar_type=type_name
		temp_val=0
		all_items.each{
			|item|
			next if !item.type.eql?(operation_tar_type)
			amt=item_number(item)
			lose_item(item,item_number(item),true)
		}
	end
	
	def lost_item_tag(type_name)
		operation_tar_type=type_name
		temp_val=0
		all_items.each{
			|item|
			next if !item.type_tag.eql?(operation_tar_type)
			amt=item_number(item)
			lose_item(item,item_number(item),true)
		}
	end
	
	def lost_humanoid_baby
		tmpBBcount = 0
		all_items.each{
			|item|
			next if !item.common_tags["baby_LonaHumChild"]
			amt=item_number(item)
			data = "Rebirth_Lost_#{item.item_name}"
			p "lostBaby from $game_party.lost_humanoid_baby => #{data}"
			$story_stats[data] += 1
			lose_item(item,item_number(item),true)
			$story_stats["dialog_baby_lost"] =1
			$story_stats["sex_record_birth_BabyLost"] += amt
			tmpBBcount += amt
		}
		tmpBBcount
	end

  def drop_item_and_summon(itemid,amt=1)
	return if item_number($data_items[itemid])==0
	lose_item($data_items[itemid],amt)
	$game_temp.call_item_drop([$data_items[itemid].item_name])
  end
  
  def drop_items_of_type_and_summon(type)
	dropped_item=Array.new
	members.each do |actor|
      eqps=actor.equips
	  eqps.each{
		|eqp|
		next if eqp.nil? || !type.eql?(eqp.type_tag)
		actor.discard_equip(eqp)
		amt=item_number(eqp)+1
		dropped_item.concat(Array.new(amt,eqp.item_name))
		lose_item(eqp,amt,true)
	  }
		all_items.each{
		|item|
		next if !type.eql?(item.type_tag)
		amt=item_number(item)
		lose_item(item,item_number(item),true)
		dropped_item.concat(Array.new(amt,item.item_name))
	}
	$game_temp.call_item_drop(dropped_item)
  end
  end
  
	def drop_all_equipped_items_and_summon(except=["Key","Bondage","Hair","Trait", "Child"])
		dropped_item=Array.new
		members.each do |actor|
			eqps=actor.equips
			eqps.each{
				|eqp|
				next if eqp.nil? || except.include?(eqp.type_tag) || eqp.key_item?
				actor.discard_equip(eqp)
				amt=item_number(eqp)+1
				dropped_item.concat(Array.new(amt,eqp.item_name))
				lose_item(eqp,amt,true)
			}
		$game_temp.call_item_drop(dropped_item)
		$game_player.actor.update_chs
		$game_player.actor.portrait.update
		$game_player.refresh_chs #was only scheduling refresh, but not executing it, so caused wrong spreadsheet until first update.
		end
	end

  #掉落除了指定Tag(except)以外的物品
	def drop_items_and_summon(except,summon=true,tmpRngAMT=false)
		dropped_item=Array.new
		all_items.each{
			|item|
			p "except.include?(#{item.type_tag})=> #{except.include?(item.type_tag)}"
			next if except.include?(item.type_tag) || item.key_item?
			amt=item_number(item)
			amt = rand(amt) if tmpRngAMT
			lose_item(item,amt,true) if amt > 0
			dropped_item.concat(Array.new(amt,item.item_name)) if amt > 0
		}
		$game_temp.call_item_drop(dropped_item) if summon==true
	end

	def drop_all_equipped_items_to_storage(storageID=65535,except=["Key","Bondage","Hair","Trait", "Child"], skipfrist=false)
		dropped_item=Array.new
		members.each do |actor|
			eqps=actor.equips
			eqps.each{
				|eqp|
				next if eqp.nil? || except.include?(eqp.type_tag) || eqp.key_item?
				actor.discard_equip(eqp)
				amt=item_number(eqp)+1
				if amt >= 2 && skipfrist #skip frist item 
					amt -= 1
					lose_item(eqp,1,true)
				elsif amt == 1 && skipfrist && rand(100) > 60
					next lose_item(eqp,amt,true)
				end
				
				if !$game_boxes.box(storageID)[eqp]
					$game_boxes.box(storageID)[eqp] = amt
				else
					$game_boxes.box(storageID)[eqp] += amt
				end
				lose_item(eqp,amt,true)
			}
		$game_player.actor.update_chs
		$game_player.actor.portrait.update
		$game_player.refresh_chs #was only scheduling refresh, but not executing it, so caused wrong spreadsheet until first update.
		end
	end
	
	def drop_items_to_storage(storageID=65535,except=[],skipfrist=false)
		dropped_item=Array.new
		all_items.each{
			|item|
			p "except.include?(#{item.type_tag})=> #{except.include?(item.type_tag)}"
			next if except.include?(item.type_tag) || item.key_item?
			amt=item_number(item)
			if amt >= 2 && skipfrist #skip frist item 
				amt -= 1
				lose_item(item,1,true)
			elsif amt == 1 && skipfrist && rand(100) > 60
				next lose_item(item,amt,true)
			end
			if !$game_boxes.box(storageID)[item]
				$game_boxes.box(storageID)[item] = amt
			else
				$game_boxes.box(storageID)[item] += amt
			end
			lose_item(item,item_number(item),true)
		}
	end
  
  def get_price_from_items(except=["Key","Bondage","Hair","Trait", "Child"])
	dropped_item=Array.new
	tarPrice= 0
	all_items.each{
		|item|
		p "except.include?(#{item.type_tag})=> #{except.include?(item.type_tag)}"
		next if except.include?(item.type_tag)
		amt=item_number(item)
		tarPrice += item.price*amt
	}
	tarPrice
  end
  
  def drop_all_items_and_summon(include_equip=false,except=["Key","Bondage","Hair","Trait", "Child"],summon=true)
		p "drop_all_items_and_summon"
		p "drop_items_and_summon"
		drop_items_and_summon(except,summon)
		p "drop_all_equipped_items_and_summon"
		drop_all_equipped_items_and_summon(except) if include_equip
  end

	#def drop_raw(tmpBasedOn=$game_date.dateAmt,rawList = ["RawSemen","RawWaste","RawMeat","RawPlant","RawMilk","RawSemen","RawOther"])
	#	all_items.each{
	#		|item|
	#		next unless rawList.include?(item.type_tag)
	#		next unless item.addData
	#		item.raw_date ? tmpDropAMT = item.raw_date : tmpDropAMT = 1
	#		if tmpBasedOn % tmpDropAMT == 0
	#			amt = 1+rand(item_number(item))
	#			next lose_item(item,amt,true)
	#		end
	#	}
	#end
	def update_rotten_items
		all_items.each do |item|
			next unless item.raw_date

			tmpDropAMT = item.raw_date.to_i.nonzero? || 1
			next if tmpDropAMT <= 0

			if $game_date.dateAmt % tmpDropAMT == 0
				current_amt = item_number(item).to_i
				next if current_amt <= 0

				amt = 1 + rand(current_amt)

				if item.rot_progress
					raw_progress_item = item.rot_progress[0]
					raw_progress_amt = item.rot_progress[1]
					gain_item(raw_progress_item, raw_progress_amt * amt)
				end

				lose_item(item, amt, true)
			end
		end
	end
	
	def drop_all_items_to_storage(include_equip=false,storageID=65535,except=["Key","Bondage","Hair","Trait", "Child"],skipfrist=false)
		drop_items_to_storage(storageID,except,skipfrist)
		drop_all_equipped_items_to_storage(storageID,except,skipfrist) if include_equip
	end


  #drop_tgt_item_and_summon(item_name,amt)
  #$data_items.select{|item| item.item_name.eql?()}[itemid]
  def drop_tgt_item_and_summon(type,item_name,amt,summon=true)
	case type
		when "Item";item=$data_items.select{|item| !item.nil? && item.item_name.eql?(item_name)};
		when "Weapon";item=$data_weapons.select{|item| !item.nil? &&item.item_name.eql?(item_name)};
		when "Armor";item=$data_armors.select{|item| !item.nil? &&item.item_name.eql?(item_name)};
		else raise "unknown type=>#{type} while drop_tgt_item_and_summon";
	end
	raise "no item of name=#{item_name} found in Database" if item.nil?
	poseession=item_number(item[0])
	amt=poseession if amt >poseession
	p "poseession =>#{poseession}"
	lose_item(item[0],amt)
	p "amt,item[0].item_name #{amt},#{item[0].item_name}"
	$game_temp.call_item_drop(Array.new(amt,item[0].item_name)) if summon
  end
	

  
end
