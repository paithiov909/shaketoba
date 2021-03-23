#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @noRd
app_ui <- function(request) {
  shinybulma::bulmaNavbarPage(
    golem_add_external_resources(), ## Leave this function for adding external resources.
    shiny::div(
      shinybulma::bulmaNavbarBrand(
        shinybulma::bulmaNavbarItem(
          shiny::h1("shaketoba"),
          href = "#main"
        ),
        shinybulma::bulmaNavbarBurger()
      ),
      shinybulma::bulmaNavbarMenu(
        shinybulma::bulmaNavbarEnd(
          shinybulma::bulmaNavbarItem("テキスト分析", href = "#main"),
          shinybulma::bulmaNavbarItem("このアプリについて", href = "#about")
        )
      )
    ),
    shiny::div(
      id = "app",
      ## List the first level UI elements here.
      shinybulma::bulmaNav("main", mod_main_ui("main_pane")),
      shinybulma::bulmaNav("about", mod_about_ui("about_pane"))
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  golem::add_resource_path("www", app_sys("app/www"))
  shiny::tags$head(
    golem::favicon(),
    golem::bundle_resources(
      path = app_sys("app/www"),
      app_title = "shaketoba"
    )
  )
}
