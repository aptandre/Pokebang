-- módulo responsável por definir o objeto Game
-- o jogo possui um estado, dois players distintos, um ganhador e as balas atiradas pelos jogadores
module GameModel where

import           GameState
import           PlayerModel

data BANG = Game
    { gameState :: GameState
    , player1   :: Player
    , player2   :: Player
    , winner    :: Player
    , gunFired  :: [Bullet]
    }
