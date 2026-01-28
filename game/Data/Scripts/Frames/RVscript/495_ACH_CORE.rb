

############################################################################################################################################################
#useage for 417
module GabeSDK
	AchievementsData={
		#:ach_id						=>[stat,														TriggerVal,hidden],		,3folder,4title,5desp
		:DoneTutorial					=>[DataManager.get_constant("ACH","DoneTutorial",1)						,1,false		,nil,nil,nil],
		:DedTutorial					=>[DataManager.get_constant("ACH","DedTutorial",1)						,1,true			,nil,nil,nil],
		:GameOver						=>[DataManager.get_constant("ACH","GameOver",1)							,1,false		,nil,nil,nil],
		:ArtAllBuy						=>[DataManager.get_constant("ACH","ArtAllBuy",1)						,1,true			,nil,nil,nil],
		:ArtHopeless					=>[DataManager.get_constant("ACH","ArtHopeless",1)						,1,true			,nil,nil,nil],
		:ArtThinking					=>[DataManager.get_constant("ACH","ArtThinking",1)						,1,true			,nil,nil,nil],
		:ArtThisIsFine					=>[DataManager.get_constant("ACH","ArtThisIsFine",1)					,1,true			,nil,nil,nil],
		:ArtChadVsVirgin				=>[DataManager.get_constant("ACH","ArtChadVsVirgin",1)					,1,true			,nil,nil,nil],
		:ArtDontShit					=>[DataManager.get_constant("ACH","ArtDontShit",1)						,1,true			,nil,nil,nil],
		:ArtGodEmperor					=>[DataManager.get_constant("ACH","ArtGodEmperor",1)					,1,true			,nil,nil,nil],
		:ArtSeaWitch					=>[DataManager.get_constant("ACH","ArtSeaWitch",1)						,1,true			,nil,nil,nil],
		:ArtTankMan						=>[DataManager.get_constant("ACH","ArtTankMan",1)						,1,true			,nil,nil,nil],
		:Artlous2						=>[DataManager.get_constant("ACH","Artlous2",1)							,1,true			,nil,nil,nil],
		:ArtBlack						=>[DataManager.get_constant("ACH","ArtBlack",1)							,1,true			,nil,nil,nil],
		:ArtPlague						=>[DataManager.get_constant("ACH","ArtPlague",1)						,1,true			,nil,nil,nil],
		:ArtFHK_pepe					=>[DataManager.get_constant("ACH","ArtFHK_pepe",1)						,1,true			,nil,nil,nil],
		:GuildCompletedScoutCampOrkind_3=>[DataManager.get_constant("ACH","GuildCompletedScoutCampOrkind_3",1)	,1,false		,nil,nil,nil],
		:SavedScoutCampOrkind_1			=>[DataManager.get_constant("ACH","SavedScoutCampOrkind_1",1)			,1,false		,nil,nil,nil],
		:RecQuestC130_2					=>[DataManager.get_constant("ACH","RecQuestC130_2",1)					,1,false		,nil,nil,nil],
		:RecQuestLisa_5					=>[DataManager.get_constant("ACH","RecQuestLisa_5",1)					,1,true			,nil,nil,nil],
		:RecQuestLisa_10				=>[DataManager.get_constant("ACH","RecQuestLisa_10",1)					,1,false		,nil,nil,nil],
		:RecQuestLisaSaintCall_0		=>[DataManager.get_constant("ACH","RecQuestLisaSaintCall_0",1)			,1,false		,nil,nil,nil],
		:Rebirth						=>[DataManager.get_constant("ACH","Rebirth",1)							,1,false		,nil,nil,nil],
		:Kill1Hive						=>[DataManager.get_constant("ACH","Kill1Hive",1)						,1,false		,nil,nil,nil],
		:RecQuestBC2_SideQu_0			=>[DataManager.get_constant("ACH","RecQuestBC2_SideQu_0",1)				,1,false		,nil,nil,nil],
		:Ending20G						=>[DataManager.get_constant("ACH","Ending20G",1)						,1,false		,nil,nil,nil],
		:BankTP_T1						=>[DataManager.get_constant("ACH","BankTP_T1",64)						,20000,false	,nil,nil,nil],
		:BankTP_T2						=>[DataManager.get_constant("ACH","BankTP_T2",64)						,200000,false	,nil,nil,nil],
		:BankTP_T3						=>[DataManager.get_constant("ACH","BankTP_T3",64)						,800000,false	,nil,nil,nil],
		:BankTP_T4						=>[DataManager.get_constant("ACH","BankTP_T4",64)						,2400000,true	,nil,nil,nil],
		:KillTheBaby					=>[DataManager.get_constant("ACH","KillTheBaby",1)						,1,true			,nil,nil,nil],
		:EliseAbortion_T1				=>[DataManager.get_constant("ACH","EliseAbortion_T1",64)				,1,false		,nil,nil,nil],
		:EliseAbortion_T2				=>[DataManager.get_constant("ACH","EliseAbortion_T2",64)				,3,true			,nil,nil,nil],
		:EliseAbortion_T3				=>[DataManager.get_constant("ACH","EliseAbortion_T3",64)				,5,true			,nil,nil,nil],
		:EliseAbortion_T4				=>[DataManager.get_constant("ACH","EliseAbortion_T4",64)				,7,true			,nil,nil,nil],
		:UniqueCharUniqueCocona_n1		=>[DataManager.get_constant("ACH","UniqueCharUniqueCocona_n1",1)		,1,false		,nil,nil,nil],
		:RecQuestCocona_5				=>[DataManager.get_constant("ACH","RecQuestCocona_5",1)					,1,true			,nil,nil,nil],
		:RecQuestCocona_28				=>[DataManager.get_constant("ACH","RecQuestCocona_28",1)				,1,true			,nil,nil,nil],
		:RecCoconaHeadPat				=>[DataManager.get_constant("ACH","RecCoconaHeadPat",64)				,6,true			,nil,nil,nil],
		:RecCoconaBath					=>[DataManager.get_constant("ACH","RecCoconaBath",64)					,6,true			,nil,nil,nil],
		:RecCoconaSleep					=>[DataManager.get_constant("ACH","RecCoconaSleep",64)					,6,true			,nil,nil,nil],
		:DefeatSpawnPoolWithoutDedOne	=>[DataManager.get_constant("ACH","DefeatSpawnPoolWithoutDedOne",1)		,1,false		,nil,nil,nil],
		:DefeatBossMama					=>[DataManager.get_constant("ACH","DefeatBossMama",1)					,1,false		,nil,nil,nil],
		:DefeatHorseCock				=>[DataManager.get_constant("ACH","DefeatHorseCock",1)					,1,false		,nil,nil,nil],
		:DefeatOrkindWarboss			=>[DataManager.get_constant("ACH","DefeatOrkindWarboss",1)				,1,false		,nil,nil,nil],
		:DefeatOrkindWarbossSTA			=>[DataManager.get_constant("ACH","DefeatOrkindWarbossSTA",1)			,1,true			,nil,nil,nil],
		:QuProgSaveCecily_6				=>[DataManager.get_constant("ACH","QuProgSaveCecily_6",1)				,1,false		,nil,nil,nil],
		:RecQuestMilo_12				=>[DataManager.get_constant("ACH","RecQuestMilo_12",1)					,1,true			,nil,nil,nil],
		:QuProgSaveCecily_12			=>[DataManager.get_constant("ACH","QuProgSaveCecily_12",1)				,1,true			,nil,nil,nil],
		:QuProgSaveCecily_21			=>[DataManager.get_constant("ACH","QuProgSaveCecily_21",1)				,1,true			,nil,nil,nil],
		:RecQuestElise_5				=>[DataManager.get_constant("ACH","RecQuestElise_5",1)					,1,false		,nil,nil,nil],
		:RecQuestElise_18				=>[DataManager.get_constant("ACH","RecQuestElise_18",1)					,1,true			,nil,nil,nil],
		:RecQuest_Df_TellerSide_4		=>[DataManager.get_constant("ACH","RecQuest_Df_TellerSide_4",1)			,1,true			,nil,nil,nil],
		:RecQuestBoardSwordCave_1		=>[DataManager.get_constant("ACH","RecQuestBoardSwordCave_1",1)			,1,false		,nil,nil,nil],
		:RecQuestHostageReturnT1		=>[DataManager.get_constant("ACH","RecQuestHostageReturnT1",64)			,1,false		,nil,nil,nil],
		:RecQuestHostageReturnT2		=>[DataManager.get_constant("ACH","RecQuestHostageReturnT2",64)			,10,false		,nil,nil,nil],
		:RecQuestHostageReturnT3		=>[DataManager.get_constant("ACH","RecQuestHostageReturnT3",64)			,20,false		,nil,nil,nil],
		:HellModDateT1					=>[DataManager.get_constant("ACH","HellModDateT1",1)					,1,false		,nil,nil,nil],
		:HellModDateT2					=>[DataManager.get_constant("ACH","HellModDateT2",1)					,1,false		,nil,nil,nil],
		:HellModDateT3					=>[DataManager.get_constant("ACH","HellModDateT3",1)					,1,false		,nil,nil,nil],
		:DoomModDateT1					=>[DataManager.get_constant("ACH","DoomModDateT1",1)					,1,false		,nil,nil,nil],
		:DoomModDateT2					=>[DataManager.get_constant("ACH","DoomModDateT2",1)					,1,false		,nil,nil,nil],
		:DoomModDateT3					=>[DataManager.get_constant("ACH","DoomModDateT3",1)					,1,false		,nil,nil,nil],
		:record_giveup_hardcore			=>[DataManager.get_constant("ACH","record_giveup_hardcore",1)			,1,true			,nil,nil,nil],
		:record_vaginal_count_0			=>[DataManager.get_constant("ACH","record_vaginal_count_0",1)			,1,true			,nil,nil,nil],
		:ArenaWin						=>[DataManager.get_constant("ACH","ArenaWin",1)							,1,false		,nil,nil,nil],
		:ArenaSexBeastKilled			=>[DataManager.get_constant("ACH","ArenaSexBeastKilled",1)				,1,false		,nil,nil,nil],
		:RecQuestAdam_6					=>[DataManager.get_constant("ACH","RecQuestAdam_6",1)					,1,false		,nil,nil,nil],
		:RecQuestSeaWitch_4				=>[DataManager.get_constant("ACH","RecQuestSeaWitch_4",1)				,1,false		,nil,nil,nil],
		:RecQuestSeaWitch_5				=>[DataManager.get_constant("ACH","RecQuestSeaWitch_5",1)				,1,false		,nil,nil,nil],
		:AbomLona						=>[DataManager.get_constant("ACH","AbomLona",1)							,1,false		,nil,nil,nil],
		:TrueDeepone					=>[DataManager.get_constant("ACH","TrueDeepone",1)						,1,false		,nil,nil,nil],
		:SnowflakeFragged				=>[DataManager.get_constant("ACH","SnowflakeFragged",1)					,1,false		,nil,nil,nil],
		:SMRefugeeCampCBT				=>[DataManager.get_constant("ACH","SMRefugeeCampCBT",1)					,1,false		,nil,nil,nil]
	}
	
	def self.GetACHlist
		AchievementsData
	end
	def self.GetACHinfo(ach_id)
		ach_idSYM = ach_id.to_sym
		AchievementsData[ach_idSYM]
	end
	
	def self.getAchievement(ach_id)
		ach_idSYM = ach_id.to_sym
		return if !AchievementsData[ach_idSYM]
		return if AchievementsData[ach_idSYM][0] >= AchievementsData[ach_idSYM][1]
		AchievementsData[ach_idSYM][0] = AchievementsData[ach_idSYM][1]
		DataManager.write_constant("ACH",ach_id,AchievementsData[ach_idSYM][1])
		tmpName = AchievementsData[ach_idSYM][4] ? AchievementsData[ach_idSYM][4] : $game_text["DataACH:#{ach_id}/item_name"]
		SceneManager.scene.achievementGet(tmpAchName=tmpName,tmpIcon=ach_id)
	end
	
	def self.removeAchievement(ach_id)
		ach_idSYM = ach_id.to_sym
		return if !AchievementsData[ach_idSYM]
		AchievementsData[ach_idSYM][0] = 0
		DataManager.write_constant("ACH",ach_id,0)
	end
	
	def self.AchievementDone(ach_id)
		ach_idSYM = ach_id.to_sym
		return false if !AchievementsData[ach_idSYM]
		AchievementsData[ach_idSYM][0] >= AchievementsData[ach_idSYM][1]
	end
	
	
	#make tar stat = val 
	#if no max_val then no popup unless unlocked
	def self.setAchievementStat(ach_id,val)
		ach_idSYM = ach_id.to_sym
		p val
		return if !AchievementsData[ach_idSYM]
		return if AchievementsData[ach_idSYM][0] >= AchievementsData[ach_idSYM][1]
		return if val < AchievementsData[ach_idSYM][0]
		max_val = AchievementsData[ach_idSYM][1]
		tmpName = AchievementsData[ach_idSYM][4] ? AchievementsData[ach_idSYM][4] : $game_text["DataACH:#{ach_id}/item_name"]
		AchievementsData[ach_idSYM][0] = val
		DataManager.write_constant("ACH",ach_id,AchievementsData[ach_idSYM][0])
		if AchievementsData[ach_idSYM][0] >= AchievementsData[ach_idSYM][1]
			SceneManager.scene.achievementGet(tmpAchName=tmpName,tmpIcon=ach_id)
		else
			SceneManager.scene.achievementSetStat("#{val} / #{max_val}")
		end
	end
	def self.reset
		AchievementsData.each{|tmpACH|
			DataManager.write_constant("ACH",tmpACH[0].to_s,0)
			AchievementsData[tmpACH[0]][0] = 0
		}
	end
	
end

############################################################################################################################################################
# useage on Interpreter
module GIM_ADDON
	def achCheckBankTP
		wait(1)
		tmpTier1ID = "BankTP_T1"
		tmpTier2ID = "BankTP_T2"
		tmpTier3ID = "BankTP_T3"
		tmpTier4ID = "BankTP_T4"
		tmpVal = $game_boxes.get_price(System_Settings::STORAGE_BANK)
		if !GabeSDK.AchievementDone(tmpTier1ID)
			GabeSDK.setAchievementStat(tmpTier1ID,tmpVal)
		elsif !GabeSDK.AchievementDone(tmpTier2ID)
			GabeSDK.setAchievementStat(tmpTier2ID,tmpVal)
		elsif !GabeSDK.AchievementDone(tmpTier3ID)
			GabeSDK.setAchievementStat(tmpTier3ID,tmpVal)
		elsif !GabeSDK.AchievementDone(tmpTier4ID)
			GabeSDK.setAchievementStat(tmpTier4ID,tmpVal)
		end
	end
	
	def achCheckVictim
		tmpTier1ID = "RecQuestHostageReturnT1"
		tmpTier2ID = "RecQuestHostageReturnT2"
		tmpTier3ID = "RecQuestHostageReturnT3"
		tmpVal = $story_stats["RecQuestHostageReturned"]
		if !GabeSDK.AchievementDone(tmpTier1ID)
			GabeSDK.setAchievementStat(tmpTier1ID,tmpVal)
		elsif !GabeSDK.AchievementDone(tmpTier2ID)
			GabeSDK.setAchievementStat(tmpTier2ID,tmpVal)
		elsif !GabeSDK.AchievementDone(tmpTier3ID)
			GabeSDK.setAchievementStat(tmpTier3ID,tmpVal)
		end
	end
	
	def achCheckEliseAbortion
		tmpTier1ID = "EliseAbortion_T1"
		tmpTier2ID = "EliseAbortion_T2"
		tmpTier3ID = "EliseAbortion_T3"
		tmpTier4ID = "EliseAbortion_T4"
		tmpVal = $story_stats["RecQuestEliseAbortion"]
		if !GabeSDK.AchievementDone(tmpTier1ID)
			#p "asdasdasdasd1"
			#GabeSDK.getAchievement(tmpTier1ID) if $story_stats["RecQuestEliseAbortion"] >= 1
			#p "asdasdasdasd2"
			GabeSDK.setAchievementStat(tmpTier1ID,tmpVal)
		elsif !GabeSDK.AchievementDone(tmpTier2ID)
			GabeSDK.setAchievementStat(tmpTier2ID,tmpVal)
		elsif !GabeSDK.AchievementDone(tmpTier3ID)
			GabeSDK.setAchievementStat(tmpTier3ID,tmpVal)
		elsif !GabeSDK.AchievementDone(tmpTier4ID)
			GabeSDK.setAchievementStat(tmpTier4ID,tmpVal)
		end
	end

	
	def achCheckDate
		return if $story_stats["Setup_HardcoreAmt"] != [1772,3,1]
		#末日 MODE
		if $story_stats["Setup_Hardcore"] >= 2
			case $game_date.date[0..2]
				when [1772,3,2]
					GabeSDK.getAchievement("DoomModDateT1")
				when [1773,3,1]
					GabeSDK.getAchievement("DoomModDateT2")
				when [1776,6,6]
					GabeSDK.getAchievement("DoomModDateT3")
			end
		#地獄 MODE
		elsif $story_stats["Setup_Hardcore"] >= 1
			case $game_date.date[0..2]
				when [1772,3,2]
					GabeSDK.getAchievement("HellModDateT1")
				when [1773,3,1]
					GabeSDK.getAchievement("HellModDateT2")
				when [1774,3,1]
					GabeSDK.getAchievement("HellModDateT3")
			end
		end
		
	end
end
