# Toolbox of interventions against online misinformation

A [workflowr][] project.


Data and code for the project "Toolbox of interventions against online misinformation".
All data & code to reproduce the website supplement https://interventionstoolbox.mpib-berlin.mpg.de/ are available in this repo.


## Overview

| file/folder | description |
|:--|:--|
| `analysis` | RMarkdown files that create all web pages and tables.|
| `code` | R script to process JSON column in the evidence table -- it creates infos_raw and infos_refined.json (required for the table_evidence.rmd). The working refined JSON files are already included in the output.|
| `data` | Input data for conceptual and evidence tables.|
| `output` | Processed files (figure for the static worldmap and processed json files) |
| `logos` | Logos for the conceptual table |
| `images` | Images for the examples page |
| `public` | html files for the website |
| `.gitignore` | Files that git should ignore |
| `toolbox.Rproj` | RStudio project file |
