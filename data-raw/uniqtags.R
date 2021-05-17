# code to prepare `uniqtags` dataset goes here
# from: 'https://github.com/greymd/ojichat/blob/master/pattern/tags.go'

uniqtags <- list(
  first_person = jsonlite::read_json("data-raw/first_person.json", simplifyVector = TRUE),
  day_of_week = c(
    "月", "火", "水", "木", "金", "土", "日"
  ),
  location = c(
    stringr::str_sub(zipangu::jpnprefs$prefecture_kanji, 1, -2)
  ),
  restaurant = jsonlite::read_json("data-raw/restaurant.json", simplifyVector = TRUE),
  food = jsonlite::read_json("data-raw/food.json", simplifyVector = TRUE),
  weather = jsonlite::read_json("data-raw/weather.json", simplifyVector = TRUE),
  nanchatte = jsonlite::read_json("data-raw/nanchatte.json", simplifyVector = TRUE),
  hotel = jsonlite::read_json("data-raw/hotel.json", simplifyVector = TRUE),
  date = jsonlite::read_json("data-raw/date.json", simplifyVector = TRUE),
  metaphor = jsonlite::read_json("data-raw/metaphor.json", simplifyVector = TRUE)
)

usethis::use_data(uniqtags, overwrite = TRUE)
