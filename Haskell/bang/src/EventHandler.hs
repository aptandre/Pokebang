module EventHandler where

import           Initial

import           GameModel
import           GameState
import           Graphics.Gloss
import           Graphics.Gloss.Interface.IO.Game
import           PokemonModel
import           Util

-- associa eventos no teclado a eventos do jogo
eventHandler :: Event -> BANG -> BANG

-- inicia o jogo ao apertar enter
eventHandler (EventKey (SpecialKey KeyEnter) Down _ _) game@Game { gameState = Menu }
    = game { gameState = Playing }

-- o Player 1 atira ao apertar a tecla D
eventHandler (EventKey (Char 'd') Down _ _) game@Game { gameState = Playing } =
    game { bulbasaur = throwPokeBallBulbasaur (bulbasaur game) }

-- move o Player 1 para cima ao apertar a tecla W
eventHandler (EventKey (Char 'w') Down _ _) game@Game { gameState = Playing } =
    game { bulbasaur = updateLocationUp (bulbasaur game) }

-- move o Player 1 para baixo ao apertar a tecla S
eventHandler (EventKey (Char 's') Down _ _) game@Game { gameState = Playing } =
    game { bulbasaur = updateLocationDown (bulbasaur game) }

-- o Player 2 atira ao apertar a seta para a tecla seta para esquerda
eventHandler (EventKey (SpecialKey KeyLeft) Down _ _) game@Game { gameState = Playing }
    = game { charmander = throwPokeBallCharmander (charmander game) }

-- move o Player 2 para cima ao apertar a tecla seta para cima
eventHandler (EventKey (SpecialKey KeyUp) Down _ _) game@Game { gameState = Playing }
    = game { charmander = updateLocationUp (charmander game) }

-- move o Player 2 para baixo ao apertar a tecla seta para baixo
eventHandler (EventKey (SpecialKey KeyDown) Down _ _) game@Game { gameState = Playing }
    = game { charmander = updateLocationDown (charmander game) }

eventHandler _ game = game

-- atualiza a posição do Player na tela no sentido para cima
updateLocationUp :: Pokemon -> Pokemon
updateLocationUp pokemon
    | finalPosition < 350 = pokemon { location = (eixoX, finalPosition) }
    | otherwise           = pokemon
  where
    eixoX         = fst (location pokemon)
    eixoY         = snd (location pokemon)
    finalPosition = eixoY + 50

-- atualiza a posição do Player na tela no sentido para baixo
updateLocationDown :: Pokemon -> Pokemon
updateLocationDown pokemon
    | finalPosition > -300 = pokemon { location = (eixoX, finalPosition) }
    | otherwise            = pokemon
  where
    eixoX         = fst (location pokemon)
    eixoY         = snd (location pokemon)
    finalPosition = eixoY - 50

-- atira uma bala para o Player 1 periodicamente
throwPokeBallBulbasaur :: Pokemon -> Pokemon
throwPokeBallBulbasaur bulbasaur = if not (hasFired bulbasaur)
    then bulbasaur { hasFired = True, onShoot = pokeball }
    else bulbasaur
    where pokeball = generateMovingPokeball1 bulbasaur

-- atira uma bala para o Player 2 periodicamente
throwPokeBallCharmander :: Pokemon -> Pokemon
throwPokeBallCharmander charmander = if not (hasFired charmander)
    then charmander { hasFired = True, onShoot = pokeball }
    else charmander
    where pokeball = generateMovingPokeball2 charmander
