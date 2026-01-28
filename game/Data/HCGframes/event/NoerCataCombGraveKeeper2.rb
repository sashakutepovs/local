#不死族務農任務
if $story_stats["QuProgCataUndeadHunt"] == 2
	call_msg("TagMapNoerCatacomb:Necropolis/CataUndeadHunt_done2_2")
	$story_stats["QuProgCataUndeadHunt"] =3
	get_character(0).call_balloon(0)
else
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapNoerCatacomb:Guard/talk#{rand(4)}",get_character(0).id)
end
