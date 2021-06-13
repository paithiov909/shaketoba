#' Onara message patterns
#'
#' @param merge list.
#' @return list.
#'
#' @keywords internal
#' @export
sktb_message_pattern <- function(merge) {
  res <- list(
    gqs = c("greeting", "question", "sympathy"),
    gr = c("greeting", "reporting"),
    gc = c("greeting", "cheering"),
    gqi = c("greeting", "question", "invitation"),
    pa = c("praising", "admiration"),
    s = c("sympathy")
  )
  return(purrr::list_merge(res, merge))
}
