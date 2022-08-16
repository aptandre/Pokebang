:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

% Função responsável por mostrar o menu inicial do jogo
show_menu():-
    L0 = "-------------------------------------------------------------------------------------------------",
    L1 = "|                                 Press Enter to start the game                                 |",
    L2 = "|                                           POKESHOT!                                           |",
    L3 = "|                                                                                               |",
    L4 = "|                 Pressione W, S para mover o Bulbasaur e D para faze-lo atirar                 |",
    L5 = "|                 Pressione I, K para mover o Charmander e J para faze-lo atirar                |",
    List = [L0, L1, L2, L3, L4, L5, L0],
    
    nl, nl, nl,
    print_menu(List).

print_menu([]) :- nl, nl, nl.
print_menu([Head|Tail]) :- write(Head), nl, print_menu(Tail).

% Predicado responsável por renderizar os objetos na tela, essa função gera um "board", insere 
% as pokebolas de ambos os players, insere os projéteis do vileplume, os obstáculos, por fim,
% o players.
show_game(Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles) :-
    generate_board(13, Board), 
    insert_pokeballs(PokeballBulbasaur, Board, IntermidiateBoard1), 
    insert_pokeballs(PokeballCharmander, IntermidiateBoard1, IntermidiateBoard2), 
    insert_projectiles(Projectiles, IntermidiateBoard2, IntermidiateBoard3), 
    insert_obstacles(Obstacles, IntermidiateBoard3, IntermidiateBoard4),
    insert_pokemon(Bulbasaur, IntermidiateBoard4, IntermidiateBoard5), 
    insert_pokemon(Charmander, IntermidiateBoard5, FinalBoard),      

    nl, nl, nl,
    write('============= continue jogando!!'),  
    nl,
    print_board(FinalBoard),
    nl,
    write('================================='),
    nl, nl, nl.

% Predicado responsável por gerar a matriz do tabuleiro
generate_board(Length, Board) :- 
    length(Board, Length), 
    matrizLine(25, MatrizLine),
    maplist(=(MatrizLine), Board).
    
% Gera a linha da matriz com espaços vazios
matrizLine(Length, MatrizLine) :- 
    length(MatrizLine, Length), 
    maplist(=('_'), MatrizLine).

% Insere um pokémon na matriz do tabuleiro
insert_pokemon([Name|Tail], Board, NewBoard) :-
    [(X, Y)] = Tail,
    insert_on_board(X, Y, Name, Board, NewBoard).

% Insere uma pokéball na matriz do tabuleiro
insert_pokeballs([Head|Tail], Board, NewBoard):-
    (OnShoot, Direction, Speed) = Head, 
    [(X, Y)] = Tail,
    (
        OnShoot -> insert_on_board(X, Y, '+', Board, NewBoard);
        NewBoard = Board
    ).

% Insere os projéteis na matriz do tabuleiro
insert_projectiles([], IntermidiateBoard, NewBoard) :- NewBoard = IntermidiateBoard.
insert_projectiles([Head|Tail], Board, NewBoard) :- 
    insert_pokeballs(Head, Board, IntermidiateBoard), 
    insert_projectiles(Tail, IntermidiateBoard, NewBoard).

% Insere os obstáculos na matriz do tabuleiro
insert_obstacles([], IntermidiateBoard, NewBoard) :- NewBoard = IntermidiateBoard.
insert_obstacles([Head|Tail], Board, NewBoard) :-
    insert_pokemon(Head, Board, IntermidiateBoard),
    insert_obstacles(Tail, IntermidiateBoard, NewBoard).

% Insere um objeto no tabuleiro.
insert_on_board(X, 0, Name, [Head|Tail], [Insert|Tail]) :- 
    insert_on_list(X, Name, Head, Insert), !.
insert_on_board(X, Y, Name, [Head|Tail], [Head|Other]) :-
	NewY is Y - 1, 
	insert_on_board(X, NewY, Name, Tail, Other).

% Insere o objeto na lista.
insert_on_list(0, Name, [_|Tail], [Name|Tail]) :- !.
insert_on_list(X, Name, [Head|Tail], [Head|Other]) :-
	NewX is X - 1, 
	insert_on_list(NewX, Name, Tail, Other).

% Imprime o tabuleiro no terminal.
print_board([]).
print_board([Head|Tail]):-
    print_line(Head), nl,
    print_board(Tail).

% Imrpime uma linha da matriz no terminal.
print_line([]).
print_line([Head|Tail]):-
    write(Head), 
    print_line(Tail).

% Compara quem foi o vencedor. Caso o Vileplume tenha acertado
% os dois jogadores ao mesmo tempo, ambos perdem e o Vileplume
% será o vencedor.
show_winner(Bulbasaur, Charmander):-
    (
        
        loser(Bulbasaur), loser(Charmander) -> print_winner_vileplum();
        winner(Bulbasaur) -> print_winner_bulbasaur();
        winner(Charmander) -> print_winner_charmander()
        
    ).

% Imprime o menu de resultado quando o Bulbasaur ganha.
print_winner_bulbasaur():- 
    L0 = "-------------------------------------------------------------------------------------------------",
    L1 = "|                                         Game Over                                             |",
    L2 = "|                                      Bulbasaur Wins!                                          |",

    List = [L0, L1, L2, L0],
    
    nl, nl, nl,
    print_menu(List).

% Imprime o menu de resultado quando o Charmander ganha.
print_winner_charmander():- 
    L0 = "-------------------------------------------------------------------------------------------------",
    L1 = "|                                         Game Over                                              |",
    L2 = "|                                      Charmander Wins!                                          |",

    List = [L0, L1, L2, L0],
    
    nl, nl, nl,
    print_menu(List).

% Imprime o menu de resultado quando o Vileplume ganha.
print_winner_vileplum():- 
    L0 = "-------------------------------------------------------------------------------------------------",
    L1 = "|                                         Game Over                                             |",
    L2 = "|                                      Vileplum Wins!                                           |",

    List = [L0, L1, L2, L0],
    
    nl, nl, nl,
    print_menu(List).