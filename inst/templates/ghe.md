## Installing this package

To install this package, to use  **devtools**:

```r
install.packages("devtools") # if not already installed
devtools::install_github("{name}/{{package_name}}", host = "{{host}}")
```

## Usage

For future package-installations from {{name}}'s GitHub Enterprise, 
you can simply use `{{package_name}}::use_github_{{suffix}}("user/repo")`.

If you wish that **{{package_name}}** be started automatically in your interactive 
sessions, you can modify your `.Rprofile` file, just like you would for
[**devtools**](https://github.com/hadley/devtools#other-tips). 

To access private packages on this instance of GitHub,
Enterprise, you need a Personal Access Token (PAT)
and to set an environment variable named GITHUB_{{suffix_upper}}_PAT.

You can set the environment variable by adding a line like this to 
your `.Renviron` file:

```
GITHUB_{{suffix_upper}}_PAT="your_pat_goes_here"
```

If you wish to create a package repository on {{name}}'s GitHub Enterprise,
you can use the function `{{package_name}}::use_github_{{suffix}}()` in the 
same way you would use `devtools::use_github()` for GitHub.
