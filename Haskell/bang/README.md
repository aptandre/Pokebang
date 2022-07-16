# 🎮 _BANG!_ EM [HASKELL](https://github.com/aptandre/BANG/tree/main/Haskell/bang)

&nbsp; _**“POKEBANG!”**_ é um jogo inspirado nos antigos jogos shooter 2D com o visual da famosa franquia Pokémon. É essencialmente um jogo baseado em uma disputa de Pokémons, em que dois jogadores entram em uma batalha de disparos, o primeiro a acertar o adversário detêm a vitória.

## 🖥️ INSTALAÇÃO

⚠️ É NECESSÁRIO TER EM SUA MÁQUINA [HASKELL, CABAL E GHC](https://www.haskell.org/downloads/)

### 1. CLONE O REPOSITÓRIO 
```
  $ git clone https://github.com/aptandre/BANG.git
```

### 2. ENTRE DENTRO DO REPOSITÓRIO
```
  $ cd Haskell/bang
```

### 3. INSTALE O CABAL, GHCUP e GLOSS
As instalações abaixo podem durar alguns minutos.
```
  $ cabal install Cabal cabal-install
  $ ghcup install 8.6.5
  $ cabal install --lib gloss
```

### 4. EXECUTE COM O COMANDO ABAIXO
```
  $ cabal run
```

## ❔ COMO JOGAR?

&nbsp; É preciso de dois jogadores para poder jogar, o objetivo é acertar o outro ao mesmo tempo que desvia tomando cuidado com os **obstáculos** que surgirão na sua frente.

## 🕹️ COMANDOS

### JOGADOR 1 ( BULBASAUR )

&nbsp;&nbsp;**W -** MOVIMENTA PARA CIMA

&nbsp;&nbsp;&nbsp;**S -** MOVIMENTA PARA BAIXO

&nbsp;&nbsp;&nbsp;**D -** ATIRA

### JOGADOR 2 ( CHARMANDER )

&nbsp;&nbsp;&nbsp;**↑ -** MOVIMENTA PARA CIMA

&nbsp;&nbsp;&nbsp;**↓ -** MOVIMENTA PARA BAIXO

&nbsp;&nbsp;**← -** ATIRA

## <img src="https://cdn-icons-png.flaticon.com/512/188/188918.png?w=826&t=st=1657547419~exp=1657548019~hmac=fb3e922e92807a21bb9cf2c1a3a453e3b7d45432045977b093ac344f4a23b03f" width=30px>  OBSTÁCULOS

<p>&nbsp; Existem certos <strong>"obstáculos"</strong>, que consistem em outros pokémons que aparecem aleatoriamente para impedir o êxito dos jogadores. Cada um desses têm diferentes características que os tornam adversidades diferentes. Por enquanto, nesse momento, temos três principais: </p>

| Nome  |  Pokémon  | Efeito |
| --------- | -------- | --------- |
| **Slowpoke** |<img src="https://img.pokemondb.net/sprites/sword-shield/normal/slowpoke.png"> | Ao ser atingido deixa os projéteis mais lentos. |
| **Rhydon** | <img src="https://pixelartmaker-data-78746291193.nyc3.digitaloceanspaces.com/image/1234ba855fd443b.png"> | Ao ser atingido, bloqueia o projétil, cancelado-o. |
| **Vileplume** | <img src="https://img.pokemondb.net/sprites/sword-shield/normal/vileplume.png"> | Solta espinhos na direção dos jogadores, os quais são igualmente fatais a um tiro. Assim os jogadores são obrigados a desviar dos tiros de Vileplume e dos tiros do adversário simultaneamente.

## 👾 DEMONSTRAÇÃO

<!-- LINK DO YOUTUBE -->

## 👨‍💻 AUTORES


### [@aptandre](https://github.com/aptandre) [@leinharr]() [@gabrielvsc](https://www.github.com/gabrielvsc) [@jonngab](https://github.com/jonngab) [@laysa]()
