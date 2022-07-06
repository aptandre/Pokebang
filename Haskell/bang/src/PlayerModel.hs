-- módulo responsável por definir o objeto Player
-- cada Player possui armas, que guardam balas para atirar
module PlayerModel where

type Tuple = (Float, Float)

data Player = Player
    { life     :: Int
    , name     :: String
    , gun      :: Gun
    , location :: Tuple
    }
    deriving (Show, Eq)

data Gun = Gun
    { direction      :: Bool
    , playerLocation :: Tuple
    , bullet         :: Bullet
    }
    deriving (Show, Eq)

data Bullet = Bullet
    { damage         :: Int
    , speed          :: Tuple
    , bulletLocation :: Tuple
    }
    deriving (Show, Eq)
