-- módulo responsável por renderizar a parte gráfica
-- cria imagens para a visualização dos eventos na tela
module Render where

import           GameModel
import           GameState
import           Graphics.Gloss
import           ObstaclesModel
import           PlayerModel

render :: Picture -> Picture -> Picture -> Picture -> BANG -> Picture

-- renderiza as imagens referentes ao jogo em estado de jogo
render bulbasaur charmander pokeball foreground game@Game { gameState = Playing }
  = frame
 where
  frame = pictures
    (  [positionForegorund foreground]
    ++ [makePlayer1 $ player1 game]
    ++ [makePlayer2 $ player2 game]
    ++ [makeBullet $ onShoot (player1 game)]
    ++ [makeBullet $ onShoot (player2 game)]
    ++ map makeObstacleCactus (cactus game)
    ++ map makeObstacleWheat  (wheats game)
    ++ map makeObstacleStone  (stones game)
    ++ [makeBulbasaur (player1 game) bulbasaur]
    ++ [makeCharmander (player2 game) charmander]
    ++ [makePokeBall (onShoot (player1 game)) pokeball]
    ++ [makePokeBall (onShoot (player2 game)) pokeball]
    )

-- renderiza as imagens referentes ao jogo em estado de menu
render _ _ _ _ game@Game { gameState = Menu } = pictures
  [ makeText black "BANG!"                0.6 0.6 (-100) 0
  , makeText black "PRESS ENTER TO START" 0.3 0.3 (-215) 100
  , makeText black "PRESS ESC TO QUIT"    0.3 0.3 (-190) (-100)
  ]

-- renderiza as imagens referentes ao jogo em estado de end 
render _ _ _ _ game@Game { gameState = End } = pictures
  [ makeText black "WIN!"        0.6 0.6 (-100) 0
  , makeText black (winner game) 0.3 0.3 (-100) (-100)
  ]

-- constroí a imagem responsável por mostrar o texto na tela
makeText :: Color -> String -> Float -> Float -> Float -> Float -> Picture
makeText textColor text x y x' y' =
  translate x' y' $ scale x y $ color textColor $ Text text

-- constroí a imagem responsável por mostrar o player 1 na tela
makePlayer1 :: Player -> Picture
makePlayer1 _player1 = translate x y $ color playerColor $ rectangleSolid 45 90
 where
  (x, y)      = location _player1
  playerColor = dark cyan

-- constroí a imagem responsável por mostrar o player 2 na tela
makePlayer2 :: Player -> Picture
makePlayer2 _player2 = translate x y $ color playerColor $ rectangleSolid 45 90
 where
  (x, y)      = location _player2
  playerColor = dark magenta

-- constroí a imagem responsável por mostrar as balas na tela
makeBullet :: Bullet -> Picture
makeBullet _bullet = translate x y $ color bulletColor $ rectangleSolid 10 10
 where
  (x, y)      = actualLocation _bullet
  bulletColor = black

makeObstacleCactus :: Cactus -> Picture
makeObstacleCactus _cactus =
  translate x y $ color obstacleColor $ rectangleSolid 40 40
 where
  (x, y)        = cactusLocation _cactus
  obstacleColor = dark green

makeObstacleWheat :: Wheat -> Picture
makeObstacleWheat _wheat = translate x y $ color obstacleColor $ rectangleSolid
  40
  40
 where
  (x, y)        = wheatLocation _wheat
  obstacleColor = light yellow

makeObstacleStone :: Stone -> Picture
makeObstacleStone _stone = translate x y $ color obstacleColor $ rectangleSolid
  40
  40
 where
  (x, y)        = stoneLocation _stone
  obstacleColor = light (light black)


makeBulbasaur :: Player -> Picture -> Picture
makeBulbasaur _player1 _bulbasaur = translate x y
  $ color playerColor _bulbasaur
 where
  (x, y)      = location _player1
  playerColor = dark cyan

makeCharmander :: Player -> Picture -> Picture
makeCharmander _player2 _charmander = translate x y
  $ color playerColor _charmander
 where
  (x, y)      = location _player2
  playerColor = dark magenta

makePokeBall :: Bullet -> Picture -> Picture
makePokeBall _bullet _pokeball = translate x y $ color bulletColor _pokeball
 where
  (x, y)      = actualLocation _bullet
  bulletColor = black

positionForegorund :: Picture -> Picture
positionForegorund = translate 0.0 0.0
