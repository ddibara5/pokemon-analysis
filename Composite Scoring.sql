--Define composite scoring definitions as new table
CREATE OR REPLACE TABLE `pokemon_data.composite_scoring` AS
  WITH scoring_def AS (
    SELECT p.dexnum,
          p.name,
          p.generation,
          CASE
            WHEN s.hp_group = 'High HP' THEN 3
            WHEN s.hp_group = 'Average HP' THEN 2
            WHEN s.hp_group = 'Low HP' THEN 1
            ELSE .5
          END AS hp_score,
          CASE
            WHEN s.attack_group = 'High attack' THEN 3
            WHEN s.attack_group = 'Average attack' THEN 2
            WHEN s.attack_group = 'Low attack' THEN 1
            ELSE .5
          END AS atk_score,
          CASE
            WHEN s.defense_group = 'High defense' THEN 1.5
            WHEN s.defense_group = 'Average defense' THEN 1
            WHEN s.defense_group = 'Low defense' THEN 0.5
            ELSE .25
          END AS defense_score,
          CASE
            WHEN s.speed_group = 'High speed' THEN 1.5
            WHEN s.speed_group = 'Average speed' THEN 1
            WHEN s.speed_group = 'Low speed' THEN .5
            ELSE .25
          END AS speed_score,
          CASE
            WHEN s.sp_atk_group = 'High SP Attack' THEN 6
            WHEN s.sp_atk_group = 'Average SP Attack' THEN 3
            WHEN s.sp_atk_group = 'Low SP Attack' THEN 2
            ELSE 1
          END AS sp_atk_score,
          CASE
            WHEN s.sp_def_group = 'High SP Defense' THEN 6
            WHEN s.sp_def_group = 'Average SP Defense' THEN 3
            WHEN s.sp_def_group = 'Low SP Defense' THEN 2
            ELSE 1
          END AS sp_def_score,
      FROM `pokemon_data.pokemon` AS p
      JOIN pokemon_data.stat_groupings as s
        ON p.dexnum = s.dexnum)

  SELECT dexnum, name, generation,
        (hp_score + atk_score + defense_score + speed_score + sp_atk_score + sp_def_score) AS composite_score
    FROM pokemon_data.composite_scoring
  ORDER BY composite_score DESC;