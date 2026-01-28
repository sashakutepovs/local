######################################################################################################################################################################

#module RPG
#  class AudioFile
#    def initialize(name = "", volume = 100, pitch = 100)
#      @name = name
#      @volume = volume
#      @pitch = pitch
#    end
#    attr_accessor :name
#    attr_accessor :volume
#    attr_accessor :pitch
#  end
#end




#class RPG::BGM < RPG::AudioFile
#  @@last = RPG::BGM.new
#  def play(pos = 0)
#    if @name.empty?
#      Audio.bgm_stop
#      @@last = RPG::BGM.new
#    else
#      Audio.bgm_play('Audio/BGM/' + @name, @volume, @pitch, pos)
#      @@last = self.clone
#    end
#  end
#  def replay
#    play(@pos)
#  end
#  def self.stop
#    Audio.bgm_stop
#    @@last = RPG::BGM.new
#  end
#  def self.fade(time)
#    Audio.bgm_fade(time)
#    @@last = RPG::BGM.new
#  end
#  def self.last
#    @@last.pos = Audio.bgm_pos
#    @@last
#  end
#  attr_accessor :pos
#end
######################################################################################################################################################################
module SndLib

def self.bgs_play(tar_file,vol=80,pitch=100,pos=0)
	calculateVOL = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.bgs_play("Audio/BGS/#{tar_file}.ogg",calculateVOL,pitch,pos) if calculateVOL > 0 && (tar_file != RPG::BGS.last.name || pitch != RPG::BGS.last.pitch)
	RPG::BGS.last.name = tar_file
	RPG::BGS.last.volume = vol
	RPG::BGS.last.pitch = pitch
	RPG::BGS.last.pos = pos
end

def self.bgs_stop(tmpSPD=500)
	#Audio.bgs_stop
	Audio.bgs_fade(tmpSPD)
	RPG::BGS.last.name = ""
	RPG::BGS.last.volume = 100
	RPG::BGS.last.pitch = 100
	RPG::BGS.last.pos = 0
end

def self.bgm_play_prev
	p $game_map.prev_bgm_name
	return bgm_stop if !$game_map.prev_bgm_name || $game_map.prev_bgm_name== ""
	tar_file = $game_map.prev_bgm_name
	vol =$game_map.prev_bgm_volume
	pitch =$game_map.prev_bgm_pitch
	pos =$game_map.prev_bgm_pos
	$game_map.prev_bgm_name = RPG::BGM.last.name
	$game_map.prev_bgm_volume = RPG::BGM.last.volume
	$game_map.prev_bgm_pitch = RPG::BGM.last.pitch
	$game_map.prev_bgm_pos = RPG::BGM.last.pos
	calculateVOL = (vol * ($data_BGMvol * 0.01)).to_i
	Audio.bgm_play("Audio/BGM/#{tar_file}.ogg",calculateVOL,pitch,pos)  if calculateVOL > 0 && (tar_file != RPG::BGM.last.name || pitch != RPG::BGM.last.pitch)
	RPG::BGM.last.name = tar_file
	RPG::BGM.last.volume = vol
	RPG::BGM.last.pitch = pitch
	RPG::BGM.last.pos = pos
end

def self.bgm_play(tar_file,vol=80,pitch=100,pos=0)
	$game_map.prev_bgm_name = RPG::BGM.last.name 
	$game_map.prev_bgm_volume = RPG::BGM.last.volume
	$game_map.prev_bgm_pitch = RPG::BGM.last.pitch
	$game_map.prev_bgm_pos = RPG::BGM.last.pos
	calculateVOL = (vol * ($data_BGMvol * 0.01)).to_i
	Audio.bgm_play("Audio/BGM/#{tar_file}.ogg",calculateVOL,pitch,pos)  if calculateVOL > 0 && (tar_file != RPG::BGM.last.name || pitch != RPG::BGM.last.pitch)
	RPG::BGM.last.name = tar_file
	RPG::BGM.last.volume = vol
	RPG::BGM.last.pitch = pitch
	RPG::BGM.last.pos = pos
end

def self.bgm_stop(tmpSPD=500)
	Audio.bgm_fade(tmpSPD)
	RPG::BGM.last.name = ""
	RPG::BGM.last.volume = 100
	RPG::BGM.last.pitch = 100
	RPG::BGM.last.pos = 0
end

def self.bg_stop
	bgm_stop
	bgs_stop
end

def self.bgm_scene_on
	tmpVol = RPG::BGM.last.volume
	tmpPit = RPG::BGM.last.pitch
	calculateVOL = ((tmpVol*0.8) * ($data_BGMvol * 0.01)).to_i
	calculatePIT = tmpPit#((tmpPit*0.9) * ($data_BGMvol * 0.01)).to_i
	Audio.bgm_play("Audio/BGM/#{RPG::BGM.last.name}.ogg",calculateVOL,calculatePIT,RPG::BGM.last.pos) if RPG::BGM.last.name != ""
end
def self.bgs_scene_on
	tmpVol = RPG::BGS.last.volume
	tmpPit = RPG::BGS.last.pitch
	calculateVOL = ((tmpVol*0.7) * ($data_SNDvol * 0.01)).to_i
	calculatePIT = tmpPit#((tmpPit*1) * ($data_SNDvol * 0.01)).to_i
	Audio.bgs_play("Audio/BGS/#{RPG::BGS.last.name}.ogg",calculateVOL,calculatePIT,RPG::BGS.last.pos) if RPG::BGS.last.name != ""
end

def self.scene_off
	tmpVol = RPG::BGM.last.volume
	calculateVOL = (tmpVol * ($data_BGMvol * 0.01)).to_i
	Audio.bgm_play("Audio/BGM/#{RPG::BGM.last.name}.ogg",calculateVOL,RPG::BGM.last.pitch,RPG::BGM.last.pos) if RPG::BGM.last.name != ""
	tmpVol = RPG::BGS.last.volume
	calculateVOL = (tmpVol * ($data_SNDvol * 0.01)).to_i
	Audio.bgs_play("Audio/BGS/#{RPG::BGS.last.name}.ogg",calculateVOL,RPG::BGS.last.pitch,RPG::BGS.last.pos) if RPG::BGS.last.name != ""
end

def self.bgm_playOM(vol=80,effect=100)
	temp_sounds= [
	"Overmap/HB_Starter_-_Fantasy_-_Sad",
	"Overmap/Medieval Theme 5",
	"Overmap/Dark Fantasy Studio- Peacefull place",
	"Overmap/Dark Fantasy Studio- The village"
	]
	if $DEMO == false
		temp_sounds << "D/Overmap/Open Exploring"
		temp_sounds << "D/Overmap/Planets_VenusPart2"
		temp_sounds << "D/Overmap/Planets_VenusPart1"
	end
	return if temp_sounds.any?{|aud| aud == RPG::BGM.last.name}
tar_aud = temp_sounds[rand(temp_sounds.length)]
calculateVOL = (vol * ($data_BGMvol * 0.01)).to_i
Audio.bgm_play("Audio/BGM/#{tar_aud}.ogg",calculateVOL,effect,0) if calculateVOL > 0
RPG::BGM.last.name = tar_aud
RPG::BGM.last.volume = vol
RPG::BGM.last.pitch = effect
RPG::BGM.last.pos = 0
end

def self.me_play(tar_file,vol=80,pitch=100)
	calculateVOL = (vol * ($data_BGMvol * 0.01)).to_i
	vol = calculateVOL
	return if vol <=0
	Audio.me_play("Audio/#{tar_file}.ogg",vol,pitch) if calculateVOL > 0 
end

def self.se_play(tar_file,vol=80,pitch=100)
	calculateVOL = (vol * ($data_BGMvol * 0.01)).to_i
	vol = calculateVOL
	return if vol <=0
	Audio.se_play("Audio/#{tar_file}.ogg",vol,pitch) if calculateVOL > 0 
end

################################################################################# SYSTEM ################################################################################

def self.play_cursor(vol=50,effect=120+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/Open1.ogg",vol,effect)
end
def self.play_cursorMove(vol=20,effect=190+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/Open1.ogg",vol,effect)
end
def self.sys_ok(vol=60,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/Open2.ogg",vol,effect)
end

def self.sys_trigger(vol=70,effect=85+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/trigger01.ogg",vol,effect)
end

def self.sys_close(vol=60,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/Close1.ogg",vol,effect)
end

def self.sys_cancel(vol=70,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/Equip2.ogg",vol,effect)
end

def self.sys_buzzer(vol=75,effect=120+rand(31))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/Buzzer1.ogg",vol,effect)
end

def self.sys_UseItem(vol=75,effect=120+rand(31))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/eat02.ogg",vol,effect)
end

def self.sys_UseItem2(vol=75,effect=120+rand(31))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/eat03.ogg",vol,effect)
end

def self.sys_SneakOff(vol=100,effect=50)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/sneak.ogg",vol,effect)
end

def self.sys_GameOver(vol=100,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.me_play("Audio/ME/Fanfares_GameOver_01.ogg",vol,effect)
end

def self.sys_SneakOn(vol=100,effect=120)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/sneak.ogg",vol,effect)
end

def self.sys_DoorLock(vol=100,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/DoorLock.ogg",vol,effect)
end

def self.sys_Dialog(vol=rand(20)+30,effect=40+rand(40),tmpName="Cursor2")
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	tgt = "Audio/SE/"+tmpName
	#p "vol,effect = #{vol} #{effect} #{tgt}"
	Audio.se_play(tgt,vol,effect)
	#Audio.se_play("Audio/SE/"+tmpName,vol,effect)
end

def self.sys_Gain(vol=100,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Item1.ogg",
	"Audio/SE/Item2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sys_MeatGain(vol=100,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/gore08.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sys_LvUp(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/Chime2",vol,effect)
end

def self.sys_equip(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/Equip3",vol,effect)
end

def self.sys_ChangeMapFailed(vol=80,effect=80)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/FABRIC_Movement_Fast_03_mono.ogg",vol,effect)
end

def self.sys_OverMapDay(vol=60,effect=115+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/ME/OvermapDay.ogg",vol,effect)
end

def self.sys_OverMapNight(vol=100,effect=115+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/ME/OvermapNight.ogg",vol,effect)
end

def self.sys_StepChangeMap(vol=75,effect=120+rand(31))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/Move.ogg",vol,effect)
end

def self.sys_KnockDoor(vol=100,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/wood_chop.ogg",vol,effect)
end
def self.sys_WoodChop(vol=100,effect=60+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/wood_chop03.ogg",vol,effect)
end

def self.sys_TreeFalling(vol=90,effect=80+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/TreeFalling01.ogg",
	"Audio/SE/TreeFalling02.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sys_PaperTear(vol=100,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/PaperTear.ogg",vol,effect)
end

def self.sys_DialogNarr(vol=100,effect=105+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/narr01.ogg",
	"Audio/SE/narr02.ogg",
	"Audio/SE/narr03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sys_DialogNarrClose(vol=100,effect=105+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/narr01.ogg",vol,effect)
end

def self.sys_DialogBoard(vol=100,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	Audio.se_play("Audio/SE/Book1.ogg",vol,effect)
end
def self.sys_LoadGame(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/orc/OrcSpot1.ogg",
		"Audio/SE/orc/OrcSpot2.ogg",
		"Audio/SE/orc/OrcSpot3.ogg",
		"Audio/SE/human/MaleWarriorSpot1.ogg",
		"Audio/SE/UndeadQuestion1.ogg",
		"Audio/SE/UndeadQuestion2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.sys_Achievement(vol=95,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/Achievement01.ogg",
		"Audio/SE/Achievement02.ogg",
		"Audio/SE/Achievement03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sys_CoinsFalling(vol=95,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/Many_Coins_In_Sack_Held_By_Drawstring_01.ogg",
		"Audio/SE/Many_Coins_In_Sack_Held_By_Drawstring_02.ogg",
		"Audio/SE/Many_Coins_In_Sack_Held_By_Drawstring_03.ogg",
		"Audio/SE/Many_Coins_In_Sack_Held_By_Drawstring_04.ogg",
		"Audio/SE/Many_Coins_In_Sack_Held_By_Drawstring_05.ogg",
		"Audio/SE/Many_Coins_In_Sack_Held_By_Drawstring_06.ogg",
		"Audio/SE/Many_Coins_In_Sack_Held_By_Drawstring_07.ogg",
		"Audio/SE/Many_Coins_In_Sack_Held_By_Drawstring_08.ogg",
		"Audio/SE/Many_Coins_In_Sack_Held_By_Drawstring_09.ogg",
		"Audio/SE/Many_Coins_In_Sack_Held_By_Drawstring_10.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


########################################################################################################################################################################
def self.balloon_zoom(vol=95,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/BALLOON_Rub_03_mono.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.balloon_rub(vol=95,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/BALLOON_Rub_04_mono.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chs_buchu(vol=rand(40)+55,effect=rand(50)+105)
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_CHS/Buchu00.ogg",
	"Audio/Hevent_CHS/Buchu01.ogg",
	"Audio/Hevent_CHS/Buchu02.ogg",
	"Audio/Hevent_CHS/Buchu03.ogg",
	"Audio/Hevent_CHS/Buchu04.ogg",
	"Audio/Hevent_CHS/Buchu05.ogg",
	"Audio/Hevent_CHS/Buchu06.ogg",
	"Audio/Hevent_CHS/Buchu07.ogg",
	"Audio/Hevent_CHS/Buchu08.ogg",
	"Audio/Hevent_CHS/Buchu09.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chs_dopyu(vol=rand(40)+55,effect=rand(50)+105)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_CHS/Dopyu00.ogg",
	"Audio/Hevent_CHS/Dopyu01.ogg",
	"Audio/Hevent_CHS/Dopyu02.ogg",
	"Audio/Hevent_CHS/Dopyu03.ogg",
	"Audio/Hevent_CHS/Dopyu04.ogg",
	"Audio/Hevent_CHS/Dopyu05.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chs_papa(vol=rand(40)+55,effect=rand(75)+50)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_CHS/papa01.ogg",
	"Audio/Hevent_CHS/papa02.ogg",
	"Audio/Hevent_CHS/papa03.ogg",
	"Audio/Hevent_CHS/papa04.ogg",
	"Audio/Hevent_CHS/papa05.ogg",
	"Audio/Hevent_CHS/papa06.ogg",
	"Audio/Hevent_CHS/papa07.ogg",
	"Audio/Hevent_CHS/papa08.ogg",
	"Audio/Hevent_CHS/papa09.ogg",
	"Audio/Hevent_CHS/papa10.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chs_pyu(vol=rand(40)+55,effect=rand(50)+105)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_CHS/Pyu00.ogg",
	"Audio/Hevent_CHS/Pyu01.ogg",
	"Audio/Hevent_CHS/Pyu02.ogg",
	"Audio/Hevent_CHS/Pyu03.ogg",
	"Audio/Hevent_CHS/Pyu04.ogg",
	"Audio/Hevent_CHS/Pyu05.ogg",
	"Audio/Hevent_CHS/Pyu06.ogg",
	"Audio/Hevent_CHS/Pyu07.ogg",
	"Audio/Hevent_CHS/Pyu08.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chcg_pee(vol=rand(60)+40,effect=rand(20)+90)
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_CHCG_Full/pee1.ogg",
	"Audio/Hevent_CHCG_Full/pee2.ogg",
	"Audio/Hevent_CHCG_Full/pee3.ogg",
	"Audio/Hevent_CHCG_Full/pee4.ogg",
	"Audio/Hevent_CHCG_Full/pee5.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chcg_full(vol=rand(40)+55,effect=rand(50)+105)
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_CHS/Pyu00.ogg",
	"Audio/Hevent_CHS/Pyu01.ogg",
	"Audio/Hevent_CHS/Pyu02.ogg",
	"Audio/Hevent_CHS/Pyu03.ogg",
	"Audio/Hevent_CHS/Pyu04.ogg",
	"Audio/Hevent_CHS/Pyu05.ogg",
	"Audio/Hevent_CHS/Pyu06.ogg",
	"Audio/Hevent_CHS/Pyu07.ogg",
	"Audio/Hevent_CHS/Pyu08.ogg",
	"Audio/Hevent_CHS/Dopyu00.ogg",
	"Audio/Hevent_CHS/Dopyu01.ogg",
	"Audio/Hevent_CHS/Dopyu02.ogg",
	"Audio/Hevent_CHS/Dopyu03.ogg",
	"Audio/Hevent_CHS/Dopyu04.ogg",
	"Audio/Hevent_CHS/Dopyu05.ogg",
	"Audio/Hevent_CHS/Buchu00.ogg",
	"Audio/Hevent_CHS/Buchu01.ogg",
	"Audio/Hevent_CHS/Buchu02.ogg",
	"Audio/Hevent_CHS/Buchu03.ogg",
	"Audio/Hevent_CHS/Buchu04.ogg",
	"Audio/Hevent_CHS/Buchu05.ogg",
	"Audio/Hevent_CHS/Buchu06.ogg",
	"Audio/Hevent_CHS/Buchu07.ogg",
	"Audio/Hevent_CHS/Buchu08.ogg",
	"Audio/Hevent_CHS/Buchu09.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chcg_full_long(vol=rand(40)+55,effect=rand(50)+105) #very long, dont use at shot frame	
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_CHCG_Full/0001.ogg",
	"Audio/Hevent_CHCG_Full/0002.ogg",
	"Audio/Hevent_CHCG_Full/0003.ogg",
	"Audio/Hevent_CHCG_Full/0004.ogg",
	"Audio/Hevent_CHCG_Full/0005.ogg",
	"Audio/Hevent_CHCG_Full/0006.ogg",
	"Audio/Hevent_CHCG_Full/0007.ogg",
	"Audio/Hevent_CHCG_Full/0008.ogg",
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chcg_AnalBead(vol=100,effect=100) #very long, dont use at shot frame	
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_CHCG_Full/0002.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

	
	
def self.sound_chcg_picha(vol=rand(40)+55 ,effect=rand(50)+50 ) #very long, dont use at shot frame
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_CHCG_Full/Picha01.ogg",
	"Audio/Hevent_CHCG_Full/Picha02.ogg",
	"Audio/Hevent_CHCG_Full/Picha03.ogg",
	"Audio/Hevent_CHCG_Full/Picha04.ogg",
	"Audio/Hevent_CHCG_Full/Picha05.ogg",
	"Audio/Hevent_CHCG_Full/Picha06.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chcg_fapper(vol=rand(40)+55,effect=rand(50)+105)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_Fapper/0001.ogg",
	"Audio/Hevent_Fapper/0002.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chcg_chupa(vol=rand(40)+55,effect=rand(50)+105)
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_Chupa/chupaB.ogg",
	"Audio/Hevent_Chupa/chupaA.ogg",
	"Audio/Hevent_Chupa/KissA.ogg",
	"Audio/Hevent_Chupa/chupaD.ogg",
	"Audio/Hevent_Chupa/chupaE.ogg",
	"Audio/Hevent_Chupa/SyaburuB.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chcg_chupa_long(vol=rand(40)+55,effect=rand(50)+105)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_Chupa/ChupA.ogg",
	"Audio/Hevent_Chupa/SyaburuC.ogg",
	"Audio/Hevent_Chupa/SyaburuA.ogg",
	"Audio/Hevent_Chupa/chupaLong.ogg",
	"Audio/Hevent_Chupa/ChuruA.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chcg_scat(vol=rand(40)+55,effect=rand(50)+105 )
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_Scat/Fart1.ogg",
	"Audio/Hevent_Scat/Fart2.ogg",
	"Audio/Hevent_Scat/Fart3.ogg",
	"Audio/Hevent_Scat/Fart4.ogg",
	"Audio/Hevent_Scat/Fart5.ogg",
	"Audio/Hevent_Scat/Fart6.ogg",
	"Audio/Hevent_Scat/Fart7.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_chcg_puke(vol=rand(40)+55,effect=rand(50)+105)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/Hevent_Puke/puke02"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.HolyMagicCharge(vol=rand(10)+80,effect=200+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/BLACK MAGIC SPELL - Dark Cinematic Rise - 01    [003588].ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.SaintSmiteEfxLaunch(vol=rand(10)+80,effect=200+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/HolySmiteHit01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.JudgmentEfx(vol=rand(10)+80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/SaintJudgment01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.JudgmentHit(vol=rand(10)+80,effect=200+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/SaintJudgmentHit01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.SmiteHitTgt(vol=rand(10)+80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/SaintSmiteHit01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.BonkHitSap(vol=rand(10)+80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/bonk0.ogg",
		"Audio/SE/bonk1.ogg"
		]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.WoodenOBJ_Destroy(vol=rand(10)+80,effect=95+rand(10)) #unused
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/SAP Metal_hit_2.ogg",
		"Audio/SE/SAP Metal_hit_11.ogg",
		"Audio/SE/SAP Metal_hit_12.ogg"
		]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.sound_punch_hit(vol=rand(10)+70,effect=rand(10)+95)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/punch01.ogg",
	"Audio/SE/punch02.ogg",
	"Audio/SE/punch03.ogg",
	"Audio/SE/punch04.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_punch_hit_heavy(vol=rand(10)+70,effect=rand(10)+95)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/HeavyPunchHit01.ogg",
	"Audio/SE/HeavyPunchHit02.ogg",
	"Audio/SE/HeavyPunchHit03.ogg",
	"Audio/SE/HeavyPunchHit04.ogg",
	"Audio/SE/HeavyPunchHit05.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_punch_hit_heavy_bloody(vol=rand(10)+70,effect=rand(10)+95)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/HeavyPunchBloody01.ogg",
	"Audio/SE/HeavyPunchBloody02.ogg",
	"Audio/SE/HeavyPunchBloody03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_punch_heavy(vol=rand(10)+70,effect=rand(10)+95)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/HeavyPunchAtk01.ogg",
	"Audio/SE/HeavyPunchAtk02.ogg",
	"Audio/SE/HeavyPunchAtk03.ogg",
	"Audio/SE/HeavyPunchAtk04.ogg",
	"Audio/SE/HeavyPunchAtk05.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.sound_gore(vol=rand(30)+70,effect=rand(40)+80)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/gore04.ogg",
	"Audio/SE/gore06.ogg",
	"Audio/SE/gore07.ogg",
	"Audio/SE/gore08.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_whoosh(vol=rand(30)+70,effect=rand(50)+105)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/WHOOSH01.ogg",
	"Audio/SE/WHOOSH02.ogg",
	"Audio/SE/WHOOSH03.ogg",
	"Audio/SE/WHOOSH04.ogg",
	"Audio/SE/WHOOSH05.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.playerOverKill(vol=100,effect=rand(50)+105)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/gore10.ogg",
	"Audio/SE/gore06.ogg",
	"Audio/SE/gore11.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_slap(vol=rand(30)+70,effect=rand(50)+105)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Whip_slap01.ogg",
	"Audio/SE/Whip_slap02.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_equip_armor(vol=rand(30)+70,effect=rand(50)+105)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/FABRIC_Movement_Fast_01_mono.ogg",
	"Audio/SE/FABRIC_Movement_Fast_02_mono.ogg",
	"Audio/SE/FABRIC_Movement_Fast_03_mono.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_eat(vol=rand(30)+70,effect=rand(50)+105)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/eat02.ogg",
	"Audio/SE/eat03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_eat_debuff(vol=rand(30)+70,effect=rand(10)+30)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/eat03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_drink(vol=rand(30)+70,effect=rand(50)+105)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/drink02.ogg",
	"Audio/SE/drink04.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_drink2(vol=rand(10)+80,effect=rand(20)+90)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/drink02.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.sound_drink3(vol=rand(10)+80,effect=rand(20)+90)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/drink04.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.ClapGroup(vol=90,effect=rand(10)+95)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/ClapGroup01.ogg",
	"Audio/SE/ClapGroup02.ogg",
	"Audio/SE/ClapGroup03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.BadClap(vol=90,effect=rand(10)+95)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/BadClap.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_flame(vol=rand(30)+70,effect=rand(50)+105)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/flame01.ogg",
	"Audio/SE/flame02.ogg",
	"Audio/SE/flame03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.Whistle(vol=rand(30)+70,effect=rand(10)+115)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Whistle1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.PenWrite(vol=80,effect=rand(10)+95)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/PenWrite0.ogg",
	"Audio/SE/PenWrite1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_HeavyStep(vol=rand(20)+80,effect=50+rand(20))
	vol -= 30
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/HeavyStep1.ogg",
	"Audio/SE/HeavyStep2.ogg",
	"Audio/SE/HeavyStep3.ogg",
	"Audio/SE/HeavyStep4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_step(vol=rand(20)+80,effect=rand(20)+80)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/step1.ogg",
	"Audio/SE/step2.ogg",
	"Audio/SE/step3.ogg",
	"Audio/SE/step4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end



def self.stepBush(vol=rand(20)+80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Footsteps_Casual_Grass_01.ogg",
	"Audio/SE/Footsteps_Casual_Grass_05.ogg",
	"Audio/SE/Footsteps_Casual_Grass_10.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.stepWater(vol=rand(20)+80,effect=rand(20)+40)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Footsteps_Casual_Water_01.ogg",
	"Audio/SE/Footsteps_Casual_Water_02.ogg",
	"Audio/SE/Footsteps_Casual_Water_03.ogg",
	"Audio/SE/Footsteps_Casual_Water_04.ogg",
	"Audio/SE/Footsteps_Casual_Water_05.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.glassBreak(vol=80,effect=rand(10)+95)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/GlassBreak01.ogg",
	"Audio/SE/GlassBreak02.ogg",
	"Audio/SE/GlassBreak03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.openChest(vol=rand(20)+90,effect=rand(10)+95)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Item_Chest_Opening_01.ogg",
	"Audio/SE/Item_Chest_Opening_02.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.WoodenBuild(vol=rand(20)+90,effect=rand(10)+95)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/WoodenBuild.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.closeChest(vol=rand(20)+90,effect=rand(10)+95)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Item_Chest_Close.ogg",
	"Audio/SE/Item_Chest_Landing.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.closeDoor(vol=80,effect=50+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/DOOR_Owen_Close_stereo.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.openDoor(vol=90,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/DOOR_Owen_Open_stereo.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.closeDoorMetal(vol=90,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/DOOR_Metal_Door_02_Close_stereo.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.stoneCollapsed(vol=90,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Collapsed01.ogg",
	"Audio/SE/Collapsed02.ogg",
	"Audio/SE/Collapsed03.ogg",
	"Audio/SE/Collapsed04.ogg",
	"Audio/SE/Collapsed05.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_step_chain(vol=rand(20)+80,effect=rand(20)+80)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Chain_move01.ogg",
	"Audio/SE/Chain_move02.ogg",
	"Audio/SE/Chain_move03.ogg",
	"Audio/SE/Chain_move04.ogg",
	"Audio/SE/Chain_move05.ogg",
	"Audio/SE/Chain_move06.ogg",
	"Audio/SE/Chain_move07.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_combat_whoosh(vol=95,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/WHOOSH1.ogg",
	"Audio/SE/WHOOSH2.ogg",
	"Audio/SE/WHOOSH3.ogg",
	"Audio/SE/WHOOSH4.ogg",
	"Audio/SE/WHOOSH5.ogg",
	"Audio/SE/WHOOSH6.ogg",
	"Audio/SE/WHOOSH7.ogg",
	"Audio/SE/WHOOSH8.ogg",
	"Audio/SE/WHOOSH9.ogg",
	"Audio/SE/WHOOSH10.ogg",
	"Audio/SE/WHOOSH11.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.sound_combat_heavy_whoosh(vol=95,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/HeavyWoosh01.ogg",
	"Audio/SE/HeavyWoosh02.ogg",
	"Audio/SE/HeavyWoosh03.ogg",
	"Audio/SE/HeavyWoosh04.ogg",
	"Audio/SE/HeavyWoosh05.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_stable_woosh(vol=95,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/WHOOSH2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_combat_heavy_whoosh(vol=95,effect=100)
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/WHOOSH05.ogg",
	"Audio/SE/WHOOSH03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.sound_combat_throw_whoosh(vol=95,effect=95+rand(10))
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/WHOOSH01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.actionReady(vol=95,effect=95+rand(10))
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Equip3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

######################################################### WEABOO KATANA

def self.katana_end(vol=70,effect=80+rand(40))
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Katana_end.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.katana_start_heavy(vol=70,effect=90+rand(20))
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Katana_Start_heavy0.ogg",
	"Audio/SE/Katana_Start_heavy1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.katana_start_light(vol=70,effect=90+rand(20))
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Katana_Start_light0.ogg",
	"Audio/SE/Katana_Start_light1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

######################################################### SWORD

def self.sound_combat_sword_hit_sword(vol=80,effect=100)
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/SWORD_Hit_Sword_RR1_mono.ogg",
	"Audio/SE/SWORD_Hit_Sword_RR2_mono.ogg",
	"Audio/SE/SWORD_Hit_Sword_RR3_mono.ogg",
	"Audio/SE/SWORD_Hit_Sword_RR4_mono.ogg",
	"Audio/SE/SWORD_Hit_Sword_RR6_mono.ogg",
	"Audio/SE/SWORD_Hit_Sword_RR7_mono.ogg",
	"Audio/SE/SWORD_Hit_Sword_RR8_mono.ogg",
	"Audio/SE/SWORD_Hit_Sword_RR9_mono.ogg",
	"Audio/SE/SWORD_Hit_Sword_RR10_mono.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.sound_TeslaHold(vol=80,effect=95+rand(10))
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/TeslaHold01.ogg",
	"Audio/SE/TeslaHold02.ogg",
	"Audio/SE/TeslaHold03.ogg",
	"Audio/SE/TeslaHold04.ogg",
	"Audio/SE/TeslaHold05.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_TeslaHit(vol=80,effect=95+rand(10))
	return if vol <=0 
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/TeslaHit01.ogg",
	"Audio/SE/TeslaHit02.ogg",
	"Audio/SE/TeslaHit03.ogg",
	"Audio/SE/TeslaHit04.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_combat_slash(vol=80,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Slash1.ogg",
	"Audio/SE/Slash2.ogg",
	"Audio/SE/Slash3.ogg",
	"Audio/SE/Slash10.ogg",
	"Audio/SE/Slash11.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_explosion(vol=80,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/EXPLOSION_Distorted_01_Medium_stereo.ogg",
	"Audio/SE/EXPLOSION_Distorted_05_Medium_stereo.ogg",
	"Audio/SE/EXPLOSION_Distorted_09_Medium_stereo.ogg",
	"Audio/SE/EXPLOSION_Distorted_10_Medium_stereo.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.sound_explosion_big(vol=80,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Rocket Explosion A.ogg",
	"Audio/SE/Rocket Explosion B.ogg",
	"Audio/SE/Rocket Explosion C.ogg",
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_combat_hit_gore(vol=100,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Gore_hit1.ogg",
	"Audio/SE/Gore_hit2.ogg",
	"Audio/SE/Gore_hit3.ogg",
	"Audio/SE/Gore_hit4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_gore_breed(vol=100,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Gore_hit4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_goblin_idle(vol=80,effect=rand(50)+70)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/goblin/Goblin_idle1.ogg",
	"Audio/SE/goblin/Goblin_idle2.ogg",
	"Audio/SE/goblin/Goblin_idle3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_goblin_death(vol=80,effect=rand(30)+90)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/goblin/Goblin_death1.ogg",
	"Audio/SE/goblin/Goblin_death2.ogg",
	"Audio/SE/goblin/Goblin_death3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_goblin_roar(vol=80,effect=rand(30)+90)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/goblin/Goblin_roar1.ogg",
	"Audio/SE/goblin/Goblin_roar2.ogg",
	"Audio/SE/goblin/Goblin_roar3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_goblin_spot(vol=80,effect=rand(30)+90)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/goblin/Goblin_spot1.ogg",
	"Audio/SE/goblin/Goblin_spot2.ogg",
	"Audio/SE/goblin/Goblin_spot3.ogg",
	"Audio/SE/goblin/Goblin_spot4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
############# goblin BB


def self.sound_goblinBB_idle(vol=80,effect=rand(10)+150)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/goblin/Goblin_idle1.ogg",
	"Audio/SE/goblin/Goblin_idle2.ogg",
	"Audio/SE/goblin/Goblin_idle3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_goblinBB_death(vol=80,effect=rand(10)+150)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/goblin/Goblin_death1.ogg",
	"Audio/SE/goblin/Goblin_death2.ogg",
	"Audio/SE/goblin/Goblin_death3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_goblinBB_roar(vol=80,effect=rand(10)+150)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/goblin/Goblin_roar1.ogg",
	"Audio/SE/goblin/Goblin_roar2.ogg",
	"Audio/SE/goblin/Goblin_roar3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_goblinBB_spot(vol=80,effect=rand(10)+150)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/goblin/Goblin_spot1.ogg",
	"Audio/SE/goblin/Goblin_spot2.ogg",
	"Audio/SE/goblin/Goblin_spot3.ogg",
	"Audio/SE/goblin/Goblin_spot4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

##############

def self.sound_hit_whip(vol=80,effect=70)
	vol -= 25
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Whip01.ogg",
	"Audio/SE/Whip02.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_release_arrow(vol=80,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/BOW_Release_Arrow_Large_mono.ogg",
	"Audio/SE/BOW_Release_Arrow_mono.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_arrow_hit(vol=80,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/ARROW_Hit_Body_stereo.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_arrow_hold(vol=80,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Tears_Pineapple_2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_shield_up(vol=80,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/HAMMER_Hit_Wood_Shield_stereo.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_backstab_hold(vol=80,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/backstab1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.sound_backstab_attack(vol=80,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/backstab2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.sound_ShockBomb(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/SmokeBomb1.ogg",
	#"Audio/SE/SmokeBomb2.ogg",
	"Audio/SE/SmokeBomb3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.Plane(vol=80,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Plane1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_HumanRoar(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/roar.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_Heartbeat(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/HeartbeatSINGLE.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_AcidBurn(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/AcidBurn1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_AcidBurnLong(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/AcidBurn_long.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_Bubble(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Bubble1.ogg",
	"Audio/SE/Bubble2.ogg",
	"Audio/SE/Bubble3.ogg",
	"Audio/SE/Bubble4.ogg",
	"Audio/SE/Bubble5.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_BloodMagicCasting(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/MAGIC_SPELL_Dark_Pulse_Echo_Subtle_stereo.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_MagicMissileLaunch(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/MAGIC_SPELL_Flame_01_mono.ogg",
	"Audio/SE/MAGIC_SPELL_Flame_02_mono.ogg",
	"Audio/SE/MAGIC_SPELL_Flame_04_mono.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_RockedLaunch(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Rocket Launcher Shot A.ogg",
	"Audio/SE/Rocket Launcher Shot B.ogg",
	"Audio/SE/Rocket Launcher Shot C.ogg",
	"Audio/SE/Rocket Launcher Shot D.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.GlassCup(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/BF002.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_HowlWind(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/HowlWind1.ogg",
	"Audio/SE/HowlWind2.ogg",
	"Audio/SE/HowlWind3.ogg",
	"Audio/SE/HowlWind4.ogg",
	"Audio/SE/HowlWind5.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_FlameCast(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/FlameCast1.ogg",
	"Audio/SE/FlameCast2.ogg",
	"Audio/SE/FlameCast3.ogg",
	"Audio/SE/FlameCast4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.sound_Burning(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/burning1.ogg",
	"Audio/SE/burning2.ogg",
	"Audio/SE/burning3.ogg",
	"Audio/SE/burning4.ogg",
	"Audio/SE/burning5.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_GunSingle(vol=80,effect=95+rand(10))
	return if vol <=0
	vol -= 10
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/gun_rifle_shot_01.ogg",
	"Audio/SE/gun_rifle_shot_02.ogg",
	"Audio/SE/gun_rifle_shot_03.ogg",
	"Audio/SE/gun_rifle_shot_04.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_GunShotgun(vol=80,effect=100+rand(10))
	return if vol <=0
	vol -= 10
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/gun_shotgun_shot_01.ogg",
	"Audio/SE/gun_shotgun_shot_02.ogg",
	"Audio/SE/gun_shotgun_shot_03.ogg",
	"Audio/SE/gun_shotgun_shot_04.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_GunBrust(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/gun_brust01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_DressTear(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Wooden_Tearing_09.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.sound_Reload(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/reload2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_ReadyFire(vol=80,effect=160+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/RdyFire01.ogg",
	"Audio/SE/RdyFire02.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_mortar(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/mortar1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_ProtectShieldOn(vol=80,effect=75+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/ProtectShieldOn.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_WaterRiver(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/WaterRiverPoint1.ogg",
	"Audio/SE/WaterRiverPoint2.ogg",
	"Audio/SE/WaterRiverPoint3.ogg",
	"Audio/SE/WaterRiverPoint4.ogg",
	"Audio/SE/WaterRiverPoint5.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_Flies(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Flies01.ogg",
	"Audio/SE/Flies02.ogg",
	"Audio/SE/Flies03.ogg",
	"Audio/SE/Flies04.ogg",
	"Audio/SE/Flies05.ogg",
	"Audio/SE/Flies06.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_WaterSpla(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Water1.ogg",
	"Audio/SE/Water2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_WaterShot(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/WaterShot1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.WaterIn(vol=90,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/WaterSuppriseIn.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.WaterOut(vol=90,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/WaterSuppriseOut.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_NecroBoom(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/NecroMagicHit1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_FarBoom(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/FarBoom01.ogg",
	"Audio/SE/FarBoom02.ogg",
	"Audio/SE/FarBoom03.ogg",
	"Audio/SE/FarBoom04.ogg",
	"Audio/SE/FarBoom05.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_TrapTrigger(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/TrapTrigger1.ogg",
	"Audio/SE/TrapTrigger2.ogg",
	"Audio/SE/TrapTrigger3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_FlashMagic(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/MAGIC_SPELL_Distinct_Thrust_Bright_Pad_stereo.ogg",
	"Audio/SE/MAGIC_SPELL_Distinct_Thrust_Bright_Pad_Subtle_stereo.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_Stomp(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Stomp1.ogg",
	"Audio/SE/Stomp2.ogg",
	"Audio/SE/Stomp3.ogg",
	"Audio/SE/Stomp4.ogg",
	"Audio/SE/Stomp5.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_MetorStomp(vol=90,effect=90+rand(19))
	return if vol <=0
	vol+=10
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/MetorStomp1.ogg",
	"Audio/SE/MetorStomp2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_QuickDialog(vol=80,effect=150+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/UI_Animate_Whister_Disappear_stereo.ogg",
	"Audio/SE/UI_Animate_Whisper_Appear_stereo.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.waterBath(vol=90,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/WaterBath0.ogg",
	"Audio/SE/WaterBath1.ogg",
	"Audio/SE/WaterBath2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.ppl_CheerGroup(vol=80,effect=85+rand(15))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/CheerGroup1.ogg",
	"Audio/SE/CheerGroup2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.ppl_BooGroup(vol=80,effect=85+rand(15))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/BooGroup1.ogg",
	"Audio/SE/BooGroup2.ogg",
	"Audio/SE/BooGroup3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.ppl_Boo(vol=80,effect=85+rand(15))
	return if vol <=0
	vol+=20
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/boo1.ogg",
	"Audio/SE/boo2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.ppl_Cheer(vol=80,effect=85+rand(15))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/yeah1.ogg",
	"Audio/SE/yeah2.ogg",
	"Audio/SE/yeah3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_Boiling(vol=80,effect=100)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Boiling1.ogg",
	"Audio/SE/Boiling2.ogg",
	"Audio/SE/Boiling3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.buff_life(vol=80,effect=40+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/BuffLife1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.Breathing_Goblin(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Breathing_Goblin1.ogg",
	"Audio/SE/Breathing_Goblin2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.Breathing_Human(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Breathing_Human.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.Breathing_Orc(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Breathing_Orc1.ogg",
	"Audio/SE/Breathing_Orc2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
###################################################### NPC VOICE ######################################################################
###################################################### NPC VOICE ######################################################################
###################################################### NPC VOICE ######################################################################
###################################################### NPC VOICE ######################################################################
###################################################### NPC VOICE ######################################################################


def self.sound_UndeadSurprise(vol=80,effect=65+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/ZombieHiss1.ogg",
	"Audio/SE/UndeadSpot.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_ZombieATK(vol=80,effect=65+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/ZombieATK01.ogg",
		"Audio/SE/ZombieATK02.ogg",
		"Audio/SE/ZombieATK03.ogg",
		"Audio/SE/ZombieATK04.ogg",
		"Audio/SE/ZombieATK05.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_ZombieDED(vol=80,effect=65+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/ZombieDED01.ogg",
		"Audio/SE/ZombieDED02.ogg",
		"Audio/SE/ZombieDED04.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_ZombieSpot(vol=80,effect=65+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/ZombieSpot01.ogg",
		"Audio/SE/ZombieSpot02.ogg",
		"Audio/SE/ZombieSpot03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.sound_UndeadSkill(vol=80,effect=65+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/UndeadAtk.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_UndeadDed(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/UndeadDead1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_UndeadQuestion(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/UndeadQuestion1.ogg",
	"Audio/SE/UndeadQuestion2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.sound_OrcQuestion(vol=80,effect=rand(10)+140)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/orc/OrcQuestion1.ogg",
	"Audio/SE/orc/OrcQuestion2.ogg",
	"Audio/SE/orc/OrcQuestion3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_OrcHurt(vol=80,effect=rand(10)+140)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/orc/OrcHurt1.ogg",
	"Audio/SE/orc/OrcHurt2.ogg",
	"Audio/SE/orc/OrcHurt3.ogg",
	"Audio/SE/orc/OrcHurt4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_OrcDeath(vol=80,effect=rand(10)+140)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/orc/OrcDeath1.ogg",
	"Audio/SE/orc/OrcDeath2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_OrcSkill(vol=80,effect=rand(10)+140)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/orc/OrcSkill1.ogg",
	"Audio/SE/orc/OrcSkill2.ogg",
	"Audio/SE/orc/OrcSkill3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.sound_OrcSpot(vol=80,effect=rand(10)+140)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/orc/OrcSpot1.ogg",
	"Audio/SE/orc/OrcSpot2.ogg",
	"Audio/SE/orc/OrcSpot3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
###################################					Ogre

def self.sound_OgreQuestion(vol=80,effect=120+rand(10))
	return if vol <=0
	vol+=20
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Ogre/OgreQuestion1.ogg",
	"Audio/SE/Ogre/OgreQuestion2.ogg",
	"Audio/SE/Ogre/OgreQuestion3.ogg",
	"Audio/SE/Ogre/OgreQuestion4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_OgreLost(vol=80,effect=120+rand(10))
	return if vol <=0
	vol+=20
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Ogre/OgreLost1.ogg",
	"Audio/SE/Ogre/OgreLost2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_OgreHurt(vol=80,effect=90+rand(20))
	return if vol <=0
	vol+=30
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Ogre/OgreHurt2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_OgreSkill(vol=80,effect=140+rand(10))
	return if vol <=0
	vol+=20
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Ogre/OgreSkill1.ogg",
	"Audio/SE/Ogre/OgreSkill2.ogg",
	"Audio/SE/Ogre/OgreSkill4.ogg",
	"Audio/SE/Ogre/OgreSkill5.ogg",
	"Audio/SE/Ogre/OgreSkill6.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_OgreSpot(vol=80,effect=100+rand(10))
	return if vol <=0
	vol+=30
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Ogre/OgreSpot3.ogg",
	"Audio/SE/Ogre/OgreSpot4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_OgreDed(vol=90,effect=70+rand(10))
	return if vol <=0
	vol+=30
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Ogre/OgreDed1.ogg",
	"Audio/SE/Ogre/OgreDed2X.ogg",
	"Audio/SE/Ogre/OgreDed3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_OgreSeSkill(vol=90,effect=80+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Ogre/OgreSeSkill.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
#################################################################################					Fishkind
def self.FishkindPuke(vol=80,effect=rand(10)+95)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindPuke1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

########################################## SM
def self.FishkindSmSkill(vol=80,effect=rand(10)+140)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindAtk1.ogg",
	"Audio/SE/fishkind/FishkindAtk2.ogg",
	"Audio/SE/fishkind/FishkindAtk3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.FishkindBabySkill(vol=80,effect=200)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindAtk1.ogg",
	"Audio/SE/fishkind/FishkindAtk2.ogg",
	"Audio/SE/fishkind/FishkindAtk3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.FishkindSmDed(vol=80,effect=rand(10)+140)
	return if vol <=0
	vol += 20
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindDed1.ogg",
	"Audio/SE/fishkind/FishkindDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.FishkindBabyDed(vol=80,effect=200)
	return if vol <=0
	vol += 20
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindDed1.ogg",
	"Audio/SE/fishkind/FishkindDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.FishkindSmQuestion(vol=80,effect=rand(10)+140)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindQuestion1.ogg",
	"Audio/SE/fishkind/FishkindQuestion2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.FishkindBabyQuestion(vol=80,effect=200)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindQuestion1.ogg",
	"Audio/SE/fishkind/FishkindQuestion2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.FishkindSmSpot(vol=80,effect=rand(10)+140)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindSpot1.ogg",
	"Audio/SE/fishkind/FishkindSpot2.ogg",
	"Audio/SE/fishkind/FishkindSpot3.ogg",
	"Audio/SE/fishkind/FishkindSpot4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.FishkindBabySpot(vol=80,effect=200)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindSpot1.ogg",
	"Audio/SE/fishkind/FishkindSpot2.ogg",
	"Audio/SE/fishkind/FishkindSpot3.ogg",
	"Audio/SE/fishkind/FishkindSpot4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.FishkindSmHurt(vol=80,effect=rand(10)+140)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	vol += 20
	temp_sounds= [
	"Audio/SE/fishkind/FishkindHurt1.ogg",
	"Audio/SE/fishkind/FishkindHurt2.ogg",
	"Audio/SE/fishkind/FishkindHurt3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.FishkindBabyHurt(vol=80,effect=200)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	vol += 20
	temp_sounds= [
	"Audio/SE/fishkind/FishkindHurt1.ogg",
	"Audio/SE/fishkind/FishkindHurt2.ogg",
	"Audio/SE/fishkind/FishkindHurt3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
########################################## large
def self.FishkindLgSkill(vol=80,effect=rand(10)+60)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindAtk1.ogg",
	"Audio/SE/fishkind/FishkindAtk2.ogg",
	"Audio/SE/fishkind/FishkindAtk3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.FishkindLgDed(vol=80,effect=rand(10)+60)
	return if vol <=0
	vol += 20
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindDed1.ogg",
	"Audio/SE/fishkind/FishkindDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.FishkindLgQuestion(vol=80,effect=rand(10)+60)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindQuestion1.ogg",
	"Audio/SE/fishkind/FishkindQuestion2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.FishkindLgSpot(vol=80,effect=rand(10)+60)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindSpot1.ogg",
	"Audio/SE/fishkind/FishkindSpot2.ogg",
	"Audio/SE/fishkind/FishkindSpot3.ogg",
	"Audio/SE/fishkind/FishkindSpot4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.FishkindLgHurt(vol=80,effect=rand(10)+60)
	return if vol <=0
	vol += 20
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/fishkind/FishkindHurt1.ogg",
	"Audio/SE/fishkind/FishkindHurt2.ogg",
	"Audio/SE/fishkind/FishkindHurt3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

#################################################################################					Human

def self.sound_MaleWarriorSpot(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorSpot1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_MaleWarriorHurt(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorHurt1.ogg",
	"Audio/SE/human/MaleWarriorHurt2.ogg",
	"Audio/SE/human/MaleWarriorHurt3.ogg",
	"Audio/SE/human/MaleWarriorHurt4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_MaleWarriorDed(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorDed1.ogg",
	"Audio/SE/human/MaleWarriorDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_MaleWarriorAtk(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorAtk1.ogg",
	"Audio/SE/human/MaleWarriorAtk2.ogg",
	"Audio/SE/human/MaleWarriorAtk3.ogg",
	"Audio/SE/human/MaleWarriorAtk4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_MaleWarriorQuestion(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorQuestion1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
###############################

def self.MaleWarriorGruntSpot(vol=80,effect=70+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorSpot1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.MaleWarriorGruntHurt(vol=80,effect=70+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorHurt1.ogg",
	"Audio/SE/human/MaleWarriorHurt2.ogg",
	"Audio/SE/human/MaleWarriorHurt3.ogg",
	"Audio/SE/human/MaleWarriorHurt4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.MaleWarriorGruntDed(vol=80,effect=70+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorDed1.ogg",
	"Audio/SE/human/MaleWarriorDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.MaleWarriorGruntAtk(vol=80,effect=70+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorAtk1.ogg",
	"Audio/SE/human/MaleWarriorAtk2.ogg",
	"Audio/SE/human/MaleWarriorAtk3.ogg",
	"Audio/SE/human/MaleWarriorAtk4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.MaleWarriorGruntQuestion(vol=80,effect=70+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorQuestion1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

###############################

def self.MaleWarriorFatSpot(vol=80,effect=70+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorSpot1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.MaleWarriorFatHurt(vol=80,effect=70+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorHurt1.ogg",
	"Audio/SE/human/MaleWarriorHurt2.ogg",
	"Audio/SE/human/MaleWarriorHurt3.ogg",
	"Audio/SE/human/MaleWarriorHurt4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.MaleWarriorFatDed(vol=80,effect=70+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FatDeath1.ogg",
	"Audio/SE/human/FatDeath2.ogg",
	"Audio/SE/human/FatDeath3.ogg",
	"Audio/SE/human/FatDeath4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.MaleWarriorFatAtk(vol=80,effect=70+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FatAtk1.ogg",
	"Audio/SE/human/FatAtk2.ogg",
	"Audio/SE/human/FatAtk3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.MaleWarriorFatQuestion(vol=80,effect=70+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/MaleWarriorQuestion1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
######################################################################################### CoconaUnique

def self.CoconaLost(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/human/CoconaLost01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.CoconaSpot(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/human/CoconaSpot01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.CoconaAtk(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/human/CoconaAtk01.ogg",
		"Audio/SE/human/CoconaAtk02.ogg",
		"Audio/SE/human/CoconaAtk03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.CoconaHurt(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/human/CoconaHurt01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.CoconaDed(vol=100,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/human/CoconaDed01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

######################################################################################### 

def self.HumanBabyCry(vol=80,effect=95+rand(10))
	vol -= 10
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/human/HumanBabyCry01.ogg",
		"Audio/SE/human/HumanBabyCry02.ogg",
		"Audio/SE/human/HumanBabyCry03.ogg",
		"Audio/SE/human/HumanBabyCry04.ogg",
		"Audio/SE/human/HumanBabyCry05.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.HumanBabySpot(vol=80,effect=80)
	vol -= 10
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/human/HumanBabyCry01.ogg",
		"Audio/SE/human/HumanBabyCry02.ogg",
		"Audio/SE/human/HumanBabyCry03.ogg",
		"Audio/SE/human/HumanBabyCry04.ogg",
		"Audio/SE/human/HumanBabyCry05.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.teenLowLost(vol=80,effect=95+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/human/TeenGirlLost1.ogg",
		"Audio/SE/human/TeenGirlLost2.ogg",
		"Audio/SE/human/TeenGirlLost3.ogg",
		"Audio/SE/human/TeenGirlLost4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.teenLowHurt(vol=80,effect=82+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/TeenSpot1.ogg",
	"Audio/SE/human/TeenSpot3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.teenLowDed(vol=80,effect=85+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/TeenAr1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.teenLowAtk(vol=80,effect=82+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/TeenSpot2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.teenLowQuestion(vol=80,effect=87+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/TeenQuestion1.ogg",
	"Audio/SE/human/TeenQuestion2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

#########################################################################################
def self.teenHighLost(vol=80,effect=107+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/human/TeenGirlLost1.ogg",
		"Audio/SE/human/TeenGirlLost2.ogg",
		"Audio/SE/human/TeenGirlLost3.ogg",
		"Audio/SE/human/TeenGirlLost4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.teenHighHurt(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/TeenSpot1.ogg",
	"Audio/SE/human/TeenSpot3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.teenHighDed(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/TeenAr1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.teenHighAtk(vol=80,effect=90+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/TeenSpot2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.teenHighQuestion(vol=80,effect=100+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/TeenQuestion1.ogg",
	"Audio/SE/human/TeenQuestion2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

#########################################################################################

def self.sound_HumanFemaleAtk(vol=80,effect=98+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleAtk.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.sound_HumanFemaleSpot(vol=80,effect=98+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleSpot1.ogg",
	"Audio/SE/human/FemaleSpot2.ogg",
	"Audio/SE/human/FemaleSpot3.ogg",
	"Audio/SE/human/FemaleSpot4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.sound_HumanFemaleLost(vol=80,effect=98+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleLost1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_HumanFemaleDed(vol=80,effect=98+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleDed1.ogg",
	"Audio/SE/human/FemaleDed2.ogg",
	"Audio/SE/human/FemaleDed3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

########################################
def self.sound_HumanFemaleGruntSpot(vol=80,effect=100+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleGruntSpot1.ogg",
	"Audio/SE/human/FemaleGruntSpot2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_HumanFemaleGruntAtk(vol=80,effect=100+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleGruntAtk1.ogg",
	"Audio/SE/human/FemaleGruntAtk2.ogg",
	"Audio/SE/human/FemaleGruntAtk3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.sound_HumanFemaleGruntDed(vol=100,effect=100+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleGruntDed1.ogg",
	"Audio/SE/human/FemaleGruntDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

########################################
def self.FemaleWarriorSpot(vol=80,effect=110+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleGruntSpot1.ogg",
	"Audio/SE/human/FemaleGruntSpot2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.FemaleWarriorAtk(vol=80,effect=110+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleGruntAtk1.ogg",
	"Audio/SE/human/FemaleGruntAtk2.ogg",
	"Audio/SE/human/FemaleGruntAtk3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.FemaleWarriorDed(vol=100,effect=110+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleGruntDed1.ogg",
	"Audio/SE/human/FemaleGruntDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

########################################
def self.FemaleWarriorHighSpot(vol=90,effect=120+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleGruntSpot1.ogg",
	"Audio/SE/human/FemaleGruntSpot2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.FemaleWarriorHighAtk(vol=90,effect=120+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleGruntAtk1.ogg",
	"Audio/SE/human/FemaleGruntAtk2.ogg",
	"Audio/SE/human/FemaleGruntAtk3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.FemaleWarriorHighDed(vol=100,effect=120+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/human/FemaleGruntDed1.ogg",
	"Audio/SE/human/FemaleGruntDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


######################################################################################################################## Animal
########################### Monkey
def self.MonkeyAggro(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/MonkeyAggro0.ogg",
	"Audio/SE/MonkeyAggro1.ogg",
	"Audio/SE/MonkeyAggro2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.MonkeyDed(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/MonkeyDed0.ogg",
	"Audio/SE/MonkeyDed1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.MonkeyAlert(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/MonkeyAlert0.ogg",
	"Audio/SE/MonkeyAlert1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.MonkeyLost(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/MonkeyLost0.ogg",
	"Audio/SE/MonkeyLost1.ogg",
	"Audio/SE/MonkeyLost2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.MonkeyQuestion(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/MonkeyQuestion0.ogg",
	"Audio/SE/MonkeyQuestion1.ogg",
	"Audio/SE/MonkeyQuestion2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.MonkeySkill(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/MonkeySkill0.ogg",
	"Audio/SE/MonkeySkill1.ogg",
	"Audio/SE/MonkeySkill2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


########################### Rat
def self.ratHurt(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/RatDed1.ogg",
	"Audio/SE/RatDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.ratHurtHigh(vol=80,effect=130+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/RatDed1.ogg",
	"Audio/SE/RatDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.ratAtk(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/RatAtk1.ogg",
	"Audio/SE/RatAtk2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.ratAtkHigh(vol=80,effect=130+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/RatAtk1.ogg",
	"Audio/SE/RatAtk2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.ratSpot(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/RatSpot1.ogg",
	"Audio/SE/RatSpot2.ogg",
	"Audio/SE/RatSpot3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.ratSpotHigh(vol=80,effect=130+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/RatSpot1.ogg",
	"Audio/SE/RatSpot2.ogg",
	"Audio/SE/RatSpot3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

################

def self.horseIdle_evil(vol=80,effect=80+rand(7))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/HorseIdle01.ogg",
	"Audio/SE/HorseIdle02.ogg",
	"Audio/SE/HorseIdle03.ogg",
	"Audio/SE/HorseIdle04.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.horseIdle(vol=80,effect=100+rand(7))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/HorseIdle01.ogg",
	"Audio/SE/HorseIdle02.ogg",
	"Audio/SE/HorseIdle03.ogg",
	"Audio/SE/HorseIdle04.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.horseDed(vol=80,effect=100+rand(7))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/HorseDed01.ogg",
	"Audio/SE/HorseDed02.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.SwineAggro(vol=95,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/PigAggro00.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.SwineAtk(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/PigAtk00.ogg",
	"Audio/SE/PigAtk01.ogg",
	"Audio/SE/PigAtk02.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.SwineSpot(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/PigSpot00.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.SwineDed(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/PigDed00.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.pigQuestion(vol=80,effect=100+rand(7))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/pig1.ogg",
	"Audio/SE/pig2.ogg",
	"Audio/SE/pig3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.pigHurt(vol=80,effect=80+rand(40))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/pigDed1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.pigSpot(vol=80,effect=100+rand(7))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/pigSpot1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.ChickenSpot(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Chicken01.ogg",
	"Audio/SE/Chicken02.ogg",
	"Audio/SE/Chicken03.ogg",
	"Audio/SE/Chicken04.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.ChickenIdle(vol=80,effect=95+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/ChickenIDLE01.ogg",
	"Audio/SE/ChickenIDLE02.ogg",
	"Audio/SE/ChickenIDLE03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.CrowYelling(vol=80,effect=85+rand(16))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/CreepyCrow.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.BirdWing(vol=85,effect=95+rand(11))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/BirdWing01.ogg",
	"Audio/SE/BirdWing02.ogg",
	"Audio/SE/BirdWing03.ogg",
	"Audio/SE/BirdWing04.ogg",
	"Audio/SE/BirdWing05.ogg",
	"Audio/SE/BirdWing06.ogg",
	"Audio/SE/BirdWing07.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

################ ROBOT


def self.sound_robot_idle(vol=85,effect=95+rand(11))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/ROBOTIC_Servo_Small_Movement_Slow_mono.ogg",
		"Audio/SE/ROBOTIC_Servo_Small_Movement_Surge_mono.ogg",
		"Audio/SE/ROBOTIC_Servo_Small_One_Long_Two_Short_mono.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_robot_spot(vol=100,effect=95+rand(11))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/Dark Robotic Voice - Self Destruction Initiated.ogg",
		"Audio/SE/Dark Robotic Voice - Destroy Them.ogg",
		"Audio/SE/Dark Robotic Voice - Exterminate.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

################
################################
################################   ABOM
################################
################################ Breedling

def self.BreedlingAtk(vol=80,effect=145+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/BreedlingAtk01.ogg",
	"Audio/SE/Abom/BreedlingAtk02.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.BreedlingDed(vol=80,effect=135+rand(60))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/BreedlingDed01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.BreedlingPain(vol=80,effect=135+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/BreedlingPain01.ogg",
	"Audio/SE/Abom/BreedlingPain02.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.BreedlingSpot(vol=80,effect=165+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/BreedlingSpot01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

################

def self.sound_WormSpotAtk(vol=80,effect=140+rand(70))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelDed1.ogg",
	"Audio/SE/Abom/SqueelDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_WormMoonAtk(vol=80,effect=200+rand(100))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelSpot1.ogg",
	"Audio/SE/Abom/SqueelSpot2.ogg",
	"Audio/SE/Abom/SqueelSpot3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_WormMoonQuestion(vol=80,effect=200+rand(100))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelSpot1.ogg",
	"Audio/SE/Abom/SqueelSpot2.ogg",
	"Audio/SE/Abom/SqueelSpot3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.sound_MoodWormDed(vol=80,effect=100+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelDed1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_WormQuestion(vol=80,effect=200+rand(100))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelDed1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.sound_WormDed(vol=80,effect=200+rand(100))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelSpot4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_WormCommonLow(vol=80,effect=60+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/Worm1.ogg",
	"Audio/SE/Abom/Worm2.ogg",
	"Audio/SE/Abom/Worm3.ogg",
	"Audio/SE/Abom/Worm4.ogg",
	"Audio/SE/Abom/Worm5.ogg",
	"Audio/SE/Abom/Worm6.ogg",
	"Audio/SE/Abom/Worm7.ogg",
	"Audio/SE/Abom/Worm8.ogg",
	"Audio/SE/Abom/Worm9.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.sound_WormCommon(vol=80,effect=130+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/Worm1.ogg",
	"Audio/SE/Abom/Worm2.ogg",
	"Audio/SE/Abom/Worm3.ogg",
	"Audio/SE/Abom/Worm4.ogg",
	"Audio/SE/Abom/Worm5.ogg",
	"Audio/SE/Abom/Worm6.ogg",
	"Audio/SE/Abom/Worm7.ogg",
	"Audio/SE/Abom/Worm8.ogg",
	"Audio/SE/Abom/Worm9.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_WormCommonLoud(vol=90,effect=80+rand(30))
	return if vol <=0
	vol+=20
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/Worm1.ogg",
	"Audio/SE/Abom/Worm2.ogg",
	"Audio/SE/Abom/Worm3.ogg",
	"Audio/SE/Abom/Worm4.ogg",
	"Audio/SE/Abom/Worm5.ogg",
	"Audio/SE/Abom/Worm6.ogg",
	"Audio/SE/Abom/Worm7.ogg",
	"Audio/SE/Abom/Worm8.ogg",
	"Audio/SE/Abom/Worm9.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_WormCommonDed(vol=80,effect=250+rand(50))
	return if vol <=0
	vol+=30
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/Worm1.ogg",
	"Audio/SE/Abom/Worm2.ogg",
	"Audio/SE/Abom/Worm3.ogg",
	"Audio/SE/Abom/Worm4.ogg",
	"Audio/SE/Abom/Worm5.ogg",
	"Audio/SE/Abom/Worm6.ogg",
	"Audio/SE/Abom/Worm7.ogg",
	"Audio/SE/Abom/Worm8.ogg",
	"Audio/SE/Abom/Worm9.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_WormCommonDedLoud(vol=90,effect=150+rand(50))
	return if vol <=0
	vol+=40
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/Worm1.ogg",
	"Audio/SE/Abom/Worm2.ogg",
	"Audio/SE/Abom/Worm3.ogg",
	"Audio/SE/Abom/Worm4.ogg",
	"Audio/SE/Abom/Worm5.ogg",
	"Audio/SE/Abom/Worm6.ogg",
	"Audio/SE/Abom/Worm7.ogg",
	"Audio/SE/Abom/Worm8.ogg",
	"Audio/SE/Abom/Worm9.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.AbomBatSpot(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelSpot1.ogg",
	"Audio/SE/Abom/SqueelSpot2.ogg",
	"Audio/SE/Abom/SqueelSpot3.ogg",
	"Audio/SE/Abom/SqueelSpot4.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.AbomBatAtk(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelSkill1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.AbomBatQuestion(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelQuestion1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.AbomBatHurt(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelHurt1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.AbomBatDed(vol=80,effect=85+rand(30))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelDed1.ogg",
	"Audio/SE/Abom/SqueelDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

#############################################################################################################

def self.sound_TetacleHurt(vol=80,effect=45+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelHurt1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_TetacleSpot(vol=80,effect=45+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelQuestion1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_TetacleDed(vol=80,effect=45+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelDed1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_TetacleAtk(vol=80,effect=45+rand(10))
	vol -= 20
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelSpot2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.sound_ManagerHurt(vol=80,effect=30+rand(5))
	return if vol <=0
	vol+=20
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelHurt1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_ManagerSpot(vol=80,effect=30+rand(5))
	return if vol <=0
	vol+=20
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelQuestion1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.sound_ManagerDed(vol=80,effect=30+rand(5))
	return if vol <=0
	vol+=20
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelDed1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.sound_ManagerAtk(vol=80,effect=25+rand(5))
	return if vol <=0
	vol+=10
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Abom/SqueelSpot2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

#############################################################################################################

def self.dogSpot(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/DogSpot1.ogg",
	"Audio/SE/DogSpot2.ogg",
	"Audio/SE/DogSpot3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.dogAtk(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/DogAtk1.ogg",
	"Audio/SE/DogAtk2.ogg",
	"Audio/SE/DogAtk3.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.dogDead(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/DogHurt1.ogg",
	"Audio/SE/DogHurt2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.dogHurt(vol=80,effect=110+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/DogGrowl1.ogg",
	"Audio/SE/DogGrowl2.ogg",
	"Audio/SE/DogGrowl3.ogg",
	"Audio/SE/DogGrowl4.ogg",
	"Audio/SE/DogGrowl5.ogg",
	"Audio/SE/DogGrowl6.ogg",
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end



def self.catSpot(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/CatSpot1.ogg",
	"Audio/SE/CatSpot2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.catAtk(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/CatAtk1.ogg",
	"Audio/SE/CatAtk2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.catDead(vol=80,effect=90+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/CatDed1.ogg",
	"Audio/SE/CatDed2.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


def self.catHurt(vol=80,effect=110+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/CatHurt1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.catPurr(vol=80,effect=110+rand(20))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/CatPurr1.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.HeavySeaWave(vol=80,effect=200)
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/WATER_Sea_Waves_Big_10sec_loop_stereo.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.HarpWaveHigh(vol=80,effect=150+rand(50))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Puzzle Clue HARP.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end

def self.HarpWaveLow(vol=80,effect=110+rand(50))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
	"Audio/SE/Puzzle Solved HARP.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end


###################################################### FishFistMaster ######################################################################

def self.FishFistMasterDash(vol=90,effect=65+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/FistMaster/Wind_Whoosh_01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.FishFistMasterSkill(vol=90,effect=65+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	vol += 10
	temp_sounds= [
		"Audio/SE/FistMaster/TigerCreature_02.ogg",
		"Audio/SE/FistMaster/TigerCreature_03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.FishFistMasterAggro(vol=90,effect=65+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	vol += 10
	temp_sounds= [
		"Audio/SE/FistMaster/ANIMAL_Tiger_Growl_02.ogg",
		"Audio/SE/FistMaster/ANIMAL_Tiger_Growl_04.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.FishFistMasterSpot1(vol=90,effect=65+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	vol += 10
	temp_sounds= [
		"Audio/SE/FistMaster/TigerCreature_03.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.FishFistMasterSpot2(vol=90,effect=65+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	vol += 10
	temp_sounds= [
		"Audio/SE/FistMaster/TigerCreature_01.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
def self.FishFistMasterHurt(vol=90,effect=65+rand(10))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/FistMaster/TigerCreature_02.ogg",
		"Audio/SE/FistMaster/TigerCreature_04.ogg"
	]
	Audio.se_play(temp_sounds[rand(temp_sounds.length)],vol,effect)
end
###################################################### for dev ######################################################################
def self.test(vol=80,effect=118+rand(5))
	return if vol <=0
	vol = (vol * ($data_SNDvol * 0.01)).to_i
	temp_sounds= [
		"Audio/SE/human/FemaleLost1.ogg"
	]
	asd= temp_sounds[rand(temp_sounds.length)]
	p asd
	Audio.se_play(asd,vol,effect)
end
############################################################################################################################

end#class
