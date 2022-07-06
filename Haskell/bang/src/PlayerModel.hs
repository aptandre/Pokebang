module PlayerModel where

type Tuple = (Float, Float)

data Player = Player
    { life     :: Int
    , gun      :: Gun
    , name     :: String
    , position :: Float
    }
    deriving (Show, Eq)

data Gun = Gun
    { shotsCount :: Int
    , bullets    :: [Bullet]
    }
    deriving (Show, Eq)

data Bullet = Bullet
    { damage :: Int
    , speed  :: Tuple
    }
    deriving (Show, Eq)
