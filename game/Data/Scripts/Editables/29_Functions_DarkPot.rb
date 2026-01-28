
class Game_Interpreter
=begin
	def darkPot_ArecaNut(tmpList,tmpGetItemList)
			if $game_player.actor.survival_trait >= 15 && tmpList["ArecaNut"] >=2 && tmpList["HerbSta"] >=1
				tmpNut = tmpList["ArecaNut"] / 2
				tmpStaHerb = tmpList["HerbSta"]
				result = ([tmpNut,tmpStaHerb].min).round
				tmpGetItemList["ItemNoerTea"] += result
				tmpList["HerbSta"] -= result
				tmpList["ArecaNut"] -= result*2
				tmpList["Plant"] -= ((result*2)*0.5).to_i
				tmpList["Plant"] = 0 if tmpList["Plant"] < 0
			end
		[tmpList,tmpGetItemList]
	end
	def darkPot_MergeMeatDifference(tmpList,tmpGetItemList)
			if tmpList["HumanMysticMeat"] >= 1 || (tmpList["HumanMeat"] >= 1 && tmpList["MysticMeat"] >=1)
				tmpList["HumanMysticMeat"] += tmpList["HumanMeat"]+tmpList["MysticMeat"]
				tmpList["HumanMeat"] = 0
				tmpList["MysticMeat"] = 0
			end
		[tmpList,tmpGetItemList]
	end
	def darkPot_Medcines(tmpList,tmpGetItemList)

			if $game_player.actor.survival_trait >= 15 && tmpList["HerbSta"] >=2
				result = (tmpList["HerbSta"] / 2).round
				tmpGetItemList["ItemBluePotion"] += result
				tmpList["HerbSta"] -= result*2
			end
			if $game_player.actor.survival_trait >= 15 && tmpList["HerbCure"] >=2
				result = (tmpList["HerbCure"] / 2).round
				tmpGetItemList["ItemRedPotion"] += result
				tmpList["HerbCure"] -= result*2
			end
			if $game_player.actor.survival_trait >= 15 && tmpList["HerbContraceptive"] >=2
				result = (tmpList["HerbContraceptive"] / 2).round
				tmpGetItemList["ItemContraceptivePills"] = result
				tmpList["HerbContraceptive"] -= result*2
			end
			if $game_player.actor.survival_trait >= 15 && tmpList["HerbRepellents"] >=4
				result = (tmpList["HerbRepellents"] / 4).round
				tmpGetItemList["ItemRepellents"] += result
				tmpList["HerbRepellents"] -= result*4
			end

			if $game_player.actor.survival_trait >= 15 && tmpList["HerbHi"] >=4 && tmpList["RedPotion"] >= 1
				tmpHerb = tmpList["HerbHi"] / 2 #24
				tmpPotion = tmpList["RedPotion"]
				result = ([tmpHerb,tmpList["RedPotion"]].min).round
				tmpGetItemList["ItemHiPotionLV2"] += result
				tmpList["RedPotion"] -= result
				tmpList["HerbHi"]-= result * 4
			end
		[tmpList,tmpGetItemList]
	end
	def darkPot_MeatAndSoups(tmpList,tmpGetItemList)

			##############################################################################################################################  FOOD

			################################################## junkFood
			if tmpList["Plant"] >=1 && tmpList["Starch"] >=1 && tmpList["Oil"] >= 1
				result_JunkFood = ([tmpList["Plant"],tmpList["Starch"]].min).round
				tmpList["Plant"] -= result_JunkFood
				tmpList["Starch"] -= result_JunkFood
				tmpList["Oil"] -= 1
				tmpGetItemList["ItemJunkFood"] += result_JunkFood*3
			end
			################################################################ Food GOOD SOUP
			if tmpList["Plant"] >= 1 && tmpList["Meat"] >= 1 && tmpList["Wood"] < 1
				result_good_soup_Mystic = 0
				result_good_soup_hum = 0
				result_good_soup_hum_Mystic = 0
				result_good_soup = 0
				if tmpList["HumanMysticMeat"] >= 1
					result_good_soup_hum_Mystic = ([tmpList["Plant"],tmpList["HumanMysticMeat"]].min).round
					tmpGetItemList["ItemSopGoodHumanMystery"] += result_good_soup_hum_Mystic
				elsif tmpList["HumanMeat"] >= 1
					result_good_soup_hum = ([tmpList["Plant"],tmpList["Meat"]].min).round
					tmpGetItemList["ItemSopGoodHuman"] += result_good_soup_hum
				elsif tmpList["MysticMeat"] >=1
					result_good_soup_Mystic = ([tmpList["Plant"],tmpList["Meat"]].min).round
					tmpGetItemList["ItemSopGoodMystery"] += result_good_soup_Mystic
				else
					result_good_soup = ([tmpList["Plant"],tmpList["Meat"]].min).round
					tmpGetItemList["ItemSopGood"] += result_good_soup
				end
				tmpTotal = result_good_soup+result_good_soup_Mystic+result_good_soup_hum+result_good_soup_hum_Mystic
				tmpList["Meat"] -= tmpTotal
				tmpList["Plant"] -= tmpTotal
			end

			################################################################# Food dry food
			if $game_player.actor.survival_trait >= 10 && tmpList["Plant"] >=2 && tmpList["Wood"] >= 1
				result = (tmpList["Plant"] / 2).round
				tmpGetItemList["ItemDryFood"] += result
				tmpList["Plant"] -= result*2
			end

			################################################################# Food dry meat
			if $game_player.actor.survival_trait >= 10 && tmpList["Meat"] >= 2 && tmpList["Wood"] >= 1
				result_HumSmokedMeat = 0
				result_MysticSmokedMeat = 0
				result_HumMysticSmokedMeat = 0
				result_SmokedMeat = 0
				if tmpList["HumanMysticMeat"] >= 1
					result_HumMysticSmokedMeat = (tmpList["Meat"] / 2).round
					tmpGetItemList["ItemSmokedMeatHumanMystery"] += result_HumMysticSmokedMeat
				elsif tmpList["HumanMeat"] >= 1
					result_HumSmokedMeat = (tmpList["Meat"] / 2).round
					tmpGetItemList["ItemSmokedMeatHuman"] += result_HumSmokedMeat
				elsif tmpList["MysticMeat"] >=1
					result_MysticSmokedMeat = (tmpList["Meat"] / 2).round
					tmpGetItemList["ItemSmokedMeatMystery"] += result_MysticSmokedMeat
				else
					result_SmokedMeat = (tmpList["Meat"] / 2).round
					tmpGetItemList["ItemSmokedMeat"] += result_SmokedMeat
				end
				tmpTotal = result_HumSmokedMeat+result_MysticSmokedMeat+result_SmokedMeat+result_HumMysticSmokedMeat
				tmpList["Meat"] -= (tmpTotal*2).round
			end
			#
			################################################################# Food Plant soup
			if tmpList["Plant"] >=2
				result = (tmpList["Plant"] / 2).round
				tmpGetItemList["ItemSopPlant"] += result
				tmpList["Plant"] -= result*2
			end

			################################################################# food meat soup
			if tmpList["Meat"] >= 2
				result_HumanMeat = 0
				result_MysticMeat = 0
				result_HumanMysticMeat = 0
				result_meat_soup = 0
				if tmpList["HumanMysticMeat"] >= 1
					result_HumanMysticMeat = (tmpList["Meat"] / 2).round
					tmpGetItemList["ItemSopMeatHumanMystery"] += result_HumanMysticMeat
				elsif tmpList["HumanMeat"] >= 1
					result_HumanMeat = (tmpList["Meat"] / 2).round
					tmpGetItemList["ItemSopMeatHuman"] += result_HumanMeat
				elsif tmpList["MysticMeat"] >=1
					result_MysticMeat = (tmpList["Meat"] / 2).round
					tmpGetItemList["ItemSopMeatMystery"] += result_MysticMeat
				else
					result_meat_soup = (tmpList["Meat"] / 2).round
					tmpGetItemList["ItemSopMeat"] += result_meat_soup
				end
				tmpTotal = result_HumanMeat+result_MysticMeat+result_meat_soup+result_HumanMysticMeat
				tmpList["Meat"] -= (tmpTotal*2).round
			end
		[tmpList,tmpGetItemList]
	end
	def darkPot_ToolsAndOthers(tmpList,tmpGetItemList)
			#################################################################################################################################  TOOLs and other
			################################################################# Oil to FlameBottle
			if $game_player.actor.survival_trait >= 5 && tmpList["Oil"] >=6
				result = tmpList["Oil"] / 6
				tmpGetItemList["ItemFlameBottle"] += result
				tmpList["Oil"] -= result*6
			end

			################################################################# CookedMeat to Oil
			if tmpList["Fat"] >= 1
				result = tmpList["Fat"]
				tmpGetItemList["ItemOil"] += result.round
				tmpList["Fat"] -= result
			end

			################################################################# semen to ItemDryProtein
			if tmpList["Protein"] >=2
				result = (tmpList["Protein"] / 2).round
				tmpGetItemList["ItemDryProtein"] += result
				tmpList["Protein"] -= result*2
			end

			################################################################# milk to Cheese
			if $game_player.actor.survival_trait >= 20 && tmpList["Milk"] >= 3
				result = (tmpList["Milk"]/3).round
				tmpGetItemList["ItemCheese"] += result
				tmpList["Milk"] -= result * 3
			end
		[tmpList,tmpGetItemList]
	end
	def darkPot_Bombs(tmpList,tmpGetItemList)

			################################################################# Frag Bomb
			if $game_player.actor.survival_trait >= 10 && tmpList["Wood"] >= 1 && tmpList["Saltpeter"] >= 2 && tmpList["Carbon"] >= 2
				tmpMaterial1 = tmpList["Saltpeter"]/2
				tmpMaterial2 = tmpList["Carbon"]/2
				result = ([tmpMaterial1,tmpMaterial2].min).round
				result = [result,tmpList["Wood"]].min
				tmpGetItemList["ItemBombFragPasstive"] += result
				tmpList["Wood"] -= result
				tmpList["Saltpeter"] -= result*2
				tmpList["Carbon"] -= result*2
			end

			################## Timer bomb
			if $game_player.actor.survival_trait >= 10 && tmpList["BombFragPasstive"] >= 1 && tmpList["Cloth"] >= 1
				result = [tmpList["BombFragPasstive"],tmpList["Cloth"]].min
				tmpGetItemList["ItemBombFragTimer"] += result
				tmpList["ItemBombFragTimer"] -= result
				tmpList["Cloth"] -= result
			end

			################## trigger bomb
			if $game_player.actor.survival_trait >= 10 && tmpList["BombFragTimer"] >= 1 && tmpList["Cloth"] >= 1
				result = [tmpList["BombFragTimer"],tmpList["Cloth"]].min
				tmpGetItemList["ItemBombFragTrigger"] += result
				tmpList["BombFragTimer"] -= result
				tmpList["Cloth"] -= result
			end

			################################################################# Smoke Bomb
			if $game_player.actor.survival_trait >= 10 && tmpList["Wood"] >= 1 && tmpList["Phosphorus"] >= 1 && tmpList["Carbon"] >= 1
				result=[tmpList["Wood"],tmpList["Phosphorus"],tmpList["Carbon"]].min
				tmpGetItemList["ItemBombShockPasstive"] += result
				tmpList["Wood"] -= result
				tmpList["Phosphorus"] -= result
				tmpList["Carbon"] -= result
			end

			################## Timer Smoke
			if $game_player.actor.survival_trait >= 10 && tmpList["BombShockPasstive"] >= 1 && tmpList["Cloth"] >= 1
				result = [tmpList["BombShockPasstive"],tmpList["Cloth"]].min
				tmpGetItemList["ItemBombShockTimer"] += result
				tmpList["BombShockPasstive"] -= result
				tmpList["Cloth"] -= result
			end

			################## trigger Smoke
			if $game_player.actor.survival_trait >= 10 && tmpList["BombShockTimer"] >= 1 && tmpList["Cloth"] >= 1
				result = [tmpList["BombShockTimer"],tmpList["Cloth"]].min
				tmpGetItemList["ItemBombShockTrigger"] += result
				tmpList["BombShockTimer"] -= result
				tmpList["Cloth"] -= result
			end
		[tmpList,tmpGetItemList]
	end

	########################################################################################### unique food recipes
	def darkPot_UniqueFoodFormula(tmpList,tmpGetItemList) ### todo
		withBadMeat = tmpList.any?{|hashID,data| # to check if any bad meat
			hashID.include?("MysticMeat") || hashID.include?("HumanMeat")
		}
		################ #ItemMeatSalad
		if !withBadMeat && tmpList["SmokedMeat"] >= 1 && tmpList["Plant"] >= 4 && tmpList["Fruit"] >= 2 && tmpList["Vegetable"] >= 2 && tmpList["Oil"] >= 1 && tmpList["Fat"] >= 2 && $game_player.actor.survival_trait >= 10
			result = [tmpList["SmokedMeat"],tmpList["Plant"]/4,tmpList["Fruit"]/2,tmpList["Vegetable"]/2,tmpList["Oil"],tmpList["Fat"]].min
			tmpList["SmokedMeat"] -= result
			tmpList["Plant"] -= result*4
			tmpList["Fruit"] -= result*2
			tmpList["Vegetable"] -= result*2
			tmpList["Oil"] -= result
			tmpList["Fat"] -= result*2 #smoke meat
			tmpGetItemList["ItemMeatSalad"] += result
		end
		#if !withBadMeat && tmpList["Meat"] >= 2
		#end
		[tmpList,tmpGetItemList]
	end
	#todo
	#Starch new item
	#######ItemMeatSalad new item
	#MeatHerbSoup new item
	#Starch+Oil > JunkFood
	#JunkFood > add mood
	########################################################################################### Final result, set item to 0
	def darkPot_FinalResult(tmpList,tmpGetItemList)
			################################################################# WOOD TO CARBON
			if tmpList["Wood"] >= 1
				tmpGetItemList["ItemCarbon"] += tmpList["Wood"]
				tmpList["Wood"] = 0
			end

			################################################################# Carbon to Phosphorus
			if $game_player.actor.survival_trait >= 10 && tmpList["Pee"] >= 1
				tmpGetItemList["ItemPhosphorus"] += tmpList["Pee"]
				tmpList["Pee"] = 0
			end

			################################################################# poo to Saltpeter
			if $game_player.actor.survival_trait >= 10 && tmpList["Poo"] >= 1
				tmpGetItemList["ItemSaltpeter"] += tmpList["Poo"]
				tmpList["Poo"] = 0
			end
		[tmpList,tmpGetItemList]
	end
=end

	def darkPot_translate_recipe(recipe, tmpList, tmpGetItemList)
		export_name = recipe["export_name"] || "UnnamedRecipe"
		puts "==> Processing Recipe: #{export_name}"
		puts "  [Before] tmpList: #{tmpList}"

		# Check excludeIngredients
		exclude = recipe.dig("conditions", "excludeIngredients") || []
		if exclude.any? { |bad_ing| tmpList[bad_ing].to_f > 0 }
			puts "  Skipped due to excludeIngredients"
			return [tmpList, tmpGetItemList]
		end

		# Check bannedItem
		dangerous = recipe["bannedItem"] || {}
		if dangerous.any? { |key, _| tmpList[key].to_f > 0 }
			puts "  Skipped due to bannedItem"
			return [tmpList, tmpGetItemList]
		end

		# Check MinStatReq
		min_req = recipe.dig("conditions", "MinStatReq") || {}
		min_req.each do |expr, min_val|
			begin
				player_val = eval(expr)
			rescue StandardError => e
				puts "  Eval error on MinStatReq expression '#{expr}': #{e}"
				return [tmpList, tmpGetItemList]
			end
			if player_val < min_val
				puts "  Skipped due to MinStatReq: #{expr} < #{min_val}"
				return [tmpList, tmpGetItemList]
			end
		end

		# Check requirements
		requirements = recipe["requirements"] || {}
		requirements.each do |item, qty|
			if tmpList[item].to_f < qty
				puts "  Skipped due to insufficient #{item}"
				return [tmpList, tmpGetItemList]
			end
		end

		# Custom boolean condition
		custom_condition = recipe.dig("conditions", "customCondition")
		if custom_condition
			begin
				eval_str = custom_condition.dup
				tmpList.each { |k, v| eval_str.gsub!(/\b#{k}\b/, v.to_s) }
				unless eval(eval_str)
					puts "  Skipped due to customCondition eval == false"
					return [tmpList, tmpGetItemList]
				end
			rescue StandardError => e
				puts "  Custom condition eval error: #{e}"
				return [tmpList, tmpGetItemList]
			end
		end

		# Calculate max output quantity
		#max_outputs = requirements.map do |item, qty|
		#	available = tmpList[item].to_f
		#	qty.to_f > 0 ? (available / qty.to_f) : Float::INFINITY
		#end
		#max_output_quantity = max_outputs.min.floor
		post_deducts = (recipe["postProcess"] || {}).select { |_, op| op =~ /^-=/ }

		# fallback if no postProcess, use requirements (for safety)
		target_keys = post_deducts.empty? ? requirements : post_deducts

		max_outputs = target_keys.map do |item, operation_or_qty|
			available = tmpList[item].to_f

			# if postProcess, extract the required quantity using eval
			if operation_or_qty.is_a?(String) && operation_or_qty =~ /^-=\s*(.+)$/
				begin
					expr = $1.dup
					expr.gsub!(/\bmax_output_quantity\b/, "1")  # assume 1 cycle for unit cost
					tmpList.each { |k, v| expr.gsub!(/\b#{k}\b/, v.to_s) }
					cost = eval(expr).to_f
					cost = 1.0 if cost <= 0
				rescue => e
					puts "  Eval error in postProcess deduction check: #{e}"
					cost = 1.0
				end
			else
				cost = operation_or_qty.to_f  # fallback or from requirements
				cost = 1.0 if cost <= 0
			end
			cost > 0 ? (available / cost) : Float::INFINITY
		end

		max_output_quantity = max_outputs.min.floor

		if max_output_quantity <= 0
			puts "  Skipped due to zero max_output_quantity"
			return [tmpList, tmpGetItemList]
		end

		# Clone before deduction for formula parsing
		originalList = tmpList.clone

		# Deduct consumed ingredients
		if recipe["postProcess"]
			# Deduct only ingredients with '-=' operation in postProcess
			recipe["postProcess"].each do |item, operation|
				next if item == "__clearAll__"
				if operation =~ /^-=\s*(.+)$/
						expr = operation.dup
					expr.gsub!(/\bmax_output_quantity\b/, max_output_quantity.to_s)
					tmpList.each { |k, v| expr.gsub!(/\b#{k}\b/, v.to_s) }
					begin
						qty_to_deduct = eval(expr[2..-1]).to_f
					rescue => e
						puts "  PostProcess deduction eval error for #{item}: #{e}"
						qty_to_deduct = 0.0
					end
					tmpList[item] ||= 0.0
					tmpList[item] -= qty_to_deduct
					tmpList[item] = 0.0 if tmpList[item] < 0
				end
			end
		else
			# Fallback: deduct all requirements if no postProcess
			requirements.each do |item, qty|
				tmpList[item] ||= 0.0
				tmpList[item] -= (qty.to_f * max_output_quantity)
				tmpList[item] = 0.0 if tmpList[item] < 0
			end
		end

		produced_something = false

		# Generate output
		if recipe["output"]
			recipe["output"].each do |output_item, details|
				tmpGetItemList[output_item] ||= 0
				if details["quantity"].is_a?(String)
					begin
						formula = details["quantity"].dup
						originalList.each { |k, v| formula.gsub!(/\b#{k}\b/, v.to_s) }
						formula.gsub!(/\bmax_output_quantity\b/, max_output_quantity.to_s)
						result_qty = eval(formula).to_i
						if result_qty > 0
							tmpGetItemList[output_item] += result_qty
							produced_something = true
						end
					rescue => e
						puts "  Output quantity eval failed for #{output_item}: #{e}"
					end
				else
					tmpGetItemList[output_item] += max_output_quantity
					produced_something = true if max_output_quantity > 0
				end
			end
		end

			# Handle postProcess (other than deduction)
			if recipe["postProcess"]
				if !produced_something && recipe["postProcess"].key?("__clearAll__")
					begin
						expr = recipe["postProcess"]["__clearAll__"]
						eval(expr) if expr.is_a?(String)
					rescue => e
						puts "  ClearAll postProcess eval error: #{e}"
					end
					tmpList.clear
					tmpGetItemList.clear
					return [tmpList, tmpGetItemList]
				end

				recipe["postProcess"].each do |item, operation|
					next if item == "__clearAll__" # Skip deduction handled above
					next if operation =~ /^-=\s*(.+)$/
					begin
						expr = operation.dup
						expr.gsub!(/\bmax_output_quantity\b/, max_output_quantity.to_s)
						tmpList.each { |k, v| expr.gsub!(/\b#{k}\b/, v.to_s) }
						p "lgkjsdgflkjsdlfgjskldfgk #{expr}"
						case expr
							when /^\+=\s*(.+)$/
								delta = eval($1).to_f
								tmpList[item] = (tmpList[item] || 0.0) + delta
							when /^=\s*(.+)$/
								value = eval($1).to_f
								tmpList[item] = value
							else
								puts "  Unrecognized postProcess operation format: #{operation}"
						end
					rescue => e
						puts "  PostProcess error for #{item}: #{e}"
					end
				end
			end
		puts "  [After] tmpList: #{tmpList}"
		puts "==> Finished Recipe: #{export_name}"
		puts
		[tmpList, tmpGetItemList]
	end



	def darkPot_LetsCook(tmpList,tmpGetItemList)
		$data_AlchemyRecipes.each do |recipe|
			tmpList, tmpGetItemList = darkPot_translate_recipe(recipe, tmpList, tmpGetItemList)
		end
		#tmpList,tmpGetItemList = darkPot_UniqueFoodFormula(tmpList,tmpGetItemList)
		#tmpList,tmpGetItemList = darkPot_ArecaNut(tmpList,tmpGetItemList)
		#tmpList,tmpGetItemList = darkPot_MergeMeatDifference(tmpList,tmpGetItemList)
		#tmpList,tmpGetItemList = darkPot_Medcines(tmpList,tmpGetItemList)
		#tmpList,tmpGetItemList = darkPot_MeatAndSoups(tmpList,tmpGetItemList)
		#tmpList,tmpGetItemList = darkPot_ToolsAndOthers(tmpList,tmpGetItemList)
		#tmpList,tmpGetItemList = darkPot_Bombs(tmpList,tmpGetItemList)
		#tmpList,tmpGetItemList = darkPot_FinalResult(tmpList,tmpGetItemList)
		[tmpList,tmpGetItemList]
	end

end 

