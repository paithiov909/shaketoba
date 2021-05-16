#' control pane UI function
#'
#' @keywords internal
#' @noRd
mod_control_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList()
}

#' @keywords internal
#' @noRd
mod_control_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {

  })
}
