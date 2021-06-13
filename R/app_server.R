#' The application server-side
#'
#' @param input,output,session Internal parameters for shiny.
#'     DO NOT REMOVE.
#'
#' @keywords internal
#' @noRd
app_server <- function(input, output, session) {
  sktb_module("sktbapp")
}

#' @noRd
sktb_module <- function(id) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      renew_ojichat <-
        shiny::eventReactive(input$render, {
          message <-
            sktb_sample_message(1L, tail = 1L, collapse = "{BREAK_HERE}") %>%
            sktb_conv_ojichat(
              target_name = input$name,
              pos_after = input$pos,
              emoji_rep = input$emoji,
              comma_freq = input$comma
            )
          print(message)
        })
      output$plot <- shiny::renderPlot({
        g <- renew_ojichat() %>%
          sktb_plot_ojichat(split = "{BREAK_HERE}")
        plot(g)
      },
      alt = "ojichat meme created with shaketoba")
    }
  )
}
