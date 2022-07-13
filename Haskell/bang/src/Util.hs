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
generateMovingShootVileplume projSpeed vileplume =  Pokeball { speed = projSpeed, damage = 100, locationPokeball = (vilePlumLocation vileplume) }

