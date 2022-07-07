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

fireGunPlayer1 :: Player -> Player
fireGunPlayer1 player1 = player1 { onShoot = bullet }
    where bullet = generateMovingBullet1 player1

fireGunPlayer2 :: Player -> Player
fireGunPlayer2 player2 = player2 { onShoot = bullet }
    where bullet = generateMovingBullet2 player2
