module PlayerModel where

type Tuple = (Int, Int)

data Player = Player
    { life :: Int
    , gun  :: Gun
    , name :: String
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
