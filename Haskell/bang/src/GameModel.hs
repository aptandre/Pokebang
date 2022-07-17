-- módulo responsável por definir o objeto Game
-- o jogo possui um estado, dois players distintos, um ganhador e o tempo de jogo
module GameModel where

import           GameState
import           Graphics.Gloss
import           PokemonModel

-- objeto GAME
data BANG = Game
    { gameState  :: GameState
    , bulbasaur  :: Pokemon
    , charmander :: Pokemon
    , winner     :: String
    , time       :: Float
    , stones     :: [Stone]
    , slowpokes  :: [SlowPoke]
    , vileplume  :: VilePlum
    }

-- objetos IMAGES, serve como uma abstração para implementar as imagens
-- junto com o Gloss, já que este package utiliza objetos Picture
data IMAGES = Images
    { foreground_menu              :: Picture
    , foreground_playing           :: Picture
    , foreground_winner_bulbasaur  :: Picture
    , foreground_winner_charmander :: Picture
    , image_bulbasaur              :: Picture
    , image_charmander             :: Picture
    , image_pokeball               :: Picture
    , image_vileplum               :: Picture
    , image_slowpoke               :: Picture
    , image_stone                  :: Picture
    }

