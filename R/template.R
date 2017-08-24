# repurposed from r-lib/usethis to allow other packages to use
# templating system
#
# TODO: make issue at r-lib/usethis to give them a heads up about
# this "repurposing", make sure it is OK with them, and propose an
# extension to the usethis framework.

#' create a file using a template
#'
#'
#'
use_template <- function(template,
                         save_as = template,
                         data = list(),
                         ignore = FALSE,
                         open = FALSE,
                         base_path = ".",
                         package = "usethis"
) {

  template_contents <- render_template(template, data, package = package)
  new <- usethis:write_over(base_path, save_as, template_contents)

  if (ignore) {
    usethis::use_build_ignore(save_as, base_path = base_path)
  }

  if (open) {
    todo("Modify ", value(save_as))
    use_this:::open_in_rstudio(save_as, base_path = base_path)
  }

  invisible(new)
}

# why not glue?
render_template <- function(template, data = list(), package = "usethis") {
  template_path <- find_template(template, package = package)
  paste0(whisker::whisker.render(readLines(template_path), data), "\n", collapse = "")
}

find_template <- function(template_name, package = "usethis") {
  path <- system.file("templates", template_name, package = package)
  if (identical(path, "")) {
    stop("Could not find template ", value(template_name), call. = FALSE)
  }
  path
}
