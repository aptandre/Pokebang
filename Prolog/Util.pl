show_menu():-
    L0 = "-------------------------------------------------------------------------------------------------",
    L1 = "|                                   Press Enter to start the game                               |",
    L2 = "|                                           POKESHOT!                                           |",

    List = [L0, L1, L2, L0],
    
    nl, nl, nl,
    print_menu(List).

    

initialBulbasaur([(0, 500)]).
initialCharmander([(0, -500)]).
initialObstacles([(100, 100)]).

print_menu([]) :- nl, nl, nl.
print_menu([Head|Tail]) :- write(Head), nl, print_menu(Tail).
