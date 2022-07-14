module Main where

import           EventHandler
import           GameDisplay
import           GameModel
import           GameState
import           Graphics.Gloss
import           Initial
import           PokemonModel
import           Render
import           UpdateController
import           Util                           ( makeImagesHolder )

-- Interface grafica
window :: Display
window = InWindow "BANG!" (width, height) (xOffset, yOffset)

main = do
    image_bulbasaur  <- loadBMP "images/bulba.bmp"
    image_charmander <- loadBMP "images/charm.bmp"
    image_pokeball   <- loadBMP "images/pokebola.bmp"
    foreground       <- loadBMP "images/background.bmp"
    image_slowpoke   <- loadBMP "images/slowpoke.bmp"
    image_belossom   <- loadBMP "images/vileplum.bmp"
    image_stone      <- loadBMP "images/stone.bmp"
    play
        window
        background
        fps
        initialState
        (render
            (makeImagesHolder foreground
                              foreground
                              foreground
                              foreground
                              image_bulbasaur
                              image_charmander
                              image_pokeball
                              image_belossom
                              image_slowpoke
                              image_stone
            )
        )
        eventHandler
        updateController
