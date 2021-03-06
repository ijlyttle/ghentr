% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/use_drat.R
\name{use_drat_repo}
\alias{use_drat_repo}
\alias{use_repo}
\title{Adds Repository field to DESCRIPTION}
\usage{
use_drat_repo()

use_repo(name)
}
\arguments{
\item{name}{\code{character}, name of repository}
}
\value{
\code{invisible(NULL)}, called for side effect
}
\description{
This function helps you add a repository field to a package DESCRIPTION file.
}
\details{
For packrat and RStudioConnect deployment to work, packages in CRAN-like
repositories must identify the name of the repository in their DESCRIPTION
files. For CRAN, this line is added by the CRAN maintainers. If you are
submitting a package to your institution's repository, you will need to add
its name to your DESCRIPTION file.
}
\examples{
\dontrun{
  # if you have a DRAT repository with the same basename
  use_drat_repo()

  # if you know the name of the repository
  use_repo(name = "ACMERAN")
}

}
