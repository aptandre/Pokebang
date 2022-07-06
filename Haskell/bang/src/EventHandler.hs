module EventHandler where

import           Initial

import           GameModel
import           GameState
import           Graphics.Gloss
import           Graphics.Gloss.Interface.IO.Game
import           PlayerModel


eventHandler :: Event -> BANG -> BANG

eventHandler (EventKey (SpecialKey KeyEnter) Down _ _) game@Game { gameState = Menu }
    = game { gameState = Playing }

eventHandler (EventKey (Char 'e') Down _ _) game@Game { gameState = Menu } =
    game { gameState = Playing }

eventHandler (EventKey (Char 'd') Down _ _) game@Game { gameState = Playing }
    = game
eventHandler (EventKey (Char 'w') Down _ _) game@Game { gameState = Playing } =
    game { player1 = updateLocationUp (player1 game) }
eventHandler (EventKey (Char 's') Down _ _) game@Game { gameState = Playing } =
    game { player1 = updateLocationDown (player1 game) }

eventHandler (EventKey (SpecialKey KeyLeft) Down _ _) game@Game { gameState = Playing }
    = game
eventHandler (EventKey (SpecialKey KeyUp) Down _ _) game@Game { gameState = Playing }
    = game { player2 = updateLocationUp (player2 game) }
eventHandler (EventKey (SpecialKey KeyDown) Down _ _) game@Game { gameState = Playing }
    = game { player2 = updateLocationDown (player2 game) }

eventHandler _ game = game

-- atualizar a função para adicionar até o limite da tela
-- similarmenente decrementar até o limite da tela
updateLocationUp :: Player -> Player
updateLocationUp player
    | finalPosition < 350 = player { position = eixo_y + 25 }
    | otherwise           = player
  where
    eixo_y        = position player
    finalPosition = eixo_y + 25

updateLocationDown :: Player -> Player
updateLocationDown player
    | finalPosition > -300 = player { position = eixo_y - 25 }
    | otherwise            = player
  where
    eixo_y        = position player
    finalPosition = eixo_y - 25



