insert_players([Name|Tail], Board, NewBoard) :-
    [(X, Y)] = Tail,
    insert_player_on_board(X, Y, Name, Board, NewBoard), write(NewBoard).

insert_player_on_board(0, Y, Name, [Head|Tail], [Insert|Tail]) :- 
    insert_player_on_list(Y, Name, Head, Insert), !.
insert_player_on_board(X, Y, Name, [Head|Tail], [Head|Other]) :-
	NewX is X - 1, 
	insert_player_on_board(NewX, Y, Name, Tail, Other).

insert_player_on_list(0, Name, [_|Tail], [Name|Tail]) :- !.
insert_player_on_list(Y, Name, [Head|Tail], [Head|Other]) :-
	NewY is Y - 1, 
	insert_player_on_list(NewY, Name, Tail, Other).