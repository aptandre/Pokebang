:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

eventHandler(menu, NewGameState, _, _, _, _, _) :-
    get_single_char(Key),

    (
        startKey(Key) -> NewGameState = game;
        NewGameState = menu
    ).

eventHandler(game, _, Bulbasaur, Charmander, Obstacles, NewBulbasaur, NewCharmander) :-
    
    get_single_char(Key),
    
    (
        bulbasaurUp(Key) -> moveUp(Bulbasaur, NewBulbasaur), NewCharmander = Charmander;
        bulbasaurDown(Key) -> moveDown(Bulbasaur, NewBulbasaur), NewCharmander = Charmander;
        charmanderUp(Key) -> moveUp(Charmander, NewCharmander), NewBulbasaur = Bulbasaur;
        charmanderDown(Key) -> moveDown(Charmander, NewCharmander), NewBulbasaur = Bulbasaur
    ).

moveUp([Name|Tail], [Name, (NewX, Y)]) :- 
    [(X, Y)] = Tail,
    (
        constraintsUp(X) -> NewX is X;
        NewX is X - 3
    ).

moveDown([Name|Tail], [Name, (NewX, Y)]) :- 
    [(X, Y)] = Tail,
    (
        constraintsDown(X) -> NewX is X;
        NewX is X + 3
    ).

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

constraintsUp(0).
constraintsDown(12).