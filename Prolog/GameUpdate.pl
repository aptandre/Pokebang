:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

updateCollisions(PokeballBulbasaur, PokeballCharmander, ObstaclesList, Projectiles, FinalPokeballBulbasaur, FinalPokeballCharmander, NewObstacles, NewProjectiles) :-
    (
        iterateCollisions(PokeballBulbasaur, ObstaclesList, ObstaclesList, FinalPokeballBulbasaur, IntermidiateObstacles),
        iterateCollisions(PokeballCharmander, IntermidiateObstacles, IntermidiateObstacles, FinalPokeballCharmander, NewObstacles)
        , updateProjectiles(Projectiles, NewProjectiles)
    ). 

iterateCollisions(Pokeball, [], ObstaclesList, NewPokeball, NewObstacles):- 
    NewPokeball = Pokeball, NewObstacles = ObstaclesList, !.
iterateCollisions(Pokeball, [Obstacle|Tail], ObstaclesList, NewPokeball, NewObstacles) :- 
    [(OnShoot, _, _)|[PokeballPosition]] = Pokeball,
    [Type, ObstaclePosition] = Obstacle,
    checkCollision(ObstaclePosition, PokeballPosition) -> 
    (
        resolveCollision(Type, Pokeball, OtherPokeball), 
        removeObstacle(Type, Obstacle, ObstaclesList, OtherObstacles), 
        iterateCollisions(OtherPokeball, Tail, OtherObstacles, NewPokeball, NewObstacles)
    );
    iterateCollisions(Pokeball, Tail, ObstaclesList, NewPokeball, NewObstacles).

checkCollision(ObstaclePosition, PokeballPosition) :-
    ObstaclePosition = PokeballPosition.

removeObstacle("O", _, ObstaclesList, ObstaclesList) :- !.
removeObstacle("@", _, ObstaclesList, ObstaclesList) :- !.
removeObstacle(_,  Obstacle, [Obstacle|Tail], Tail) :- !.
removeObstacle(Type,  Obstacle, [Head|Tail], [Head|Other]) :- 
    removeObstacle(Type,  Obstacle, Tail, Other).

resolveCollision("#",  [Shoot|[PokeballPosition]], NewPokeball):-
    (OnShoot, Direction, _) = Shoot, 
    NewSpeed is 2,
    NewPokeball = [(OnShoot, Direction, NewSpeed), PokeballPosition],!.
resolveCollision("@", [Shoot|[PokeballPosition]], NewPokeball):- 
    (_, Direction, Speed) = Shoot, 
    NewOnShoot = false,  
    NewPokeball = [(NewOnShoot, Direction, Speed), PokeballPosition], !.
resolveCollision("O", [Shoot|[PokeballPosition]], NewPokeball) :-
    (_, Direction, Speed) = Shoot, 
    NewOnShoot = false,  
    NewPokeball = [(NewOnShoot, Direction, Speed), PokeballPosition], !.

updateProjectiles([ProjectileRight|[ProjectileLeft]], NewProjectiles) :- 
    initializeProjectile(ProjectileRight, ActualProjectileRight),
    initializeProjectile(ProjectileLeft, ActualProjectileLeft),
    movePokeball(ActualProjectileRight, MovedProjectileRight), 
    movePokeball(ActualProjectileLeft, MovedProjectileLeft),
    NewProjectiles = [MovedProjectileRight, MovedProjectileLeft].

initializeProjectile([Shoot|Position], NewProjectile) :-  
    (OnShoot, Direction, Speed) = Shoot, 
	(true, Direction, Speed) = NewShoot,
    (OnShoot ->  NewProjectile = [Shoot|Position];
    NewProjectile = [NewShoot|[(12, 6)]]).

updatePlayers(Bulbasaur, Charmander, Projectiles, PokeballBulbasaur, PokeballCharmander, FinalBulbasaur, FinalCharmander) :-
    [ProjectileRight|[ProjectileLeft]] = Projectiles,
    deathPokemon(Bulbasaur, PokeballCharmander, IntermidiateBulbasaur),
    deathPokemon(Charmander, PokeballBulbasaur, IntermidiateCharmander),
    deathPokemon(IntermidiateBulbasaur, ProjectileLeft, FinalBulbasaur),
    deathPokemon(IntermidiateCharmander, ProjectileRight, FinalCharmander).

deathPokemon([Name|Location], [Shoot|PokeballPosition], FinalPokemon) :-
    (
        Location = PokeballPosition ->  FinalPokemon = ["X"|Location] ;
        FinalPokemon = [Name|Location]
    ).
