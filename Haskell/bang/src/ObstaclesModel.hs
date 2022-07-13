module ObstaclesModel where

import           PokemonModel

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

data VilePlum = VilePlum
    { vilePlumName     :: String
    , vilePlumLife     :: Integer
    , vilePlumShootLeft    :: Pokeball
    , vilePlumShootRight    :: Pokeball
    , vilePlumLocation :: Tuple
    }
    deriving (Show, Eq)

data Collision = Collision
    { obstacleType      :: String
    , collisionLocation :: Tuple
    , pokemonCollided   :: Pokemon
    }
    deriving (Show, Eq)
