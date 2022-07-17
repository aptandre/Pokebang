-- módulo responsável por definir o objeto Player
-- cada Player possui armas, que guardam balas para atirar
module PokemonModel where

-- Tipo criado para podermos trabalhar com o ponto cartesiano
-- de forma mais dinâmica dentro do contexto do jogo
type Tuple = (Float, Float)

-- Objeto Pokemon, que é a entidade dos players
-- todo Pokémon possui uma life, localização, nome,
-- onShoot que é o tiro do Pokémon e hasFired que
-- indica se ele já atirou ou não
data Pokemon = Pokemon
    { life     :: Int
    , location :: Tuple
    , name     :: String
    , onShoot  :: Pokeball
    , hasFired :: Bool
    }
    deriving (Show, Eq)

-- Objeto Slowpoke, é um obstáculo e possui apenas um nome e uma localização
data SlowPoke = SlowPoke
    { slowPokeName     :: String
    , slowPokeLocation :: Tuple
    }
    deriving (Show, Eq)

-- Objeto Pedra, é um obstáculo e possui apenas um nome a uma localização
data Stone = Stone
    { stoneName     :: String
    , stoneLocation :: Tuple
    }
    deriving (Show, Eq)

-- Objeto Vileplum, é um obstáculo e possui nome, um hasPlums que indica
-- se ele poderá ou não atirar, shootLeft e shootRight que são os seus
-- objetos de tiro e, por fim, a sua localização
data VilePlum = VilePlum
    { vilePlumName       :: String
    , hasPlums           :: Bool
    , vilePlumShootLeft  :: Pokeball
    , vilePlumShootRight :: Pokeball
    , vilePlumLocation   :: Tuple
    }
    deriving (Show, Eq)

-- Objeto Pokeball, trata-se de das "balas" que temos
-- dentro do jogo, toda Pokeball vai possuir uma velocidade,
-- dano e localização a ela associados
data Pokeball = Pokeball
    { speed            :: Tuple
    , damage           :: Int
    , locationPokeball :: Tuple
    }
    deriving (Show, Eq)

-- Objeto Collision, este objeto é utilizado para imple-
-- mentarmos a colisão com os obstáculos dentro do jogo
data Collision = Collision
    { obstacleType      :: String
    , collisionLocation :: Tuple
    , pokemonCollided   :: Pokemon
    }
    deriving (Show, Eq)
