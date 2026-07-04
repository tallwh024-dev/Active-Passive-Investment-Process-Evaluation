# Active vs. Passive Investment Process Evaluation
# Author: Jackson Wang

library(readxl)
library(dplyr)
library(tidyr)
library(stringr)
library(PerformanceAnalytics)

# ------------------------------------------------------------
# Data setup
# ------------------------------------------------------------

# Place the course workbook in the project root or data folder.
# Update the file path if needed.
file_path <- "FinalProjectData.xlsx"

benchmark_tickers <- c("IWB", "IWM", "IXUS", "SHV", "TLT", "IGSB", "XLRE", "GSG", "IGF")
active_tickers <- paste0("AF_", benchmark_tickers)

# The workbook structure may vary by course version.
# The key inputs are monthly benchmark returns and active fund returns.
# This script provides the project workflow and calculation structure.

# Example expected sheets:
# benchmark_returns <- read_excel(file_path, sheet = "Benchmark Returns")
# active_returns <- read_excel(file_path, sheet = "Active Returns")

# ------------------------------------------------------------
# Helper functions
# ------------------------------------------------------------

calc_return_summary <- function(return_df, tickers) {
  return_df |>
    summarise(across(all_of(tickers), list(mean = mean, sd = sd), na.rm = TRUE)) |>
    pivot_longer(everything(), names_to = "metric", values_to = "value") |>
    separate(metric, into = c("Fund", "Statistic"), sep = "_(?=[^_]+$)") |>
    pivot_wider(names_from = Statistic, values_from = value)
}

calc_active_metrics <- function(active_return_df, tickers) {
  active_return_df |>
    summarise(
      across(
        all_of(tickers),
        list(
          excess_return = mean,
          tracking_error = sd
        ),
        na.rm = TRUE
      )
    ) |>
    pivot_longer(everything(), names_to = "metric", values_to = "value") |>
    separate(metric, into = c("Fund", "Statistic"), sep = "_(?=[^_]+$)") |>
    pivot_wider(names_from = Statistic, values_from = value) |>
    mutate(information_ratio = excess_return / tracking_error)
}

# ------------------------------------------------------------
# Benchmark allocation weights
# ------------------------------------------------------------

asset_weights <- tibble(
  Asset_Class = c("IWB", "IWM", "IXUS", "SHV", "TLT", "IGSB", "XLRE", "GSG", "IGF"),
  Benchmark_Weight = c(0.55, 0.06, 0.39, 0.20, 0.30, 0.50, 0.34, 0.33, 0.33),
  Actual_Weight = c(0.58, 0.07, 0.35, 0.18, 0.33, 0.49, 0.40, 0.30, 0.30)
)

multi_asset_weights <- tibble(
  Fund = c("60/30/10", "60/30/10", "60/30/10", "50/45/5", "50/45/5", "50/45/5"),
  Category = c("Stocks", "Bonds", "Alternatives", "Stocks", "Bonds", "Alternatives"),
  Benchmark_Weight = c(0.60, 0.30, 0.10, 0.50, 0.45, 0.05),
  Actual_Weight = c(0.59, 0.26, 0.15, 0.51, 0.42, 0.07)
)

# ------------------------------------------------------------
# Reported project results
# ------------------------------------------------------------

passive_return_summary <- tibble(
  Fund = c("IWB", "IWM", "IXUS", "SHV", "TLT", "IGSB", "XLRE", "GSG", "IGF"),
  Mean = c(0.012344366, 0.009478707, 0.007789176, 0.001733675, 0.000379219, 0.002361547, 0.006325383, 0.005902668, 0.008004295),
  Std_Dev = c(0.044392338, 0.059802806, 0.042343147, 0.001702223, 0.039408833, 0.008337334, 0.049552777, 0.058365848, 0.043610452)
)

benchmark_correlation_matrix <- matrix(
  c(
    1.000000000, 0.884436543, 0.847868485, 0.018324788, 0.152269543, 0.557933957, 0.768837981, 0.409837317, 0.758711923,
    0.884436543, 1.000000000, 0.777289508, -0.057542050, 0.060093397, 0.495384806, 0.688118946, 0.441848079, 0.701704302,
    0.847868485, 0.777289508, 1.000000000, 0.058143710, 0.192296860, 0.658252120, 0.705020890, 0.466162460, 0.857987640,
    0.018324788, -0.057542050, 0.058143710, 1.000000000, 0.192406880, 0.287238900, 0.022600260, -0.206566400, -0.001103800,
    0.152269543, 0.060093397, 0.192296860, 0.192406880, 1.000000000, 0.544208206, 0.438608317, -0.344850711, 0.200689944,
    0.557933957, 0.495384806, 0.658252120, 0.287238900, 0.544208206, 1.000000000, 0.613351384, 0.137169101, 0.646122104,
    0.768837981, 0.688118946, 0.705020890, 0.022600260, 0.438608317, 0.613351384, 1.000000000, 0.238997413, 0.772638695,
    0.409837317, 0.441848079, 0.466162460, -0.206566400, -0.344850711, 0.137169101, 0.238997413, 1.000000000, 0.487071230,
    0.758711923, 0.701704302, 0.857987640, -0.001103800, 0.200689944, 0.646122104, 0.772638695, 0.487071230, 1.000000000
  ),
  nrow = 9,
  byrow = TRUE,
  dimnames = list(benchmark_tickers, benchmark_tickers)
)

dimension_results <- tibble(
  Dimension = c("Capitalization", "Country", "Duration", "Credit", "Alternatives", "Multi-Asset 60/30/10", "Multi-Asset 50/45/5"),
  Excess_Return = c(0.000512167, 0.000810620, 0.001002421, 0.000233230, 0.000307269, 0.000752383, 0.000722401),
  Tracking_Error = c(0.000374688, 0.001056293, 0.001835905, 0.001144822, 0.002795578, 0.001820299, 0.001384055),
  Information_Ratio = c(1.36691596, 0.76741974, 0.54600908, 0.20372609, 0.10991247, 0.41332920, 0.52194545)
)

# ------------------------------------------------------------
# Output project tables
# ------------------------------------------------------------

print(passive_return_summary)
print(benchmark_correlation_matrix)
print(dimension_results)

# Optional: write output files after creating outputs folder locally
# dir.create("outputs", showWarnings = FALSE)
# write.csv(passive_return_summary, "outputs/passive_return_summary.csv", row.names = FALSE)
# write.csv(dimension_results, "outputs/dimension_results.csv", row.names = FALSE)
