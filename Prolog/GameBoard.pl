:- include('EventHandler.pl').
:- include('Render.pl').
:- include('Initial.pl').
:- include('Util.pl').
:- include('GameUpdate.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

play(menu, _, _, _) :-
    render(menu, _, _, _, _, _),
    
    eventHandler(menu, NewGameState, _, _, _, _, _, _, _, _),

    play(NewGameState, [], [], [], [], []).

play(game, [], [], [], [], []) :-
    initialBulbasaur(NewBulbasaur),
    initialCharmander(NewCharmander),
    initialObstacles(NewObstacles),
    initialShoot(NewBulbasaur, NewPokeballBulbasaur),
    initialShoot(NewCharmander, NewPokeballCharmander),

    render(game, NewBulbasaur, NewPokeballBulbasaur, NewCharmander, NewPokeballCharmander, NewObstacles),

    play(game, NewBulbasaur, NewPokeballBulbasaur, NewCharmander, NewPokeballCharmander, NewObstacles).

play(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles) :-
    sleep(1),

    eventHandler(game, _, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, NewBulbasaur, NewCharmander, NewPokeballBulbasaur, NewPokeballCharmander),

    render(game, NewBulbasaur, NewPokeballBulbasaur, NewCharmander, NewPokeballCharmander, Obstacles),
    
    updateCollisions(NewPokeballBulbasaur, NewPokeballCharmander, Obstacles, FinalPokeballBulbasaur, FinalPokeballCharmander, NewObstacles), 

    updatePlayers(NewBulbasaur, NewCharmander, FinalPokeballBulbasaur, FinalPokeballCharmander, FinalBulbasaur, FinalCharmander),

    checkGameOver(FinalBulbasaur, FinalCharmander, NewGameState),
    
    nl, write(FinalPokeballBulbasaur), nl,
    write(FinalPokeballCharmander), nl,
    write(NewObstacles), nl, 

    play(NewGameState, FinalBulbasaur, FinalPokeballBulbasaur, FinalCharmander, FinalPokeballCharmander, NewObstacles).

play(over, Bulbasaur, _, Charmander, _, _) :- 
    render(over, Bulbasaur, _, Charmander, _, _), 
    halt.