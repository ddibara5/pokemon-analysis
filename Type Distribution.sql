--Count of each type, comparison of primary vs. secondary types, prep for visualization of type frequency.
WITH type_comparison AS (
     SELECT type1 AS description, 'Type 1' AS type_group, COUNT(*) AS type_count
     FROM `pokemon_data.pokemon` AS p
     GROUP BY type1

     UNION ALL 

     SELECT type2 AS description, 'Type 2' AS type_group, COUNT(*) AS type_count
     FROM `pokemon_data.pokemon` AS p
     GROUP BY type2
     ORDER BY type_group, type_count DESC)
--Summary statistics for visualization
SELECT t.description, 
       t.type_group, 
       SUM(type_count) AS total_type,
       (SELECT COUNT(*) FROM `pokemon_data.pokemon`) AS total_pokemon
  FROM type_comparison AS t
 GROUP BY 1,2
 ORDER BY t.type_group ASC;