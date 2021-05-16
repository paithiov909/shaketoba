# code to prepare `gimei` dataset goes here
# from: 'https://github.com/willnet/gimei'

yaml <- (function() {
  con <- url(
    "https://raw.githubusercontent.com/willnet/gimei/main/lib/data/names.yml",
    open = "r",
    encoding = "UTF-8"
  )
  on.exit(close(con))
  return(yaml::read_yaml(con))
})()

# 女性名だけしか使わない
gimei <- purrr::map_dfr(
  yaml$first_name$female,
  ~ data.frame(
    kanji = .[1],
    hiragana = .[2],
    katakana = .[3]
  )
)

usethis::use_data(gimei, overwrite = TRUE)
