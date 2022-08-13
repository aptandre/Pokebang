initialBulbasaur(["B", (0, 6)]).
initialCharmander(["C", (24, 6)]).
initialObstacles([["#", (8, 9)], ["#", (8, 0)], ["@", (12, 6)], ["O", (16, 12)], ["O", (16, 3)]]).

initialShoot([Head|Tail], Pokeball) :- 
    [(X, Y)] = Tail,
    (X =:= 0-> Direction is 1 ; Direction is -1),
    Pokeball = [(false, Direction, 4), (X, Y)].

initialProjectiles([[(true, 1, 4), (12, 6)], [(true, -1, 4), (12, 6)]]).