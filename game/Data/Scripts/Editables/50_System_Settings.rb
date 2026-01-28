
#專門用來存放遊戲系統相關參數的位置，不准寫任何方法，也不應被引用到任何class中。
#遊戲系統相關參數請參照各自的class
module System_Settings
	GAME_DIR_INPUT_DELAY=6
	GAME_DIR_INPUT_DELAY_DASH=4   #GAME_DIR_INPUT_DELAY - GAME_DIR_INPUT_DELAY_DASH = x

	#MESSAGE_WINDOW_FONT_NAME = ["Noto Sans CJK TC Regular"]
	#MESSAGE_WINDOW_FONT_NAME = Font.default_name = ["Noto Sans CJK TC Black"]
	#MESSAGE_WINDOW_FONT_NAME = Font.default_name = [DataManager.get_font_name]
	MESSAGE_WINDOW_FONT_NAME = [DataManager.get_font_name]
	MESSAGE_STR2_LANG=["CHT","KOR","JPN"]
	MESSAGE_ORIGINAL_Y_TOP = (Graphics.height * 0.0556).to_i #20  #對話框正常狀況下的Y值
	MESSAGE_ORIGINAL_Y_MID = (Graphics.height * 0.4167).to_i #150  #對話框正常狀況下的Y值
	MESSAGE_ORIGINAL_Y_BOT = (Graphics.height * 0.7417).to_i #267  #對話框正常狀況下的Y值
	MESSAGE_ORIGINAL_Y_BOARD = (Graphics.height * 0.1111).to_i #公告模式下的Y值
	MESSAGE_WINDOW_WIDTH = 310 #對話框的寬度
	MESSAGE_WINDOW_HEIGHT = 80 #對話框的高度
	MESSAGE_WINDOW_WIDTH_DIM = Graphics.width #640 #對話框的寬度
	MESSAGE_WINDOW_TONE = [0.000000, -136.000000, -187.000000, 0.000000]
	MESSAGE_WINDOW_VISIBLE_LINES=3 #對話框可見行數
	MESSAGE_HIDE_Y = 999  #對話框隱藏狀況下的Y值
	MESSAGE_WINDOW_FONT_BOLD    = false   # Default bold?  ##BUGGED 為何進了ACE MESSAGE 會得到相反的結果？ FALSE >TRUE  TRUE >> FALSE
	MESSAGE_WINDOW_FONT_ITALIC  = false    # Default italic?
	MESSAGE_WINDOW_FONT_OUTLINE = true   # Default outline?
	MESSAGE_WINDOW_FONT_SHADOW  = true    # Default shadow?
	MESSAGE_NARRATOR_X = 35
	MESSAGE_SKIP_FRAME = 15#ctrl SKIP RATE(FRAME)
	MESSAGE_SOUND_CLOSENESS  = 4    # sound play between characters
	MESSAGE_SOUND_CLOSENESS_SHOWFAST  = 12    # sound play between characters when @show_fast
	MESSAGE_STD_LINE_HEIGHT = 18
	MESSAGE_STD_PADDING = 12
	MOD_UI_TOP_MENU_HEIGHT = 16 * 2 + 20

	#module FONT_NAME	# System_Settings::FONT_SIZE::FONT_SIZE
	#	SCENE_TITLE = System_Settings::MESSAGE_WINDOW_FONT_NAME
	#	SCENE_CREDIT = System_Settings::MESSAGE_WINDOW_FONT_NAME
	#end
	module FONT_SIZE	# System_Settings::FONT_SIZE::SCENE_INPUT_OPTIONS
		MESSAGE_WINDOW = MESSAGE_STR2_LANG.include?($lang) ? 18 : 16 #if chink,  larger,  if white pigs, smaller
		OPTION_WINDOW = 26  #Window_ChoiceList
		EVENT_GUI_TITLE_LARGE = 30 # EventLib
		EVENT_GUI_TITLE_MEDIAN = 20 #EventLib
		#LOAD_SCREEN_CURRENT_STAGE = 12 #start screen, loading
		#LOAD_SCREEN_DEV_MODE = 14 #start screen, loading
		WINDOW_FILE_SAVE_SLOT = 22 #Save file eg file1 .. 2.. 3
		WINDOW_FILE_PLAYTIME = 16
		WINDOW_FILE_DATE = 16
		WINDOW_FILE_LVL = 16
		WINDOW_FILE_VER_INFO = 16
		WINDOW_FILE_TITLE = 16
		WINDOW_FILE_ACTOR_STATS_INFO = 16
		WINDOW_FILE_VER_OUTDATED = 34

		CONSOLE_INPUT = 20 #f10 console input window
		CONSOLE_OUTPUT = 12 #f10 console output window

		SCENE_CREDIT_END = 50
		SCENE_CREDIT_BASIC = 24
		SCENE_CREDIT_SWITCH = 8
		SCENE_CREDIT_MAX = 64

		SCENE_TITLE_VER_INFO = 14 #include gamepad and ver
		SCENE_TITLE_RESET_WARNING = 20
		SCENE_TITLE_OPTIONS = 24
		SCENE_TITLE_OPTIONS_TITLE = 38
		SCENE_INPUT_OPTIONS = 22

		SCENE_REBIRTH_TITLE = 38
		SCENE_REBIRTH_OPTIONS = 24
		SCENE_REBIRTH_EXP_WARNING = 20
		SCENE_REBIRTH_EXP_COST = 20

		SCENE_ACH_NUM = 24
		SCENE_ACH_NAME = 20
		SCENE_ACH_DESP = 14
		SCENE_ACH_TITLE = 38
		SCENE_ACH_CURRENT_VAL = 28

		SCENE_STORAGE_HELP = 16

		SCENE_MOD_LIST = 14
	end 
	module Gameplay
		DODGE_2_TITLE_REQ = 18
	end
	module Console
		HISTORY_CAP = 10
	end
	


	#OVERMAP
	FOW_VISI_RANGE   = 3   				# Visibility range of the character. Larger value, longer distance
	FOW_VISI_RANGE_DAY   = 3   				# Visibility range of the character. Larger value, longer distance
	FOW_VISI_RANGE_NIGHT   = 2   				# Visibility range of the character. Larger value, longer distance
	FOW_FOG_OPACITY = 125				# Fog opacity. Set 255 for full opacity.
	FOW_FOG_OPACITY_FULL = 255				# Unused
	FOW_DEFAULT_FOG	= false			## If set to true, every map will has fog. Unless you put <no fog>  ## If set to false, every map will has no fog. Unless you put <fog>
	STORAGE_BANK = 65533
	STORAGE_TEMP = 65534
	STORAGE_HORSE_CARRY = 65535
	STORAGE_PLAYER_POT = 65536
	STORAGE_TEMP_MAP = 65537 #use for rape loop boxs "def dungeon_ChestLoot"

	DOOM_SAVE_SLOT = 999

	NON_THREATEN_COUNT = 60

	CONSOLE_MAX_RECORD = 20

	MAP_BG_RED = 125
	MAP_BG_GREEN = 60
	MAP_BG_BLUE =255
	MAP_BG_OPACITY =18
	MAP_BG_BLEND =1
	PORTRAIT_AUTO_HIDE_SEC = 1 #portrait自動隱藏的秒數，單位sec
	TEMP_CG_X=168
	TEMP_CG_Y=74
	NAP_FADEIN=10 #nap時的fadein時間，單位frame
	NAP_FADEOUT=10 #nap時的fadein時間，單位frame
	KHAS_Light_Folder= "Lights"
	KHAS_Disable_STD_Shadows=true
	KHAS_Enable_Shadows=false
	KHAS_GS_File="Graphics Settings.cfg"

	KUL_SETTINGS= {
		:static_shadows 	=>"OFF",
		:dynamic_shadows 	=>"OFF",
		:soft_shadows 		=>"OFF",
		:light_size 		=>100 ,
		:light_opacity 		=>"ON",
		:fog 				=>"ON"
	}
	#


	LONA_PORTRAIT_CANVAS_SETTING={
								#export to Game_Actor.init_statMap
								#all Default XY for CHCG MUST fit to TopRight by cam, and the result must got x+1 and y-1
								#canvasX,canvasY,DefaultX,DefaultY
									#MOVED TO JSON#################
								}



	SCENE_AchievementPopup_Z	= 2080
	#SCENE_Menu_Mouseparticle_Z	= 2071
	SCENE_Menu_CursorMouse_Z	= 2070
	SCENE_Menu_Cursor_Z			= 2060
	SCENE_PORTRAIT_MENU_Z		= 2050
	SCENE_Menu_Contents_Z		= 2040
	SCENE_Menu_Gauge_Z			= 2030
	SCENE_Menu_Command_Z		= 2020
	SCENE_Menu_ContentBase_Z	= 2010
	SCENE_CREDIT_TEXT_Z			= 2005
	SCENE_BASE_Z				= 2000

	#UI
	NUMBER_INPUT_Z			= 1410
	COMPANION_UI_Z			= 1400
	TMER_ON_FIRE_Z			= 1310
	OPT_CONFRIM_LIST_Z_TEXT	= 1300
	OPT_CONFRIM_LIST_Z		= 1290
	OPT_CONFRIM_ARROW_Z		= 1285
	OPT_CONFRIM_BACK_Z		= 1280
	TITLE_COMMAND_WINDOW_Z	= 1270
	TITLE_FOREGROUND_Z		= 1260
	TITLE_BACKGROUND2		= 1250
	TITLE_BACKGROUND1		= 1240
	LOAD_SCREEN_Z			= 1230
	MESSAGE_WINDOW_Z		= 1220
	NARRATOR_MODE_Z			= 1210
	TEMP_CG_Z_CHCG			= 1200
	PORTRAIT_CHCG_Z			= 1180
	TEMP_CG_Z_STD			= 1170
	TEMP_BG_Z_CHCG			= 1160
	TEMP_BG_Z_STD			= 1150
	MAP_VP4_Z				= 1145	#5 = flash_screen3
	CHCG_BACKGROUND_Z		= 1140
	GLAV_POPUP_Z			= 1130
	TIMER_ON_FIRE_Z			= 1125

	#HUD
	MAP_HUD_Z				= 1120
	PORTRAIT_MAP_Z			= 1115
	DB_POPUP_UI_Z			= 1110
	MOUSE_GRID_ON_MAP_Z		= 1105
	MAP_BALLOON_Z			= 1100

	#MAP
	WEATHER_SCREEN_Z_HIGH	= 1090
	MAP_BACKGROUND_COLOR_Z 	= 1080
	KHAS_SHADOW_Z			= 1070
	KHAS_FOG_Z				= 1060
	WEATHER_SCREEN_Z		= 1050
	DB_POPUP_PARTICLE_Z 	= 1040
	#MAP_VP4_Z				= 150	#4 = fog and light flash_screen2.
	MAP_VP3_Z				= 100	#3 = brightness part of tone.
	MAP_VP2_Z				= 50	#2 = flash1_screen1.
	MAP_VP1_Z				= 0		#1 = event/characters in map.
	MAP_PARALLAX_Z			= -100

	FIRST_PREV_MENSES_CYCLE	=[0	,0,0,4,4,4,4,4,4,4,0,0,0,0,2,0,0,0] #遊戲中玩家的第-1個月經週期 #SAFE_DAY=0 MENSES_DAY=2 OVUL_DAY=4
	FIRST_PREV_STATUS_LOG	=[:fine,:fine,:fine,:fine,:fine,:fine,:ovul,:fine,:fine,:fine,:fine,:fine,:fine,:menses,:bad,:fine,:fine,:fine] #遊戲中玩家的第-1個月的狀況記錄
	FIRST_MENSES_CYCLE=	[0,0,0,4,4,4,4,4,4,4,0,0,0,0,2,0,0,0] #遊戲中玩家的第一個月經週期 #SAFE_DAY=0 MENSES_DAY=2 OVUL_DAY=4
	FIRST_PREG_RATE=		[0,0,0,0,0,0,0,0,0,0,0.15,0.3,0.4,0.6,0.8,0.6,0.4,0.2] #遊戲中玩家的第一個週期中的懷孕機率
	MENSES_START_DAY=2 #玩家在遊戲開始時在月經週期上的位置，從1開始計算

	#module EQUIP     acient ruin.  moved to _sys_term/data.json
	#	# This hash adjusts the new equip types (past 4+). Adjust them to match
	#	# their names properly. You can choose to allow certain types of equipment
	#	# be removable or not, or whether or not optimize will affect them.
    #
	#	## moved to $data_system.equip_type , $data_system.equip_type_name
	#	#WEAPON_SLOTS = [0,1]
	#	#TYPES ={
	#	#	# TypeID => ["Type Name",	Removable?,		Optimize?	CombatDroppable?],
	#	#	0 => [		"MH",			true,			true,		true], #MH
	#	#	1 => [		"SH",			true,			true,		true], #SH
	#	#	2 => [		"Top",			true,			true,		true],
	#	#	3 => [		"Mid",			true,			true,		true],
	#	#	4 => [		"Bot",			true,			true,		true],
	#	#	5 => [		"TopExt",		true,			true,		true],#TopExtra
	#	#	6 => [		"MidExt",		true,			true,		true],#MidExtra
	#	#	7 => [		"Hair",			true,			true,		false],
	#	#	8 => [		"Head",			true,			true,		true],#mask tattoo glass hat etc
	#	#	9 => [		"EXT1",			true,			true,		false], #ext item1
	#	#	10=> [		"EXT2",			true,			true,		false], #ext item2
	#	#	11=> [		"EXT3",			true,			true,		false], #ext item3
	#	#	12=> [		"EXT4",			true,			true,		false], #ext item4
	#	#	13=> [		"EXT5",			true,			true,		false], #ext item5
	#	#	14=> [		"Neck",			true,			true,		false], #acc2 basicly neck, collar
	#	#	15=> [		"Vag",			true,			true,		true], #dildo, drug packget, panty
	#	#	16=> [		"Anal",			true,			true,		true], #dildo, drug packget, panty
	#	#	17=> [		"Unused1",		true,			true,		false], #
	#	#	18=> [		"Face",			true,			true,		false], #Glasses FacePaint
	#	#	19=> [		"Unused2",		true,			true,		false] #
	#	#}
	#	## a reverse with name as key  will report key, ID only
	#	#TYPES_NAME = TYPES.map { |id, (name, removable, optimize)| [name, id] }.to_h
    #
	#	LONA_STARTING_EQUIP = {
	#		"NoerNormal"=> ["ItemAdvTop", "ItemAdvMid", "ItemAdvBot", "ItemAdvMidExtra", "ItemHairTwinBraid","ItemShLantern","ItemMhWoodenClub","ItemPantyVag"]
	#	}
    #
	#	#actor layer upload flow
	#	LONA_GEAR = ["equip_head","equip_TopExtra","equip_hair","equip_Top","equip_MidExtra","equip_Mid","equip_Bot","SecondArm","MainArm"]
	#	#LONA_GEAR = ["equip_TopExtra","MainArm","WhateverEquipMayAffectStatmap"]
	#end # EQUIP
end

###NEW GAME SETTING
module GIM_ADDON
	def new_game_setting
		change_map_story_stats_fix
		$story_stats["OverMapID"] =2
		$story_stats["OverMapEvent_name"] =0
		$story_stats["OverMapEvent_saw"] =0
		$story_stats["OverMapEvent_enemy"] =0
		$story_stats["OverMapStepEncounterUnknow"] = 2000
		$story_stats["OverMapStepEncounterBad"] = 1000
		$story_stats["StartOverMapX"]=32	#初始OVERMAP XY 複寫
		$story_stats["StartOverMapY"]=96	#初始OVERMAP XY 複寫
		$story_stats["LastOverMapX"]= $story_stats["StartOverMapX"]
		$story_stats["LastOverMapY"]= $story_stats["StartOverMapY"]
		$story_stats["OnRegionMap_Regid"] = 21

		$story_stats["RegionMap_RegionOuta"] = 0
		$story_stats["RegionMap_RegionInsa"] = 0
		$story_stats["RapeLoop"] = 0
		$story_stats["Captured"] = 0
		$story_stats["OnRegionMap"] =0
		$story_stats["OnRegionMapSpawnRace"] = 0
		$story_stats["Record_CapturedPregCheckPassed"] = 0
		$story_stats["CapturedStatic"] = 0
		$story_stats["LimitedNeedsSkill"] = 0
		$story_stats["LimitedNapSkill"] = 0
		$story_stats["Ending_MainCharacter"] = 0
		$story_stats["Ending_Noer"] = "Ending_Noer_DestroyedByOrkind"
		$story_stats["RapeLoopTorture"] = 0
		$story_stats["Setup_ScatEffect"] = 0
		$story_stats["Setup_UrineEffect"] = 0
		$story_stats["ReRollHalfEvents"] = 1
		$story_stats["Setup_Hardcore"] = 0
		$story_stats["CharacterItems"] = Hash.new
		$story_stats["CharacterSteal"] = Hash.new
		$story_stats["HostageSaved"] = Hash.new(0)
		$story_stats["BG_EFX_data"] = []

		###################################################DialogSetting
		$story_stats["dialog_death"]			=1
		$story_stats["dialog_vag_virgin"]		=1
		$story_stats["dialog_anal_virgin"]		=1
		#$story_stats["dialog_mouth_virgin"]	=1	#unused
		$story_stats["dialog_cumflation"]		=1
		#$story_stats["dialog_frist_kiss"]		=1	#unused
		#$story_stats["dialog_hunger"]			=1	#unused
		$story_stats["dialog_babie_feeding"]	=0
		$story_stats["dialog_sta"]				=1
		$story_stats["dialog_sat"]				=0
		$story_stats["dialog_wet"]				=1
		$story_stats["dialog_cuff"]				=1
		$story_stats["dialog_collar"]			=1
		$story_stats["dialog_cuff_equiped"]		=1
		$story_stats["dialog_collar_equiped"]	=1
		$story_stats["dialog_baby_lost"]		=0
		$story_stats["dialog_dress_out"]		=1
		$story_stats["dialog_preg_exped"]		=0
		$story_stats["dialog_ready_to_birth"]	=0
		$story_stats["dialog_cumflation_heal"]	=0
		$story_stats["dialog_defecate"]			=0
		$story_stats["dialog_defecated"]		=1
		$story_stats["dialog_urinary"]			=0
		$story_stats["dialog_overweight"]		=1
		$story_stats["dialog_lactation"]		=1
		$story_stats["dialog_sick"]				=1
		$story_stats["dialog_drug_addiction"]	=1
		$story_stats["dialog_semen_addiction"]	=1
		$story_stats["dialog_ograsm_addiction"]	=1
		#$story_stats["dialog_auto_nap"]		=1 ## unused
		$story_stats["dialog_moon_worm_hit"]	=1
		$story_stats["dialog_pot_worm_hit"]		=1
		$story_stats["dialog_HookWorm_hit"]		=1
		$story_stats["dialog_PolypWorm_hit"]	=1
		$story_stats["dialog_parasited"]		=1

		################################################### record setting



		$game_system.add_mail("Tutorial_MainControl")
		$game_system.add_mail("Tutorial_MainStats")
		$game_system.add_mail("Tutorial_GamePad")
		$game_system.add_mail("TextLog1")
		$game_system.add_mail("TextLog3")
		#$game_system.add_mail("Tutorial_SexService")
		#$game_system.add_mail("Tutorial_BattleSex")

		if $TEST
			new_game_GetDebugSkills
			$story_stats["Setup_UrineEffect"] = 1
			$story_stats["Setup_ScatEffect"] = 1
			$story_stats["Setup_Hardcore"] = 1
			$story_stats["Setup_HardcoreAmt"] = [1772,3,2]
		end

		$story_stats["RecQuestConvoyTarget"] = []

		$story_stats.init_basic_data

		$game_party.gain_item($data_items[20], 3)
		$game_party.gain_item($data_items[104], 1)
		$game_party.gain_item($data_ItemName["Item2MhBareHand"], 1)

		$hudForceHide = false
		$balloonForceHide = false
	end
	def new_game_SetFetishLevel
		$story_stats["Setup_UrineEffect"] == 1 ?	$game_player.actor.fetishPeePee(true) : $game_player.actor.fetishPeePee(false)
		$story_stats["Setup_ScatEffect"] == 1 ?		$game_player.actor.fetishPooPoo(true) : $game_player.actor.fetishPooPoo(false)
		$story_stats["Setup_Hardcore"] >= 1 ?		$game_player.actor.fetishHardcore(true) : $game_player.actor.fetishHardcore(false)
	end
	def new_game_GetDebugSkills
			$game_player.actor.learn_skill("DebugPrintChar") #104
			$game_player.actor.learn_skill("BasicDance") #105
			$game_player.setup_SkillRoster(tmpRoster=0,"DebugPrintChar",:slot_hotkey_4) #104
			$game_player.setup_SkillRoster(tmpRoster=0,"BasicDance",:slot_hotkey_3) #105
	end
	def new_game_learn_skills
		$game_player.actor.learn_skill("BasicNormal") #1
		$game_player.actor.learn_skill("BasicHeavy")  #2
		$game_player.actor.learn_skill("BasicControl") #3
		$game_player.actor.learn_skill("BasicNap") #50
		$game_player.actor.learn_skill("BasicSlipped") #51
		$game_player.actor.learn_skill("BasicNeeds") #BasicNeeds
		$game_player.actor.learn_skill("BasicSubmit") #BasicSubmit
		$game_player.actor.learn_skill("BasicSetDarkPot") #BasicSetDarkPot
		$game_player.actor.learn_skill("BasicThrow") #BasicThrow
		$game_player.actor.learn_skill("BasicQuickExt1") #BasicQuickExt1
		$game_player.actor.learn_skill("BasicQuickExt2") #BasicQuickExt2
		$game_player.actor.learn_skill("BasicQuickExt3") #BasicQuickExt3
		$game_player.actor.learn_skill("BasicQuickExt4") #BasicQuickExt4
		$game_player.actor.learn_skill("BasicQuickExt5") #BasicQuickExt5
		$game_player.actor.learn_skill("BasicAssemblyCall") #BasicAssemblyCall
		$game_player.actor.learn_skill("BasicSteal") #BasicSteal
		$game_player.actor.learn_skill("BasicDodge") #BasicDodge
	end
	def new_game_record_hotkey
		$skill_roster_rec = {
			:slot_RosterCurrent       => $game_player.slot_RosterCurrent,
			:slot_RosterArray         => $game_player.slot_RosterArray,
			:slot_skill_normal        => $game_player.slot_skill_normal,
			:slot_skill_heavy         => $game_player.slot_skill_heavy,
			:slot_skill_control       => $game_player.slot_skill_control,
			:slot_hotkey_0            => $game_player.slot_hotkey_0,
			:slot_hotkey_1            => $game_player.slot_hotkey_1,
			:slot_hotkey_2            => $game_player.slot_hotkey_2,
			:slot_hotkey_3            => $game_player.slot_hotkey_3,
			:slot_hotkey_4            => $game_player.slot_hotkey_4,
			:slot_hotkey_other        => $game_player.slot_hotkey_other
		}
	end
	def new_game_setup
		##$game_player.slot_hotkey_other = 22 #BasicThrow
		##$game_player.slot_hotkey_1 = 50 #BasicNap
		new_game_learn_skills
		if $skill_roster_rec
			$game_player.slot_RosterCurrent  = $skill_roster_rec[:slot_RosterCurrent]
			$game_player.slot_RosterArray    = $skill_roster_rec[:slot_RosterArray]
			$game_player.slot_skill_normal   = $skill_roster_rec[:slot_skill_normal]
			$game_player.slot_skill_heavy    = $skill_roster_rec[:slot_skill_heavy]
			$game_player.slot_skill_control  = $skill_roster_rec[:slot_skill_control]
			$game_player.slot_hotkey_0       = $skill_roster_rec[:slot_hotkey_0]
			$game_player.slot_hotkey_1       = $skill_roster_rec[:slot_hotkey_1]
			$game_player.slot_hotkey_2       = $skill_roster_rec[:slot_hotkey_2]
			$game_player.slot_hotkey_3       = $skill_roster_rec[:slot_hotkey_3]
			$game_player.slot_hotkey_4       = $skill_roster_rec[:slot_hotkey_4]
			$game_player.slot_hotkey_other   = $skill_roster_rec[:slot_hotkey_other]
			$skill_roster_rec = nil
		else
			$game_player.setup_SkillRoster(tmpRoster=0,22,:slot_hotkey_other) #BasicThrow
			$game_player.setup_SkillRoster(tmpRoster=0,50,:slot_hotkey_1) #BasicNap
			$game_player.setup_SkillRoster(tmpRoster=0,70,:slot_hotkey_0) #BasicDodge
		end
	end


end

