:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

render(menu, _, _, _) :-
    show_menu().

render(game, NewBulbasaur, NewCharmander, NewObstacles) :- 
    show_game(NewBulbasaur, NewCharmander, NewObstacles).

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
    generate_board(25, Board), 
    insert_players(NewBulbasaur, Board, IntermidiateBoard1), 
    insert_players(NewCharmander, IntermidiateBoard1, IntermidiateBoard2), 
    insert_players(NewObstacles, IntermidiateBoard2, FinalBoard), 
    print_board(FinalBoard).
    
show_game(NewBulbasaur, NewCharmander, NewObstacles) :-
    generate_board(30, Board), 
    insert_players(NewBulbasaur, Board, IntermidiateBoard1), 
    insert_players(NewCharmander, IntermidiateBoard1, IntermidiateBoard2), 
    print_board(IntermidiateBoard2).

generate_board(Length, Board) :- 
    length(Board, Length), 
    matrizLine(100, MatrizLine),
    maplist(=(MatrizLine), Board).
    
 matrizLine(Length, MatrizLine) :- 
    length(MatrizLine, Length), 
    maplist(=(' '), MatrizLine).

insert_players([Name|Tail], Board, NewBoard) :-
    [(X, Y)] = Tail,
    insert_player_on_board(X, Y, Name, Board, NewBoard).

insert_player_on_board(0, Y, Name, [Head|Tail], [Insert|Tail]) :- 
    insert_player_on_list(Y, Name, Head, Insert), !.
insert_player_on_board(X, Y, Name, [Head|Tail], [Head|Other]) :-
	NewX is X - 1, 
	insert_player_on_board(NewX, Y, Name, Tail, Other).

insert_player_on_list(0, Name, [_|Tail], [Name|Tail]) :- !.
insert_player_on_list(Y, Name, [Head|Tail], [Head|Other]) :-
	NewY is Y - 1, 
	insert_player_on_list(NewY, Name, Tail, Other).
    
print_board([]).
print_board([Head|Tail]):-
    print_line(Head), nl,
    print_board(Tail).
    
print_line([]).
print_line([Head|Tail]):-
    write(Head), 
    print_line(Tail).