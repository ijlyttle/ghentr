
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/ghentr)](https://cran.r-project.org/package=ghentr) [![Travis-CI Build Status](https://travis-ci.org/ijlyttle/ghentr.svg?branch=master)](https://travis-ci.org/ijlyttle/ghentr)

ghentr
======

The goal of ghentr is to make it easier for you to build custom functions to access your instance of GitHub Enterprise.

You are likely already using the functions `devtools::install_github()` and `usethis::use_github()` to interact with `github.com`. If you have an instance GitHub Enterprise (GHE), you can also use these functions with GHE.

Let's say that you work for [Acme Corporation](https://en.wikipedia.org/wiki/Acme_Corporation), and that Acme has its own instance of GHE. At present, you could install a package using the `host` argument with `devtools::install_github`.

``` r
devtools::install_github("user/repo", host = "github.acme-corp.com/api/v3")
```

In time, it may become tiresome to add the host argument each time you want to install a package from GHE. Instead, it might be handy to create a function to do this for you, then put that function into a package that you can use and make available to your colleagues. This is what **ghentr** helps you to do.

Let's say you create a package called **acmetools**. Using templating functions in this package, you can add a function to your package would allow to use syntax like this:

``` r
# wraps devtools::install_github()
acmetools::install_github_acme("user/repo")
```

Furthermore, you can use the templating functions in your package to create a function to make it easier to create a package repository at your instance of GHE:

``` r
# wraps usethis::use_github()
acmetools::use_github_acme()
```

Installation
------------

You can install ghentr from github with:

``` r
# install.packages("devtools")
devtools::install_github("ijlyttle/ghentr")
```

Usage
-----

To create your functions, you will need a few things:

-   an instance of GitHub Enterprise, used to determine the `host`, e.g. `"github.acme-corp.com/api/v3"`

-   a concise `suffix` to use in the names of your new functions, e.g. `"acme"`

-   a longform `name` to use in your functions' documentation, e.g. `"Acme Corporation"`

These arguments are used with the function `use_github_enterprise()`:

``` r
ghentr::use_github_enterprise(
  host = "github.acme-corp.com/api/v3",
  suffix = "acme",
  name = "Acme Corporation"
)
```

This function will write three files into the `R` directory of your package project:

-   `utils-use_ghe.R`, containing `use_github_acme()`

-   `utils-install_ghe.R`, containing `install_github_acme()`

-   `utils-ghe_pat.R`, containing `github_acme_pat()`

It will also add `roxygen2`, `usethis`, and `devtools` to the `Imports` section of your `DESCRIPTION` file.

Finally, it will copy some text to your clipboard that may be helpful for your `README` file.

Followup steps
--------------

As you know, `devtools::install_github()` uses a GitHub Personal Access Token, normally stored in an environment variable named `GITHUB_PAT`. The function `acmetools::install_github_acme()` will look for an environment variable named `GITHUB_ACME_PAT`. You and your colleagues will have to create your tokens, then add the information to your `.Renviron` files.

You can make your package **acmetools** available to your colleagues using code like this:

``` r
# install.packages("devtools")
devtools::install_github("foo/acmetools", host = "github.acme-corp.com/api/v3")
```

If you modified your `.Rprofile` file to load **devtools** automatically into your interactive sessions, you may want also to do the same for **acmetools**.

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
