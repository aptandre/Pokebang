-- módulo responsável por iniciar certos objetos
-- cria objetos como base para iniciar a aplicação 
module Initial where

import           GameModel
import           GameState
import           PokemonModel

-- cria o jogo base para ínicio da aplicação
initialState :: BANG
initialState = Game { gameState  = Menu
                    , bulbasaur  = initializeBulbasur
                    , charmander = initializeCharmander
                    , winner     = ""
                    , time       = 0.0
                    , vileplume  = generateVileplume
                    , slowpokes  = getSlowpokes
                    , stones     = getStones
                    }

-- cria o Player 1 base para ínicio da aplicação
initializeBulbasur :: Pokemon
initializeBulbasur = Pokemon { life     = 100
                             , name     = "Bulbasaur"
                             , location = (-525, 0)
                             , onShoot  = initializePokeball
                             , hasFired = False
                             }

-- cria o Player 2 base para ínicio da aplicação
initializeCharmander :: Pokemon
initializeCharmander = Pokemon { life     = 100
                               , name     = "Charmander"
                               , location = (525, 0)
                               , onShoot  = initializePokeball
                               , hasFired = False
                               }

-- Inicializa uma Pokeball com uma velocidade pré-definida e uma localização fora do mapa
initializePokeball :: Pokeball
initializePokeball =
    Pokeball { damage = 100, speed = (4, 0), locationPokeball = (-10000, 0) }

-- Gera o Vileplume inicia, com as coordenadas de posicionamento do objeto e dos seus tiros
generateVileplume :: VilePlum
generateVileplume = VilePlum { vilePlumName       = "vileplume"
                             , hasPlums           = True
                             , vilePlumShootLeft  = initializeVileplumBall
                             , vilePlumShootRight = initializeVileplumBall
                             , vilePlumLocation   = (0, -50)
                             }

-- Gera uma lista de Slowpokes em suas respectivas localizações
getSlowpokes :: [SlowPoke]
getSlowpokes =
    [ SlowPoke { slowPokeName = "slowpoke", slowPokeLocation = (250, 250) }
    , SlowPoke { slowPokeName = "slowpoke", slowPokeLocation = (150, 50) }
    , SlowPoke { slowPokeName = "slowpoke", slowPokeLocation = (-300, -150) }
    ]

-- Gera uma lista de obstáculos do tipo Pedra em suas respectivas localizações
getStones :: [Stone]
getStones =
    [ Stone { stoneName = "stone", stoneLocation = (250, -250) }
    , Stone { stoneName = "stone", stoneLocation = (-100, 150) }
    ]

-- Inicializa o objeto de colisões com uma localização inicial
-- e um charmander inicial a ele atribuído
initializeCollision :: Collision
initializeCollision = Collision { obstacleType      = ""
                                , collisionLocation = (0, 0)
                                , pokemonCollided   = initializeCharmander
                                }

-- Inicializa a Pokeball do Vileplum, que possui uma
-- localização diferente da pokeball dos players
initializeVileplumBall :: Pokeball
initializeVileplumBall =
    Pokeball { damage = 100, speed = (4, 0), locationPokeball = (0, -50) }
