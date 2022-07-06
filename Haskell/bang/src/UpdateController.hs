module UpdateController where

import           GameModel
import           GameState

updateController :: Float -> BANG -> BANG
updateController seconds game = case gameState game of
    Menu    -> game
    Playing -> updateGame game
    End     -> game

updateGame :: BANG -> BANG
updateGame game = updatePositions $ updateShot $ 
