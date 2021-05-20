#' Plot an ojichat meme
#'
#' @param str ojichat message.
#' @param img passed to \code{meme::meme()}.
#' @param split character scalar.
#' @return object returned from \code{meme::meme()}.
#'
#' @export
sktb_plot_ojichat <- function(str, img = NULL, split = "EOS") {
  s <- stringi::stri_replace_all_fixed(str, split, "\n")
  if (is.null(img)) img <- app_sys(dqrng::dqsample(sktb_images(), 1))
  withr::with_package(
    "meme",
    {
      e <- rlang::caller_env()
      rlang::eval_tidy(
        rlang::quo(meme(
          img,
          s,
          "",
          size = 1.4,
          color = "snow",
          font = "SetoFont-SP",
          vjust = 0.4,
          bgcolor = "violet"
        )),
        env = rlang::env_bind(e, `base::toupper` = sktb_dummy_toupper)
      )
    }
  )
}

#' Mask `base::toupper`
#'
#' Since `meme::meme` calls `base::toupper` internally,
#' Unicode code points sometimes get broken (4 digits point are mistaken 5 digits).
#' This func is mask that function to prevent them.
#'
#' @keywords internal
#' @noRd
sktb_dummy_toupper <- function(x) {
  message("Masking toupper call")
  if (!is.character(x)) { x <- as.character(x) }
  return(x)
}

