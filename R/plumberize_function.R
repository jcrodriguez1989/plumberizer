#' Plumberize a Function
#'
#' @param function_name The name of the function to plumberize.
#'
#' @importFrom glue glue
#'
plumberize_function <- function(function_name) {
  message("! Plumberizing ", function_name)
  fun_parameters <- formals(function_name)
  function_skeleton <- paste(
    readLines(system.file("plumberizer", "function_skeleton.R", package = "plumberizer")),
    collapse = "\n"
  )
  params_decorators <- generate_params_decorators(fun_parameters)
  params_input_line <- generate_params_input_line(fun_parameters)
  params_names <- paste(names(fun_parameters), collapse = ", ")
  glue(function_skeleton, .open = "{{", .close = "}}")
}

generate_params_decorators <- function(fun_parameters) {
  paste0("#* @param ", names(fun_parameters), collapse = "\n")
}

generate_params_input_line <- function(fun_parameters) {
  params_input_line <- sapply(names(fun_parameters), function(fun_parameter_name) {
    if (is.character(fun_parameters[[fun_parameter_name]])) {
      fun_parameter <- paste0('"', fun_parameters[[fun_parameter_name]], '"')
    } else {
      fun_parameter <- as.character(fun_parameters)[[
        which(names(fun_parameters) == fun_parameter_name)
      ]]
    }
    if (nchar(fun_parameter) > 0) {
      paste0(fun_parameter_name, " = ", fun_parameter)
    } else {
      fun_parameter_name
    }
  })
  paste(params_input_line, collapse = ", ")
}
