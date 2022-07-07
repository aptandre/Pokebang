module Util where

import           PlayerModel

-- cria balas para uso na arma dos Players
generateMovingBullet1 :: Player -> Bullet
generateMovingBullet1 playerM1 = Bullet { isFired        = True
                                        , damage         = 100
                                        , speed          = (4, 0)
                                        , actualLocation = location playerM1
                                        }

generateMovingBullet2 :: Player -> Bullet
generateMovingBullet2 playerM2 = Bullet { isFired        = True
                                        , damage         = 100
                                        , speed          = (-4, 0)
                                        , actualLocation = location playerM2
                                        }

