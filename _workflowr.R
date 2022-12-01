### workflowr management
#
# Note: `dry_run` is set to `TRUE`
library(workflowr)


# project files
# (in their order of processing)
files <- c("analysis/index.Rmd",
  "analysis/table_concept.Rmd",
  "analysis/table_evidence.Rmd",
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

#
# getwd()
# dir.exists(".git")
# packageVersion("git2r")
# git2r::repository(".", discover = TRUE)


#Deploying the project website (only needs to be set once)
# wflow_status()
#
# wflow_git_config(user.name = "Kozyreva", user.email = "kozyreva@mpib-berlin.mpg.de", overwrite=TRUE)
#
#  wflow_use_gitlab(
#    username = "ai_society",
#   repository = "intervention_toolbox",
#   domain = "arc-git.mpib-berlin.mpg.de"
#  )

# install.packages("workflowr")
