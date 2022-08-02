:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

render(menu, _, _, _) :-
    show_menu().

render(game, NewBulbasaur, NewCharmander, NewObstacles) :- 
    write("bicha"),
    show_game(NewBulbasaur, NewCharmander, NewObstacles),
    write("bicha").