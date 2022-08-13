:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

show_menu():-
    L0 = "-------------------------------------------------------------------------------------------------",
    L1 = "|                                 Press Enter to start the game                                 |",
    L2 = "|                                           POKESHOT!                                           |",

    List = [L0, L1, L2, L0],
    
    nl, nl, nl,
    print_menu(List).

print_menu([]) :- nl, nl, nl.
print_menu([Head|Tail]) :- write(Head), nl, print_menu(Tail).

show_game(Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles) :-
    generate_board(13, Board), 
    insert_pokeballs(PokeballBulbasaur, Board, IntermidiateBoard1), 
    insert_pokeballs(PokeballCharmander, IntermidiateBoard1, IntermidiateBoard2), 
    insert_obstacles(Obstacles, IntermidiateBoard2, IntermidiateBoard3),
    insert_pokemon(Bulbasaur, IntermidiateBoard3, IntermidiateBoard4), 
    insert_pokemon(Charmander, IntermidiateBoard4, FinalBoard),      

    nl,
    write('------------------- new frame of the game --------------------'),  nl,
    print_board(FinalBoard),
    nl,
    write('---------------------------------------------------------------'),  nl.

generate_board(Length, Board) :- 
    length(Board, Length), 
    matrizLine(25, MatrizLine),
    maplist(=(MatrizLine), Board).
    
matrizLine(Length, MatrizLine) :- 
    length(MatrizLine, Length), 
    maplist(=('_'), MatrizLine).

insert_pokemon([Name|Tail], Board, NewBoard) :-
    [(X, Y)] = Tail,
    insert_on_board(X, Y, Name, Board, NewBoard).

insert_pokeballs([Head|Tail], Board, NewBoard):-
    (OnShoot, Direction, Speed) = Head, 
    [(X, Y)] = Tail,
    (
        OnShoot -> insert_on_board(X, Y, '+', Board, NewBoard);
        NewBoard = Board
    ).

insert_obstacles([], IntermidiateBoard, NewBoard) :- NewBoard = IntermidiateBoard.
insert_obstacles([Head|Tail], Board, NewBoard) :-
    insert_pokemon(Head, Board, IntermidiateBoard),
    insert_obstacles(Tail, IntermidiateBoard, NewBoard).

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

show_winner(Bulbasaur, Charmander):-
    (
        winner(Bulbasaur) -> print_winner_bulbasaur();
        winner(Charmander) -> print_winner_charmander()
    ).

print_winner_bulbasaur():- 
    L0 = "-------------------------------------------------------------------------------------------------",
    L1 = "|                                         Game Over                                             |",
    L2 = "|                                      Bulbasaur Wins!                                          |",

    List = [L0, L1, L2, L0],
    
    nl, nl, nl,
    print_menu(List).

print_winner_charmander():- 
    L0 = "-------------------------------------------------------------------------------------------------",
    L1 = "|                                         Game Over                                              |",
    L2 = "|                                      Charmander Wins!                                          |",

    List = [L0, L1, L2, L0],
    
    nl, nl, nl,
    print_menu(List).