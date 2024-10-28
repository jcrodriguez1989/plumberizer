#' Plumberize
#'
#' Generate the `plumber.R` file for any package. The `plumber.R` file is the configuration file
#' that builds the API by using the Plumber framework.
#' This function will create one endpoint per exported function in the `package_name` package.
#'
#' @param package_name A string with the name of the package for which to generate the API.
#'   The package should be installed. E.g., `plumberize("chatgpt")`.
#' @param out_file The name of the file where to save the `plumber.R` code. If `NULL` it will
#'   return it as a string.
#'
#' @export
#'
plumberize <- function(package_name, out_file = NULL) {
  if (!require(package_name, character.only = TRUE, quietly = TRUE)) {
    stop("Package {", package_name, "} is not installed")
  }
  plumber_skeleton <- paste(
    readLines(system.file("plumberizer", "plumber_skeleton.R", package = "plumberizer")),
    collapse = "\n"
  )
  exports <- sort(getNamespaceExports(package_name))
  functions_plumber <- paste(sapply(exports, plumberize_function), collapse = "\n\n")
  plumber_code <- glue(plumber_skeleton, .open = "{{", .close = "}}")
  if (!is.null(out_file)) {
    # Delete the file if it exists already.
    unlink(out_file)
    writeLines(plumber_code, out_file)
    return(invisible(out_file))
  }
  invisible(plumber_code)
}
