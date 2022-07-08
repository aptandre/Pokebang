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
updateGame seconds game = updateShots $ updateState seconds game

-- atualiza o estado do jogo
-- verifica se algum dos pokemons foi atingido para definir um vencedor
updateState :: Float -> BANG -> BANG
updateState seconds game
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

-- atualiza os tiros do pokemon 1 movimentando esses
firePokeballBulbasaur :: BANG -> BANG
firePokeballBulbasaur game
  | not firePokeball = game
  | offMap pokeball = game
    { bulbasaur = (bulbasaur game) { hasFired = False
                                   , onShoot  = initializePokeball
                                   }
    }
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
  | offMap pokeball = game
    { charmander = (charmander game) { hasFired = False
                                     , onShoot  = initializePokeball
                                     }
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
  | hasCollidedpokemon1 (onShoot (charmander game)) (bulbasaur game) = game
    { bulbasaur = (bulbasaur game) { life = 0 }
    }
  | hasCollidedpokemon2 (onShoot (bulbasaur game)) (charmander game) = game
    { charmander = (charmander game) { life = 0 }
    }
  | otherwise = game

-- verifica se houve collisão do pokemon 1 com algum tiro do pokemon 2
hasCollidedpokemon1 :: Pokeball -> Pokemon -> Bool
hasCollidedpokemon1 pokeball pokemon
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
hasCollidedpokemon2 :: Pokeball -> Pokemon -> Bool
hasCollidedpokemon2 pokeball pokemon
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
