-- módulo responsável por iniciar certos objetos
-- cria objetos como base para iniciar a aplicação 
module Initial where

import           GameModel
import           GameState
import           ObstaclesModel
import           PlayerModel

-- cria o jogo base para ínicio da aplicação
initialState :: BANG
initialState = Game { gameState = Menu
                    , player1   = initializePlayer1
                    , player2   = initializePlayer2
                    , winner    = ""
                    , time      = 0.0
                    , cactus    = getCactus
                    , wheats    = getWheats
                    , stones    = getStones
                    }

-- cria o Player 1 base para ínicio da aplicação
initializePlayer1 :: Player
initializePlayer1 = Player { life     = 100
                           , name     = "Player 1"
                           , location = (-500, 0)
                           , onShoot  = initializeBullet
                           , hasFired = False
                           }

-- cria o Player 2 base para ínicio da aplicação
initializePlayer2 :: Player
initializePlayer2 = Player { life     = 100
                           , name     = "Player 2"
                           , location = (500, 0)
                           , onShoot  = initializeBullet
                           , hasFired = False
                           }

-- Função responsável por retornar a bala inicial
initializeBullet :: Bullet
initializeBullet =
    Bullet { damage = 100, speed = (4, 0), actualLocation = (-10000, 0) }

-- Função utilizada para gerar objetos cacto
makeCactus :: String -> Integer -> Spike -> Tuple -> Cactus
makeCactus name life spike location = Cactus { cactusName     = name,
                                               cactusLife     = life,
                                               cactusShoot    = spike,
                                               cactusLocation = location
                                             }

-- Função utilizada para gerar objetos trigo
makeWheat :: String -> Integer -> Tuple -> Wheat
makeWheat name life location = Wheat {
    wheatName = name,
    wheatLife = life,
    wheatLocation = location
}

-- Função utilizada para gerar objetos pedra
makeStone :: String -> Integer -> Tuple -> Stone
makeStone name life location = Stone {
    stoneName = name,
    stoneLife = life,
    stoneLocation = location
}

-- Função utilizada para pegar a lista de cactos
getCactus :: [Cactus]
getCactus = [makeCactus "Juliette" 20 Spike { cactusSpeed = (3, 0), cactusDamage = 100, spikeLocation = (-200,100)} (0, 0),
             makeCactus "André" 20 Spike { cactusSpeed = (3, 0), cactusDamage = 100, spikeLocation = (20,-200)} (20, -290)]

-- Função utilizada para pegar a lista de trigos
getWheats :: [Wheat]
getWheats = [makeWheat "Trigo" 100 (110, 305),
             makeWheat "Trigo" 100 (-200, 130),
             makeWheat "Trigo" 100 (200, -150)]

-- Função utilizada para pegar a lista de pedras
getStones :: [Stone]
getStones = [makeStone "Preda" 100 (-10, 245),
             makeStone "Preda" 100 (-200, -250)]
