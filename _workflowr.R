### workflowr management
#

#install.packages("workflowr")
library(workflowr)


# project files
# (in their order of processing)
files <- c("analysis/index.Rmd",
  "analysis/table_concept.Rmd",
  "analysis/table_evidence.Rmd",
  "analysis/table_examples.Rmd",
  "analysis/toolbox_map.Rmd",
  "analysis/privacy.rmd",
  "analysis/terms.rmd"
 )


# Building the project website
wflow_build(files = files,
            verbose = FALSE,
            republish = FALSE,
            update = TRUE,
            delete_cache = TRUE,
            dry_run = FALSE)


# Publishing/updating the project website
wflow_publish(
  files = files,
  republish = TRUE,
  delete_cache = TRUE,
  dry_run = FALSE
)


wflow_git_push()

