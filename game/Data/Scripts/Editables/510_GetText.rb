module GetText


def self.lona_race
	case $game_player.actor.stat["RaceRecord"]
		when "Human"					;$game_text["menu:main_stats/race_Human"]
		when "PreDeepone"				;$game_text["menu:main_stats/race_Deepone"]
		when "Moot"						;$game_text["menu:main_stats/race_Moot"]
		when "TrueDeepone"				;$game_text["menu:main_stats/race_SeaWitch"]
		when "Abomination"				; tmpAwaked = $game_player.actor.skill_learn?($data_SkillName["BasicAbomEatDed"]) # 67
										  if tmpAwaked
											$game_text["DataNpcName:race/Abomination"]
										  else
											if $game_player.actor.stat["Race"] == "Human"
												$game_text["menu:main_stats/race_Human"]
											else
												$game_text["menu:main_stats/race_Moot"]
											end
										  end
		else							;"NoData"
	end
end

def self.lona_persona
	case $game_player.actor.stat["persona"]
		when "typical"			;$game_text["menu:main_stats/persona_typical"]
		when "gloomy"			;$game_text["menu:main_stats/persona_gloomy"]
		when "tsundere"			;$game_text["menu:main_stats/persona_tsundere"]
		when "slut"				;$game_text["menu:main_stats/persona_slut"]
		else 					;"NoData"
	end
end


def self.lona_sex_skill(tar_val)
    tar_val = tar_val.round
    case tar_val
		when 0..30            ;$game_text["menu:sex_stats/battle_stats_inexperienced"]
		when 31..50            ;$game_text["menu:sex_stats/battle_stats_exped"]
		when 51..70            ;$game_text["menu:sex_stats/battle_stats_skilled"]
		else        ;$game_text["menu:sex_stats/battle_stats_master"]
    end
end


def self.lona_hole_broken_level(tar_val)
    tar_val = tar_val.round
    case tar_val
        when 0..1000            ;[$game_text["menu:sex_stats/main_hole_tight"]	,0];
        when 1001..2000         ;[$game_text["menu:sex_stats/main_hole_narrow"] ,1];
        when 2001..4000         ;[$game_text["menu:sex_stats/main_hole_used"]   ,2];
        when 4001..8000         ;[$game_text["menu:sex_stats/main_hole_gaping"] ,3];
        when 8001..20000        ;[$game_text["menu:sex_stats/main_hole_ruined"] ,4];
        else                    ;["NoData"                                   ,0];
    end
end

def self.lona_belly_size
    case $game_player.actor.stat["preg"]
        when 0            ;$game_text["menu:sex_stats/main_belly_normal"]
        when 1            ;$game_text["menu:sex_stats/main_belly_preg1"]
        when 2            ;$game_text["menu:sex_stats/main_belly_preg2"]
        when 3            ;$game_text["menu:sex_stats/main_belly_preg3"]
        else                     ;"NoData"
    end
end

def self.lona_wounds(tar)
	if tar >=1
		$game_text["menu:body_stats/common_wound"]
	else
		$game_text["menu:nil/nil"]
	end
end

def self.lona_cums(tar)
	if tar >=1 
		$game_text["menu:body_stats/common_semen"]
	else
		$game_text["menu:nil/nil"]
	end
end

def self.lona_piercings(tar)
	if tar >=1 
		$game_text["menu:body_stats/common_piercing"]
	else
		$game_text["menu:nil/nil"]
	end
end

def self.time
	return $game_text["menu:main_stats/date_day"]  if $game_date.day?
	return $game_text["menu:main_stats/date_night"]  if  $game_date.night?
end

end #class
