#' Plumberize a Function
#'
#' @param function_name The name of the function to plumberize.
#'
#' @importFrom glue glue
#'
plumberize_function <- function(function_name) {
  message("! Plumberizing ", function_name)
  function_skeleton <- paste(
    readLines(system.file("plumberizer", "function_skeleton.R", package = "plumberizer")),
    collapse = "\n"
  )
  fun_parameters <- formals(function_name)
  function_help_decorators <- generate_function_help_decorators(function_name)
  function_help_title <- function_help_decorators$function_help_title
  params_decorators <- function_help_decorators$function_help_params
  params_input_line <- generate_params_input_line(fun_parameters)
  params_names <- paste(names(fun_parameters), collapse = ", ")
  glue(function_skeleton, .open = "{{", .close = "}}")
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

#' @importFrom utils help
generate_function_help_decorators <- function(function_name) {
  function_help <- utils:::.getHelpFile(help(function_name))
  list(
    function_help_title = generate_function_help_title(function_help),
    function_help_params = generate_function_help_params(function_help)
  )
}

generate_function_help_title <- function(function_help) {
  function_help_title <- unlist(lapply(function_help, function(help_section) {
    if (attr(help_section, "Rd_tag") %in% c("\\title", "\\description")) {
      as.character(help_section)
    } else if (attr(help_section, "Rd_tag") == "\\value") {
      paste0("Returns:", paste(help_section, collapse = " "))
    }
  }))
  gsub("\n$", "", paste0("#* ", gsub("\n", "", function_help_title), "\n", collapse = ""))
}

generate_function_help_params <- function(function_help) {
  function_help_params <- lapply(function_help, function(help_section) {
    if (attr(help_section, "Rd_tag") == "\\arguments") {
      lapply(help_section, function(help_section_item) {
        if (attr(help_section_item, "Rd_tag") == "\\item" && length(help_section_item) > 0) {
          paste(
            "#* @param",
            help_section_item[[1]],
            gsub("\n", "", paste0(unlist(help_section_item[-1]), collapse = " "))
          )
        }
      })
    }
  })
  paste(unlist(function_help_params), collapse = "\n")
}
