# Launch the ShinyApp (Do not remove this comment)

Sys.setenv("LANG" = "ja_JP.UTF-8")

## Copy font files manually and call `fc-cache`.
if (!dir.exists("~/.fonts")) { dir.create("~/.fonts") }
file.copy("./inst/fonts/setofont-sp-merged.ttf", "~/.fonts", overwrite = TRUE)
system("fc-cache -vf ~/.fonts")

## Load app
pkgload::load_all(export_all = FALSE, helpers = FALSE, attach_testthat = FALSE)
options(
  "golem.app.prod" = TRUE
)
shaketoba::run_app() # add parameters here (if any)
