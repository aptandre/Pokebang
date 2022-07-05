module Initial where

import           GameModel
import           GameState
import           PlayerModel

initialState :: BANG
initialState =
    Game { gameState = Menu, winner = initialPlayer, looser = initialPlayer }

initialPlayer :: Player
initialPlayer = Player { life = 100, name = "", gun = generateGun }

generateGun :: Gun
generateGun = Gun { shotsCount = 0, bullets = [generateBullet] }

generateBullet :: Bullet
generateBullet = Bullet { damage = 100, speed = (10, 10) }
