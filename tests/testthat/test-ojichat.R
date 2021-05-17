tp <- purrr::flatten_chr(templates)

test_that("all templates can be parsed", {
  expect_length(
    sktb_conv_ojichat(tp),
    length(tp)
  )
})
