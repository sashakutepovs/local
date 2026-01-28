FileGetter.load_lona_scripts


#Font.default_name = ["Noto Sans CJK TC Black"]
Font.default_name = [DataManager.get_font_name]
Font.default_bold = false


$debug_lona_chs=false
$debug_chs=false
$debug_portrait=false
$debug_event=false
$debug_map=false
$debug_state=false
$debug_battle=false
$debug_sensor=false
$debug_npc=false

#true = play event #false no event
$debug_chcg_appetizer=true
$debug_chcg_hevent=true

$correcting_text=true

if $TEST
  msgbox "FileGetter::COMPRESSED != false" if  FileGetter::COMPRESSED != false
  msgbox "WRITING_LIST != false" if  FileGetter::WRITING_LIST != false
end
FileGetter.load_starter
