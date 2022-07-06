module Initial where

import           GameModel
import           GameState
import           PlayerModel

initialState :: BANG
initialState = Game { gameState = Menu
                    , player1   = initializePlayer1
                    , player2   = initializePlayer2
                    , winner    = initialPlayer
                    }

initializePlayer1 :: Player
initializePlayer1 =
    Player { life = 100, name = "Player 1", gun = generateGun, position = 0 }

initializePlayer2 :: Player
initializePlayer2 =
    Player { life = 100, name = "Player 2", gun = generateGun, position = 0 }

initialPlayer :: Player
initialPlayer =
    Player { life = 100, name = "", gun = generateGun, position = 0 }

generateGun :: Gun
generateGun = Gun { shotsCount = 0, bullets = [generateBullet] }

generateBullet :: Bullet
generateBullet = Bullet { damage = 100, speed = (10, 10) }
