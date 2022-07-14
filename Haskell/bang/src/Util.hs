module Util where

import           GameModel
import           Graphics.Gloss
import           Initial
import           PokemonModel

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

-- cria balas para uso na arma do Player 1
generateMovingPokeballBulbasaur :: Pokemon -> Pokeball
generateMovingPokeballBulbasaur bulbasaur = Pokeball
    { damage           = 100
    , speed            = (4, 0)
    , locationPokeball = location bulbasaur
    }

-- cria balas para uso na arma do Player 2
generateMovingPokeballCharmander :: Pokemon -> Pokeball
generateMovingPokeballCharmander charmander = Pokeball
    { damage           = 100
    , speed            = (-4, 0)
    , locationPokeball = location charmander
    }

generateMultiplier :: Float
generateMultiplier = 4

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

removeFromListSlowPoke :: Tuple -> [SlowPoke] -> [SlowPoke]
removeFromListSlowPoke position [] = []
removeFromListSlowPoke position slowpokes
    | slowPokeLocation (head slowpokes) == position = removeFromListSlowPoke
        position
        (tail slowpokes)
    | otherwise = head slowpokes
    : removeFromListSlowPoke position (tail slowpokes)

generateMovingShootVileplume :: Tuple -> VilePlum -> Pokeball
generateMovingShootVileplume projSpeed vileplume = Pokeball
    { speed            = projSpeed
    , damage           = 100
    , locationPokeball = vilePlumLocation vileplume
    }

