main :- 
    generate_board(50, Board), 
    print_board(Board), !.

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