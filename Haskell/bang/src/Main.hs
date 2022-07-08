module Main where

import           EventHandler
import           GameDisplay
import           GameModel
import           GameState
import           Graphics.Gloss
import           Initial
import           PlayerModel
import           Render
import           UpdateController

-- Interface grafica
window :: Display
window = InWindow "BANG!" (width, height) (xOffset, yOffset)

main = do
    bulba      <- loadBMP "bulba.bmp"
    charm      <- loadBMP "charm.bmp"
    pokeball   <- loadBMP "pokebola.bmp"
    foreground <- loadBMP "background.bmp"
    play window
         background
         fps
         initialState
         (render bulba charm pokeball foreground)
         eventHandler
         updateController
