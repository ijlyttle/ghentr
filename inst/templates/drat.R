# note - this template is not active because it would introduce
# a lot of ::: into other packages

#' Adds Repository field to DESCRIPTION
#'
#' This function helps you add a repository field to a package DESCRIPTION file.
#'
#' For packrat and RStudioConnect deployment to work, packages in CRAN-like
#' repositories must identify the name of the repository in their DESCRIPTION
#' files. For CRAN, this line is added by the CRAN maintainers. If you are
#' submitting a package to a {{name}} repository, you will need to add its
#' name to your DESCRIPTION file.
#'
#' @param name `character`, name of repository
#'
#' @return `invisible(NULL)`, called for side effect
#' @export
#' @examples
#' \dontrun{
#'   # if you have a DRAT repository with the same basename
#'   use_drat_repo()
#'
#'   # if you know the name of the repository
#'   use_repo(name = "ACMERAN")
#' }
#'
use_drat_repo <- function() {

  name <- basename(getOption("dratRepo", default = ""))

  if (identical(nchar(name), 0L)) {
    stop("name not specified - is option 'dratRepo' set?", call. = FALSE)
  }

  use_repo(name)

  invisible(NULL)
}

#' @rdname use_drat_repo
#'
use_repo <- function(name) {

  if (is.null(name)) {
    stop("name not specified", call. = FALSE)
  }

  usethis:::use_description_field("Repository", value = name)

  invisible(NULL)
}

#' Initialize a DRAT repository
#'
#' Helps you to initalize a DRAT repositiory for use with {{name}}'s
#' GitHub Enterprise. This function would be needed only for those people
#' with push-access to this DRAT repository.
#'
#' This function is meant to parallel [drat::initRepo()], but there is an
#' important difference: `drat::initRepo()` establishes a `gh-pages` branch
#' in the git repository, the philosophy here is to use the `master` branch.
#' This is because GitHub automatically serves the `gh-pages` branch, but you
#' may not want to do this.
#'
#' This is because it is possible that this DRAT repository will be nominally
#' private to {{name}}, hosted behind its firewall. However, you may
#' wish to access this repository from a (cloud-hosted) virtual machine outside
#' your firewall. To do this, you could push a copy of this repository to a
#' private GitHub repository - then pull from your external virtual-machine.
#'
#' On your virtual machine, you could refer to the location of this package
#' repository using a local `file://` URL rather than a remote `https://` URL.
#' By fetching the DRAT repository from private GitHub to your external
#' virtual-machine, then using that repository locally, you can use a
#' CRAN-like repository while maintaining the
#' privacy of your "private" repository.
#'
#' @return `invisible(NULL)`, called for side effect
#' @seealso [drat::initRepo()]
#' @export
#' @examples
#' \dontrun{
#'   # create a new project, then call from the project directory
#'   init_drat_repo()
#'   usethis::use_git()
#'   use_github_foo()
#'   # activate the github pages for the master branch
#' }
#'
init_drat_repo_{{suffix}} <- function() {

  usethis::use_directory("src/contrib")

  path <- usethis::proj_get()

  usethis:::todo("Add the following element to options() in your .Rprofile file:")
  usethis:::code_block(paste0("dratRepo = \"", path, "\""))
  usethis:::todo("Create a git repository using usethis::use_git()")
  usethis:::todo("Establish remote using {{package_name}}::use_github_{{suffix}}()")
  usethis:::todo("At {{name}}'s GitHub instance, activate GitHub pages on the master branch.")
  usethis:::todo("Publicize repository's URL for your colleagues to add to options() in .Rprofile.")

  invisible(NULL)
}
