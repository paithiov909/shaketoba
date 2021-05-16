#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#'
#' @keywords internal
#' @noRd
app_ui <- function(request) {
  shiny::fluidPage(
    golem_add_external_resources(), ## Leave this function for adding external resources.
    shiny::div(
      id = "app",
      ## List the first level UI elements here.
      # mod_about_ui("main_pane")
      # mod_about_ui("control_pane")
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @keywords internal
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
