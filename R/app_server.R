#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#'
#' @keywords internal
#' @noRd
app_server <- function(input, output, session) {
  sktb_module("sktb-app")
}

#' @keywords internal
#' @noRd
sktb_module <- function(id) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      renew_ojichat <-
        shiny::eventReactive(input$render, {
          message <-
            sktb_sample_message(1L, collapse = "BREAK_HERE") %>%
            sktb_insert_comma(input$pos, input$comma) %>%
            sktb_conv_tags_all(input$name, input$emoji)
          message
        })
      output$plot <- shiny::renderPlot({
        print(renew_ojichat()) ## Logging for debug
        g <- renew_ojichat() %>%
          sktb_plot_ojichat(split = "BREAK_HERE")
        return(g)
      })
    }
  )
}
