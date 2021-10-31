
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cbx

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

O objetivo desse pacote é brincar com dados de xadrez no R.

## Installation

``` r
# install.packages("devtools")
devtools::install_github("tomasbarcellos/cbx")
```

## Examplo

Esse pacote contem dados do 87o Campeonato Brasileiro Absoluto Final
Aberta.

``` r
library(cbx)
library(dplyr)
glimpse(campeonato)
#> Rows: 294
#> Columns: 6
#> $ evento    <chr> "87o Campeonato Brasileiro Absoluto Final Aberta", "87o Camp~
#> $ local     <chr> "Cuiaba MT", "Cuiaba MT", "Cuiaba MT", "Cuiaba MT", "Cuiaba ~
#> $ brancas   <chr> "Supi, Luis Paulo", "Fontoura, Alexandre Souza", "Mekhitaria~
#> $ pretas    <chr> "Sopko, Cassio Roberto", "Fier, Alexandr", "Deus Filho, Joaq~
#> $ resultado <chr> "1-0", "0-1", "1-0", "0-1", "1-0", "0-1", "1-0", "0-1", "1-0~
#> $ pgn       <list> <"[Event \"87o Campeonato Brasileiro Absoluto Final Aberta\~
```

É possível buscar partidas das formas usadas regularmentes no
`tidyverse`.

``` r
campeonato %>% 
  filter(resultado == "1/2-1/2")
#> # A tibble: 45 x 6
#>    evento               local   brancas          pretas         resultado pgn   
#>    <chr>                <chr>   <chr>            <chr>          <chr>     <list>
#>  1 87o Campeonato Bras~ Cuiaba~ Proudian, Armen  Lima, Carlos ~ 1/2-1/2   <chr ~
#>  2 87o Campeonato Bras~ Cuiaba~ Correa, Joao Pe~ Federzoni, En~ 1/2-1/2   <chr ~
#>  3 87o Campeonato Bras~ Cuiaba~ Mazetto, Sergio~ Da Cruz, Emer~ 1/2-1/2   <chr ~
#>  4 87o Campeonato Bras~ Cuiaba~ Urquiza, Marcel~ Olivo, Anibal~ 1/2-1/2   <chr ~
#>  5 87o Campeonato Bras~ Cuiaba~ Barbosa Filho, ~ Toth, Peter    1/2-1/2   <chr ~
#>  6 87o Campeonato Bras~ Cuiaba~ De Andrade, Dal~ Naief Moreira~ 1/2-1/2   <chr ~
#>  7 87o Campeonato Bras~ Cuiaba~ Araujo, Everson~ Ferreira, Tha~ 1/2-1/2   <chr ~
#>  8 87o Campeonato Bras~ Cuiaba~ De Souza, Eliel~ Almeida, Tiag~ 1/2-1/2   <chr ~
#>  9 87o Campeonato Bras~ Cuiaba~ Ferreira, Andre~ Baeta, Marcio~ 1/2-1/2   <chr ~
#> 10 87o Campeonato Bras~ Cuiaba~ Lopes, Wendell ~ Felicio, Leon~ 1/2-1/2   <chr ~
#> # ... with 35 more rows
```

A ideia é poder usar o `data.frame` para passar partidas especificas com
o auxílio de outros pacotes como `rchess` ou `chess`.

``` r
set.seed(123)
partida_aleat <- campeonato[sample(nrow(campeonato), 1), ]

chsspgn <- rchess::Chess$new()
pgn <- partida_aleat$pgn[[1]]
pgn <- paste(pgn, collapse = "\n")

chsspgn$load_pgn(pgn)
#> [1] TRUE
plot(chsspgn)
```

<div id="htmlwidget-0dc2a931752ae4f30d75" style="width:300px;height:300px;" class="chessboardjs html-widget"></div>
<script type="application/json" data-for="htmlwidget-0dc2a931752ae4f30d75">{"x":{"fen":"n2r3k/5N2/p5B1/1p5p/7P/1Pb2P2/P1P3P1/2K4R b - - 2 29"},"evals":[],"jsHooks":[]}</script>
