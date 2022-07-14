-- módulo responsável por definir a tela de fundo da interface gráfica
-- cria as características necessárias para definir a tela
module GameDisplay where

import           GameState
import           Graphics.Gloss

import           GameModel
import           Initial
import           PokemonModel

-- define a cor de fundo da tela
background :: Color
background = makeColorI 245 228 185 0x8C

-- define as dimensões da tela
width, height, xOffset, yOffset :: Int
width = 1200
height = 800
xOffset = 0
yOffset = 0

-- define a taxa de atualização da tela
fps :: Int
fps = 100
