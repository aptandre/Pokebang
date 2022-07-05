module EventHandler where

import           Initial

import           GameModel
import           GameState
import           Graphics.Gloss
import           Graphics.Gloss.Interface.IO.Game

eventHandler :: Event -> BANG -> BANG

eventHandler (EventKey (Char 'p') Down _ _) game@Game { gameState = Menu } =
    game { gameState = Playing }

eventHandler (EventKey (Char 'q') Down _ _) game@Game { gameState = Menu } =
    game { gameState = End }


eventHandler _ game = game



