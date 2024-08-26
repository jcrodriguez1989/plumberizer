library("plumber")

#* @param question
#* @param session_id
#* @param openai_api_key
#* @param images
#* @get /ask_chatgpt
function(question, session_id = 1, openai_api_key = Sys.getenv("OPENAI_API_KEY"), images = NULL) {
  ask_chatgpt ( question, session_id, openai_api_key, images )

}

#* @param code
#* @get /comment_code
function(code = clipr::read_clip(allow_non_interactive = TRUE)) {
  comment_code ( code )

}

#* @param code
#* @get /complete_code
function(code = clipr::read_clip(allow_non_interactive = TRUE)) {
  complete_code ( code )

}

#* @param code
#* @get /create_unit_tests
function(code = clipr::read_clip(allow_non_interactive = TRUE)) {
  create_unit_tests ( code )

}

#* @param code
#* @get /create_variable_name
function(code = clipr::read_clip(allow_non_interactive = TRUE)) {
  create_variable_name ( code )

}

#* @param code
#* @get /document_code
function(code = clipr::read_clip(allow_non_interactive = TRUE)) {
  document_code ( code )

}

#* @param code
#* @get /explain_code
function(code = clipr::read_clip(allow_non_interactive = TRUE)) {
  explain_code ( code )

}

#* @param code
#* @get /find_issues_in_code
function(code = clipr::read_clip(allow_non_interactive = TRUE)) {
  find_issues_in_code ( code )

}

#* @param prompt
#* @param out_file
#* @param openai_api_key
#* @get /generate_image
function(prompt, out_file = tempfile(fileext = ".png"), openai_api_key = Sys.getenv("OPENAI_API_KEY")) {
  generate_image ( prompt, out_file, openai_api_key )

}

#* @param openai_api_key
#* @get /list_models
function(openai_api_key = Sys.getenv("OPENAI_API_KEY")) {
  list_models ( openai_api_key )

}

#* @param code
#* @get /optimize_code
function(code = clipr::read_clip(allow_non_interactive = TRUE)) {
  optimize_code ( code )

}

#* @param code
#* @get /refactor_code
function(code = clipr::read_clip(allow_non_interactive = TRUE)) {
  refactor_code ( code )

}

#* @param system_role
#* @param session_id
#* @get /reset_chat_session
function(system_role = "You are a helpful assistant.", session_id = 1) {
  reset_chat_session ( system_role, session_id )

}
