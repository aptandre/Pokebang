initialBulbasaur([(0, 500)]).
initialCharmander([(0, -500)]).
initialObstacles([(100, 100)]).

show_menu():-
    L0 = "-------------------------------------------------------------------------------------------------",
    L1 = "|                                   Press Enter to start the game                               |",
    L2 = "|                                           POKESHOT!                                           |",

    List = [L0, L1, L2, L0],
    
    nl, nl, nl,
    print_menu(List).

print_menu([]) :- nl, nl, nl.
print_menu([Head|Tail]) :- write(Head), nl, print_menu(Tail).

show_game(NewBulbasaur, NewCharmander, NewObstacles) :-
    generate_board([], 10, Board).
    % print_pokemon(NewBulbasaur), print_pokemon(NewCharmander), print_obstacles(NewObstacles)
     
generate_board(_, 0, Board) :- print_board(Board).
generate_board(List, Lines, _) :- 
    matriz_line([], 50, MatrizLine),
    append(List, MatrizLine, Result),
    NewLines is Lines - 1, 
    generate_board(Result, NewLines, Result).

matriz_line(_, 0, MatrizLine).
matriz_line(List, Count, _) :- 
    append(List, ['#'], Result),
    NewCount is Count - 1,
    matriz_line(Result, NewCount, Result).

% imprime no terminal cada toda a matriz
print_board([]).
print_board([Head|Tail]):-
    print_line(Head), nl,
    print_board(Tail).

% imprime no terminal uma linha da matriz
print_line([]).
print_line([Head|Tail]):-
    write(Head), 
    print_line(Tail).