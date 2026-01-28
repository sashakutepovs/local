
#===============================================================================
#這裡紀錄FileGetter的各項設定參數
#實際內容再GetFileList
#===============================================================================
module FileGetter
	COMPRESSED    = $LonaINI["LonaRPG"]["COMPRESSED"] == 1 		#是否為已壓縮的狀態
	WRITING_LIST  = $LonaINI["LonaRPG"]["WRITING_LIST"] == 1	#是否需要更新已寫成rvdata2的清單，只在非壓縮狀態下有用。
	$DEMO         = false
	#MONSTER_LIB_ID= 1 # 
	CONFIG_LOCATION={
	"npc_portraitConfigs" =>"Graphics/Portrait/npc/Configs/*.json"
	}
end
#when zipping,  false, true
#when output, true false
#when dev, false, false