module GameModel where

import           GameState
import           PlayerModel

data BANG = Game
    { gameState :: GameState
    , winner    :: Player
    , looser    :: Player
    }
