# Active vs. Passive Investment Process Evaluation

This repository contains a CFRM 503 asset allocation and portfolio management project evaluating an investment firm's active investment process.

The project analyzes 10 years of monthly return data from January 2016 through December 2025. It evaluates both allocation decisions across major asset categories and active implementation decisions within individual funds.

## Project objective

The Chief Investment Officer wants to understand which parts of the firm's investment process are adding value and which parts are weaker. The analysis evaluates:

- passive benchmark return behavior
- excess returns
- tracking error
- information ratios
- active versus passive implementation quality
- allocation dimensions across stocks, bonds, alternatives, and multi-asset funds
- active fund performance relative to benchmarks

## Evaluation areas

The project evaluates seven investment process dimensions:

1. Multi-Asset 60/30/10 Allocation
2. Multi-Asset 50/45/5 Allocation
3. Capitalization: U.S. Large Cap vs. U.S. Small Cap
4. Country Selection: U.S. vs. Non-U.S. Equity
5. Duration: Short vs. Long Treasuries
6. Credit Quality: Investment Grade Corporate vs. Treasuries
7. Alternatives Allocation: Real Estate, Commodities, and Infrastructure

It also evaluates nine active asset-class funds relative to their benchmarks:

- IWB
- IWM
- IXUS
- SHV
- TLT
- IGSB
- XLRE
- GSG
- IGF

## Methods

The analysis includes:

- monthly return summary statistics
- benchmark mean returns and standard deviations
- benchmark correlation matrix
- active return calculation
- excess return analysis
- tracking error calculation
- information ratio calculation
- assessment of active fund implementation
- active vs. passive allocation model formulation

## Key findings

- The overall investment process added value at the total portfolio level.
- Capitalization, Country, and Duration were the strongest allocation dimensions.
- IWB, IXUS, and TLT showed the strongest active fund results.
- IWM, SHV, IGSB, and IGF were weaker active implementations.
- Credit and Alternatives were positive but much less efficient than the stronger dimensions.
- The analysis supports retaining active management where information ratios are strong and considering more passive implementation where active results are weak.

## Main dimension results

| Dimension | Excess Return | Tracking Error | Information Ratio |
|---|---:|---:|---:|
| Capitalization | 0.000512 | 0.000375 | 1.367 |
| Country | 0.000811 | 0.001056 | 0.767 |
| Duration | 0.001002 | 0.001836 | 0.546 |
| Credit | 0.000233 | 0.001145 | 0.204 |
| Alternatives | 0.000307 | 0.002796 | 0.110 |
| Multi-Asset 60/30/10 | 0.000752 | 0.001820 | 0.413 |
| Multi-Asset 50/45/5 | 0.000722 | 0.001384 | 0.522 |

## Repository structure

```text
Active-Passive-Investment-Process-Evaluation/
├── README.md
├── scripts/
│   └── active_passive_evaluation.R
├── source/
│   └── final_project_report.Rmd
├── reports/
│   └── project_summary.md
├── outputs/
│   ├── passive_return_summary.csv
│   ├── dimension_results.csv
│   └── active_fund_results.csv
├── data/
│   └── data_notes.md
└── requirements.txt
```

## How to run

1. Install the R packages listed in `requirements.txt`.
2. Place the course-provided `FinalProjectData.xlsx` file in the project root or `data/` folder.
3. Run:

```r
source("scripts/active_passive_evaluation.R")
```

The script is designed around the course Excel workbook containing benchmark returns and active fund returns.

## Tools used

- R
- readxl
- dplyr
- tidyr
- stringr
- PerformanceAnalytics
- knitr

## Author

Jackson Wang  
M.S. Computational Finance and Risk Management  
University of Washington
