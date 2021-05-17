#' Convert message templates into ojichat
#'
#' @param message message template
#' @param target_name passed to \code{sktb_conv_tags_all}.
#' @param pos_after passed to \code{sktb_insert_comma}.
#' @param comma_freq passed to \code{sktb_insert_comma}.
#' @return character vector.
#'
#' @export
sktb_conv_ojichat <- function(message,
                              target_name = "",
                              pos_after = c("\u52a9\u8a5e", "\u52a9\u52d5\u8a5e"),
                              emoji_rep = 4L,
                              comma_freq = runif(1, 0, 1)) {
  message <- message %>%
    sktb_conv_tags_all(target_name, emoji_rep) %>%
    sktb_insert_comma(pos_after, comma_freq)
  return(message)
}

#' Sample message template
#'
#' @param size integer.
#' @param merge list.
#' @param collapse character scalar.
#' @return message templates are returned as a charcter vector.
#'
#' @export
sktb_sample_message <- function(size = 1L, merge = list(), collapse = " ") {
  onara <- dqrng::dqsample(sktb_message_pattern(merge), size, replace = TRUE)
  names(onara) <- NULL
  onara <- purrr::map_chr(onara, function(emotions) {
    messages <- lapply(emotions, function(elem) {
      emotion <- purrr::pluck(templates, elem)
      message <- dqrng::dqsample(emotion, 1)
      sktb_conv_tail_charclass(message, tail = dqrng::dqsample.int(3, 1))
    })
    paste0(unlist(messages, use.names = FALSE), collapse = collapse)
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

#' Insert comma after specified pos
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
  result <- purrr::map_chr(message, function(str) {
    tokens <- tokenize_kuromoji(str)
    chars <- purrr::map_chr(tokens, function(elem) {
      pos_tag <- stringi::stri_split_fixed(elem$feature, ",")
      return(
        dplyr::if_else(
          pos_tag[[1]][1] %in% pos_after && dqrng::dqrunif(1, 0, 1) <= comma_freq,
          paste0(elem$surface, "\u3001", collapse = ""),
          elem$surface
        )
      )
    })
    return(paste0(chars, collapse = ""))
  })
  return(result)
}
