# Lanceur portable (package ZIP) : charge la version compilee (bytecode) de
# l'application et ouvre le navigateur par defaut sur un port local libre.
app_dir <- local({
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (length(file_arg) > 0) {
    dirname(normalizePath(sub("^--file=", "", file_arg[[1]]), mustWork = TRUE))
  } else {
    getwd()
  }
})
setwd(app_dir)

port <- suppressWarnings(as.integer(Sys.getenv("OUTCOME_PORT", "")))
if (is.na(port)) {
  port <- tryCatch(httpuv::randomPort(), error = function(e) NULL)
}
if (is.null(port) || is.na(port)) port <- 7474L

message("Demarrage de l'Outcome App sur http://127.0.0.1:", port)
message("Ne fermez pas cette fenetre pendant l'utilisation de l'application.")

app_env <- new.env()
compiler::loadcmp(file.path(app_dir, "Outcome_App.Rc"), envir = app_env)
app_obj <- shiny::shinyApp(app_env$ui, app_env$server)

open_browser <- !identical(tolower(Sys.getenv("OUTCOME_NO_BROWSER")), "true")
shiny::runApp(app_obj, host = "127.0.0.1", port = port, launch.browser = open_browser)
