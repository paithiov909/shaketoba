#' @noRd
.locale <- NULL

#' @noRd
.mdl <- NULL

#' Wrapper of udpipe::udpipe
#'
#' @param message character vector.
#' @return data.frame
#'
#' @keywords internal
sktb_udpipe <- function(message) {
  udpipe::udpipe(stringi::stri_enc_toutf8(message), .mdl)
}

#' On load
#'
#' @param libname libname
#' @param pkgname pkgname
#'
#' @keywords internal
.onLoad <- function(libname, pkgname) {

  ## Preload udpipe model.
  model_path <- ifelse(Sys.getenv("SKTB_UDMODEL_PATH") != "",
    file.path("SKTB_UDMODEL_PATH"),
    system.file("models/japanese-gsd-ud-2.5-191206.udpipe", package = pkgname)
  )
  .mdl <<- udpipe::udpipe_load_model(model_path)

  ## Register 'SetoFont-SP' internally.
  sysfonts::font_add(
    "SetoFont-SP",
    system.file("fonts/setofont-sp-merged.ttf", package = pkgname)
  )
  if (.Platform$OS.type == "windows") windowsFonts("SetoFont-SP" = windowsFont("SetoFont-SP"))

  ## Reset strigni default locale.
  # .locale <<- stringi::stri_locale_set("ja_JP")

  ## Init showtext
  showtext::showtext_auto()
}

#' On unload
#'
#' @param libpath libpath
#'
#' @keywords internal
.onUnload <- function(libpath) {
  # stringi::stri_locale_set(.locale)
  showtext::showtext_auto(FALSE)
}
