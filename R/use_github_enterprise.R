#' Use GitHub Enterprise components in your package
#'
#' @param suffix `character` lowercase suffix to use for function names
#' @param name `character` title-case name of the GHE instance
#' @param host `character` hostname for GHE instance
#'
#' @return `invisible(NULL)`, called for side effects
#' @export
#'
use_github_enterprise <- function(host, suffix, name) {

  data <- list(
    package_name = usethis:::project_name(),
    host = host,
    suffix = suffix,
    suffix_upper = toupper(suffix),
    name = name
  )

  use_ghe_pat(suffix, name)

  use_install_ghe(host, suffix, name)

  use_use_ghe(host, suffix, name)

  # TODO: feedback on what to put into README
  usethis:::todo("Run devtools::document()")
  usethis:::todo(
    "Add this to your package's README, manually replacing ",
    "the items inside {curly brackets}."
  )
  usethis:::code_block(
    vapply(
      readLines(system.file("templates/ghe.md", package = "ghentr")),
      whisker::whisker.render,
      "",
      data,
      USE.NAMES = FALSE
    )
  )

  invisible(NULL)
}

#' @rdname use_github_enterprise
#' @export
#'
use_install_ghe <- function(host, suffix, name) {

  if (!usethis:::uses_roxygen()) {
    stop("`use_install_ghe()` requires that you use roxygen.", call. = FALSE)
  }

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

#' @rdname use_github_enterprise
#' @export
#'
use_ghe_pat <- function(suffix, name) {

  if (!usethis:::uses_roxygen()) {
    stop("`use_ghe_pat()` requires that you use roxygen.", call. = FALSE)
  }

  data <- list(
    suffix = suffix,
    suffix_upper = toupper(suffix),
    name = name
  )

  usethis::use_package("usethis")

  usethis::use_template(
    template = "ghe_pat.R",
    save_as = "R/utils-ghe_pat.R",
    data = data,
    open = TRUE,
    package = "ghentr"
  )

  invisible(NULL)
}

#' @rdname use_github_enterprise
#' @export
#'
use_use_ghe <- function(host, suffix, name) {

  if (!usethis:::uses_roxygen()) {
    stop("`use_use_ghe()` requires that you use roxygen.", call. = FALSE)
  }

  data <- list(
    host = host,
    suffix = suffix,
    name = name
  )

  usethis::use_package("devtools")

  usethis::use_template(
    template = "use_ghe.R",
    save_as = "R/utils-use_ghe.R",
    data = data,
    open = TRUE,
    package = "ghentr"
  )

  invisible(NULL)
}
