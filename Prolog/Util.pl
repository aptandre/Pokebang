:-style_check(-discontiguous).
:-style_check(-singleton).

%      W     S    D   J    K     I
% X = [119, 115, 100, 106, 107, 105].
% teclas apertadas para começar a rodar a aplicação
startKey(13).
startKey(10).

% tecla apertada para mover o bulbasaur para cima
bulbasaurUp(119).
% tecla apertada para mover o bulbasaur para baixo
bulbasaurDown(115).

% tecla apertada para mover o charmannder para cima
charmanderUp(105).
% tecla apertada para mover o charmannder para baixo
charmanderDown(107).

%tecla apertada para atirar a pokeball do bulbasaur
bulbasaurShoot(100).
%tecla apertada para atirar a pokeball do charmander
charmanderShoot(106).

%tecla para sair do jogo incondicionalmente
stopGame(109).

constraintsUp(0).
constraintsDown(12).
constraintsRight(24).
constraintsLeft(0).

winner(["B"|_]).
winner(["C"|_]).
loser(["X"|_]).

checkGameOver([Bulbasaur|_], [Charmander|_], NewGameState):- 
    (   
        Bulbasaur =:= "X"; Charmander  =:= "X" -> NewGameState = over;
        NewGameState = game
    ).