#' Thin wrapper of `tangela::kuromoji`
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
