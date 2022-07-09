module Util where

import           GameModel
import           Initial
import           PokemonModel

-- cria balas para uso na arma do Player 1
generateMovingPokeball1 :: Pokemon -> Pokeball
generateMovingPokeball1 bulbasaur = Pokeball
    { damage           = 100
    , speed            = (4, 0)
    , locationPokeball = location bulbasaur
    }

-- cria balas para uso na arma do Player 2
generateMovingPokeball2 :: Pokemon -> Pokeball
generateMovingPokeball2 charmander = Pokeball
    { damage           = 100
    , speed            = (-4, 0)
    , locationPokeball = location charmander
    }

generateMultiplier :: Float
generateMultiplier = 4

interceptPokeball :: String -> BANG -> BANG
interceptPokeball name game
    | name == "Bulbasaur" = game
        { bulbasaur = (bulbasaur game) { onShoot = initializePokeball }
        }
    | otherwise = game
        { charmander = (charmander game) { onShoot = initializePokeball }
        }

slowDownPokeball :: String -> [Tuple] -> BANG -> BANG
slowDownPokeball name position game
    | name == "Bulbasaur" = game
        { slowpokes = tail $ slowpokes game
        , bulbasaur = (bulbasaur game)
                          { onShoot = (onShoot $ bulbasaur game)
                                          { speed = (1.5, 0)
                                          }
                          }
        }
    | otherwise = game
        { slowpokes  = tail $ slowpokes game
        , charmander = (charmander game)
                           { onShoot = (onShoot $ charmander game)
                                           { speed = (-1.5, 0)
                                           }
                           }
        }

killsVileplum :: String -> [Tuple] -> BANG -> BANG
killsVileplum name position game
    | name == "Bulbalsaur" = game
        { vileplums = tail $ vileplums game
        , bulbasaur = (bulbasaur game) { onShoot = initializePokeball }
        }
    | otherwise = game
        { vileplums  = tail $ vileplums game
        , charmander = (charmander game) { onShoot = initializePokeball }
        }
