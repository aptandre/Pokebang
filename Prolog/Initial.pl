initialBulbasaur(["B", (0, 6)]).
initialCharmander(["C", (24, 6)]).
initialObstacles(["S", (20, 6)]).
% initialObstacles([["S", (28, 6)], ["V", (28, 6)], ["R", (28, 6)]]).

initialShoot([Head|Tail], Pokeball) :- 
    [(X, Y)] = Tail,
    (X =:= 0->  InitialX is X + 2 ; InitialX is X - 2),
    (X =:= 0-> Direction is 1 ; Direction is -1),
    Pokeball = [(false, Direction, 4), (InitialX, Y)].