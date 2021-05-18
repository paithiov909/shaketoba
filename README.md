
<!-- README.md is generated from README.Rmd. Please edit that file -->

# shaketoba

<!-- badges: start -->
<!-- badges: end -->

> R Port of Ojisan NArikiri Randomized Algorithm

## なんだこれは

[ojichat](https://github.com/greymd/ojichat)のR言語版です。

## インストール

rJavaへの依存があるのでJavaが必要です。

``` r
if (!requireNamespace("tangela", quietly = TRUE)) {
  remotes::install_github("paithiov909/tangela")
}
remotes::install_github("paithiov909/shaketoba")
```

## 使い方

### As a Shiny application

[Shaketoba \| おじさんLINE文章画像ジェネレータ](#)

### As an R package

``` r
chat_message <- sktb_sample_message() %>%
  sktb_conv_ojichat(emoji_rep = 3L, comma_freq = 0.2)

sktb_plot_ojichat(chat_message)
```

こういう感じの画像をプロットできます。

![sktb-plot-sample](https://raw.githack.com/paithiov909/shaketoba/main/man/figures/plot.png)

## ライセンス

MIT License

`inst/fonts/setofont-sp-merged.ttf`には[OFL
v1.1](https://github.com/paithiov909/shaketoba/blob/main/inst/fonts/OFL.txt)が適用されます。
このソフトウェアには[Apache License
2.0](https://www.apache.org/licenses/LICENSE-2.0.html)で頒布されているソフトウェアの派生物が含まれます。

`inst/illust`以下の画像は[いらすとや](https://www.irasutoya.com/)で頒布されている素材です。[利用規定](https://www.irasutoya.com/p/terms.html)の都合上、これらの画像そのものの再利用はできません。
