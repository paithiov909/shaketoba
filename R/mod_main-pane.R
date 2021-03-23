#' main-pane UI Function
#'
#' @noRd
mod_main_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shinybulma::bulmaHero(
      color = "primary",
      size = "small",
      container = TRUE,
      shinybulma::bulmaHeroBody(
        shinybulma::bulmaContainer(
          shinybulma::bulmaTitle("Shaketoba"),
          shinybulma::bulmaSubtitle("Hello Shaketoba!!")
        )
      )
    ),
    shinybulma::bulmaSection(
      htmltools::tags$form(
        class = "box",
        shiny::div(
          class = "field",
          shiny::div(
            class = "control",
            shinybulma::bulmaTextAreaInput(
              ns("text_area"),
              label = "ボタンを連打するのはやめようね",
              rows = 12L
            )
          ),
          shinybulma::bulmaActionButton(
            ns("save"),
            label = "Analyse!",
            wrap = TRUE
          )
        )
      )
    ),
    shinybulma::bulmaSection(
      shiny::tableOutput(
        ns("tst")
      )
    )
  )
}

#' @noRd
#' @importFrom future future
#' @importFrom promises %...>%
#' @importFrom quanteda convert
mod_main_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- shiny::NS(id)
    shiny::observeEvent(input$save, {
      ## Render
      text <- input$text_area
      output$tst <- shiny::renderTable({
        future::future({
          make_dfm(text)
        }, seed = NULL) %...>%
        quanteda::convert(to = "data.frame")
      })
    })
  })
}

