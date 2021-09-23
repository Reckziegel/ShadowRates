#' Inverse Call Transformation
#'
#' Computes the "shadow rates" implied by the inverse call transformation.
#'
#' @param .data A tidy \code{tibble}.
#' @param .group_col The maturities column.
#' @param .dbl_col A column with interest rates.
#' @param .eta A \code{double} with the threshold between high and low interest
#' rates environments.
#' @param .strike A \code{double} with the call strike rate. Default's to zero.
#'
#' @return A tidy \code{tibble}.
#' @export
#'
#' @importFrom magrittr %>%
#'
#' @examples
#' library(ggplot2)
#'
#' data("us_yield_curve")
#'
#' shadow <- shadow_rates(us_yield_curve, maturity, rates)
#'
#' ggplot(shadow, aes(x = index, y = rates, color = maturity)) +
#'   geom_line()
shadow_rates <- function(.data, .group_col, .dbl_col, .eta = 0.015, .strike = 0) {

  assertthat::assert_that(assertthat::is.number(.eta))
  assertthat::assert_that(assertthat::is.number(.strike))

  .data %>%
    dplyr::group_by({{.group_col}}) %>%
    dplyr::mutate({{.dbl_col}} := dplyr::if_else(
      condition = {{.dbl_col}} >= .eta,
      true      = {{.dbl_col}} + .strike,
      false     = .eta * (log({{.dbl_col}} / .eta) + (1 / .eta) * (.eta + .strike))
    )
    ) %>%
    dplyr::filter(!is.infinite({{.dbl_col}}))
}
