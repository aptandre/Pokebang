module UpdateController where

import           GameModel
import           GameState
import           Initial
import           PlayerModel

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
fireShotsPlayer1 game | not move  = game
                      | otherwise = game { player1 = _player1 }
 where
  move           = isFired (onShoot (player1 game))
  bullet         = onShoot (player1 game)
  multiplier     = 4
  (velx, vely)   = speed bullet
  (x   , y   )   = actualLocation bullet
  x'             = x + (velx * multiplier)
  y'             = y + (vely * multiplier)

  _movingBullet1 = bullet { actualLocation = (x', y') }
  _player1       = (player1 game) { onShoot = _movingBullet1 }

fireShotsPlayer2 :: BANG -> BANG
fireShotsPlayer2 game | not move  = game
                      | otherwise = game { player2 = _player2 }
 where
  move           = isFired (onShoot (player2 game))
  bullet         = onShoot (player2 game)
  multiplier     = 4
  (velx, vely)   = speed bullet
  (x   , y   )   = actualLocation bullet
  x'             = x + (velx * multiplier)
  y'             = y + (vely * multiplier)

  _movingBullet2 = bullet { actualLocation = (x', y') }
  _player2       = (player2 game) { onShoot = _movingBullet2 }
