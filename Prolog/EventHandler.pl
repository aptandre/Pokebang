:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

eventHandler(menu, NewGameState, _, _, _, _, _, _, _, _) :-
    get_single_char(Key),

    (
        startKey(Key) -> NewGameState = game;
        NewGameState = menu
    ).

eventHandler(game, _, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, NewBulbasaur, NewCharmander, NewPokeballBulbasaur, NewPokeballCharmander) :-
    get_single_char(Key),
    
    (
        stopGame(Key) -> false;
        bulbasaurUp(Key) -> moveUp(Bulbasaur, NewBulbasaur), NewCharmander = Charmander, NewPokeballBulbasaur = PokeballBulbasaur, NewPokeballCharmander = PokeballCharmander;
        bulbasaurDown(Key) -> moveDown(Bulbasaur, NewBulbasaur), NewCharmander = Charmander, NewPokeballBulbasaur = PokeballBulbasaur, NewPokeballCharmander = PokeballCharmander;
        bulbasaurShoot(Key) -> initializeShoot(Bulbasaur, PokeballBulbasaur, NewPokeball), moveShoot(NewPokeball, NewPokeballBulbasaur), NewBulbasaur = Bulbasaur, NewCharmander = Charmander, NewPokeballCharmander = PokeballCharmander;
        charmanderUp(Key) -> moveUp(Charmander, NewCharmander), NewBulbasaur = Bulbasaur, NewPokeballBulbasaur = PokeballBulbasaur, NewPokeballCharmander = PokeballCharmander;
        charmanderDown(Key) -> moveDown(Charmander, NewCharmander), NewBulbasaur = Bulbasaur, NewPokeballBulbasaur = PokeballBulbasaur, NewPokeballCharmander = PokeballCharmander; 
        charmanderShoot(Key) ->  initializeShoot(Charmander, PokeballCharmander, NewPokeball), moveShoot(NewPokeball, NewPokeballCharmander), NewBulbasaur = Bulbasaur, NewCharmander = Charmander, NewPokeballBulbasaur = PokeballBulbasaur;
        NewBulbasaur = Bulbasaur, NewCharmander = Charmander, NewPokeballBulbasaur = PokeballBulbasaur, NewPokeballCharmander = PokeballCharmander
    ).

initializeShoot([_|Location], [Shoot|Position], NewPokeball) :-  
    (OnShoot, Direction, Speed) = Shoot, 
	(true, Direction, Speed) = NewShoot,
    (OnShoot ->  NewPokeball = [Shoot|Position];
    NewPokeball = [NewShoot|Location]).

moveUp([Name|Tail], [Name, (X, NewY)]) :- 
    [(X, Y)] = Tail,
    (
        constraintsUp(Y) -> NewY is Y;
        NewY is Y - 3
    ).

moveDown([Name|Tail], [Name, (X, NewY)]) :- 
    [(X, Y)] = Tail,
    (
        constraintsDown(Y) -> NewY is Y;
        NewY is Y + 3
    ).

moveShoot([Head|Tail], NewPokeball) :- 
    (OnShoot, Direction, Speed) = Head, 
    [(X, Y)] = Tail, 
    (   
        Direction =:= -1, constraintsLeft(X) -> NewX is X, NewOnShoot = false;
        Direction =:= 1, constraintsRight(X) -> NewX is X, NewOnShoot = false;
        NewX is X + (Direction * Speed), NewOnShoot = true
    ), 
    NewPokeball = [(NewOnShoot, Direction, Speed), (NewX, Y)].