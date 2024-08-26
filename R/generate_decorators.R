generate_params_decorators <- function(fun_parameters) {
  paste0("#* @param ", names(fun_parameters), collapse = "\n")
}

generate_params_input_line <- function(fun_parameters) {
  params_input_line <- sapply(names(fun_parameters), function(fun_parameter_name) {
    fun_parameter <- as.character(fun_parameters)[[which(names(fun_parameters) == fun_parameter_name)]]
    if (nchar(fun_parameter) > 0) {
      paste0(fun_parameter_name, " = ", fun_parameter)
    } else {
      fun_parameter_name
    }
  })
  paste(params_input_line, collapse = ", ")
}

plumberize_function <- function(function_name) {
  fun_parameters <- formals(function_name)
  paste(
    generate_params_decorators(fun_parameters),
    paste0("#* @get /", function_name),
    paste0("function(", generate_params_input_line(fun_parameters), ") {"),
    paste("  ", function_name, "(", paste(names(fun_parameters), collapse = ", "), ")\n"),
    "}",
    sep = "\n"
  )
}
