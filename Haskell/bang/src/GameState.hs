-- módulo responsável por definir estado para uso no objeto Game
-- o jogo possui três estados: Menu, Playing, End
module GameState where

import           Graphics.Gloss

data GameState =
    Menu | Playing | End
    deriving Show
