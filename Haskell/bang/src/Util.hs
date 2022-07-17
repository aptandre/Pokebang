-- Módulo utilizado para agregar funções úteis, em geral
-- as funções daqui são bastante utilizadas ou no update
-- controller ou no event handler
module Util where

import           GameModel
import           Graphics.Gloss
import           Initial
import           PokemonModel

-- Função que configura todas as imagens utilizadas no jogo
makeImagesHolder
    :: Picture
    -> Picture
    -> Picture
    -> Picture
    -> Picture
    -> Picture
    -> Picture
    -> Picture
    -> Picture
    -> Picture
    -> IMAGES
makeImagesHolder foreground_menu foreground_playing foreground_winner_bulbasaur foreground_winner_charmander image_bulbasaur image_charmander image_pokeball image_vileplum image_slowpoke image_stone
    = Images { foreground_menu              = foreground_menu
             , foreground_playing           = foreground_playing
             , foreground_winner_bulbasaur  = foreground_winner_bulbasaur
             , foreground_winner_charmander = foreground_winner_charmander
             , image_bulbasaur              = image_bulbasaur
             , image_charmander             = image_charmander
             , image_pokeball               = image_pokeball
             , image_vileplum               = image_vileplum
             , image_slowpoke               = image_slowpoke
             , image_stone                  = image_stone
             }

-- Cria uma Pokéball que se move para o uso do Bulbasaur
generateMovingPokeballBulbasaur :: Pokemon -> Pokeball
generateMovingPokeballBulbasaur bulbasaur = Pokeball
    { damage           = 100
    , speed            = (4, 0)
    , locationPokeball = location bulbasaur
    }

-- Cria uma Pokéball que se move para o uso do Charmander
generateMovingPokeballCharmander :: Pokemon -> Pokeball
generateMovingPokeballCharmander charmander = Pokeball
    { damage           = 100
    , speed            = (-4, 0)
    , locationPokeball = location charmander
    }

-- Utilizada para gerar os multiplicadores das velocidades
generateMultiplier :: Float
generateMultiplier = 4

-- Intercepta Pokebolas a partir de um objeto collision e do game
interceptPokeball :: Collision -> BANG -> BANG
interceptPokeball collision game
    | pokemon == "Bulbasaur" = game
        { bulbasaur = (bulbasaur game) { onShoot = initializePokeball }
        }
    | pokemon == "Charmander" = game
        { charmander = (charmander game) { onShoot = initializePokeball }
        }
    | otherwise = game
  where
    pokemon  = name (pokemonCollided collision)
    position = collisionLocation collision

-- Decrementa a velocidade de Pokebolas a partir de um objeto collision e do game
slowDownPokeball :: Collision -> BANG -> BANG
slowDownPokeball collision game
    | pokemon == "Bulbasaur" = game
        { slowpokes = removeFromListSlowPoke position (slowpokes game)
        , bulbasaur = (bulbasaur game)
                          { onShoot = (onShoot $ bulbasaur game)
                                          { speed = (1.5, 0)
                                          }
                          }
        }
    | pokemon == "Charmander" = game
        { slowpokes  = removeFromListSlowPoke position (slowpokes game)
        , charmander = (charmander game)
                           { onShoot = (onShoot $ charmander game)
                                           { speed = (-1.5, 0)
                                           }
                           }
        }
    | otherwise = game
  where
    pokemon  = name (pokemonCollided collision)
    position = collisionLocation collision

-- Remove um slowpoke da lista de slowpokes quando ele é atingido por uma pokeball
removeFromListSlowPoke :: Tuple -> [SlowPoke] -> [SlowPoke]
removeFromListSlowPoke position [] = []
removeFromListSlowPoke position slowpokes
    | slowPokeLocation (head slowpokes) == position = removeFromListSlowPoke
        position
        (tail slowpokes)
    | otherwise = head slowpokes
    : removeFromListSlowPoke position (tail slowpokes)

-- Faz um objeto vileplume novo
generateMovingShootVileplume :: Tuple -> VilePlum -> Pokeball
generateMovingShootVileplume projSpeed vileplume = Pokeball
    { speed            = projSpeed
    , damage           = 100
    , locationPokeball = vilePlumLocation vileplume
    }

