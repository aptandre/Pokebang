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
    (  [positionedForegorund (foreground_playing images)]
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
render images game@Game { gameState = Menu } = foreground_menu images

-- renderiza as imagens referentes ao jogo em estado de end 
render images game@Game { gameState = End }  = if winner game == "Bulbasaur"
  then foreground_winner_bulbasaur images
  else foreground_winner_charmander images

-- Posiciona o foregroud na tela através da função translate do gloss
positionedForegorund :: Picture -> Picture
positionedForegorund = translate 0.0 0.0

-- Cria a visualização (Picture) do player 1 a partir do objeto Bulbasaur e a sua imagem
makeBulbasaur :: Pokemon -> Picture -> Picture
makeBulbasaur _bulbasaur = translate x y where (x, y) = location _bulbasaur

-- Cria a visualização (Picture) do player 2 a partir do objeto Charmander e a sua imagem
makeCharmander :: Pokemon -> Picture -> Picture
makeCharmander _charmander = translate x y where (x, y) = location _charmander

-- Cria a visualização (Picture) da Pokéball (ou a bala) a partir do objeto Pokeball e a sua imagem
makePokeBall :: Pokeball -> Picture -> Picture
makePokeBall _pokeball = translate x y
  where (x, y) = locationPokeball _pokeball

-- Cria a visualização (Picture) do obstáculo Vileplum partir do objeto Vileplum e a sua imagem
makeObstacleVilePlum :: Picture -> VilePlum -> Picture
makeObstacleVilePlum _image _vilePlum = translate x y _image
  where (x, y) = vilePlumLocation _vilePlum

-- Cria a visualização (Picture) do obstáculo Slowpoke partir do objeto Slowpoke e a sua imagem
makeObstacleSlowPoke :: Picture -> SlowPoke -> Picture
makeObstacleSlowPoke _image _slowpoke = translate x y _image
  where (x, y) = slowPokeLocation _slowpoke

-- Cria a visualização (Picture) do obstáculo Stone partir do objeto Stone e a sua imagem
makeObstacleStone :: Picture -> Stone -> Picture
makeObstacleStone _image _stone = translate x y _image
  where (x, y) = stoneLocation _stone

-- Cria a visualização (Picture) da Pokeball esquerda do vileplume a partir da imagem e do game
makeVileplumLeftBall :: Picture -> BANG -> Picture
makeVileplumLeftBall picture game =
  makePokeBall (vilePlumShootLeft $ vileplume game) picture

-- Cria a visualização (Picture) da Pokeball direito do vileplume a partir da imagem e do game
makeVilePlumRightBall :: Picture -> BANG -> Picture
makeVilePlumRightBall picture game =
  makePokeBall (vilePlumShootRight $ vileplume game) picture
