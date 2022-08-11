:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

updateCollisions(PokeballBulbasaur, PokeballCharmander, Obstacles, FinalPokeballBulbasaur, FinalPokeballCharmander, NewObstacles) :-
    (
        iterateCollisions(PokeballBulbasaur, Obstacles, FinalPokeballBulbasaur, NewObstacles),
        iterateCollisions()
    ). 

iterateCollisions(Pokeball, [], ObstaclesList, NewPokeball, NewObstacles):- 
    write("cu"), 
    write(NewPokeball), nl, write("bct"), nl,
    write(NewObstacles), NewPokeball = Pokeball, NewObstacles = ObstaclesList, !.
iterateCollisions(Pokeball, [Head|Tail], ObstaclesList, _, _) :- 
    checkCollision(Pokeball, ObstaclesList, Head, NewPokeball, NewObstacles),
    iterateCollisions(NewPokeball, Tail, NewObstacles, _, _).
    
checkCollision(Pokeball, ObstaclesList, Obstacle, NewPokeball, NewObstacles) :-
    [(OnShoot, _, _)|[PokeballPosition]] = Pokeball,
    [Type, ObstaclePosition] = Obstacle,
    (
        ObstaclePosition = PokeballPosition, OnShoot -> 
        resolveCollision(Type, Pokeball, NewPokeball), 
        removeObstacle(Type, Obstacle, ObstaclesList, NewObstacles) ;
        NewPokeball = Pokeball,
        NewObstacles = ObstaclesList
    ).
    
removeObstacle("O", _, ObstaclesList, ObstaclesList) :- !.
removeObstacle(_,  Obstacle, [Obstacle|Tail], Tail) :- !.
removeObstacle(Type,  Obstacle, [Head|Tail], [Head|Other]) :- 
    removeObstacle(Type,  Obstacle, Tail, Other).

resolveCollision("#",  [Shoot|PokeballPosition], NewPokeball):-
    (OnShoot, Direction, _) = Shoot, 
    NewSpeed is 2,
    NewPokeball = [(OnShoot, Direction, NewSpeed), PokeballPosition].
resolveCollision("@", [Shoot|PokeballPosition], NewPokeball):- 
    (_, Direction, Speed) = Shoot, 
    NewOnShoot = false,  
    NewPokeball = [(NewOnShoot, Direction, Speed), PokeballPosition].
resolveCollision("O", [Shoot|PokeballPosition], NewPokeball) :-
    (_, Direction, Speed) = Shoot, 
    NewOnShoot = false,  
    NewPokeball = [(NewOnShoot, Direction, Speed), PokeballPosition].

% updatePlayers(Bulbasaur, Charmander, FinalBulbasaur, FinalCharmander) :-
