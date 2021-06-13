tp <- purrr::flatten_chr(templates)

# TODO: Check if there are no invalid UTF8 chars
test_that("all templates can be parsed", {
  expect_length(
    sktb_conv_ojichat(tp),
    length(tp)
  )
})
