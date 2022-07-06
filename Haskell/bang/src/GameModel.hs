module GameModel where

import           GameState
import           PlayerModel

data BANG = Game
    { gameState :: GameState
    , player1   :: Player
    , player2   :: Player
    , winner    :: Player
    }
