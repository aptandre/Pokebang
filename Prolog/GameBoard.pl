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

    render(game, NewBulbasaur, NewPokeballBulbasaur, NewCharmander, NewPokeballCharmander, NewObstacles, NewProjectiles),

    play(game, NewBulbasaur, NewPokeballBulbasaur, NewCharmander, NewPokeballCharmander, NewObstacles, NewProjectiles).

play(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles) :-
    sleep(1),

    eventHandler(game, _, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, NewBulbasaur, NewCharmander, NewPokeballBulbasaur, NewPokeballCharmander),

    render(game, NewBulbasaur, NewPokeballBulbasaur, NewCharmander, NewPokeballCharmander, Obstacles, Projectiles),
    
    updateCollisions(NewPokeballBulbasaur, NewPokeballCharmander, Obstacles, Projectiles, FinalPokeballBulbasaur, FinalPokeballCharmander, NewObstacles, NewProjectiles), 

    updatePlayers(NewBulbasaur, NewCharmander, FinalPokeballBulbasaur, FinalPokeballCharmander, FinalBulbasaur, FinalCharmander),

    checkGameOver(FinalBulbasaur, FinalCharmander, NewGameState),
    
    play(NewGameState, FinalBulbasaur, FinalPokeballBulbasaur, FinalCharmander, FinalPokeballCharmander, NewObstacles, NewProjectiles).

play(over, Bulbasaur, _, Charmander, _, _, _) :- 
    render(over, Bulbasaur, _, Charmander, _, _, _), 
    halt.