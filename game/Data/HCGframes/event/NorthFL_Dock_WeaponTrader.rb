if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end


tmpQ1 = $story_stats["RecQuestNorthFL_Main"] >= 8
tmpQ2 = $story_stats["RecQuestNorthFL_BucketHelmet"] == 0
tmpQ3 = $story_stats["RecQuestNorthFL_BucketHelmet"] >= 1
tmpWithBucketHelmet =  tmpQ1 && tmpQ2
if tmpWithBucketHelmet
	get_character(0).call_balloon(0)
	$story_stats["RecQuestNorthFL_BucketHelmet"] = 1
	call_msg("TagMapNorthFL_Dock:WeaponTrader/BucketHelmet_begin0")
else
	call_msg("TagMapNoerMarket:WeaponTrader/Welcome#{rand(2)}")
end
		shopNerf = ([([$story_stats["WorldDifficulty"].round,100].min)-0,0].max*0.001) #put the varible u want nerf shop,  if none put 0. var1=max  var2=min.   max-min must with in 100 (ex:weak125, -25)
		charStoreTP = [(  3000+rand(6000)  )*(1-(shopNerf+shopNerf)),0].max.round  #wildHobo 150+rand(800) hobo 300+rand(1000) #Normie 500+rand(2000) #NonTradeShop 1000+rand(2500) #innkeeper 1000+rand(2500) #storeMarket 3000+rand(6000)
		charStoreExpireDate = $game_date.dateAmt+1+rand(4+$story_stats["Setup_Hardcore"]) #if nil. delete after close.  if < date. delete after nap.
		if tmpWithBucketHelmet || tmpQ3
			manual_barters("NorthFL_Dock_WeaponTrader")
		else
			manual_barters("CommonWeaponTrader")
		end
eventPlayEnd
