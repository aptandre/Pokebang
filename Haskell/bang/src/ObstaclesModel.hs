module ObstaclesModel where

import PlayerModel

data Wheat = Wheat
    { wheatName     :: String
    , wheatLife     :: Integer
    , wheatLocation :: Tuple
    }
    deriving (Show, Eq)

data Stone = Stone
    { stoneName     :: String
    , stoneLife     :: Integer
    , stoneLocation :: Tuple
    }
    deriving (Show, Eq)

data Cactus = Cactus
    { cactusName     :: String
    , cactusLife     :: Integer
    , cactusShoot    :: Spike
    , cactusLocation :: Tuple
    }
    deriving (Show, Eq)

data Spike = Spike
    { cactusSpeed   :: Tuple
    , cactusDamage  :: Int
    , spikeLocation :: Tuple
    }
    deriving (Show, Eq)
