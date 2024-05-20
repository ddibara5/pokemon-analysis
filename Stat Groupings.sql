--Calculations of mean and standard deviation for stats; Setting thresholds for high, average and low groupings

CREATE OR REPLACE VIEW pokemon_data.stat_groupings AS(
SELECT p.dexnum,
       CASE 
        WHEN (SELECT p1.hp
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) > (SELECT mean_hp + stddev_hp FROM pokemon_data.summary_stats) THEN 'High HP'
        WHEN (SELECT p1.hp
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) BETWEEN (SELECT mean_hp - stddev_hp FROM pokemon_data.summary_stats) 
               AND (SELECT mean_hp + stddev_hp FROM pokemon_data.summary_stats) THEN 'Average HP'
        WHEN (SELECT p1.hp
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) <= (SELECT mean_hp + stddev_hp FROM pokemon_data.summary_stats) THEN 'Low HP'
        ELSE 'No HP'
       END AS hp_group,
       CASE 
        WHEN (SELECT p1.attack
                FROM `pokemon_data.pokemon` as p1
               WHERE p1.dexnum = p.dexnum) > (SELECT mean_attack + stddev_atk FROM pokemon_data.summary_stats) THEN 'High attack'
        WHEN (SELECT p1.attack
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) BETWEEN (SELECT mean_attack - stddev_atk FROM pokemon_data.summary_stats) 
               AND (SELECT mean_attack + stddev_atk FROM pokemon_data.summary_stats) 
                THEN 'Average attack'
        WHEN (SELECT p1.attack
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) <= (SELECT mean_attack + stddev_atk FROM pokemon_data.summary_stats) THEN 'Low attack'
        ELSE 'No attack'
       END AS attack_group,
       CASE
        WHEN (SELECT p1.defense
                FROM `pokemon_data.pokemon` as p1
               WHERE p1.dexnum = p.dexnum) > (SELECT mean_defense + stddev_def FROM pokemon_data.summary_stats) THEN 'High defense'
        WHEN (SELECT p1.defense
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) BETWEEN (SELECT mean_defense - stddev_def FROM pokemon_data.summary_stats) 
                AND (SELECT mean_defense + stddev_def FROM pokemon_data.summary_stats) THEN 'Average defense'
        WHEN (SELECT p1.defense
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) <= (SELECT mean_defense + stddev_def FROM pokemon_data.summary_stats) THEN 'Low defense'
        ELSE 'No defense'
       END AS defense_group,
       CASE
        WHEN (SELECT p1.speed
                FROM `pokemon_data.pokemon` as p1
               WHERE p1.dexnum = p.dexnum) > (SELECT mean_speed + stddev_speed FROM pokemon_data.summary_stats) THEN 'High speed'
        WHEN (SELECT p1.speed
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) BETWEEN (SELECT mean_speed - stddev_speed FROM pokemon_data.summary_stats) 
                AND (SELECT mean_speed + stddev_speed FROM pokemon_data.summary_stats) THEN 'Average speed'
        WHEN (SELECT p1.speed
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) <= (SELECT mean_speed + stddev_speed FROM pokemon_data.summary_stats) THEN 'Low speed'
        ELSE 'No speed'
       END AS speed_group,
       CASE
        WHEN (SELECT p1.sp_atk
                FROM `pokemon_data.pokemon` as p1
               WHERE p1.dexnum = p.dexnum) > (SELECT mean_sp_atk + stddev_sp_atk FROM pokemon_data.summary_stats) THEN 'High SP Attack'
        WHEN (SELECT p1.sp_atk
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) BETWEEN (SELECT mean_sp_atk - stddev_sp_atk FROM pokemon_data.summary_stats) 
                AND (SELECT mean_sp_atk + stddev_sp_atk FROM pokemon_data.summary_stats) THEN 'Average SP Attack'
        WHEN (SELECT p1.sp_atk
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) <= (SELECT mean_sp_atk + stddev_sp_atk FROM pokemon_data.summary_stats) THEN 'Low SP Attack'
        ELSE 'No SP Attack'
       END AS sp_atk_group,
       CASE
        WHEN (SELECT p1.sp_def
                FROM `pokemon_data.pokemon` as p1
               WHERE p1.dexnum = p.dexnum) > (SELECT mean_sp_def + stddev_sp_def FROM pokemon_data.summary_stats) THEN 'High SP Defense'
        WHEN (SELECT p1.sp_def
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) BETWEEN (SELECT mean_sp_def - stddev_sp_def FROM pokemon_data.summary_stats) 
                AND (SELECT mean_sp_def + stddev_sp_def FROM pokemon_data.summary_stats) THEN 'Average SP Defense'
        WHEN (SELECT p1.sp_def
                FROM `pokemon_data.pokemon` AS p1
               WHERE p.dexnum = p1.dexnum) <= (SELECT mean_sp_def + stddev_sp_def FROM pokemon_data.summary_stats) THEN 'Low SP Defense'
        ELSE 'No SP Defense'
       END AS sp_def_group,
  FROM `pokemon_data.pokemon` AS p
 GROUP BY p.dexnum
 ORDER BY p.dexnum ASC)
