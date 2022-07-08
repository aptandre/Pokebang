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

data Pokeball = Pokeball
    { speed            :: Tuple
    , damage           :: Int
    , locationPokeball :: Tuple
    }
    deriving (Show, Eq)
