#' @title Name the model
#' @name model_name
#'
#' @description Returns the "name" (class attribute) of a model, possibly including further information.
#'
#' @inheritParams get_residuals
#' @param include_formula Should the name include the model's formula.
#' @param include_call If `TRUE`, will return the function call as a name.
#' @param ... Currently not used.
#'
#' @return A character string of a name (which usually equals the model's class attribute).
#'
#' @examples
#' m <- lm(Sepal.Length ~ Petal.Width, data = iris)
#' model_name(m)
#' model_name(m, include_formula = TRUE)
#' model_name(m, include_call = TRUE)
#'
#' if (require("lme4")) {
#'   model_name(lmer(Sepal.Length ~ Sepal.Width + (1 | Species), data = iris))
#' }
#' @export
model_name <- function(x, ...) {
  UseMethod("model_name")
}

#' @rdname model_name
#' @export
model_name.default <- function(x, include_formula = FALSE, include_call = FALSE, ...) {
  if (include_call) {
    return(format(get_call(x)))
  }

  name <- class(x)[[1]]
  if (include_formula) {
    f <- format(find_formula(x, verbose = FALSE))
    name <- paste0(name, "(", f, ")")
  }
  name
}

#' @export
model_name.list <- function(x, include_formula = FALSE, include_call = FALSE, ...) {
  sapply(x, model_name, include_formula = include_formula, include_call = include_call, ...)
}
