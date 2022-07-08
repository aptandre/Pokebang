module ObstaclesModel where

type Tuple = (Float, Float)

data SlowPoke = SlowPoke
    { slowPokeName     :: String
    , slowPokeLife     :: Integer
    , slowPokeLocation :: Tuple
    }
    deriving (Show, Eq)

data Stone = Stone
    { stoneName     :: String
    , stoneLife     :: Integer
    , stoneLocation :: Tuple
    }
    deriving (Show, Eq)

data Belossom = Belossom
    { belossomName     :: String
    , belossomLife     :: Integer
    , belossomShoot    :: Spike
    , belossomLocation :: Tuple
    }
    deriving (Show, Eq)

data Spike = Spike
    { spikeSpeed    :: Tuple
    , spikeDamage   :: Int
    , spikeLocation :: Tuple
    }
    deriving (Show, Eq)
