#' Attempts to install a package directly from {name}'s GitHub Enterprise.
#'
#' This is a wrapper for `devtools::install_github` to make it easier to access
#' {name}'s instance of GitHub Enterprise.
#'
#' @inheritParams devtools::install_github
#' @seealso devtools::install_github
#' @export
#'
install_github_{suffix} <- function(repo,
                                    username = NULL,
                                    ref = "master",
                                    subdir = NULL,
                                    auth_token = github_{suffix}_pat(quiet),
                                    host = "{host}",
                                    quiet = FALSE,
                                    ...) {

  devtools::install_github(
    repo,
    username = username,
    ref = ref,
    subdir = subdir,
    auth_token = auth_token,
    host = host,
    quiet = quiet,
    ...
  )
}



