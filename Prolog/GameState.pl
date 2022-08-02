
clearScreen.                                   % pour vider l'ecran
/*
clearScreen :- clearScreen(0).
clearScreen(Y) :- Y >= 20, !.
clearScreen(Y) :- nl, Y2 is Y+1, clearScreen(Y2).
*/

afficher(M) :- debugMode, write(M).       % alias de write utilisé pour afficher des traces
afficher(_).

nl2 :- debugMode, nl.                     % alias de nl utilisé pour afficher des traces
nl2.

afficherCoord(Nom1,Coord1,Nom2,Coord2) :-      % affiche des coordonnées (traces)
    afficher(Nom1),afficher('='),afficher(Coord1),afficher(' '),
    afficher(Nom2),afficher('='),afficher(Coord2),afficher(' ').

dessinercarac(X,Y) :- schema(X,Y,Signe), write(Signe).

dessinerligne(Y) :- dessinerligne(0,Y).
dessinerligne(X,_Y) :- largeur(Xmax), X >= Xmax, !.
dessinerligne(X,Y) :- dessinercarac(X,Y), X2 is X+1, dessinerligne(X2,Y).

ttDessiner(Y) :- hauteur(Ymax), Y >= Ymax, !.
ttDessiner(Y) :- dessinerligne(Y), nl, Y2 is Y+1, ttDessiner(Y2).

affichage :- clearScreen, nl, afficherScore, ttDessiner(0).   % dessine le jeu