#' main pane UI function
#'
#' @keywords internal
#' @noRd
mod_main_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList()
}

#' @keywords internal
#' @noRd
mod_main_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- shiny::NS(id)
    shiny::observeEvent(input$save, {
      ## Render
      text <- input$text_area
    })
  })
}
