
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ShadowRates

> Model near zero interest-rates

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/Reckziegel/ShadowRates/branch/main/graph/badge.svg)](https://codecov.io/gh/Reckziegel/ShadowRates?branch=main)
[![R-CMD-check](https://github.com/Reckziegel/ShadowRates/workflows/R-CMD-check/badge.svg)](https://github.com/Reckziegel/ShadowRates/actions)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Installation

You can install the development version from github:

``` r
# install.packages("devtools")
devtools::install_github("Reckziegel/ShadowRates")
```

## Toy Example

``` r
library(ShadowRates)
library(dplyr, warn.conflicts = FALSE)
library(ggplot2)

data("us_yield_curve")

us_yield_curve %>%
  # shadow
  shadow_rates(.group_col = maturity, .dbl_col = rates, .eta = 0.015) %>% 
  # plotting
  ggplot(aes(x = index, y = rates, color = maturity)) + 
  geom_line() + 
  geom_hline(yintercept = 0, size = 1, color=  "grey") + 
  scale_y_continuous(labels = scales::percent_format(), breaks = scales::breaks_width(0.025)) + 
  labs(title    = "US Yield Curve", 
       subtitle = "Implied 'Shadow Rates' by the Inverse Call Transformation", 
       x        = NULL, 
       y        = NULL)
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />
