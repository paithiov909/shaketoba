#' Plot an ojichat meme
#'
#' @param str ojichat message.
#' @param img `NULL` or the file path to an image
#' (intenally passed to \code{magick::image_read()}).
#' @param split character scalar passed to \code{stringi::stri_replace_all_fixed()}
#' (NOT reprex).
#' @return an ojichat class object is returned.
#'
#' @export
sktb_plot_ojichat <- function(str, img = NULL, split = " ") {
  s <- stringi::stri_trans_nfkc(str)
  if (is.null(img)) img <- app_sys(dqrng::dqsample(sktb_images(), 1))
  sktb_meme(
    img,
    stringi::stri_replace_all_fixed(s, split, "\n"),
    "",
    size = 1.4
  )
}

#### Partial port from GuangchuangYu/meme ----

#' @name sktb_meme
#' @inherit meme::meme
#' @importFrom magick image_read image_info
#' @importFrom grid textGrob rasterGrob gpar viewport grid.draw gList
#' @importFrom grDevices dev.new
#' @keywords intrenal
#' @noRd
sktb_meme <- function(img,
                      upper = NULL,
                      lower = NULL,
                      size = "auto",
                      color = "snow",
                      font = "SetoFont-SP",
                      vjust = 0.4,
                      bgcolor = "violet",
                      r = 0.2,
                      density = NULL) {
  x <- image_read(img, density = density)
  info <- image_info(x)

  imageGrob <- rasterGrob(x)

  p <- structure(
    list(
      img = img, imageGrob = imageGrob,
      width = info$width, height = info$height,
      upper = upper, lower = lower,
      size = size, color = color,
      font = font, vjust = vjust,
      bgcolor = bgcolor, r = r
    ),
    class = c("ojichat", "recordedplot")
  )
  p
}

#' @noRd
sktb_meme_dev <- function(x) {
  if (!is.null(dev.list())) {
    tryCatch(dev.off(), error = function(e) NULL)
  }
  dev.new(width = 7, height = 7 * x$height / x$width, noRStudioGD = TRUE)
}

#' Aspect ratio
#' @inherit meme::asp
#' @keywords internal
asp <- function(x) {
  x$height / x$width
}

#' Convert pixel to inch
#' @noRd
px2in <- function(x) {
  x * 0.010417
}

#' @noRd
grid.draw.ojichat <- function(x, recording = TRUE) {
  print(x)
}

#' @noRd
#' @inherit meme::grid.echo.meme
grid.echo.ojichat <- function(x = NULL, newpage = TRUE, prefix = NULL) {
  meme_dev(x)
  grid.draw(x)
}

#' @method + ojichat
#' @importFrom utils modifyList
#' @keywords internal
"+.ojichat" <- function(e1, e2) {
  if (is(e2, "uneval")) {
    e2 <- as.character(e2)
  }
  params <- as.list(e2)
  names(params)[names(params) == "colour"] <- "color"
  params <- params[!sapply(params, is.null)]
  params <- params[names(params) %in% names(e1)]
  modifyList(e1, params)
}

#' @name print.ojichat
#' @inherit meme::print.meme
#' @importFrom grDevices dev.list dev.off dev.size dev.interactive
#' @importFrom grid grid.newpage pushViewport upViewport seekViewport
#' @keywords internal
#' @noRd
print.ojichat <- function(x, size = NULL, color = NULL, font = NULL,
                          upper = NULL, lower = NULL, vjust = NULL,
                          bgcolor = NULL, r = NULL,
                          newpage = is.null(vp), vp = NULL, newdev = FALSE, ...) {
  x <- x + list(
    size = size, color = color,
    font = font, vjust = vjust,
    bgcolor = bgcolor, r = r,
    upper = upper, lower = lower
  )

  grob <- as.gList(x)

  if (newdev) sktb_meme_dev(x)

  ## if (dev.interactive())
  if (newpage) grid.newpage()

  if (is.null(vp)) {
    grid.draw(grob)
  } else {
    if (is.character(vp)) seekViewport(vp) else pushViewport(vp)
    grid.draw(grob)
    upViewport()
  }

  invisible(x)
}

#' @name plot.ojichat
#' @inherit meme::plot.meme
#' @keywords intrenal
#' @noRd
plot.ojichat <- print.ojichat

#' @noRd
#' @inherit meme::memeGrob
memeGrob <- function(x) {
  as.gTree(x)
}

#' @noRd
#' @importFrom grid gTree
as.gTree <- function(x) {
  ## grid::grid.grabExpr(gridGraphics::grid.echo(x))
  gTree(children = as.gList(x))
}

#' Removing `base::toupper` from shadowtext calls.
#' @noRd
#' @importFrom grid gList
as.gList <- function(x) {
  if (x$size == "auto") {
    x$size <- x$height / 250
  }

  ds <- dev.size() # w & h
  h <- ds[1] * asp(x)
  vjust <- (h * x$vjust + (ds[2] - h) / 2) / ds[2]

  gp <- gpar(col = x$color, fontfamily = x$font, cex = x$size)

  upperGrob <- shadowtext(x$upper,
    gp = gp,
    vp = viewport(y = 1 - vjust),
    bgcolor = x$bgcolor, r = x$r, vjust = 1
  )

  lowerGrob <- shadowtext(x$lower,
    gp = gp,
    vp = viewport(y = vjust),
    bgcolor = x$bgcolor, r = x$r, vjust = 0
  )

  gList(x$imageGrob, upperGrob, lowerGrob)
}

#' @noRd
#' @importFrom grid unit
shadowtext <- function(text, gp = gpar(), vp = viewport(), bgcolor = NULL, r = 0.2, vjust = .5) {
  upperGrob <- textGrob(text, gp = gp, vp = vp, vjust = vjust)

  if (is.null(bgcolor)) {
    return(upperGrob)
  }

  gp$col <- bgcolor
  theta <- seq(pi / 8, 2 * pi, length.out = 16)
  ovp <- vp

  bgList <- lapply(theta, function(i) {
    vp <- ovp
    vp$x <- vp$x + unit(cos(i) * r, "strwidth", data = "X")
    vp$y <- vp$y + unit(sin(i) * r, "strheight", data = "X")
    textGrob(text, gp = gp, vp = vp, vjust = vjust)
  })

  bgGrob <- do.call(gList, bgList)
  grobs <- gList(bgGrob, upperGrob)
  gTree(children = grobs)
}
