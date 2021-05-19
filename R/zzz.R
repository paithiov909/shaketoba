#' @keywords internal
#' @noRd
.opt <- NULL

#' @keywords internal
#' @noRd
.mdl <- NULL

#' @keywords internal
#' @noRd
sktb_udpipe <- function(message) {
  udpipe::udpipe(stringi::stri_enc_toutf8(message), .mdl)
}

#' On load
#'
#' @details
#' \code{grDevices::x11}
#'
#' @param libname libname
#' @param pkgname pkgname
#'
#' @keywords internal
#' @noRd
.onLoad <- function(libname, pkgname) {

  ## Preload udpipe model
  model_path <- ifelse(Sys.getenv("SKTB_UDMODEL_PATH") != "",
    file.path("SKTB_UDMODEL_PATH"),
    system.file("models/japanese-gsd-ud-2.5-191206.udpipe", package = pkgname)
  )
  .mdl <<- udpipe::udpipe_load_model(model_path)

  sysfonts::font_add(
    "SetoFont-SP",
    system.file("fonts/setofont-sp-merged.ttf", package = pkgname)
  )

  ## Register 'SetoFont-SP' internally.
  if (.Platform$OS.type == "windows") {
    windowsFonts(
      "SetoFont-SP" = windowsFont("SetoFont-SP")
    )
  }

  ## Set `par(family)` under unix-alikes
  .opt <<- par(no.readonly = TRUE)
  if (.Platform$OS.type == "unix") {
    par(family = "SetoFont-SP")
  }

  ## Init showtext
  showtext::showtext_auto()
}

#' @keywords internal
#' @noRd
.onDetach <- function(libpath) {
  if (.Platform$OS.type == "unix") { par(.opt) }
  showtext::showtext_auto(FALSE)
}
