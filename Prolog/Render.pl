:- include('Util.pl').
:- include('Matriz.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

render(menu, _, _, _, _, _, _) :- 
    show_menu().

render(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles) :- 
    show_game(Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles).

render(over, Bulbasaur, _, Charmander, _, _, _) :-
    show_winner(Bulbasaur, Charmander).