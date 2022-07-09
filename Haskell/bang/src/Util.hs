module Util where

import           GameModel
import           Initial
import           ObstaclesModel
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
    | name == "Charmander" = game
        { charmander = (charmander game) { onShoot = initializePokeball }
        }
    | otherwise = game

slowDownPokeball :: String -> Tuple -> BANG -> BANG
slowDownPokeball name position game
    | name == "Bulbasaur" = game
        { slowpokes = removeFromListSlowPoke position (slowpokes game)
        , bulbasaur = (bulbasaur game)
                          { onShoot = (onShoot $ bulbasaur game)
                                          { speed = (1.5, 0)
                                          }
                          }
        }
    | name == "Charmander" = game
        { slowpokes  = removeFromListSlowPoke position (slowpokes game)
        , charmander = (charmander game)
                           { onShoot = (onShoot $ charmander game)
                                           { speed = (-1.5, 0)
                                           }
                           }
        }
    | otherwise = game

killsVileplum :: String -> Tuple -> BANG -> BANG
killsVileplum name position game
    | name == "Bulbasaur" = game
        { vileplums = removeVilePlumeFromList position (vileplums game)
        , bulbasaur = (bulbasaur game) { onShoot = initializePokeball }
        }
    | name == "Charmander" = game
        { vileplums  = removeVilePlumeFromList position (vileplums game)
        , charmander = (charmander game) { onShoot = initializePokeball }
        }
    | otherwise = game

removeFromListSlowPoke :: Tuple -> [SlowPoke] -> [SlowPoke]
removeFromListSlowPoke position [] = []
removeFromListSlowPoke position slowpokes =
    if position == slowPokeLocation (head slowpokes)
        then drop 1 slowpokes
        else take 1 slowpokes

removeVilePlumeFromList :: Tuple -> [VilePlum] -> [VilePlum]
removeVilePlumeFromList position [] = []
removeVilePlumeFromList position vileplums =
    if position == vilePlumLocation (head vileplums)
        then drop 1 vileplums
        else take 1 vileplums

