initialBulbasaur(["B", (0, 6)]).
initialCharmander(["C", (25, 6)]).
initialObstacles(["S", (20, 6)]).

initialShoot([Head|Tail], Pokeball) :- 
    [(X, Y)] = Tail,
    InitialX is X + 2,
    (X =:= 0-> Direction is 1 ; Direction is -1),
    Pokeball = [(false, Direction), (InitialX, Y)].