

#417個人化延伸批次
#主要為中斷器的新功能
module GIM_ADDON

	#todo , move those to date system.
	#todo select shadow mode based on weather+day night
	#todo strature bug,  map_background_color runs twice. in most weather model
	#todo  updated strature = weather_batch_r8_25_Swamp

	def select_weather(weights)
		total_weight = weights.values.sum { |data| data[:weight] }  # Суммируем веса
		roll = rand(total_weight)
		cumulative = 0
		#todo  global weather
		weights.each do |weather, data|
			cumulative += data[:weight]
			return weather if roll < cumulative
		end
	end
	def select_shadow_with_params(weights)
		total_weight = weights.inject(0) { |sum, (_, data)| sum + data[:weight] }
		roll = rand(total_weight)
		cumulative = 0
		#todo, if picked :rainy, block sunny, moonlit, fullmoon.
		weights.each do |shadow, data|
			cumulative += data[:weight]
			return shadow if roll < cumulative # Возвращаем только тип тени (ключ)
		end
	end
	def execute_weather(weather_weights,shadow_weights,bgs,bgm=nil,globalData=nil)
		current_time = $game_date.day? ? :day : :night
		selected_weather = select_weather(weather_weights[current_time])
		selected_bgs = bgs[selected_weather].sample if bgs
		selected_shadow_type = select_shadow_with_params(shadow_weights[current_time])

		$game_map.set_fog(weather_weights[current_time][selected_weather][:fog]) if weather_weights[current_time][selected_weather][:fog]
		$game_map.interpreter.weather(*weather_weights[current_time][selected_weather][:weather])
		$game_map.shadows.set_color(*shadow_weights[current_time][selected_shadow_type][:color])
		$game_map.shadows.set_opacity(shadow_weights[current_time][selected_shadow_type][:opacity])
		$game_map.interpreter.map_background_color(*shadow_weights[current_time][selected_shadow_type][:bgcolor])
		if bgs
			select_vol= nil
			select_pitch= nil
			source_vol = bgs[:data][0] if bgs[:data]
			source_pitch = bgs[:data][1] if bgs[:data]
			source_pos = bgs[:data][2] if bgs[:data]
			select_vol = source_vol ? source_vol : 80
			select_pitch = source_pitch ? source_pitch : 100
			select_pos = select_pos ? select_pos : 0
			SndLib.bgs_play(selected_bgs, select_vol, select_pitch, select_pos)
		else
			SndLib.bgs_stop
		end
		SndLib.bgm_stop #todo
	end

	########################################################################################################################################
	########################################################################################################################################
	########################################################################################################################################
	########################################################################################################################################
######################################################################################################################################## Normal weather
########################################################################################################################################

	def weather_batch_r1_PlainField
		weather_weights = {
			day: {
				day: {		weight: 65,		fog: nil,				weather: ["snow", 3, "greenDot", true]},
				rain: {		weight: 25,		fog: nil,				weather: ["rain", 40-8+rand(16), "Rain", false]},
				fog: {		weight: 15,		fog: "forestfog",		weather: ["snow", 3, "greenDot", true] }
			},
			night: {
				night: {	weight: 65,		fog: nil,				weather: ["snow", 3, "greenDot", true] },
				rain: {		weight: 25,		fog: nil,				weather: ["rain", 40-8+rand(16), "Rain", false]},
				fog: {		weight: 13,		fog: "forestfog",		weather: ["snow", 3, "greenDot", true] }
			}
		}
		shadow_weights = {
			day: {
				sunny: {	weight: 25,		color: [120, 130, 100],	opacity: 20,	bgcolor: [130, 120, 100, 125, 1] },
				cloudy: {	weight: 60,		color: [130, 140, 120],	opacity: 120,	bgcolor: [130, 140, 120, 30, 0] },
				rainy: {	weight: 35,		color: [100, 130, 90],	opacity: 80,	bgcolor: [110, 130, 100, 20, 0] }
				},
			night: {
				dark: {		weight: 70,		color: [10, 15, 20],	opacity: 205,	bgcolor: [30, 40, 35, 40, 0] },
				moonlit: {	weight: 35,		color: [50, 60, 70],	opacity: 200,	bgcolor: [40, 50, 60, 20, 0] },
				fullmoon: {	weight: 25,		color: [80, 90, 100],	opacity: 195,	bgcolor: [0, 110, 140, 80, 1] }
				}
			}
		bgs = { data: [80,100,nil],
			day: ["PlainFieldDay2", "PlainFieldDay3", "PlainFieldDay5", "PlainFieldDay6"],
			night: ["PlainFieldNight", "PlainFieldNight2", "PlainFieldNight3", "nightforest4", "nightforest5"],
			rain: ["rainforest", "PlainFieldRain", "rainforest3", "rainforest5"],
			fog: ["fogforest", "fogforest2"]
		}
		execute_weather(weather_weights,shadow_weights,bgs)
	end

########################################################################################################################################
########################################################################################################################################

	def weather_batch_r4_RainFroest
		weather_weights = {
			day: {
				day: {		weight: 65,		fog: nil,				weather: ["snow", 3, "greenDot", true]},
				rain: {		weight: 25,		fog: nil,				weather: ["rain", 30-8+rand(16), "Rain", false]},
				fog: {		weight: 5,		fog: "forestfog",		weather: ["snow", 3, "greenDot", true] }
			},
			night: {
				night: {	weight: 65,		fog: nil,				weather: ["snow", 3, "greenDot", true] },
				rain: {		weight: 25,		fog: nil,				weather: ["rain", 30-8+rand(16), "Rain", false]},
				fog: {		weight: 5,		fog: "forestfog",		weather: ["snow", 3, "greenDot", true] }
			}
		}
		shadow_weights = {
			day: {
				sunny: {	weight: 50,		color: [100, 180, 100],	opacity: 50,	bgcolor: [120, 100, 60, 100, 1]},
				cloudy: {	weight: 30,		color: [90, 140, 90],	opacity: 110,	bgcolor: [50, 90, 60, 100, 0]},
				rainy: {	weight: 20,		color: [80, 150, 80],	opacity: 70,	bgcolor: [125, 125, 125, 100, 0]}
			},
			night: {
				dark: 	{	weight: 70, 	color: [20, 40, 30],	opacity: 205,	bgcolor: [50, 90, 60, 100, 0] },
				moonlit: {	weight: 35, 	color: [90, 130, 120],	opacity: 200,	bgcolor: [50, 60, 120, 50, 1] },
				fullmoon: {	weight: 25, 	color: [130, 160, 140],	opacity: 195,	bgcolor: [50, 60, 120, 100, 1] }
			}
		}
		bgs = { data: [80,100,nil],
			day: ["jungleday", "jungleday2", "jungleday3", "jungleday4", "jungleday5"],
			night: ["junglenight2", "junglenight3", "junglenight4"],
			rain: ["rainforest", "rainforest3", "rainforest4", "rainforest5"],
			fog: ["fogforest", "fogforest2"]
		}
		execute_weather(weather_weights,shadow_weights,bgs)
	end

########################################################################################################################################
########################################################################################################################################

	def weather_batch_r5_forest
		weather_weights = {
			day: {
				day: {		weight: 65,	fog: nil,					weather: ["snow", 3, "greenDot", true]},
				rain: {		weight: 25,	fog: nil,					weather: ["rain", 35-15+rand(30), "Rain", false]},
				fog: {		weight: 15,	fog: "forestfog",			weather: ["snow", 3, "greenDot", true]},
			},
			night: {
				night: {	weight: 65,	fog: nil,					weather: ["snow", 3, "greenDot", true]},
				rain: {		weight: 25,	fog: nil,					weather: ["rain", 35-15+rand(30), "Rain", false]},
				fog: {		weight: 13,	fog: "forestfog",			weather: ["snow", 3, "greenDot", true]},
			}
		}
		shadow_weights = {
			day: {
				sunny: {	weight: 60,		color: [90, 150, 90],	opacity: 60,	bgcolor: [120, 100, 60, 100, 1]},
				cloudy: {	weight: 100,	color: [100, 100, 100],	opacity: 120,	bgcolor: [50, 90, 60, 60, 0]},
				rainy: {	weight: 35, 	color: [70, 120, 70],	opacity: 140,	bgcolor: [125, 125, 125, 100, 0]}
			},
			night: {
				dark: 	{	weight: 70, 	color: [80, 80, 60],	opacity: 205,	bgcolor: [50, 90, 60, 100, 0] },
				moonlit: {	weight: 35, 	color: [100, 110, 120],	opacity: 200,	bgcolor: [50, 60, 120, 50, 1] },
				fullmoon: {	weight: 25, 	color: [100, 110, 120],	opacity: 195,	bgcolor: [50, 60, 120, 100, 1] }
			}
		}
		bgs = { data: [80,100,nil],
			day: ["dayforest", "dayforest2", "dayforest3", "dayforest4", "dayforest5", "dayforest6"],
			night: ["nightforest", "nightforest2", "nightforest3", "nightforest4", "nightforest5"],
			rain: ["rainforest", "rainforest3", "rainforest4", "rainforest5"],
			fog: ["fogforest", "fogforest2"]
		}
		execute_weather(weather_weights,shadow_weights,bgs)
	end

########################################################################################################################################
########################################################################################################################################

	def weather_batch_r6_BadlandForest
		weather_weights = {
			day: {
				day: {		weight: 50,	fog: "infested_fall",		weather: ["snow", 20-8+rand(16), "redDot", true]},
				rain: {		weight: 50,	fog: "infested_fall_storm",	weather: ["rain", 50-13+rand(26), "redDot", true]},
				fog: {		weight: 20,	fog: nil,					weather: ["snow", 10+rand(6), "redDot", true]}
			},
			night: {
				night: {	weight: 75, fog: "infested_fall",		weather: ["snow", 20-8+rand(16), "redDot", true]},
				rain: {		weight: 75, fog: "infested_fall_storm", weather: ["rain", 60-13+rand(26), "redDot", true]},
				fog: {		weight: 15, fog: nil,					weather: ["snow", 20+rand(6), "redDot", true]}
			}
		}
		shadow_weights = {
			day: {
				sunny: {	weight: 40,		color: [120, 70, 70],	opacity: 100, bgcolor: [200, 40, 150, 80, 0] },
				cloudy: {	weight: 40,		color: [100, 50, 50],	opacity: 140, bgcolor: [200, 40, 150, 80, 0] },
				rainy: {	weight: 20,		color: [90, 40, 40],	opacity: 120, bgcolor: [200, 40, 150, 80, 0] }
			},
			night: {
				dark: {		weight: 80,		color: [30, 10, 10],	opacity: 200, bgcolor: [200, 40, 150, 80, 0] },
				moonlit: {	weight: 20,		color: [80, 40, 50],	opacity: 195, bgcolor: [200, 40, 150, 80, 0] },
				fullmoon: {	weight: 10,		color: [120, 60, 70],	opacity: 190, bgcolor: [200, 40, 150, 80, 0] }
			}
		}
		bgs = { data: [100,100,nil],
			day: ["AlienRumble", "BadlandForestSound", "BadlandForestSound2"],
			night: ["AlienRumble", "BadlandForestSound7", "BadlandForestSound8", "BadlandForestSound9", "BadlandForestSound10", "BadlandForestSound11", "BadlandForestSound12"],
			rain: ["BadlandForestStorm", "BadlandForestStorm2", "BadlandForestStorm3", "BadlandForestStorm4"],
			fog: ["AlienRumble", "BadlandForestSound13", "BadlandForestSound14", "BadlandForestSound", "BadlandForestSound2"]
		}
		execute_weather(weather_weights,shadow_weights,bgs)
	end

########################################################################################################################################
########################################################################################################################################

	def weather_batch_r7_PineFroestMountain
		weather_weights = {
			day: {
				day: {		weight: 30,	fog: nil,					weather: ["snow", 3+rand(3), "greenDot", true] },
				rain: {		weight: 10,	fog: nil,					weather: ["rain", 20+rand(10), "Rain", false] },
				snow: {		weight: 30,	fog: nil,					weather: ["snow", 30+rand(16), "WhiteDotBig",true] },
				blizzard: {	weight: 25,	fog: "mountain_storm",		weather: ["rain", 40+rand(16), "WhiteDotBig",true] },
				fog: {		weight: 5,	fog: "forestfog",			weather: ["snow", 3+rand(3), "greenDot", true] }
			},
			night: {
				night: {	weight: 40,	fog: nil,					weather: ["snow", 3+rand(3), "greenDot", true] },
				rain: {		weight: 10,	fog: nil,					weather: ["rain", 20+rand(10), "Rain", false] },
				snow: {		weight: 30,	fog: nil,					weather: ["snow", 25+rand(16), "WhiteDotBig",true] },
				blizzard: {	weight: 25,	fog: "mountain_storm",		weather: ["rain", 40+rand(16), "WhiteDotBig",true] },
				fog: {		weight: 5,	fog: "forestfog",			weather: ["snow", 3+rand(3), "greenDot", true] }
			}
		}
		shadow_weights = {
			day: {
				sunny: {	weight: 10,		color: [90, 110, 100],	opacity: 70,	bgcolor: [80, 100, 90, 100, 0] },
				cloudy: {	weight: 50,		color: [70, 80, 75],	opacity: 130,	bgcolor: [60, 70, 65, 100, 0] },
				rainy: {	weight: 30,		color: [50, 60, 55],	opacity: 90,	bgcolor: [40, 50, 45, 100, 0] },
				snowy: {	weight: 25,		color: [130, 150, 160],	opacity: 100,	bgcolor: [120, 140, 150, 100, 0] },
				blizzard: {	weight: 30,		color: [110, 130, 140],	opacity: 120,	bgcolor: [100, 120, 130, 100, 0] }
			},
			night: {
				dark: {		weight: 30,		color: [5, 10, 15],		opacity: 255,	bgcolor: [10, 20, 25, 100, 0] },
				moonlit: {	weight: 5,		color: [20, 30, 40],	opacity: 230,	bgcolor: [15, 25, 35, 100, 0] },
				fullmoon: {	weight: 5,		color: [40, 50, 60],	opacity: 200,	bgcolor: [30, 40, 50, 100, 0] },
				snowy: {	weight: 30,		color: [60, 70, 80],	opacity: 150,	bgcolor: [50, 60, 70, 100, 0] },
				blizzard: {	weight: 20,		color: [50, 60, 70],	opacity: 180,	bgcolor: [40, 50, 60, 100, 0] }
			}
		}

		bgs = { data: [100,100,nil],
			day: ["FroestMountainDay", "FroestMountainDay2", "FroestMountainDay3",  "PlainFieldDay5", "PlainFieldDay6"],
			night: ["FroestMountainNight", "FroestMountainNight", "FroestMountainNight", "nightforest4", "nightforest5"],
			rain: ["rainforest", "PlainFieldRain", "rainforest3", "rainforest5"],
			snow: ["FroestMountainDay", "FroestMountainDay2", "FroestMountainDay3", "PlainFieldDay5"],
			blizzard: ["FroestMountainSnowStorm", "FroestMountainSnowStorm2", "FroestMountainSnowStorm3", "FroestMountainSnowStorm4", "FroestMountainSnowStorm5"],
			fog: ["fogforest", "fogforest2"]
		}
		execute_weather(weather_weights,shadow_weights,bgs)
	end
########################################################################################################################################
########################################################################################################################################

	def weather_batch_r8_25_Swamp
		weather_weights = {
			day: {
				day: {		weight: 15,	fog: "mountainDown_slow",	weather: ["snow", 3, "greenDot", true]},
				rain: {		weight: 50,	fog: "mountainDown_slow",	weather: ["rain", 50-15+rand(30), "Rain", false]},
				fog: {		weight: 50,	fog: "forestfog",			weather: ["snow", 3, "greenDot", true]},
			},
			night: {
				night: {	weight: 15,	fog: "mountainDown_slow",	weather: ["snow", 3, "greenDot", true]},
				rain: {		weight: 50,	fog: "mountainDown_slow",	weather: ["rain", 50-15+rand(30), "Rain", false]},
				fog: {		weight: 50,	fog: "forestfog",			weather: ["snow", 3, "greenDot", true]},
			}
		}
		shadow_weights = {
			day: {
				sunny: {	weight: 40, color: [35, 80, 25],	opacity: 120, bgcolor: [90, 200, 150, 40, 0]},
				cloudy: {	weight: 70, color: [35, 80, 25],	opacity: 140, bgcolor: [90, 125, 100, 80, 0]},
				rainy: {	weight: 30, color: [35, 70, 25],	opacity: 150, bgcolor: [90, 125, 100, 90, 0]}
			},
			night: {
				dark: 	{	weight: 70, color: [50, 120, 40],	opacity: 255, bgcolor: [90, 200, 150, 50, 0] },
				moonlit: {	weight: 25, color: [50, 100, 60],	opacity: 230, bgcolor: [90, 150, 200, 40, 0] },
				fullmoon: {	weight: 15, color: [50, 120, 40],	opacity: 220, bgcolor: [90, 150, 200, 150, 1] }
			}
		}
		bgs = { data: [80,100,nil],
			day: ["dayswamp", "dayswamp2", "dayswamp3", "dayswamp4"],
			night: ["nightswamp", "nightswamp2", "nightforest3"],
			rain: ["rainforest", "rainforest3", "rainforest4", "rainforest5"],
			fog: ["fogforest", "fogforest2"]
		}
		execute_weather(weather_weights,shadow_weights,bgs)
	end

########################################################################################################################################
########################################################################################################################################

	def batch_weather_r15_26_Marsh
		weather_weights = {
			day: {
				day: {		weight: 10,	fog: "mountainDown_slow",	weather: ["snow", 3, "greenDot", true]},
				rain: {		weight: 35, fog: "mountainDown_slow",	weather: ["rain", 30-15+rand(30), "Rain", false]},
				fog: {		weight: 50,	fog: "forestfog",			weather: ["snow", 3, "greenDot", true]}
			},
			night: {
				night: {	weight: 15,	fog: "mountainDown_slow",	weather: ["snow", 3, "greenDot", true]},
				rain: {		weight: 30, fog: "mountainDown_slow",	weather: ["rain", 30-15+rand(30), "Rain", false]},
				fog: {		weight: 50,	fog: "forestfog",			weather: ["snow", 3, "greenDot", true]}
			}
		}
		shadow_weights = {
			day: {
				sunny: {	weight: 15, color: [80, 130, 70],	opacity: 120,	bgcolor: [80, 120, 90, 40, 0]},
				cloudy: {	weight: 60, color: [70, 120, 60],	opacity: 140,	bgcolor: [85, 110, 95, 50, 0]},
				rainy: {	weight: 50, color: [60, 110, 50],	opacity: 150,	bgcolor: [45, 60, 50, 70, 0]}
			},
			night: {
				dark: {		weight: 65, color: [30, 60, 40],	opacity: 225,	bgcolor: [70, 130, 90, 50, 0]},
				moonlit: {	weight: 30, color: [60, 80, 70],	opacity: 215,	bgcolor: [70, 130, 90, 50, 0]},
				fullmoon: {	weight: 20, color: [90, 110, 100],	opacity: 195,	bgcolor: [90, 90, 150, 110, 1]}
			}
		}
		bgs = { data: [80,100,nil],
			day: ["dayswamp", "dayswamp2", "dayswamp3", "dayswamp4"],
			night: ["nightswamp", "nightswamp2", "nightforest3"],
			rain: ["rainforest", "rainforest3", "rainforest4", "rainforest5"],
			fog: ["fogforest", "fogforest2"]
		}
		execute_weather(weather_weights,shadow_weights,bgs)
	end

########################################################################################################################################
########################################################################################################################################

	def weather_batch_r50_SnowMountain
		weather_weights = {
			day: {
				day: {		weight: 30,	fog: nil,					weather: ["snow", 3+rand(3), "WhiteDotBig",true] },
				snow: {		weight: 30,	fog: nil,					weather: ["snow", 30+rand(16), "WhiteDotBig",true] },
				blizzard: {	weight: 25,	fog: "mountain_storm",		weather: ["rain", 40+rand(16), "WhiteDotBig",true] },
				fog: {		weight: 5,	fog: "forestfog",			weather: ["snow", 3+rand(3), "WhiteDotBig",true] }
			},
			night: {
				night: {	weight: 40,	fog: nil,					weather: ["snow", 3+rand(3), "WhiteDotBig",true] },
				snow: {		weight: 30,	fog: nil,					weather: ["snow", 25+rand(16), "WhiteDotBig",true] },
				blizzard: {	weight: 25,	fog: "mountain_storm",		weather: ["rain", 40+rand(16), "WhiteDotBig",true] },
				fog: {		weight: 5,	fog: "forestfog",			weather: ["snow", 3+rand(3), "WhiteDotBig",true] }
			}
		}
		shadow_weights = {
			day: {
				sunny: {	weight: 10,	color: [90, 110, 100],	opacity: 70,	bgcolor: [80, 100, 90, 100, 1] },
				cloudy: {	weight: 50,	color: [70, 80, 75],	opacity: 130,	bgcolor: [60, 70, 65, 100, 0] },
				rainy: {	weight: 30,	color: [50, 60, 55],	opacity: 90,	bgcolor: [40, 50, 45, 100, 0] },
				snowy: {	weight: 25,	color: [130, 150, 160],	opacity: 100,	bgcolor: [120, 140, 150, 100, 0] },
				blizzard: {	weight: 30,	color: [110, 130, 140],	opacity: 120,	bgcolor: [100, 120, 130, 100, 0] }
			},
			night: {
				dark: {		weight: 30,	color: [5, 10, 15],		opacity: 205,	bgcolor: [10, 20, 25, 100, 0] },
				moonlit: {	weight: 5,	color: [20, 30, 40],	opacity: 190,	bgcolor: [15, 25, 85, 100, 1] },
				fullmoon: {	weight: 5,	color: [40, 50, 60],	opacity: 185,	bgcolor: [30, 40, 100, 120, 1] },
				snowy: {	weight: 30,	color: [60, 70, 80],	opacity: 190,	bgcolor: [50, 60, 70, 100, 0] },
				blizzard: {	weight: 20,	color: [50, 60, 70],	opacity: 205,	bgcolor: [40, 50, 60, 100, 0] }
				}
			}

		bgs = { data: [80,100,nil],
			day: ["FroestMountainDay", "FroestMountainDay2", "FroestMountainDay3"],
			night: ["FroestMountainNight", "FroestMountainNight", "FroestMountainNight"],
			snow: ["FroestMountainDay", "FroestMountainDay2", "FroestMountainDay3"],
			blizzard: ["FroestMountainSnowStorm", "FroestMountainSnowStorm2", "FroestMountainSnowStorm3", "FroestMountainSnowStorm4", "FroestMountainSnowStorm5"],
			fog: ["fogforest", "fogforest2"]
		}
		execute_weather(weather_weights,shadow_weights,bgs)
	end


########################################################################################################################################
######################################################################################################################################## BATCH
########################################################################################################################################
######################################################################################################################################## BATCH
########################################################################################################################################
######################################################################################################################################## BATCH

	def weather_batch_r6_SouthFL
		weather_weights = {
			day: {
				day: {		weight: 50,		fog: "infested_fall",		weather: ["snow", 20+rand(16), "redDot", true] },
				rain: {		weight: 50,		fog: "infested_fall_storm", weather: ["rain", 50+rand(26), "redDot", true] },
				fog: {		weight: 20,		fog: nil,					weather: ["snow", 10+rand(16), "redDot", true] }
			},
			night: {
				night: {	weight: 75,		fog: "infested_fall",		weather: ["snow", 20+rand(16), "redDot", true] },
				rain: {		weight: 75,		fog: "infested_fall_storm", weather: ["rain", 60+rand(26), "redDot", true] },
				fog: {		weight: 15,		fog: nil,					weather: ["snow", 20+rand(16), "redDot", true] }
			}
		}
		shadow_weights = {
			day: {
			sunny: {		weight: 40,		color: [120, 70, 70],	opacity: 100,	bgcolor:[200, 40, 150, 80, 0] },
			cloudy: {		weight: 40,		color: [100, 50, 50],	opacity: 140,	bgcolor:[200, 40, 150, 80, 0] },
			rainy: {		weight: 20,		color: [90, 40, 40],	opacity: 120,	bgcolor:[200, 40, 150, 80, 0] }
			},
			night: {
			dark: {			weight: 80,		color: [30, 10, 10],	opacity: 205,	bgcolor:[200, 40, 150, 80, 0] },
			moonlit: {		weight: 20,		color: [80, 40, 50],	opacity: 200,	bgcolor:[200, 40, 150, 80, 0] },
			fullmoon: {		weight: 10,		color: [120, 60, 70],	opacity: 195,	bgcolor:[200, 40, 150, 80, 0] }
			}
		}

		bgs = { data: [80,100,nil],
			day: ["AlienRumble", "BadlandForestSound", "BadlandForestSound2"],
			night: ["AlienRumble", "BadlandForestSound7", "BadlandForestSound8", "BadlandForestSound9", "BadlandForestSound10", "BadlandForestSound11", "BadlandForestSound12"],
			rain: ["BadlandForestStorm", "BadlandForestStorm2", "BadlandForestStorm3", "BadlandForestStorm4"],
			fog: ["AlienRumble", "BadlandForestSound13", "BadlandForestSound14", "BadlandForestSound", "BadlandForestSound2"]
		}
		execute_weather(weather_weights,shadow_weights,bgs)
	end
	########################################################################################################################################
	########################################################################################################################################

	def batch_weather_r6_SybFDgate
		weather_weights = {
		day: {
				day: {		weight: 50,		fog:"infested_fall",		weather: ["snow", 20+rand(16), "redDot", true] },
				rain: {		weight: 50,		fog:"infested_fall_storm",	weather: ["rain", 50+rand(26), "redDot", true] },
				fog: {		weight: 20,		fog:nil,					weather: ["snow", 10+rand(6), "redDot", true] }
			},
		night: {
				night: {	weight: 75,		fog:"infested_fall",		weather: ["snow", 20+rand(16), "redDot", true] },
				rain: {		weight: 75,		fog:"infested_fall_storm",	weather: ["rain", 60+rand(26), "redDot", true] },
				fog: {		weight: 15,		fog:nil,					weather: ["snow", 10+rand(6), "redDot", true] }
			}
		}
		shadow_weights = {
		day: {
				sunny: {	weight: 40,		color: [120, 70, 70],	opacity: 100,	bgcolor:[200, 40, 150, 80, 0] },
				cloudy: {	weight: 40,		color: [100, 50, 50],	opacity: 140,	bgcolor:[200, 40, 150, 80, 0] },
				rainy: {	weight: 20,		color: [90, 40, 40],	opacity: 120,	bgcolor:[200, 40, 150, 80, 0] }
			},
		night: {
				dark: {		weight: 80,		color: [30, 10, 10],	opacity: 205,	bgcolor:[200, 40, 150, 80, 0] },
				moonlit: {	weight: 20,		color: [80, 40, 50],	opacity: 200,	bgcolor:[100, 40, 150, 80, 1] },
				fullmoon: {	weight: 10,		color: [120, 60, 70],	opacity: 195,	bgcolor:[100, 40, 150, 120, 1] }
			}
		}
		bgs = { data: [100,100,nil],
			day: ["forest_wind"],
			night: ["forest_wind"],
			rain: ["forest_wind"],
			fog: ["forest_wind"]
		}
		execute_weather(weather_weights,shadow_weights,bgs)
	end
	########################################################################################################################################
	########################################################################################################################################
end #module

