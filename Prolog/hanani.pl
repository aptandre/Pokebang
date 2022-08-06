constraintsUp(0).
constraintsDown(25).

moveUp([Name|Tail], [Name, (NewX, Y)]) :- 
    [(X, Y)] = Tail,
    (
        constraintsUp(X) -> NewX is X;
        NewX is X - 4
    ).

moveDown([Name|Tail], [Name, (NewX, Y)]) :- 
    [(X, Y)] = Tail,
    (
        constraintsDown(X) -> NewX is X;
        NewX is X + 4
    ).