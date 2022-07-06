-- módulo responsável por iniciar certos objetos
-- cria objetos como base para iniciar a aplicação 
module Initial where

import           GameModel
import           GameState
import           PlayerModel

-- cria o jogo base para ínicio da aplicação
initialState :: BANG
initialState = Game { gameState = Menu
                    , player1   = initializePlayer1
                    , player2   = initializePlayer2
                    , winner    = initialPlayer
                    , gunFired  = []
                    }

-- cria o Player 1 base para ínicio da aplicação
initializePlayer1 :: Player
initializePlayer1 = Player { life     = 100
                           , name     = "Player 1"
                           , gun      = generateGun1
                           , location = (500, 0)
                           }

-- cria o Player 2 base para ínicio da aplicação
initializePlayer2 :: Player
initializePlayer2 = Player { life     = 100
                           , name     = "Player 2"
                           , gun      = generateGun2
                           , location = (-500, 0)
                           }

-- cria um Player genérico para ínicio da aplicação
initialPlayer :: Player
initialPlayer =
    Player { life = 100, name = "", gun = generateGun1, location = (0, 0) }

-- cria uma arma para uso do Player 1
generateGun1 :: Gun
generateGun1 = Gun { direction      = True
                   , bullet         = generateBullet1
                   , playerLocation = (500, 0)
                   }

-- cria uma arma para uso do Player 2
generateGun2 :: Gun
generateGun2 = Gun { direction      = False
                   , bullet         = generateBullet2
                   , playerLocation = (-500, 0)
                   }

-- cria bals para uso na arma dos Players
generateBullet1 :: Bullet
generateBullet1 =
    Bullet { damage = 100, speed = (10, 10), bulletLocation = (500, 0) }

generateBullet2 :: Bullet
generateBullet2 =
    Bullet { damage = 100, speed = (10, 10), bulletLocation = (-500, 0) }
