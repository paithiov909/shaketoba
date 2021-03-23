#' about-pane UI Function
#'
#' @noRd
mod_about_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shinybulma::bulmaHero(
      fullheight = TRUE,
      color = "black",
      shinybulma::bulmaHeroBody(
        shinybulma::bulmaContainer(
          shinybulma::bulmaTitle("Shiny meets Bulma!"),
          shinybulma::bulmaSubtitle("A neat framework for your Shiny apps.")
        )
      )
    )
  )
}

#' @noRd
mod_about_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {

  })
}
