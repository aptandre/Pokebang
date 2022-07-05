module Render where

import           GameModel
import           GameState
import           Graphics.Gloss

render :: BANG -> Picture

render game@Game { gameState = Playing } = text "Me"

render game@Game { gameState = Menu }    = text "Ajuda"

render game@Game { gameState = End }     = text "Meu deus"

-- mkText :: Color -> String -> Float -> Float -> Float -> Float -> Picture
-- mkText col text x y x' y' = translate x' y' $ scale x y $ color col $ Text text



