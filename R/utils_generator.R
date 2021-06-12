#' Convert message templates into ojichat
#'
#' @param message message template
#' @param target_name passed to \code{sktb_conv_tags_all()}.
#' @param pos_after passed to \code{sktb_insert_comma()}.
#' @param comma_freq passed to \code{sktb_insert_comma()}.
#' @return character vector.
#'
#' @export
sktb_conv_ojichat <- function(message,
                              target_name = "",
                              pos_after = c("ADP", "AUX"),
                              emoji_rep = 4L,
                              comma_freq = runif(1, 0, 1)) {
  message <- message %>%
    sktb_insert_comma(pos_after, comma_freq) %>%
    sktb_conv_tags_all(target_name, emoji_rep)
  return(message)
}

#' Sample message template
#'
#' @param size integer.
#' @param merge list. internaly passed to \code{sktb_message_pattern()}.
#' @param tail integer. passed to \code{sktb_conv_tail_charclass()}.
#' @param collapse character scalar.
#' @return message templates are returned as a charcter vector.
#'
#' @export
sktb_sample_message <- function(size = 1L, merge = list(), tail = sample.int(3, 1), collapse = "") {
  onara <- dqrng::dqsample(sktb_message_pattern(merge), size, replace = TRUE)
  onara <- purrr::map_chr(unname(onara), function(emotions) {
    messages <- lapply(emotions, function(elem) {
      emotion <- purrr::pluck(templates, elem)
      message <- dqrng::dqsample(emotion, 1)
      sktb_conv_tail_charclass(message, tail = tail)
    })
    stringi::stri_c(unlist(messages, use.names = FALSE), collapse = collapse)
  })
  return(onara)
}

#' Convert charclass of the last nth characters
#'
#' @param message character vector.
#' @param tail integer.
#' @param to this argument is passed to \code{zipangu::str_conv_hirakana()}.
#' @return list of character.
#'
#' @export
sktb_conv_tail_charclass <- function(message, tail = 1L, to = c("katakana", "hiragana")) {
  if (tail <= 1) {
    return(message)
  }
  to <- rlang::arg_match(to)
  message <- stringi::stri_split_boundaries(
    ## This function is locale-sensitive.
    ## See `?stringi::about_search_coll`
    message,
    opts_brkiter = stringi::stri_opts_brkiter("character", "ja_JP")
  )
  message <-
    lapply(message, function(elem) {
      purrr::imap_chr(
        elem,
        ~ ifelse(
          .y < length(elem) - (tail - 1),
          .x,
          zipangu::str_conv_hirakana(.x, to = to)
        )
      )
    })
  return(lapply(message, function(elem) {
    stringi::stri_c(elem, collapse = "")
  }))
}

#' Insert comma after specified pos
#'
#' @param message character scalar.
#' @param pos_after character vector.
#' @param comma_freq numeric.
#' @return character vector.
#'
#' @export
sktb_insert_comma <- function(message,
                              pos_after = c("ADP", "AUX"),
                              comma_freq = 0) {
  if (comma_freq == 0) {
    return(message)
  }
  tokens <- sktb_udpipe(message)
  result <- tokens %>%
    dplyr::rowwise() %>%
    dplyr::mutate(token = dplyr::if_else(
      upos %in% pos_after && dqrng::dqrunif(1, 0, 1) <= comma_freq,
      stringi::stri_c(token, stringi::stri_enc_toutf8("\u3001"), collapse = ""),
      token
    )) %>%
    dplyr::pull(token)
  return(stringi::stri_c(result, collapse = ""))
}
