module Render where

import           GameModel
import           GameState
import           Graphics.Gloss
import           PlayerModel

render :: BANG -> Picture

render game@Game { gameState = Playing } = frame
  where
    frame = pictures [makePlayer1 $ player1 game, makePlayer2 $ player2 game]

render game@Game { gameState = Menu } = pictures
    [ makeText black "BANG!"                0.6 0.6 (-100) 0
    , makeText black "PRESS ENTER TO START" 0.3 0.3 (-215) 100
    , makeText black "PRESS ESC TO QUIT"    0.3 0.3 (-190) (-100)
    ]

render game@Game { gameState = End } = makeText black "WIN!" 0.6 0.6 (-100) 0

makeText :: Color -> String -> Float -> Float -> Float -> Float -> Picture
makeText textColor text x y x' y' =
    translate x' y' $ scale x y $ color textColor $ Text text

makePlayer1 :: Player -> Picture
makePlayer1 _player = translate x y $ color playerColor $ rectangleSolid 45 90
  where
    (x, y)      = (500, position _player)
    playerColor = dark cyan

makePlayer2 :: Player -> Picture
makePlayer2 _player = translate x y $ color playerColor $ rectangleSolid 45 90
  where
    (x, y)      = (-500, position _player)
    playerColor = dark magenta
