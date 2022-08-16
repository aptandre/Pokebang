:- include('Util.pl').
:- include('Matriz.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

% Predicado responsável por renderizar o menu na tela.
render(menu, _, _, _, _, _, _) :- 
    show_menu().

% Predicado responsável por renderizar o jogo em estado jogável, atualizando
% todas as informações  de obstáculos, tiros, players etc.
render(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles) :- 
    show_game(Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles).

% Predicado responsável por renderizar o jogo quando ele
% terminou, mostrando, ao final, quem foi o vencedor.
render(over, Bulbasaur, _, Charmander, _, _, _) :-
    show_winner(Bulbasaur, Charmander).