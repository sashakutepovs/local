
summon_hold :holding技能使用的特殊特效",

"projectile_type": 0, melee
"projectile_type": 1, grid missile
"projectile_type": 2, AOE redirect (skip friendly, redirect only)
"projectile_type": 3, skip friendly

			when "none";@hold_type = 0;	#一般攻擊，沒有holding
			when "holding";@hold_type = 1; #舉著一個東西啥事都沒有
			when "blocking";@hold_type = 2; #舉盾
			when "energizing";@hold_type = 3; #蓄力攻擊

	"effect": [{
			"race_skip": ["Human"],    >> Human will remain 1 damage effect
			"race_only": ["Human"],    >> only Human with full damage,  otherwise with only 1
