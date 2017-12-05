#' Retrieve personal access token to {{name}}'s GitHub Enterprise
#'
#' This function mimics `devtools::github_pat` to retrieve
#' a personal access token (PAT) to
#' {{name}}'s instance of GitHub Enterprise.
#'
#' Unlike `devtools::github_pat`, this function does not handle the
#' the CI case.
#'
#' @param quiet `logical` indicates if function should be quiet
#'
#' @return `character`, PAT for {{name}}'s GitHub Enterprise
#' @seealso `devtools::github_pat`
#'
#' @export
#'
github_{{suffix}}_pat <- function(quiet = FALSE) {

  pat <- Sys.getenv("GITHUB_{{suffix_upper}}_PAT")
  if (nzchar(pat)) {
    if (!quiet) {
      message("Using GitHub PAT from envvar GITHUB_{{suffix_upper}}_PAT")
    }
    return(pat)
  }
}





