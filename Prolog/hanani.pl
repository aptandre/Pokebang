% insert_obstacles([], _, NewBoard).
% insert_obstacles([Head|Tail], Board, _) :-
%     insert_pokemon(Head, Board, IntermidiateBoard),
%     NewBoard = IntermidiateBoard,
%     insert_obstacles(Tail, IntermidiateBoard, NewBoard).

% insert_pokemon([Name|Tail], Board, NewBoard) :-
%     [(X, Y)] = Tail,
%     insert_on_board(X, Y, Name, Board, NewBoard).

% insert_on_board(X, 0, Name, [Head|Tail], [Insert|Tail]) :- 
%     insert_on_list(X, Name, Head, Insert), !.
% insert_on_board(X, Y, Name, [Head|Tail], [Head|Other]) :-
% 	NewY is Y - 1, 
% 	insert_on_board(X, NewY, Name, Tail, Other).

% insert_on_list(0, Name, [_|Tail], [Name|Tail]) :- !.
% insert_on_list(X, Name, [Head|Tail], [Head|Other]) :-
% 	NewX is X - 1, 
% 	insert_on_list(NewX, Name, Tail, Other).