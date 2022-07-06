-- módulo responsável por renderizar a parte gráfica
-- cria imagens para a visualização dos eventos na tela
module Render where

import           GameModel
import           GameState
import           Graphics.Gloss
import           PlayerModel

render :: BANG -> Picture

-- renderiza as imagens referentes ao jogo em estado de jogo
render game@Game { gameState = Playing } = frame
 where
  frame = pictures [makePlayer1 $ player1 game, makePlayer2 $ player2 game]

-- renderiza as imagens referentes ao jogo em estado de menu
render game@Game { gameState = Menu } = pictures
  [ makeText black "BANG!"                0.6 0.6 (-100) 0
  , makeText black "PRESS ENTER TO START" 0.3 0.3 (-215) 100
  , makeText black "PRESS ESC TO QUIT"    0.3 0.3 (-190) (-100)
  ]

-- renderiza as imagens referentes ao jogo em estado de end 
render game@Game { gameState = End } = makeText black "WIN!" 0.6 0.6 (-100) 0

-- constroí a imagem responsável por mostrar o texto na tela
makeText :: Color -> String -> Float -> Float -> Float -> Float -> Picture
makeText textColor text x y x' y' =
  translate x' y' $ scale x y $ color textColor $ Text text

-- constroí a imagem responsável por mostrar o player 1 na tela
makePlayer1 :: Player -> Picture
makePlayer1 _player = translate x y $ color playerColor $ rectangleSolid 45 90
 where
  (x, y)      = location _player
  playerColor = dark cyan

-- constroí a imagem responsável por mostrar o player 2 na tela
makePlayer2 :: Player -> Picture
makePlayer2 _player = translate x y $ color playerColor $ rectangleSolid 45 90
 where
  (x, y)      = location _player
  playerColor = dark magenta
