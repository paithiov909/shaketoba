# code to prepare `uniqtags` dataset goes here
# from: 'https://github.com/greymd/ojichat/blob/master/pattern/tags.go'

uniqtags <- list(
  first_person = c(
    "僕",
    "ボク",
    "ﾎﾞｸ",
    "俺",
    "オレ",
    "ｵﾚ",
    "小生",
    "オジサン",
    "ｵｼﾞｻﾝ",
    "おじさん",
    "オイラ"
  ),
  day_of_week = c(
    "月", "火", "水", "木", "金", "土", "日"
  ),
  location = c(
    stringr::str_sub(zipangu::jpnprefs$prefecture_kanji, 1, -2)
  ),
  restaurant = c(
    "お寿司<U+0001F363>",
    "イタリアン<U+0001F35D>",
    "バー<U+0001F377>",
    "ラーメン屋さん<U+0001F35C>",
    "中華<U+0001F35C>"
  ),
  food = c(
    "お惣菜",
    "サラダ",
    "おにぎり<U+0001F359>",
    "きんぴらごぼう",
    "ピッツァ<U+0001F355>",
    "パスタ<U+0001F35D>",
    "スイーツ<U+0001F36E>",
    "ケーキ<U+0001F382>"
  ),
  weather = c(
    "曇り",
    "晴れ",
    "快晴",
    "大雨",
    "雨",
    "雪",
    "台風<U+0001F300>"
  ),
  nanchatte = c(
    "ﾅﾝﾁｬｯﾃ{emoji_pos}",
    "ナンチャッテ{emoji_pos}",
    "なんちゃって{emoji_pos}",
    "なんてね{emoji_pos}",
    "冗談{emoji_pos}",
    ""
  ),
  hotel = c(
    "ホテル<U+0001F3E8>",
    "ホテル<U+0001F3E9>",
    "旅館"
  ),
  date = c(
    "デート<U+2764>",
    "カラオケ<U+0001F3A4>",
    "ドライブ<U+0001F697>"
  ),
  metaphor = c(
    "天使",
    "女神",
    "女優さん",
    "お姫様"
  )
)

usethis::use_data(uniqtags, overwrite = TRUE)
