module UpdateController where

import           GameModel
import           GameState
import           Initial
import           PlayerModel
import           Util

updateController :: Float -> BANG -> BANG
updateController seconds game = case gameState game of
  Menu    -> game
  Playing -> updateGame seconds game
  End     -> game

updateGame :: Float -> BANG -> BANG
updateGame seconds game = updateShots $ updateState seconds game

updateState :: Float -> BANG -> BANG
updateState seconds game
  | life (player1 game) == 0 = game { gameState = End, winner = "Player 2" }
  | life (player2 game) == 0 = game { gameState = End, winner = "Player 1" }
  | otherwise                = game { time = oldTime + 1 }
  where oldTime = time game

updateShots :: BANG -> BANG
updateShots game = fireShotsPlayer2 $ fireShotsPlayer1 game

fireShotsPlayer1 :: BANG -> BANG
fireShotsPlayer1 game
  | offMap bullet = game
    { player1 = (player1 game) { hasFired = False, onShoot = initializeBullet1 }
    }
  | otherwise = game { player1 = (player1 game) { onShoot = _movingBullet1 } }
 where
  bullet         = onShoot (player1 game)
  fireBullet     = hasFired (player1 game)
  multiplier     = 4
  (velx, vely)   = speed bullet
  (x   , y   )   = actualLocation bullet
  x'             = x + (velx * multiplier)
  y'             = y + (vely * multiplier)

  _movingBullet1 = bullet { actualLocation = (x', y') }

fireShotsPlayer2 :: BANG -> BANG
fireShotsPlayer2 game
  | offMap bullet = game
    { player2 = (player2 game) { hasFired = False, onShoot = initializeBullet2 }
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

offMap :: Bullet -> Bool
offMap bullet =
  fst (actualLocation bullet) > 700 || fst (actualLocation bullet) < -700
