:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

updateCollisions(PokeballBulbasaur, PokeballCharmander, ObstaclesList, FinalPokeballBulbasaur, FinalPokeballCharmander, NewObstacles) :-
    (
        iterateCollisions(PokeballBulbasaur, ObstaclesList, ObstaclesList, FinalPokeballBulbasaur, IntermidiateObstacles),
        iterateCollisions(PokeballCharmander, IntermidiateObstacles, IntermidiateObstacles, FinalPokeballCharmander, NewObstacles)
    ). 

iterateCollisions(Pokeball, [], ObstaclesList, NewPokeball, NewObstacles):- 
    NewPokeball = Pokeball, NewObstacles = ObstaclesList, !.
iterateCollisions(Pokeball, [Obstacle|Tail], ObstaclesList, NewPokeball, NewObstacles) :- 
    [(OnShoot, _, _)|[PokeballPosition]] = Pokeball,
    [Type, ObstaclePosition] = Obstacle,
    checkCollision(ObstaclePosition, PokeballPosition, OnShoot) -> 
    (
        resolveCollision(Type, Pokeball, OtherPokeball), 
        removeObstacle(Type, Obstacle, ObstaclesList, OtherObstacles), 
        iterateCollisions(OtherPokeball, Tail, OtherObstacles, NewPokeball, NewObstacles)
    );
    iterateCollisions(Pokeball, Tail, ObstaclesList, NewPokeball, NewObstacles).

checkCollision(ObstaclePosition, PokeballPosition, true) :-
    ObstaclePosition = PokeballPosition.

removeObstacle("O", _, ObstaclesList, ObstaclesList) :- !.
removeObstacle("@", _, ObstaclesList, ObstaclesList) :- !.
removeObstacle(_,  Obstacle, [Obstacle|Tail], Tail) :- !.
removeObstacle(Type,  Obstacle, [Head|Tail], [Head|Other]) :- 
    removeObstacle(Type,  Obstacle, Tail, Other).

resolveCollision("#",  [Shoot|PokeballPosition], NewPokeball):-
    (OnShoot, Direction, _) = Shoot, 
    NewSpeed is 2,
    NewPokeball = [(OnShoot, Direction, NewSpeed), PokeballPosition],!.
resolveCollision("@", [Shoot|PokeballPosition], NewPokeball):- 
    (_, Direction, Speed) = Shoot, 
    NewOnShoot = false,  
    NewPokeball = [(NewOnShoot, Direction, Speed), PokeballPosition], !.
resolveCollision("O", [Shoot|PokeballPosition], NewPokeball) :-
    (_, Direction, Speed) = Shoot, 
    NewOnShoot = false,  
    NewPokeball = [(NewOnShoot, Direction, Speed), PokeballPosition], !.

updatePlayers(Bulbasaur, Charmander, PokeballBulbasaur, PokeballCharmander, FinalBulbasaur, FinalCharmander) :-
    deathPokemon(Bulbasaur, PokeballCharmander, FinalBulbasaur), 
    deathPokemon(Charmander, PokeballBulbasaur, FinalCharmander).

deathPokemon([Name|Location], [Shoot|PokeballPosition], FinalPokemon) :-
    (
        Location = PokeballPosition -> FinalPokemon = ["X"|Location] ;
        FinalPokemon = [Name|Location]
    ).
