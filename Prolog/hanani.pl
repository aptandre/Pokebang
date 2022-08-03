generate_board(_, 0, Board) :- print_board(Board).
generate_board(List, Lines, _) :- 
    matriz_line([], 100, Line),
    append(List, Line, Result),
    NewLines is Lines - 1, 
    generate_board(Result, NewLines, Result).

matriz_line(_, 0, MatrizLine) :- !.
matriz_line(List, Count, _) :- 
    append(List, ['#'], Result),
    NewCount is Count - 1,
    matriz_line(Result, NewCount, Result).

print_board([]).
print_board([Head|Tail]):-
    print_line(Head), nl,
    print_board(Tail).

print_line([]).
print_line([Head|Tail]):-
    write(Head), 
    print_line(Tail).

hananinho(_, 0, M):-
hananinho(_, 0, M)