#' Adds Repository field to DESCRIPTION
#'
#' This function helps you add a repository field to a package DESCRIPTION file.
#'
#' For packrat and RStudioConnect deployment to work, packages in CRAN-like
#' repositories must identify the name of the repository in their DESCRIPTION
#' files. For CRAN, this line is added by the CRAN maintainers. If you are
#' submitting a package to your institution's repository, you will need to add
#' its name to your DESCRIPTION file.
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

  name <- toupper(basename(getOption("dratRepo", default = "")))

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

  # TODO: keep eye open for use_description_field() export
  use_description_field("Repository", value = name)

  invisible(NULL)
}

#' Initialize a DRAT repository
#'
#' Helps you to initalize a DRAT repositiory for use with your institution's
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
#' private to your institution, hosted behind its firewall. However, you may
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
init_drat_repo <- function() {

  usethis::use_directory("src/contrib")

  path <- usethis::proj_get()

  # TODO: keep eye on todo(), code_block() export
  todo("Add the following element to options() in your .Rprofile file:")
  code_block(paste0("dratRepo = \"", path, "\""))
  todo("Create a git repository using usethis::use_git()")
  todo("Establish remote using your institution's particular use_github()")
  todo("At your institution's GitHub instance, activate GitHub pages on master branch.")
  todo("Publicize repository's URL for your colleagues to add to options() in .Rprofile.")

  invisible(NULL)
}


#' Make binary placeholders for a drat repository
#'
#' The goal of drat is to let you create a source repository. Supporting
#' the inclusion of binary packages is beyond the scope of these tools.
#' However, if your drat repository does not have the directory structure
#' for binaries, you will get some annoying warnings each time
#' you install packages. This function can help you get rid of those messages.
#'
#' In a CRAN-like repository, binary packages are kept in their own directory
#' structure. This function looks in your project to see what parts of this
#' directory structure exist. It creates those parts of the structure that
#' do not already exist; but nothing is overwritten.
#'
#' @examples
#' \dontrun{
#'   make_drat_bin_placeholders()
#' }
#' @export
make_drat_bin_placeholders <- function() {

  os_paths <- c(
    "windows",
    "macosx/mavericks",
    "macosx/el-capitan"
  )

  r_versions <- c("3.1", "3.2", "3.3", "3.4")

  path_root <- usethis::proj_get()

  fn_path <- function(x, y){
    file.path("bin", x, "contrib", y, "PACKAGES")
  }

  path_proj <- outer(os_paths, r_versions, fn_path)

  # keep only those paths that no not yet exist
  path_proj <- path_proj[!file.exists(file.path(path_root, path_proj))]

  if (identical(length(path_proj), 0L)) {
    cat("No action needed - all binary paths exist")
    return(invisible(NULL))
  }

  x <- c(
    "These placeholder-files will be created relative to project-root:",
    paste(" ", value(path_root, "/")),
    paste(" ", clisymbols::symbol$bullet, value(path_proj)),
    "",
    "Proceed?"
  )

  x <- paste(x, collapse = "\n")

  create_placeholder <- function(file) {

    usethis::use_directory(dirname(file))
    writeLines("", con = file)
    done("Writing placeholder-file:", value(file))
  }

  if (identical(ask_user(x), TRUE)) {
    lapply(path_proj, create_placeholder)
  }

  invisible(NULL)
}
