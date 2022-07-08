module Util where

import           PlayerModel

-- cria balas para uso na arma do Player 1
generateMovingBullet1 :: Player -> Bullet
generateMovingBullet1 playerM1 =
    Bullet { damage = 100, speed = (4, 0), actualLocation = location playerM1 }

-- cria balas para uso na arma do Player 2
generateMovingBullet2 :: Player -> Bullet
generateMovingBullet2 playerM2 =
    Bullet { damage = 100, speed = (-4, 0), actualLocation = location playerM2 }

generateMultiplier :: Float
generateMultiplier = 4
