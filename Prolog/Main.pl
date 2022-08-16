:- initialization(main).
:- include('Gameboard.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

% Função principal do jogo, a partir daqui o jogo começa.
main :-
    play(menu, _, _, _, _, _, _).