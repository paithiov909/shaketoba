#' Cachem in-memory cache
#'
#' Expires in 1 hrs.
#'
#' @keywords internal
#' @noRd
.cm <- NULL

#' Thin wrapper of `tangela::kuromoji`
#'
#' This function is memoised on production.
#'
#' @keywords internal
#' @noRd
tokenize_kuromoji <- function(message) {
  tangela::kuromoji(message)
}

#' On load
#'
#' @param libname libname
#' @param pkgname pkgname
#'
#' @keywords internal
#' @noRd
.onLoad <- function(libname, pkgname) {
  if (golem::app_prod()) {
    .cm <<- cachem::cache_mem(
      max_size = 128 * 1024^2,
      max_age = 60 * 60
    )
    tokenize_kuromoji <<- memoise::memoise(tokenize_kuromoji, cache = .cm)
  }

  ## Register 'SetoFont' internally.
  sysfonts::font_paths(system.file("fonts", package = pkgname))
  sysfonts::font_add("SetoFont", "setofont-sp-merged.ttf")

  if (.Platform$OS.type == "windows") {
    windowsFonts(
      "SetoFont" = windowsFont("SetoFont")
    )
    require("fontregisterer", quietly = TRUE)
  }
}
