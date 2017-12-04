#' Connect a local repo with {name}'s GitHub Enterprise
#'
#' This is a wrapper for `usethis::use_github` to make it easier to access
#' {name}'s instance of GitHub Enterprise.
#'
#' @inheritParams usethis::use_github
#' @seealso usethis::use_github
#' @export
#'
use_github_{suffix} <- function(organisation = NULL,
                                private = FALSE,
                                protocol = c("ssh", "https"),
                                credentials = NULL,
                                auth_token = NULL,
                                host = {host}) {

  usethis::use_github(
    organisation = organisation,
    private = private,
    protocol = protocol,
    credentials = credentials,
    auth_token = auth_token,
    host = host
  )
}

