-- módulo responsável por definir o objeto Game
-- o jogo possui um estado, dois players distintos, um ganhador e o tempo de jogo
module GameModel where

import           GameState
import           ObstaclesModel
import           PlayerModel

-- objeto 
data BANG = Game
    { gameState :: GameState
    , player1   :: Player
    , player2   :: Player
    , winner    :: String
    , time      :: Float
    , cactus    :: [Cactus]
    , wheats    :: [Wheat]
    , stones    :: [Stone]
    }
