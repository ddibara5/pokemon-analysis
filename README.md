# Pokémon Statistical Analysis

## Overview

This project utilizes SQL to delve into various facets of Pokémon attributes and behaviors, ranging from type distribution and statistical analysis of their attack and defense stats Through a series of structured queries and data visualizations, this project aims to uncover trends, anomalies, and correlations within the Pokémon dataset, demonstrating comprehensive data manipulation and analysis skills.

## Dataset
- Information about all Pokémon registered within the National Dex - [Kaggle](https://www.kaggle.com/datasets/guavocado/pokemon-stats-1025-pokemons)

## Tools
- Google BigQuery for Data Analysis
- Looker Studio for Visualization - [Dashboard](https://lookerstudio.google.com/reporting/5698d915-716f-4608-8725-4b238d285ae9)

## Code Overview

| File Name | Description | Skills Demonstrated | 
|-----------|-------------|---------------------|
| [Stat Groupings](https://github.com/ddibara5/pokemon-analysis/blob/main/Stat%20Groupings.sql) | Calculation of average & standard deviation for each pokemon statistic. Grouping into high, average and low categories for composite scoring. | Summary statistics, Case statements |
| [Composite Scoring](https://github.com/ddibara5/pokemon-analysis/blob/main/Composite%20Scoring.sql) | Define composite scoring process giving higher value to more important statistics | Case statements, Joins |
| [Evolution Parsing](https://github.com/ddibara5/pokemon-analysis/blob/main/Evolution%20Parsing.sql) | Parse the evolutionary stage of each pokemon from a string field | Array Formulas, Text Splitting, Concatenation |
| [Evolution Chain](https://github.com/ddibara5/pokemon-analysis/blob/main/Evolution%20Chain.sql) | Create a combined table with raw data, composite scoring and evolutionary stages. Also create a base pokemon field which displays the 1st evolution for all pokemon | Self Joins, Recursive CTEs, Less Common Joins |
| [Type Distribution](https://github.com/ddibara5/pokemon-analysis/blob/main/Type%20Distribution.sql) | Summary calculations for primary and secondary types | CTEs, Summary statistics |

## Dashboard Highlights

![image](https://github.com/ddibara5/pokemon-analysis/assets/169186597/f67e6b29-906c-4bc7-a241-3c5a7344a37f)

![image](https://github.com/ddibara5/pokemon-analysis/assets/169186597/8e3f0621-31fe-4bf1-b681-5743efcb146e)
