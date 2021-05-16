#' main logic ~> main server
sktb_ojichat <- function(target_name = "",
                         pos_after = c("\u52a9\u8a5e", "\u52a9\u52d5\u8a5e"),
                         emoji_rep_max = 4L,
                         comma_freq = runif(1, 0, 1)) {
  message <- sktb_sample_message() %>%
    str_convert_tags(target_name, emoji_rep_max) %>%
    sktb_insert_comma(pos_after, comma_freq) %>%
    paste0(collapse = "")
  return(message)
}

#' Sample message template
#'
#' @param merge list
#' @return message template is returned randomly.
#'
#' @export
sktb_sample_message <- function(merge = list()) {
  onara <- dqrng::dqsample(sktb_message_pattern(merge), 1)
  onara <- unlist(onara, use.names = FALSE)
  onara <- purrr::map_chr(onara, function(emotions) {
    messages <- lapply(emotions, function(elem) {
      emotion <- purrr::pluck(templates, elem)
      message <- dqrng::dqsample(emotion, 1)
      sktb_conv_tail_charclass(message, tail = dqrng::dqsample.int(3, 1))
    })
    unlist(messages)
  })
  return(onara)
}

#' Convert charclass of the last nth characters
#'
#' @param message character vector.
#' @param tail integer.
#' @param to this argument is passed to \code{zipangu::str_conv_hirakana}.
#' @return list of character.
#'
#' @export
sktb_conv_tail_charclass <- function(message, tail = 1L, to = c("katakana", "hiragana")) {
  if (tail <= 1) {
    return(message)
  }

  to <- rlang::arg_match(to)
  message <- stringi::stri_split_boundaries(message)
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
    paste0(elem, collapse = "")
  }))
}

#' Insert comma
#'
#' @param message character scalar.
#' @param pos_after character vector.
#' @param comma_freq numeric.
#' @return character vector.
#'
#' @export
sktb_insert_comma <- function(message,
                              pos_after = c("\u52a9\u8a5e", "\u52a9\u52d5\u8a5e"),
                              comma_freq = 0) {
  if (comma_freq == 0) {
    return(message)
  }
  tokens <- tokenize_kuromoji(message)
  result <- purrr::map_chr(tokens, function(elem) {
    pos_tag <- stringi::stri_split_fixed(elem$feature, ",")
    return(
      dplyr::if_else(
        pos_tag[[1]][1] %in% pos_after && dqrng::dqrunif(1, 0, 1) <= comma_freq,
        paste0(elem$surface, "\u3001", collapse = ""),
        elem$surface
      )
    )
  })
  return(paste0(result, collapse = ""))
}
