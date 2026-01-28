#type=Weapon,type=Other
	#type=Armor
	#type=Food
	#type=Medicine
	#type=MedicineSta
	#type=MedicineHp
	#type=FoodSemen
	#type=Waste
	#type=FoodBad
	#type=Other

	#type=Trap
	#type=none
	#type=Baby
	#type=Key
	#type=SurgeryCoupon


class Game_Party < Game_Unit
	def refresh_ext_item
		$game_map.need_refresh = true
		$game_player.actor.calculate_weight_carried #更新carried數字
	end
end 

class Game_Actor < Game_Battler
	def refresh_ext_item
		#chk = 0
		#@ext_items.each{|tar|
		#	tar = nil if !$game_party.has_item?(@ext_items[chk])
		#	chk +=1
		#}
	end

	def use_quickslot(action_slot=1)
		temp_tar_item = $data_ItemName[@ext_items[action_slot]]

		if temp_tar_item == nil || !$game_party.has_item?(temp_tar_item, include_equip = false)
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/NoItemExt",0,0)
			return
		end
		if temp_tar_item.item_ext_SkillName && (Input.press?(:SHIFT) || temp_tar_item.item_ext_DirectUsage)
			linkNAME = temp_tar_item.item_ext_SkillName
			skillKey = Input.getSkillKey
			return if !skillKey
			return SndLib.sys_buzzer if !$game_player.actor.cost_affordable?($data_arpgskills[linkNAME])
			$game_player.actor.take_skill_cancel($data_arpgskills["BasicNormal"])
			$game_player.process_item_skill(skillKey,linkNAME)
			if !temp_tar_item.item_ext_CostAfterLaunch
				$game_map.popup(0,"#{$game_party.item_number(temp_tar_item)}-1",temp_tar_item.icon_index,-1) #moved to Skill event
				$game_party.lose_item(temp_tar_item,1)
			end
			return
		end
		if Input.press?(:CTRL)
			$game_map.popup(0,"#{$game_party.item_number(temp_tar_item)}-1",temp_tar_item.icon_index,-1)
			$game_party.lose_item(temp_tar_item,1)
			EvLib.sum(temp_tar_item.item_name,$game_player.x,$game_player.y)
			SndLib.sound_equip_armor
			$game_player.light_check
			return
		end
		case temp_tar_item.type
			when "Other","none","Baby","SurgeryCoupon","Key"
				$game_map .popup(0,"QuickMsg:Lona/NoUse",0,0)
				SndLib.sys_buzzer
				return
			when "Food","Medicine","FoodSemen","Waste","FoodBad"
				if temp_tar_item.consumable ==false
					$game_map.popup(0,"QuickMsg:Lona/NoUse",0,0)
					SndLib.sys_buzzer
					return
				else
					$game_map.popup(0,"#{$game_party.item_number(temp_tar_item)}-1",temp_tar_item.icon_index,-1)
					self.itemUseBatch(temp_tar_item)
					SndLib.sound_eat(100)
				end
				
			when "Trap"
				if $game_player.player_cuffed? || $game_player.actor.sta < 0
					SndLib.sys_buzzer
					$game_map.popup(0,"QuickMsg:Lona/cuffed1",0,0)
					return
				end
				temp_user_dir = $game_player.direction
				temp_user_x= $game_player.x
				temp_user_y= $game_player.y
				if $game_player.passable?(temp_user_x,temp_user_y,temp_user_dir)
					case temp_user_dir
						when 8;temp_x= 0; temp_y=-1
						when 2;temp_x= 0; temp_y=1
						when 4;temp_x=-1; temp_y=0
						when 6;temp_x= 1; temp_y=0
					end
					tmpData = {
							:user=>$game_player,
							:ItemName=>[temp_tar_item.item_name]
							}
					EvLib.sum(temp_tar_item.item_name,temp_user_x+temp_x,temp_user_y+temp_y,tmpData)
					$game_map.popup(0,"#{$game_party.item_number(temp_tar_item)}-1",temp_tar_item.icon_index,-1)
					$game_party.lose_item(temp_tar_item,1)
					SndLib.sound_Reload
				else # u cannot pass
					$game_map.popup(0,"QuickMsg:Lona/CannotPlaceHere#{rand(2)}",0,0)
					SndLib.sys_buzzer
					return
				end

			when "Armor"
				temp_etype_id = temp_tar_item.etype_id
				temp_current_armor = self.equips[temp_etype_id]
				 #p "asdasdasdasd #{$game_player.actor.common_equippable?(temp_tar_item)}"
				if self.equips[temp_etype_id] != nil 
					if (self.equips[temp_etype_id] && self.equips[temp_etype_id].type_tag == "Bondage") || !self.common_equippable?(temp_tar_item)
						SndLib.sys_buzzer
						$game_map.popup(0,"QuickMsg:Lona/SlotNotAllow",0,0)
						return
					end
				end
				SndLib.sound_equip_armor
				self.change_equip(temp_etype_id, temp_tar_item)
				if temp_current_armor
					@ext_items[action_slot] = temp_current_armor.item_name
				else
					@ext_items[action_slot] = nil
				end
				self.update_state_frames
				$game_player.update
				$game_player.refresh_chs
				$game_player.light_check

			when "Key"
				SndLib.sys_buzzer
				$game_map.popup(0,"QuickMsg:Lona/SlotNotAllow",0,0)

			when "Weapon","ArmorSH"
				temp_etype_id = temp_tar_item.etype_id
				tmpSuccess = false
				tmpBlockReport = self.report_reverse_equippable(temp_tar_item)
				if tmpBlockReport
					tmpUnequipList = []
					tmpBlockReport += self.report_reverse_unequip_by(temp_tar_item)
					tmpBlockReport = tmpBlockReport.uniq
					#p tmpBlockReport
					tmpBlockReport.each{|tmpEqpSlot|
						next if !tmpEqpSlot
						tmpUnequipList << self.equips[tmpEqpSlot]
						self.change_equip(tmpEqpSlot, nil)
					}
					didActionSlot = false
					tmpUnequipList.each{|tmpItem|
						next if !tmpItem
						#p tmpItem
						if !didActionSlot && !@ext_items.any?{|itemChk| next if itemChk.nil? ; ; $data_ItemName[itemChk] == tmpItem} #fix to item name because after load/save.  memory address is differnet.  item==item will be false
							if tmpItem
								@ext_items[action_slot] = tmpItem.item_name
							else
								@ext_items[action_slot] = nil
							end
							didActionSlot = true
							next
						end
						if !@ext_items.any?{|itemChk| next if itemChk.nil? ; $data_ItemName[itemChk] == tmpItem}#fix to item name because after load/save.  memory address is differnet.  item==item will be false
							index_of_nil = @ext_items.index(nil)
							if index_of_nil
								if tmpItem
									@ext_items[index_of_nil] = tmpItem.item_name
								else
									@ext_items[index_of_nil] = nil
								end
							end
						end
					}
					tmpSuccess = true
				end
				if tmpSuccess
					SndLib.sound_equip_armor
					self.change_equip(temp_etype_id, temp_tar_item)
					self.update_state_frames
					$game_player.update
					$game_player.refresh_chs
					$game_player.light_check
				else
					SndLib.sys_buzzer
					$game_map.popup(0,"QuickMsg:Lona/SlotNotAllow",0,0)
				end
			else
				$game_map.popup(0,"QuickMsg:Lona/NoUse",0,0)
				SndLib.sys_buzzer
				return
		end
	end
	
end #CLASS

