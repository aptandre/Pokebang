-- módulo responsável por definir o objeto Player
-- cada Player possui armas, que guardam balas para atirar
module PokemonModel where

type Tuple = (Float, Float)

data Pokemon = Pokemon
    { life     :: Int
    , location :: Tuple
    , name     :: String
    , onShoot  :: Pokeball
    , hasFired :: Bool
    }
    deriving (Show, Eq)

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
    { vilePlumName       :: String
    , vilePlumLife       :: Integer
    , vilePlumShootLeft  :: Pokeball
    , vilePlumShootRight :: Pokeball
    , vilePlumLocation   :: Tuple
    }
    deriving (Show, Eq)

data Pokeball = Pokeball
    { speed            :: Tuple
    , damage           :: Int
    , locationPokeball :: Tuple
    }
    deriving (Show, Eq)

data Collision = Collision
    { obstacleType      :: String
    , collisionLocation :: Tuple
    , pokemonCollided   :: Pokemon
    }
    deriving (Show, Eq)
