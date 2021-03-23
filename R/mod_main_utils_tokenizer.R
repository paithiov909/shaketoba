#' Get dfm
#'
#' @param text String scalar.
#' @return quanteda dfm object.
#'
#' @importFrom zipangu str_jnormalize
#' @importFrom quanteda as.tokens dfm
#' @importFrom tangela kuromoji
#' @importFrom purrr map_chr pluck
#' @importFrom magrittr %>%
#' @export
get_dfm <- function(text)
{
  require(magrittr, quietly = TRUE)
  text %>%
    zipangu::str_jnormalize() %>%
    tangela::kuromoji() %>%
    purrr::map_chr(., ~ purrr::pluck(., "surface")) %>%
    paste(., collapse = " ") %>%
    quanteda::tokens() %>%
    quanteda::dfm(remove_punct = TRUE)
}
