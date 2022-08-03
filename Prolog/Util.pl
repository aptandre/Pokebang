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
    generate_board(50, Board), print_board(Board).
    % print_pokemon(NewBulbasaur), print_pokemon(NewCharmander), print_obstacles(NewObstacles)
    
generate_board(Length, Board) :- 
    length(Board, Length), 
    matrizLine(100, MatrizLine),
    maplist(=(MatrizLine), Board).
    
 matrizLine(Length, MatrizLine) :- 
    length(MatrizLine, Length), 
    maplist(=('#'), MatrizLine).
    
print_board([]).
print_board([Head|Tail]):-
    print_line(Head), nl,
    print_board(Tail).
    
print_line([]).
print_line([Head|Tail]):-
    write(Head), 
    print_line(Tail).