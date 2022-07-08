module Util where

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
