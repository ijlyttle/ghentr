#' Use GitHub Enterprise components in your package
#'
#' @param suffix `character` lowercase suffix to use for function names
#' @param name `character` title-case name of the GHE instance
#' @param host `character` hostname for GHE instance
#'
#' @return `invisible(NULL)`, called for side effects
#' @export
#'
use_install_ghe <- function(host, suffix, name) {

  data <- list(
    host = host,
    suffix = suffix,
    name = name
  )

  usethis::use_template(
    template = "install_ghe.R",
    save_as = "R/utils-install_ghe.R",
    data = data,
    open = TRUE,
    package = "ghentr"
  )

  invisible(NULL)
}

#' @rdname use_install_ghe
#' @export
#'
use_ghe_pat <- function(suffix, name) {

  data <- list(
    suffix = suffix,
    suffix_upper = toupper(suffix),
    name = name
  )

  usethis::use_template(
    template = "ghe_pat.R",
    save_as = "R/utils-ghe_pat.R",
    data = data,
    open = TRUE,
    package = "ghentr"
  )

  invisible(NULL)
}

#' @rdname use_install_ghe
#' @export
#'
use_use_ghe <- function(host, suffix, name) {

  data <- list(
    host = host,
    suffix = suffix,
    name = name
  )

  usethis::use_template(
    template = "use_ghe.R",
    save_as = "R/utils-use_ghe.R",
    data = data,
    open = TRUE,
    package = "ghentr"
  )

  invisible(NULL)
}
