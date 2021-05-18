#' Convert tags in the message template
#'
#' @param message character vector.
#' @param target_name character vector.
#' @param emoji_rep integer
#' @return character vector.
#'
#' @export
sktb_conv_tags_all <- function(message, target_name = "", emoji_rep = 1L) {
  if (target_name == "") {
    target_name <- paste0(sktb_sample_first_name(), sktb_sample_name_suffix(), collapse = "")
  } else {
    target_name <- paste0(target_name, sktb_sample_name_suffix(), collapse = "")
  }
  message <- message %>%
    stringi::stri_replace_all_regex("\\{TARGET_NAME\\}", target_name) %>%
    sktb_conv_tags_uniq() %>%
    sktb_conv_tags_flex(emoji_rep = emoji_rep)
  return(message)
}

#' Convert flex tags
#'
#' @param message character vector.
#' @param emoji_rep integer.
#' @return character vector.
#'
#' @keywords internal
#' @noRd
sktb_conv_tags_flex <- function(message, emoji_rep = 1L) {
  purrr::iwalk(
    list(
      "\\{EMOJI_POS\\}",
      "\\{EMOJI_NEG\\}",
      "\\{EMOJI_NEUT\\}",
      "\\{EMOJI_ASK\\}"
    ),
    function(.x, .y) {
      message <<- stringi::stri_replace_all_regex(
        message,
        .x,
        dplyr::if_else(
          emoji_rep > 0,
          paste0(dqrng::dqsample(flextags[[.y]], emoji_rep, replace = !(length(flextags[[.y]]) < emoji_rep)), collapse = ""),
          "\u3002"
        )
      )
    }
  )
  return(message)
}

#' Convert unique tags
#'
#' @param message character vector.
#' @return character vector.
#'
#' @keywords internal
#' @noRd
sktb_conv_tags_uniq <- function(message) {
  purrr::iwalk(
    list(
      "\\{FIRST_PERSON\\}",
      "\\{DAY_OF_WEEK\\}",
      "\\{LOCATION\\}",
      "\\{RESTAURANT\\}",
      "\\{FOOD\\}",
      "\\{WEATHER\\}",
      "\\{NANCHATTE\\}",
      "\\{HOTEL\\}",
      "\\{DATE\\}",
      "\\{METAPHOR\\}"
    ),
    function(.x, .y) {
      message <<- stringi::stri_replace_all_regex(message, .x, dqrng::dqsample(uniqtags[[.y]], 1))
    }
  )
  return(message)
}

#' Sample Japanese female first names
#'
#' @param size integer.
#' @return character vector.
#'
#' @export
sktb_sample_first_name <- function(size = 1L) {
  slice <- dplyr::slice_sample(gimei, n = size, replace = !(nrow(gimei) < size))
  sw <- dqrng::dqsample.int(3, 1)
  return(
    dplyr::case_when(
      sw == 1 ~ slice$kanji,
      sw == 2 ~ slice$hiragana,
      sw == 3 ~ slice$katakana
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
  sw <- dqrng::dqrunif(size, 1, 100)
  return(
    dplyr::case_when(
      sw < 5 ~ "",
      sw < 20 ~ stringi::stri_enc_toutf8("\u30c1\u30e3\u30f3"),
      sw < 40 ~ stringi::stri_enc_toutf8("\uff81\uff6c\uff9d"),
      TRUE ~ stringi::stri_enc_toutf8("\u3061\u3083\u3093")
    )
  )
}
