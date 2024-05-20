--Create a view that joins evolution data with all raw pokemon data
CREATE OR REPLACE VIEW pokemon_data.evolution_view AS
  SELECT p.dexnum,
       e.evolution,
       p.name
  FROM `pokemon_data.pokemon` AS p
  JOIN `pokemon_data.evolution_parse` AS e
    ON p.dexnum = e.dexnum;
--Create a view that displays evolutionary relationships as separate columns
CREATE OR REPLACE VIEW pokemon_data.evolution_chain AS
  SELECT e.dexnum,
         e.name AS name1,
         e.evolution AS evolution1,
        e1.name AS name2,
         e1.evolution AS evolution2,
         e2.name AS name3,
         e2.evolution AS evolution3
   FROM pokemon_data.evolution_view AS e 
   LEFT JOIN pokemon_data.evolution_view AS e1
     ON e1.dexnum = e.dexnum + 1 AND e1.evolution = e.evolution + 1
   LEFT JOIN pokemon_data.evolution_view AS e2
     ON e2.dexnum = e1.dexnum + 1 AND e2.evolution = e1.evolution + 1;
--Create a view that unions evolution level 2 and 3 pokemon together for recursive CTE processing
CREATE OR REPLACE VIEW pokemon_data.evolution_2_3_join AS 
  SELECT e1.dexnum,
         e1.name1,
         e1.evolution1
    FROM pokemon_data.evolution_chain AS e1
   WHERE e1.evolution1 = 2
   UNION ALL 
   SELECT e2.dexnum,
         e2.name1,
         e2.evolution1
    FROM pokemon_data.evolution_chain AS e2
   WHERE e2.evolution1 = 3;
--Utilize recursive CTE to join base level pokemon with evolutions 2 and 3, keeping base pokemon relationship
CREATE OR REPLACE VIEW pokemon_data.final_evolution_join AS
  WITH RECURSIVE evolution_join AS(
    SELECT e.dexnum,
          e.name1 AS pokemon_name,
          name1 AS base_pokemon,
          e.evolution1,
          1 AS level
      FROM pokemon_data.evolution_chain AS e
    WHERE e.evolution1 = 1
    
    UNION ALL
    
    SELECT e1.dexnum,
          e1.name1,
          j.base_pokemon,
          e1.evolution1,
          j.level + 1
      FROM pokemon_data.evolution_2_3_join AS e1
      JOIN evolution_join AS j
      ON e1.dexnum = j.dexnum + 1 AND e1.evolution1 = j.evolution1 + 1)


  SELECT dexnum, base_pokemon, pokemon_name, evolution1, level
    FROM evolution_join
  ORDER BY dexnum ASC;
--Create final table joins to connect raw data with composite scoring and evolution join
CREATE OR REPLACE VIEW pokemon_data.evolution_analysis AS
  SELECT p.dexnum, 
        p.name, 
        f.base_pokemon, 
        f.evolution1 AS evolution, 
        p.type1, 
        p.type2,
        p.generation,
        p.species, 
        p.hp, 
        p.attack, 
        p.defense, 
        p.speed, 
        p.sp_atk, 
        p.sp_def, 
        c.composite_score
    FROM `pokemon_data.pokemon` AS p
    LEFT JOIN `pokemon_data.final_evolution_join` AS f
      ON p.dexnum = f.dexnum
    JOIN pokemon_data.composite_scoring AS c
      ON p.dexnum = c.dexnum
  ORDER BY p.dexnum ASC;
--Data currently does not account for non-sequential evolution patterns or pokemon with multiple 2nd or 3rd stage evolutions such as Evee.