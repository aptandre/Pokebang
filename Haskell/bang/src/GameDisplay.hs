module GameDisplay where

import           GameState
import           Graphics.Gloss

import           GameModel
import           Initial
import           PlayerModel

background :: Color
background = makeColorI 218 240 247 0x8C

width, height, xOffset, yOffset :: Int
width = 1100
height = 700
xOffset = 10
yOffset = 10

fps :: Int
fps = 100

