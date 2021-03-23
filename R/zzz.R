## Expire items in cache after 1 hrs.
#' @noRd
cm <- cachem::cache_mem(
  max_size = 128 * 1024^2,
  max_age = 60 * 60
)

#' Memoised function
#' @noRd
make_dfm <- memoise::memoise(get_dfm, cache = cm)

#' @noRd
#' @importFrom cachem cache_mem
#' @importFrom memoise memoise
#' @importFrom future plan
.onAttach <- function(libname, pkgname) {
  if (.Platform$OS.type == "windows") {
    future::plan("multisession")
  } else {
    future::plan("mutlicore")
  }
}
