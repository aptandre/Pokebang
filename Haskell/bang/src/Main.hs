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
    image_bulbasaur             <- loadBMP "images/bulba.bmp"
    image_charmander            <- loadBMP "images/charm.bmp"
    image_pokeball              <- loadBMP "images/pokeball.bmp"
    foreground_menu             <- loadBMP "images/foreground_menu.bmp"
    foreground_playing          <- loadBMP "images/foreground_playing.bmp"
    foreground_winner_bulbasaur <- loadBMP
        "images/foreground_winner_bulbasaur.bmp"
    foreground_winner_charmander <- loadBMP
        "images/foreground_winner_charmander.bmp"
    image_slowpoke <- loadBMP "images/slowpoke.bmp"
    image_belossom <- loadBMP "images/vileplum.bmp"
    image_stone    <- loadBMP "images/stone.bmp"
    play
        window
        background
        fps
        initialState
        (render
            (makeImagesHolder foreground_menu
                              foreground_playing
                              foreground_winner_bulbasaur
                              foreground_winner_charmander
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
