# code to prepare `flextags` dataset goes here
# from: 'https://github.com/greymd/ojichat/blob/master/pattern/tags.go'

flextags <- list(
  emoji_pos = jsonlite::read_json("data-raw/emoji_pos.json", simplifyVector = TRUE),
  emoji_neg = jsonlite::read_json("data-raw/emoji_neg.json", simplifyVector = TRUE),
  emoji_neut = jsonlite::read_json("data-raw/emoji_neut.json", simplifyVector = TRUE),
  emoji_ask = jsonlite::read_json("data-raw/emoji_ask.json", simplifyVector = TRUE)
)

usethis::use_data(flextags, overwrite = TRUE)
