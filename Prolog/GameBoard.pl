:- include('EventHandler.pl').
:- include('Render.pl').
:- include('Initial.pl').
:- include('Util.pl').
:- include('UpdateController.pl').
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

    play(game, NewBulbasaur, NewPokeballBulbasaur, NewCharmander, NewPokeballCharmander, NewObstacles).

play(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles) :-
    sleep(1),
    
    render(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles),
    
    eventHandler(game, _, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, NewBulbasaur, NewCharmander, NewPokeballBulbasaur, NewPokeballCharmander),
    
    checkGameOver(NewBulbasaur, NewCharmander, NewGameState),
    
    play(NewGameState, NewBulbasaur, NewPokeballBulbasaur, NewCharmander, NewPokeballCharmander, Obstacles).

play(over, Bulbasaur, _, Charmander, _, _) :- 
    render(over, Bulbasaur, _, Charmander, _, _), 
    halt.
