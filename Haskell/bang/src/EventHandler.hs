module EventHandler where

import           Initial

import           GameModel
import           GameState
import           Graphics.Gloss
import           Graphics.Gloss.Interface.IO.Game
import           PlayerModel
import           Util

-- associa eventos no teclado a eventos do jogo
eventHandler :: Event -> BANG -> BANG

-- inicia o jogo ao apertar enter
eventHandler (EventKey (SpecialKey KeyEnter) Down _ _) game@Game { gameState = Menu }
    = game { gameState = Playing }

-- o Player 1 atira ao apertar a tecla D
eventHandler (EventKey (Char 'd') Down _ _) game@Game { gameState = Playing } =
    game { player1 = fireGunPlayer1 (player1 game) }

-- move o Player 1 para cima ao apertar a tecla W
eventHandler (EventKey (Char 'w') Down _ _) game@Game { gameState = Playing } =
    game { player1 = updateLocationUp (player1 game) }

-- move o Player 1 para baixo ao apertar a tecla S
eventHandler (EventKey (Char 's') Down _ _) game@Game { gameState = Playing } =
    game { player1 = updateLocationDown (player1 game) }

-- o Player 2 atira ao apertar a seta para a tecla seta para esquerda
eventHandler (EventKey (SpecialKey KeyLeft) Down _ _) game@Game { gameState = Playing }
    = game { player2 = fireGunPlayer2 (player2 game) }

-- move o Player 2 para cima ao apertar a tecla seta para cima
eventHandler (EventKey (SpecialKey KeyUp) Down _ _) game@Game { gameState = Playing }
    = game { player2 = updateLocationUp (player2 game) }

-- move o Player 2 para baixo ao apertar a tecla seta para baixo
eventHandler (EventKey (SpecialKey KeyDown) Down _ _) game@Game { gameState = Playing }
    = game { player2 = updateLocationDown (player2 game) }


eventHandler _ game = game

-- atualiza a posição do Player na tela no sentido para cima
updateLocationUp :: Player -> Player
updateLocationUp player
    | finalPosition < 350 = player { location = (eixoX, finalPosition) }
    | otherwise           = player
  where
    eixoX         = fst (location player)
    eixoY         = snd (location player)
    finalPosition = eixoY + 50

-- atualiza a posição do Player na tela no sentido para baixo
updateLocationDown :: Player -> Player
updateLocationDown player
    | finalPosition > -300 = player { location = (eixoX, finalPosition) }
    | otherwise            = player
  where
    eixoX         = fst (location player)
    eixoY         = snd (location player)
    finalPosition = eixoY - 50

-- atira uma bala para o Player 1 periodicamente
fireGunPlayer1 :: Player -> Player
fireGunPlayer1 player1 = if not (hasFired player1)
    then player1 { hasFired = True, onShoot = bullet }
    else player1
    where bullet = generateMovingBullet1 player1

-- atira uma bala para o Player 2 periodicamente
fireGunPlayer2 :: Player -> Player
fireGunPlayer2 player2 = if not (hasFired player2)
    then player2 { hasFired = True, onShoot = bullet }
    else player2
    where bullet = generateMovingBullet2 player2
