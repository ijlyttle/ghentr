#' Use GitHub Enterprise components in your package
#'
#' These functions are used to write function files for your package.
#'
#' The function `use_github_enterprise()` calls all the templating functions:
#'
#' \describe{
#'   \item{`use_install_ghe()`}{Writes a file to the current project,
#'     `R/utils-install_ghe.R`, containing
#'     a function `install_github_foo()` that wraps
#'     `devtools::install_github()`, using the `host` argument of this function.}
#'   \item{`use_ghe_pat()`}{Writes a file to the current project,
#'    `R/utils-ghe_pat.R`, containing
#'     a function `github_foo_pat()` that parallels `devtools::github_pat()`.
#'     This new function will look for an environment variable
#'     named `GITHUB_FOO_PAT`.}
#'   \item{`use_use_ghe()`}{Writes a file, `utils-use_ghe.R`, that
#'     contains a function `use_github_foo()` that
#'     wraps `usethis::use_github()`, using
#'     the `host` argument of this function.}
#' }
#'
#' For each of the functions described above, the `foo` in the function name
#' is the value of the `suffix` argument from this function.
#' The `name` argument from this function is interpolated into the
#' documentation of each of written functions.
#'
#' @param suffix `character` lowercase suffix to use for function names
#' @param name `character` title-case name of the GHE instance
#' @param host `character` hostname for GHE instance
#'
#' @return `invisible(NULL)`, called for side effects
#' @export
#' @examples
#' \dontrun{
#'   use_github_enterprise(
#'     host = "github.acme-corp.com/api/v3",
#'     suffix = "acme",
#'     name = "Acme Corporation"
#'   )
#' }
#'
use_github_enterprise <- function(host, suffix, name) {

  data <- list(
    package_name = project_name(), # TODO: keep eye on project_name() export
    host = host,
    suffix = suffix,
    suffix_upper = toupper(suffix),
    name = name
  )

  use_ghe_pat(suffix, name)

  use_install_ghe(host, suffix, name)

  use_use_ghe(host, suffix, name)

  # TODO: feedback on what to put into README
  # TODO: keep an eye on when this will be exported
  todo("Run devtools::document()")
  todo(
    "Add this to your package's README, manually replacing ",
    "the items inside {curly brackets}."
  )
  code_block(
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

  usethis::use_roxygen_md()

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

  usethis::use_roxygen_md()

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

  usethis::use_roxygen_md()

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
