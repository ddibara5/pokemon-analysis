--This code parses the evolution of each pokemon from the ev_yield field by removing all letters and summing remaining values
CREATE OR REPLACE VIEW pokemon_data.evolution_parse AS
WITH ev_clean AS(
SELECT p.dexnum, 
       p.name, 
       p.ev_yield,
       REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(p.ev_yield,'Sp. Atk',''),'Speed',''),'HP',''),'Attack',''),'Defense',''),'Sp. Def','') AS ev_cleaned
  FROM pokemon_data.pokemon AS p
 ORDER BY p.dexnum ASC)

 SELECT e.dexnum, e.name, SUM(CAST(sub_ev AS int64)) AS evolution
   FROM ev_clean AS e,
        UNNEST(SPLIT(ev_cleaned,',')) AS sub_ev
  GROUP BY 1,2
  ORDER BY e.dexnum ASC;