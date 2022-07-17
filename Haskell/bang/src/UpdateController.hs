-- módulo responsável por atualizar a parte gráfica
-- opera funções periodicamente após um certo tempo
module UpdateController where

import           GameModel
import           GameState
import           Initial
import           PokemonModel
import           Util

-- controla as atualizações do jogo
updateController :: Float -> BANG -> BANG
updateController seconds game = case gameState game of
  Menu    -> game
  Playing -> updateGame seconds game
  End     -> game

-- atualiza o jogo em estado de Playing
updateGame :: Float -> BANG -> BANG
updateGame seconds game =
  vilePlumeShoot $ updateObstacles $ updateShots $ updateState seconds game


-- atualiza o estado do jogo
-- verifica se algum dos pokemons foi atingido para definir um vencedor
updateState :: Float -> BANG -> BANG
updateState seconds game
  | life (bulbasaur game) == 0 && life (charmander game) == 0 = game
    { gameState = End
    , winner    = "Vileplume"
    }
  | life (bulbasaur game) == 0 = game { gameState = End, winner = "Charmander" }
  | life (charmander game) == 0 = game { gameState = End, winner = "Bulbasaur" }
  | otherwise = game { time = oldTime + 1 }
  where oldTime = time game

-- atualiza os tiros dos jogadores
-- os tiros só podem ser disparados após outros tiros saírem da tela
updateShots :: BANG -> BANG
updateShots game =
  checkCollision
    $ firePokeballCharmander
    $ checkCollision
    $ firePokeballBulbasaur game

-- firePokeball :: Tuple -> Pokemon -> BANG -> BANG
-- firePokeball speed pokemon game
--   | (name $ pokemon) == "Bulbasaur" = 
--   | (name $ pokemon) == "Charmander" =
--   | otherwise = 

-- atualiza os tiros do pokemon 1 movimentando esses
firePokeballBulbasaur :: BANG -> BANG
firePokeballBulbasaur game
  | not firePokeball = game
  | offMap pokeball = game { bulbasaur = (bulbasaur game) { hasFired = False } }
  | otherwise = game
    { bulbasaur = (bulbasaur game) { onShoot = _movingPokeballBulbasaur }
    }
 where
  pokeball                 = onShoot (bulbasaur game)
  firePokeball             = hasFired (bulbasaur game)
  (velx, vely)             = speed pokeball
  (x   , y   )             = locationPokeball pokeball
  x'                       = x + (velx * generateMultiplier)
  y'                       = y + (vely * generateMultiplier)

  _movingPokeballBulbasaur = pokeball { locationPokeball = (x', y') }

-- atualiza os tiros do pokemon 2 movimentando esses
firePokeballCharmander :: BANG -> BANG
firePokeballCharmander game
  | not firePokeball = game
  | offMap pokeball = game { charmander = (charmander game) { hasFired = False }
                           }
  | otherwise = game
    { charmander = (charmander game) { onShoot = _movingPokeballCharmander }
    }
 where
  pokeball                  = onShoot (charmander game)
  firePokeball              = hasFired (charmander game)
  (velx, vely)              = speed pokeball
  (x   , y   )              = locationPokeball pokeball
  x'                        = x + (velx * generateMultiplier)
  y'                        = y + (vely * generateMultiplier)

  _movingPokeballCharmander = pokeball { locationPokeball = (x', y') }

--  ============== COLISÕES ============== --

-- verirfica se o tiro está fora do mapa
offMap :: Pokeball -> Bool
offMap pokeball =
  fst (locationPokeball pokeball)
    >  750
    || fst (locationPokeball pokeball)
    <  -750

-- verifica se ocorreu colisão entre os tiros e os pokemons
checkCollision :: BANG -> BANG
checkCollision game
  | hasCollidedPokemonBulbasaur (onShoot (charmander game)) (bulbasaur game)
  = game { bulbasaur = (bulbasaur game) { life = 0 } }
  | hasCollidedPokemonCharmander (onShoot (bulbasaur game)) (charmander game)
  = game { charmander = (charmander game) { life = 0 } }
  | hasCollidedPokemonBulbasaur (vilePlumShootLeft $ vileplume game)
                                (bulbasaur game)
  = game { bulbasaur = (bulbasaur game) { life = 0 } }
  | hasCollidedPokemonCharmander (vilePlumShootRight $ vileplume game)
                                 (charmander game)
  = game { charmander = (charmander game) { life = 0 } }
  | otherwise
  = game

-- verifica se houve collisão do pokemon 1 com algum tiro do pokemon 2
hasCollidedPokemonBulbasaur :: Pokeball -> Pokemon -> Bool
hasCollidedPokemonBulbasaur pokeball pokemon
  | ((xpokeball - 5 >= xpokemon - 22.5) && (xpokeball - 5 <= xpokemon + 22.5))
    && ((ypokeball - 5 >= ypokemon - 45) && (ypokeball + 5 <= ypokemon + 45))
  = True
  | otherwise
  = False
 where
  xpokeball = fst (locationPokeball pokeball)
  ypokeball = snd (locationPokeball pokeball)
  xpokemon  = fst (location pokemon)
  ypokemon  = snd (location pokemon)

-- verifica se houve collisão do pokemon 2 com algum tiro do pokemon 1
hasCollidedPokemonCharmander :: Pokeball -> Pokemon -> Bool
hasCollidedPokemonCharmander pokeball pokemon
  | ((xpokeball + 5 >= xpokemon - 22.5) && (xpokeball + 5 <= xpokemon + 22.5))
    && ((ypokeball - 5 >= ypokemon - 45) && (ypokeball + 5 <= ypokemon + 45))
  = True
  | otherwise
  = False
 where
  xpokeball = fst (locationPokeball pokeball)
  ypokeball = snd (locationPokeball pokeball)
  xpokemon  = fst (location pokemon)
  ypokemon  = snd (location pokemon)


--  ============== OBSTÁCULOS ============== --

-- Atualiza os obstáculos a partir da verificação da colisão com
-- ambos os pokemons Bulbasaur e Charmander
updateObstacles :: BANG -> BANG
updateObstacles game = checkObstaclesCharmander $ checkObstaclesBulbasaur game

-- Checa a colisão dos obstáculos com o Bulbasaur
checkObstaclesBulbasaur :: BANG -> BANG
checkObstaclesBulbasaur game
  | not (hasFired (bulbasaur game)) = game
  | null bulbasaurCollisions = game
  | otherwise = collisionResolver "Bulbasaur" bulbasaurCollisions game
  where bulbasaurCollisions = mapCollision (bulbasaur game) game

-- Checa a colisão dos obstáculos com o Charmander
checkObstaclesCharmander :: BANG -> BANG
checkObstaclesCharmander game
  | not (hasFired (charmander game)) = game
  | null charmanderCollisions = game
  | otherwise = collisionResolver "Charmander" charmanderCollisions game
  where charmanderCollisions = mapCollision (charmander game) game

-- Verifica as colisões a partir de um array de colisões passado,
-- além disso, esta função também é responsável por fazer os obstáculos
-- interativos, provendo-os com as suas mecâncias de jogo: intercepção
-- de projéteis ou decremento de velocidade de projétil (pokeball).
collisionResolver :: String -> [Collision] -> BANG -> BANG
collisionResolver name collisions game
  | null collisions        = game
  | obstacle == "Stone"    = interceptPokeball collision game
  | obstacle == "SlowPoke" = slowDownPokeball collision game
  | obstacle == "VilePlum" = interceptPokeball collision game
  | otherwise              = game
 where
  obstacle  = obstacleType (head collisions)
  collision = head collisions

-- Mapeia todas as colisões do jogo para fazer uma lista de colisões
-- ele compara as posições com a lista de obstáculos necessária
mapCollision :: Pokemon -> BANG -> [Collision]
mapCollision pokemon game =
  [ x
    | x <- map (hasCollidedStone pokemon) (stones game)
    , x /= initializeCollision
    ]
    ++ [ x
       | x <- map (hasCollidedSlowPoke pokemon) (slowpokes game)
       , x /= initializeCollision
       ]
    ++ [hasCollidedVilePlum pokemon $ vileplume game]

-- Verifica se um determinado Pokémon colidiu com uma Stone
-- passada e retorna um objeto de Colisão correspondente
hasCollidedStone :: Pokemon -> Stone -> Collision
hasCollidedStone pokemon stone
  | (xpokeball + 5 >= xstone - 20 && xpokeball - 5 <= xstone + 20)
    && (ypokeball + 5 <= ystone + 20 && ypokeball - 5 >= ystone - 20)
  = Collision "Stone" (stoneLocation stone) pokemon
  | otherwise
  = initializeCollision
 where
  pokeball  = onShoot pokemon
  xpokeball = fst (locationPokeball pokeball)
  ypokeball = snd (locationPokeball pokeball)
  xstone    = fst (stoneLocation stone)
  ystone    = snd (stoneLocation stone)

-- Verifica se um determinado Pokémon colidiu com um Slowpoke
-- passado e retorna um objeto de Colisão correspondente
hasCollidedSlowPoke :: Pokemon -> SlowPoke -> Collision
hasCollidedSlowPoke pokemon slowpoke
  | (xpokeball + 5 >= xslowpoke - 20 && xpokeball - 5 <= xslowpoke + 20)
    && (ypokeball + 5 <= yslowpoke + 20 && ypokeball - 5 >= yslowpoke - 20)
  = Collision "SlowPoke" (slowPokeLocation slowpoke) pokemon
  | otherwise
  = initializeCollision
 where
  pokeball  = onShoot pokemon
  xpokeball = fst (locationPokeball pokeball)
  ypokeball = snd (locationPokeball pokeball)
  xslowpoke = fst (slowPokeLocation slowpoke)
  yslowpoke = snd (slowPokeLocation slowpoke)

-- Verifica se um determinado Pokémon colidiu com um Vileplume
-- passado e retorna um objeto de Colisão correspondente
hasCollidedVilePlum :: Pokemon -> VilePlum -> Collision
hasCollidedVilePlum pokemon vileplum
  | (xpokeball + 5 >= xvileplum - 20 && xpokeball - 5 <= xvileplum + 20)
    && (ypokeball + 5 <= yvileplum + 20 && ypokeball - 5 >= yvileplum - 20)
  = Collision "Stone" (vilePlumLocation vileplum) pokemon
  | otherwise
  = initializeCollision
 where
  pokeball  = onShoot pokemon
  xpokeball = fst (locationPokeball pokeball)
  ypokeball = snd (locationPokeball pokeball)
  xvileplum = fst (vilePlumLocation vileplum)
  yvileplum = snd (vilePlumLocation vileplum)

-- Faz o Vileplume a partir da atualização das balas do objeto vileplume dentro do objeto game
vilePlumeShoot :: BANG -> BANG
vilePlumeShoot game
  | offMap (vilePlumShootLeft $ vileplume game) = game
    { vileplume = (vileplume game) { vilePlumShootLeft  = initializeVileplumBall
                                   , vilePlumShootRight = initializeVileplumBall
                                   }
    }
  | otherwise = game
    { vileplume = (vileplume game)
                    { vilePlumShootLeft  = (vilePlumShootLeft (vileplume game))
                                             { locationPokeball =
                                               locationPokeballLeft
                                             }
                    , vilePlumShootRight = (vilePlumShootRight $ vileplume game)
                                             { locationPokeball =
                                               locationPokeballRight
                                             }
                    }
    }
 where
  (x, y)                = locationPokeball $ vilePlumShootLeft $ vileplume game
  x'                    = x - 4
  locationPokeballLeft  = (x', y)
  locationPokeballRight = (-x', y)
