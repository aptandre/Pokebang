-- módulo responsável por definir o objeto Player
-- cada Player possui armas, que guardam balas para atirar
module PlayerModel where

type Tuple = (Float, Float)

data Player = Player
    { life     :: Int
    , location :: Tuple
    , name     :: String
    , onShoot  :: [Bullet]
    }
    deriving (Show, Eq)

data Bullet = Bullet
    { isFired        :: Bool
    , speed          :: Tuple
    , damage         :: Int
    , actualLocation :: Tuple
    }
    deriving (Show, Eq)
