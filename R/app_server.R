#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @noRd
app_server <- function(input, output, session) {

  # session$sendCustomMessage("show-packer", "hello packer!")

  mod_main_server("main_pane")
  mod_about_server("about_pane")
}
