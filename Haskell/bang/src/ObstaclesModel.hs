module ObstaclesModel where

type Tuple = (Float, Float)

data Wheat = Wheat
    { wheatName :: String
    , wheatLife :: Integer
    }
    deriving (Show, Eq)

data Stone = Stone
    { stoneName :: String
    , stoneLife :: Integer
    }
    deriving (Show, Eq)

data Cactus = Cactus
    { cactusName  :: String
    , cactusLife  :: Integer
    , cactusShoot :: Spike
    }
    deriving (Show, Eq)

data Spike = Spike
    { cactusSpeed    :: Tuple
    , cactusDamage   :: Int
    , cactusLocation :: Tuple
    }
    deriving (Show, Eq)
