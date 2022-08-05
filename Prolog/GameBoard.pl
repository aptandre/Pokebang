:- include('EventHandler.pl').
:- include('Render.pl').
:- include('Initial.pl').
:- include('Util.pl').
:- include('UpdateController.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

play(menu, _, _, _) :-
    render(menu, _, _, _),
    
    eventHandler(menu, NewGameState, _, _, _),

    play(NewGameState, [], [], []).

play(game, [], [], []) :-

    initialBulbasaur(NewBulbasaur),
    initialCharmander(NewCharmander),
    initialObstacles(NewObstacles),

    play(game, NewBulbasaur, NewCharmander, NewObstacles).

play(game, NewBulbasaur, NewCharmander, NewObstacles) :-
    sleep(1),

    render(game, NewBulbasaur, NewCharmander, NewObstacles),

    play(game, NewBulbasaur, NewCharmander, NewObstacles) .