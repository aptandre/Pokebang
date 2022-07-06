module GameDisplay where

import           GameState
import           Graphics.Gloss

import           GameModel
import           Initial
import           PlayerModel

background :: Color
background = makeColorI 245 228 185 0x8C

width, height, xOffset, yOffset :: Int
width = 1200
height = 800
xOffset = 10
yOffset = 10

fps :: Int
fps = 100

