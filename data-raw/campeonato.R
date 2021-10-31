chsspgn <- rchess::Chess$new()
pgn <- readLines("inst/extdata/cbx.pgn", warn = FALSE)
inicios <- stringr::str_which(pgn, "Event ")
fins <- c((inicios - 1)[-1], length(pgn))
jogos <- purrr::map2(inicios, fins, ~pgn[.x:.y])

brancas <- purrr::map(jogos, ~stringr::str_extract(.x, "(?<=White \").+(?=\")")) %>%
  purrr::map_chr(na.omit)
pretas <- purrr::map(jogos, ~stringr::str_extract(.x, "(?<=Black \").+(?=\")")) %>%
  purrr::map_chr(na.omit)
evento <- purrr::map(jogos, ~stringr::str_extract(.x, "(?<=Event \").+(?=\")")) %>%
  purrr::map_chr(na.omit)
local <- purrr::map(jogos, ~stringr::str_extract(.x, "(?<=Site \").+(?=\")")) %>%
  purrr::map_chr(na.omit)
resultado <- purrr::map(jogos, ~stringr::str_extract(.x, "(?<=Result \").+(?=\")")) %>%
  purrr::map_chr(na.omit)



campeonato <- tibble::tibble(
  evento = evento,
  local = local,
  brancas = brancas,
  pretas = pretas,
  resultado = resultado,
  pgn = jogos
)

usethis::use_data(campeonato, overwrite = TRUE)
