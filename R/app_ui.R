#' The application User-Interface
#'
#' @param request Internal parameter for shiny.
#'     DO NOT REMOVE.
#'
#' @keywords internal
#' @noRd
app_ui <- function(request) {
  shiny::fluidPage(
    golem_add_external_resources(), ## Leave this function for adding external resources.
    shiny::div(
      class = "page-header",
      shiny::h1(
        "Shaketoba | \u304a\u3058\u3055\u3093LINE\u6587\u7ae0\u753b\u50cf\u30b8\u30a7\u30cd\u30ec\u30fc\u30bf"
      )
    ),
    shiny::wellPanel(
      shiny::includeHTML(app_sys("app/include.html"))
    ),
    shiny::sidebarLayout(
      shiny::sidebarPanel(app_ui_control("sktbapp")),
      shiny::mainPanel(app_ui_main("sktbapp"))
    ),
    lang = "ja"
  )
}

#' main pane UI
#'
#' @keywords internal
#' @noRd
app_ui_main <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::actionButton(ns("render"), label = "\u751f\u6210"),
    shiny::plotOutput(ns("plot"))
  )
}

#' control pane UI
#'
#' @keywords internal
#' @noRd
app_ui_control <- function(id) {
  ns <- shiny::NS(id)
  ## Named vector for 'pos' label.
  pos_label <- c(joshi = "ADP", jodoshi = "AUX")
  names(pos_label) <- c(
    enc2utf8("\u52a9\u8a5e"),
    enc2utf8("\u52a9\u52d5\u8a5e")
  )
  shiny::tagList(
    shiny::textInput(
      ns("name"),
      "",
      value = "",
      placeholder = "\u306a\u307e\u3048"
    ),
    shiny::checkboxGroupInput(
      ns("pos"),
      "\u300c\u3001\u300d\u304c\u5f8c\u7d9a\u3059\u308b\u54c1\u8a5e",
      pos_label
    ),
    shiny::sliderInput(
      ns("emoji"),
      "\u7d75\u6587\u5b57/\u9854\u6587\u5b57\u306e\u9023\u7d9a\u6570",
      min = 0,
      max = 3,
      value = 1,
      step = 1L
    ),
    shiny::sliderInput(
      ns("comma"),
      "\u300c\u3001\u300d\u306e\u633f\u5165\u983b\u5ea6",
      min = 0,
      max = 1.0,
      value = 0.5,
      step = 0.1
    )
  )
}

#' Add external resources to the application
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
      app_title = "Shaketoba | \u304a\u3058\u3055\u3093LINE\u6587\u7ae0\u753b\u50cf\u30b8\u30a7\u30cd\u30ec\u30fc\u30bf"
    ),
    metathis::meta_social(
      metathis::meta(),
      title = "Shaketoba | \u304a\u3058\u3055\u3093LINE\u6587\u7ae0\u753b\u50cf\u30b8\u30a7\u30cd\u30ec\u30fc\u30bf",
      url = "https://github.com/paithiov909/shaketoba",
      image = "https://rawcdn.githack.com/paithiov909/shaketoba/7699e14ca72461077b0942a44b1457fb787cbf86/man/figures/plot.png",
      description = "R Port of Ojisan NArikiri Randomized Algorithm",
      twitter_card_type = "summary_large_image",
      og_type = "website",
      og_locale = "ja_JP"
    ),
    shiny::includeHTML(app_sys("app/scripts.html"))
  )
}
