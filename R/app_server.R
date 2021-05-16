#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#'
#' @keywords internal
#' @noRd
app_server <- function(input, output, session) {
  mod_main_server("main_pane")
  mod_control_server("control_pane")
}
