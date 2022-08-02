:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

eventHandler(menu, NewGameState, _, _, _) :-
    get_single_char(Key),

    (
        startKey(Key) -> NewGameState = game;
        NewGameState = menu
    ).

eventHandler(game, _, NewBulbasaur, NewCharmander, NewObstacles) :-
    get_single_char(Key).


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