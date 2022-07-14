-- módulo responsável por renderizar a parte gráfica
-- cria imagens para a visualização dos eventos na tela
module Render where

import           GameModel
import           GameState
import           Graphics.Gloss
import           PokemonModel

render :: IMAGES -> BANG -> Picture

-- renderiza as imagens referentes ao jogo em estado de jogo
render images game@Game { gameState = Playing } = frame
 where
  frame = pictures
    (  [positionedForegorund (foreground_menu images)]
    ++ [makeVileplumLeftBall (image_pokeball images) game]
    ++ [makeVilePlumRightBall (image_pokeball images) game]
    ++ [makeObstacleVilePlum (image_vileplum images) (vileplume game)]
    ++ map (makeObstacleSlowPoke (image_slowpoke images)) (slowpokes game)
    ++ map (makeObstacleStone (image_stone images))       (stones game)
    ++ [makeBulbasaur (bulbasaur game) (image_bulbasaur images)]
    ++ [makeCharmander (charmander game) (image_charmander images)]
    ++ [makePokeBall (onShoot (bulbasaur game)) (image_pokeball images)]
    ++ [makePokeBall (onShoot (charmander game)) (image_pokeball images)]
    )

-- renderiza as imagens referentes ao jogo em estado de menu
render images game@Game { gameState = Menu } = pictures
  [ makeText black "BANG!"                0.6 0.6 (-100) 0
  , makeText black "PRESS ENTER TO START" 0.3 0.3 (-215) 100
  , makeText black "PRESS ESC TO QUIT"    0.3 0.3 (-190) (-100)
  ]

-- renderiza as imagens referentes ao jogo em estado de end 
render images game@Game { gameState = End } = pictures
  [ makeText black "WIN!"        0.6 0.6 (-100) 0
  , makeText black (winner game) 0.3 0.3 (-100) (-100)
  ]

-- constroí a imagem responsável por mostrar o texto na tela
makeText :: Color -> String -> Float -> Float -> Float -> Float -> Picture
makeText textColor text x y x' y' =
  translate x' y' $ scale x y $ color textColor $ Text text

positionedForegorund :: Picture -> Picture
positionedForegorund = translate 0.0 0.0

makeBulbasaur :: Pokemon -> Picture -> Picture
makeBulbasaur _bulbasaur = translate x y where (x, y) = location _bulbasaur

makeCharmander :: Pokemon -> Picture -> Picture
makeCharmander _charmander = translate x y where (x, y) = location _charmander

makePokeBall :: Pokeball -> Picture -> Picture
makePokeBall _pokeball = translate x y
  where (x, y) = locationPokeball _pokeball

makeObstacleVilePlum :: Picture -> VilePlum -> Picture
makeObstacleVilePlum _image _vilePlum = translate x y _image
  where (x, y) = vilePlumLocation _vilePlum

makeObstacleSlowPoke :: Picture -> SlowPoke -> Picture
makeObstacleSlowPoke _image _slowpoke = translate x y _image
  where (x, y) = slowPokeLocation _slowpoke

makeObstacleStone :: Picture -> Stone -> Picture
makeObstacleStone _image _stone = translate x y _image
  where (x, y) = stoneLocation _stone

makeVileplumLeftBall :: Picture -> BANG -> Picture
makeVileplumLeftBall picture game =
  makePokeBall (vilePlumShootLeft $ vileplume game) picture

makeVilePlumRightBall :: Picture -> BANG -> Picture
makeVilePlumRightBall picture game =
  makePokeBall (vilePlumShootRight $ vileplume game) picture
