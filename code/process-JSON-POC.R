if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(tidyverse,
       here,
       readxl,
       jsonlite, glue)


dat <- read_excel(here("data/toolbox_evidence.xlsx"))

# goes through each entry in the JSON column and
# tries to read in the JSON.
# if it doesn't work (i.e., there is no or no valid JSON info in the entry),
# it will save an `try-error` object into the slot
infos_raw <-
  lapply(str_c("{", dat$JSON, "}"), function(x)
    try(fromJSON(x), silent = TRUE))

# infos_raw <- infos_raw %>%
#   lapply(function(x) try(type_convert(x[[1]]), silent = TRUE))


# set entries without JSON to `NA`
infos_raw_noJSON <-
  sapply(infos_raw, function(x)
    isTRUE(is(x) == "try-error"))
infos_raw[infos_raw_noJSON] <- NA


# show top entries
head(infos_raw)





fnc_refine_infos <- function(x)
{
  fnc_format_es <- function(x)
    ifelse(is.numeric(x), round(x, digits = 2), x)

  fnc_es_info <- function(df) {
    es_info <- df %>%
      type_convert %>%
      arrange(Study) %>%
      mutate(
        Study = as.character(Study),
        es_pe_txt = glue("{es_type}: ",
                         "{fnc_format_es(es_pe)}"),
        es_ci_txt = glue(
          " ({100*es_ci}%-CI: ",
          "{fnc_format_es(es_low)}",
          "-",
          "{fnc_format_es(es_high)})"
        ),
        es_info = glue("{es_pe_txt}{es_ci_txt}"),
        es_comments = ""
      )

    es_info <- es_info %>%
      mutate(
        es_comments = ifelse(es_txt != "", es_txt, ""),
        es_info = ifelse(is.na(es_pe), "(no standard effect size available/yet extracted)", es_info),
        es_info = ifelse(!is.na(es_pe) & (is.na(es_low) | is.na(es_high)), es_pe_txt, es_info)
      ) %>%
      select(Study, Description, N = n, `Effect size` = es_info, Comments = es_comments)

    return(es_info)
  }

  tmp <- x[[1]] %>%
    type_convert %>%
    rowwise() %>%
    summarize(fnc_es_info(cur_data()))

  output <- list(tmp)
  names(output) <- names(x)

  return(output)
}


# refine infos
suppressMessages(
  infos_refined <-
    map(infos_raw, function(x)
      try(fnc_refine_infos(x), silent = TRUE))
)


# extract ids
infos_ids <- infos_raw %>% sapply(function(x) names(x[1]))

# extract study information
infos_raw <- infos_raw %>% lapply(function(x) x[[1]])
infos_refined <- infos_refined %>% lapply(function(x) x[[1]])

# add ids
names(infos_raw) <- infos_ids
names(infos_refined) <- infos_ids



# set entries without JSON to `NA`
infos_refined[infos_raw_noJSON] <- NA

# show top entries
head(infos_refined)

# save to disk as JSON
write_lines(
  toJSON(infos_raw, pretty = TRUE, always_decimal = TRUE),
  file = here("output/infos_raw.json")
)
write_lines(toJSON(infos_refined, pretty = TRUE),
            file = here("output/infos_refined.json"))

