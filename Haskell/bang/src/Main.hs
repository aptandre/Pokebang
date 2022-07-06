module Main where

<<<<<<< Updated upstream
main :: IO ()
main = do
  putStrLn "hello world"
=======
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
    play window background fps initialState render eventHandler updateController
>>>>>>> Stashed changes
