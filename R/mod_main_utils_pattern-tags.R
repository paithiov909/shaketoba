#'
sktb_convert_tags <- function(message, target_name, emoji_number) {
  if (rlang::is_empty(target_name)) {
    target_name <- sktb_sample_first_name()
  }
}

#'
sktb_combine_multiple_patterns <- function() {

}

#' Sample Japanese female first names
#'
#' @param size integer.
#' @return character vector.
#'
#' @export
sktb_sample_first_name <- function(size = 1L) {
  slice <- dplyr::slice_sample(gimei, n = size, replace = TRUE)
  switch <- dqrng::dqsample.int(3, 1)
  return(
    dplyr::case_when(
      switch == 1 ~ slice$kanji,
      switch == 2 ~ slice$hiragana,
      switch == 3 ~ slice$katakana
    )
  )
}

#' Sample Japanese name suffix
#'
#' @param size integer.
#' @return character vector.
#'
#' @export
sktb_sample_name_suffix <- function(size = 1L) {
  switch <- dqrng::dqrunif(size, 1, 100)
  return(
    dplyr::case_when(
      switch < 5 ~ "",
      switch < 20 ~ stringi::stri_enc_toutf8("\u30c1\u30e3\u30f3"),
      switch < 40 ~ stringi::stri_enc_toutf8("\uff81\uff6c\uff9d"),
      TRUE ~ stringi::stri_enc_toutf8("\u3061\u3083\u3093")
    )
  )
}
