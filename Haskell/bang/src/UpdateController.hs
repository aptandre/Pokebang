-- módulo responsável por atualizar a parte gráfica
-- opera funções periodicamente após um certo tempo
module UpdateController where

import           GameModel
import           GameState
import           Initial
import           PlayerModel
import           Util

-- controla as atualizações do jogo
updateController :: Float -> BANG -> BANG
updateController seconds game = case gameState game of
  Menu    -> game
  Playing -> updateGame seconds game
  End     -> game

-- atualiza o jogo em estado de Playing
updateGame :: Float -> BANG -> BANG
updateGame seconds game = updateShots $ updateState seconds game

-- atualiza o estado do jogo
-- verifica se algum dos players foi atingido para definir um vencedor
updateState :: Float -> BANG -> BANG
updateState seconds game
  | life (player1 game) == 0 = game { gameState = End, winner = "Player 2" }
  | life (player2 game) == 0 = game { gameState = End, winner = "Player 1" }
  | otherwise                = game { time = oldTime + 1 }
  where oldTime = time game

-- atualiza os tiros dos jogadores
-- os tiros só podem ser disparados após outros tiros saírem da tela
updateShots :: BANG -> BANG
updateShots game =
  checkCollision $ fireShotsPlayer2 $ checkCollision $ fireShotsPlayer1 game

-- atualiza os tiros do Player 1 movimentando esses
fireShotsPlayer1 :: BANG -> BANG
fireShotsPlayer1 game
  | not fireBullet = game
  | offMap bullet = game
    { player1 = (player1 game) { hasFired = False, onShoot = initializeBullet }
    }
  | otherwise = game { player1 = (player1 game) { onShoot = _movingBullet1 } }
 where
  bullet         = onShoot (player1 game)
  fireBullet     = hasFired (player1 game)
  (velx, vely)   = speed bullet
  (x   , y   )   = actualLocation bullet
  x'             = x + (velx * generateMultiplier)
  y'             = y + (vely * generateMultiplier)

  _movingBullet1 = bullet { actualLocation = (x', y') }

-- atualiza os tiros do Player 2 movimentando esses
fireShotsPlayer2 :: BANG -> BANG
fireShotsPlayer2 game
  | not fireBullet = game
  | offMap bullet = game
    { player2 = (player2 game) { hasFired = False, onShoot = initializeBullet }
    }
  | otherwise = game { player2 = (player2 game) { onShoot = _movingBullet2 } }
 where
  bullet         = onShoot (player2 game)
  fireBullet     = hasFired (player2 game)
  (velx, vely)   = speed bullet
  (x   , y   )   = actualLocation bullet
  x'             = x + (velx * generateMultiplier)
  y'             = y + (vely * generateMultiplier)

  _movingBullet2 = bullet { actualLocation = (x', y') }

-- verirfica se o tiro está fora do mapa
offMap :: Bullet -> Bool
offMap bullet =
  fst (actualLocation bullet) > 750 || fst (actualLocation bullet) < -750

-- verifica se ocorreu colisão entre os tiros e os players
checkCollision :: BANG -> BANG
checkCollision game
  | hasCollidedPlayer1 (onShoot (player2 game)) (player1 game) = game
    { player1 = (player1 game) { life = 0 }
    }
  | hasCollidedPlayer2 (onShoot (player1 game)) (player2 game) = game
    { player2 = (player2 game) { life = 0 }
    }
  | otherwise = game

-- verifica se houve collisão do player 1 com algum tiro do player 2
hasCollidedPlayer1 :: Bullet -> Player -> Bool
hasCollidedPlayer1 bullet player
  | ((xbullet - 5 >= xplayer - 22.5) && (xbullet - 5 <= xplayer + 22.5))
    && ((ybullet - 5 >= yplayer - 45) && (ybullet + 5 <= yplayer + 45))
  = True
  | otherwise
  = False
 where
  xbullet = fst (actualLocation bullet)
  ybullet = snd (actualLocation bullet)
  xplayer = fst (location player)
  yplayer = snd (location player)

-- verifica se houve collisão do player 2 com algum tiro do player 1
hasCollidedPlayer2 :: Bullet -> Player -> Bool
hasCollidedPlayer2 bullet player
  | ((xbullet + 5 >= xplayer - 22.5) && (xbullet + 5 <= xplayer + 22.5))
    && ((ybullet - 5 >= yplayer - 45) && (ybullet + 5 <= yplayer + 45))
  = True
  | otherwise
  = False
 where
  xbullet = fst (actualLocation bullet)
  ybullet = snd (actualLocation bullet)
  xplayer = fst (location player)
  yplayer = snd (location player)
