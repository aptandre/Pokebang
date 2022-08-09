:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

render(menu, _, _, _, _, _) :-
    show_menu().

render(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles) :- 
    nl,
    write('------------------- new frame of the game --------------------'),  nl,
    show_game(Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles),
    nl,
    write('---------------------------------------------------------------'),  nl.

show_game(Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles) :-
    generate_board(13, Board), 
    insert_players(Bulbasaur, Board, IntermidiateBoard1), 
    insert_players(Charmander, IntermidiateBoard1, IntermidiateBoard2), 
    insert_players(Obstacles, IntermidiateBoard2, IntermidiateBoard3), 
    insert_pokeballs(PokeballBulbasaur, IntermidiateBoard3, IntermidiateBoard4), 
    insert_pokeballs(PokeballCharmander, IntermidiateBoard4, FinalBoard), 
    print_board(FinalBoard).
    
show_game(Bulbasaur, Charmander, NewObstacles) :-
    generate_board(13, Board), 
    insert_players(Bulbasaur, Board, IntermidiateBoard1), 
    insert_players(Charmander, IntermidiateBoard1, IntermidiateBoard2), 
    print_board(IntermidiateBoard2).

generate_board(Length, Board) :- 
    length(Board, Length), 
    matrizLine(25, MatrizLine),
    maplist(=(MatrizLine), Board).
    
matrizLine(Length, MatrizLine) :- 
    length(MatrizLine, Length), 
    maplist(=('_'), MatrizLine).

insert_players([Name|Tail], Board, NewBoard) :-
    [(X, Y)] = Tail,
    insert_on_board(X, Y, Name, Board, NewBoard).

insert_pokeballs([Head|Tail], Board, NewBoard):-
    (OnShoot, Direction, Speed) = Head, 
    [(X, Y)] = Tail,
    (
        OnShoot -> insert_on_board(X, Y, '@', Board, NewBoard);
        NewBoard = Board
    ).

insert_on_board(X, 0, Name, [Head|Tail], [Insert|Tail]) :- 
    insert_on_list(X, Name, Head, Insert), !.
insert_on_board(X, Y, Name, [Head|Tail], [Head|Other]) :-
	NewY is Y - 1, 
	insert_on_board(X, NewY, Name, Tail, Other).

insert_on_list(0, Name, [_|Tail], [Name|Tail]) :- !.
insert_on_list(X, Name, [Head|Tail], [Head|Other]) :-
	NewX is X - 1, 
	insert_on_list(NewX, Name, Tail, Other).

print_board([]).
print_board([Head|Tail]):-
    print_line(Head), nl,
    print_board(Tail).
  
print_line([]).
print_line([Head|Tail]):-
    write(Head), 
    print_line(Tail).