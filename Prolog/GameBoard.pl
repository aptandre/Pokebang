:- include('EventHandler.pl').
:- include('Render.pl').
:- include('Initial.pl').
:- include('Util.pl').
:- include('GameUpdate.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

play(menu, _, _, _, _, _, _) :-
    render(menu, _, _, _, _, _, _),
    
    eventHandler(menu, NewGameState, _, _, _, _, _, _, _, _),

    play(NewGameState, [], [], [], [], [], []).

play(game, [], [], [], [], [], []) :-
    initialBulbasaur(NewBulbasaur),
    initialCharmander(NewCharmander),
    initialObstacles(NewObstacles),
    initialShoot(NewBulbasaur, NewPokeballBulbasaur),
    initialShoot(NewCharmander, NewPokeballCharmander),
    initialProjectiles(NewProjectiles),

    play(game, NewBulbasaur, NewPokeballBulbasaur, NewCharmander, NewPokeballCharmander, NewObstacles, NewProjectiles).

play(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles) :-
    sleep(1),

    render(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles),

    eventHandler(game, _, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, NewBulbasaur, NewCharmander, NewPokeballBulbasaur, NewPokeballCharmander),

    updateCollisions(NewPokeballBulbasaur, NewPokeballCharmander, Obstacles, Projectiles, FinalPokeballBulbasaur, FinalPokeballCharmander, NewObstacles, NewProjectiles), 

    updatePlayers(NewBulbasaur, NewCharmander, NewProjectiles, FinalPokeballBulbasaur, FinalPokeballCharmander, FinalBulbasaur, FinalCharmander),

    checkGameOver(FinalBulbasaur, FinalCharmander, NewGameState),
    
    play(NewGameState, FinalBulbasaur, FinalPokeballBulbasaur, FinalCharmander, FinalPokeballCharmander, NewObstacles, NewProjectiles).

play(over, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles):- 
    render(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles),
    render(over, Bulbasaur, _, Charmander, _, _, _), 
    halt.