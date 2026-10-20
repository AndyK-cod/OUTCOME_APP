# Lanceur Shiny pour le packaging Electron (Outcome App)
# Demarre l'application sur un port local choisi par le processus Electron.
# En production, le code R est charge depuis la version compilee (bytecode,
# produite par electron-app/scripts/build_compiled_app.R) ; en developpement,
# le script source Outcome_App.R est utilise s'il est present.

port <- suppressWarnings(as.integer(Sys.getenv("SHINY_PORT", "7474")))
if (is.na(port)) port <- 7474L
host <- Sys.getenv("SHINY_HOST", "127.0.0.1")
app_dir <- Sys.getenv("APP_DIR", ".")

setwd(app_dir)

compiled_app <- file.path(app_dir, "Outcome_App.Rc")
if (file.exists(compiled_app)) {
  # Version compilee : les affectations ui/server se font dans app_env.
  app_env <- new.env()
  compiler::loadcmp(compiled_app, envir = app_env)
  app_obj <- shiny::shinyApp(app_env$ui, app_env$server)
} else {
  # Version source (developpement) : l'application se termine par
  # shinyApp(ui, server) ; on recupere l'objet applicatif.
  app_obj <- source("Outcome_App.R", local = TRUE)$value
}

shiny::runApp(app_obj, host = host, port = port, launch.browser = FALSE)
