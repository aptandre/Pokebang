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
                    , winner    = ""
                    , shotP1    = initializeBullet1
                    , shotP2    = initializeBullet2
                    , time      = 0.0
                    }

-- cria o Player 1 base para ínicio da aplicação
initializePlayer1 :: Player
initializePlayer1 = Player { life     = 100
                           , name     = "Player 1"
                           , location = (-500, 0)
                           , onShoot  = initializeBullet1
                           , hasFired = False
                           }

-- cria o Player 2 base para ínicio da aplicação
initializePlayer2 :: Player
initializePlayer2 = Player { life     = 100
                           , name     = "Player 2"
                           , location = (500, 0)
                           , onShoot  = initializeBullet2
                           , hasFired = False
                           }

initializeBullet1 :: Bullet
initializeBullet1 =
    Bullet { damage = 100, speed = (4, 0), actualLocation = (-10000, 0) }

initializeBullet2 :: Bullet
initializeBullet2 =
    Bullet { damage = 100, speed = (-4, 0), actualLocation = (10000, 0) }
