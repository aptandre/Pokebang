-- módulo responsável por definir o objeto Game
-- o jogo possui um estado, dois players distintos, um ganhador e o tempo de jogo
module GameModel where

import           GameState
import           ObstaclesModel
import           PokemonModel

-- objeto 
data BANG = Game
    { gameState  :: GameState
    , bulbasaur  :: Pokemon
    , charmander :: Pokemon
    , winner     :: String
    , time       :: Float
    , stones     :: [Stone]
    , slowpokes  :: [SlowPoke]
    , belossoms  :: [Belossom]
    }
