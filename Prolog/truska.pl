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

    write("travou"), nl,

    (
        bulbasaurUp(Key) ->
            write("bulbasaurUp"), nl,
            moveUp(Bulbasaur, NewBulbasaur), 
            NewCharmander = Charmander, 
            movePokeball(PokeballBulbasaur, NewPokeballBulbasaur),
            movePokeball(PokeballCharmander, NewPokeballCharmander); 
               

        bulbasaurDown(Key) ->
            write("bulbasaurDown"), nl,
            moveDown(Bulbasaur, NewBulbasaur), 
            NewCharmander = Charmander, 
            movePokeball(PokeballBulbasaur, NewPokeballBulbasaur),
            movePokeball(PokeballCharmander, NewPokeballCharmander);

        bulbasaurShoot(Key) -> 
            write("bulbasaurShoot"), nl,
            initializeShoot(Bulbasaur, PokeballBulbasaur, NewPokeball),
            movePokeball(NewPokeball, NewPokeballBulbasaur), 
            NewBulbasaur = Bulbasaur, 
            NewCharmander = Charmander, 
            NewPokeballCharmander = PokeballCharmander;

        charmanderUp(Key) -> 
            write("charmanderUp"), nl,
            moveUp(Charmander, NewCharmander), 
            NewBulbasaur = Bulbasaur,
            m   movePokeball(PokeballBulbasaur, NewPokeballBulbasaur),
            movePokeball(PokeballCharmander, NewPokeballCharmander);
        
        charmanderDown(Key) -> 
            write("charmanderDown"), nl,
            moveDown(Charmander, NewCharmander),
            write("pasosu 1"), nl,
            NewBulbasaur = Bulbasaur, 
            write("pasosu 2"), nl,
            movePokeball(PokeballBulbasaur, NewPokeballBulbasaur), 
            write("pasosu 3"), nl,
            movePokeball(PokeballCharmander)
            write("pasosu 4"), nl;

        charmanderShoot(Key) -> 
            write("charmanderShoot"), nl,
            initializeShoot(Charmander, PokeballCharmander, NewPokeball), 
            movePokeball(NewPokeball, NewPokeballCharmander), 
            NewBulbasaur = Bulbasaur, 
            NewCharmander = Charmander, 
            NewPokeballBulbasaur = PokeballBulbasaur;
        
        write("fim"),
        NewBulbasaur = Bulbasaur, NewCharmander = Charmander, NewPokeballBulbasaur = PokeballBulbasaur, NewPokeballCharmander = PokeballCharmander
    ).

moveUp([Name|Location], [Name, (X, NewY)]) :- 
    [(X, Y)] = Location,
    (
        constraintsUp(Y) -> NewY is Y;
        NewY is Y - 3
    ).

moveDown([Name|Location], [Name, (X, NewY)]) :- 
    [(X, Y)] = Location,
    (
        constraintsDown(Y) -> NewY is Y;
        NewY is Y + 3
    ).

movingPokeball([(true, _, _)|_]).

initializeShoot([_|Location], [Shoot|Position], NewPokeball) :-  
    (OnShoot, Direction, Speed) = Shoot, 
	(true, Direction, Speed) = NewShoot,
    % OnShoot é true quando a pokeball está em movimento
    % A pokeboll deve continuar se movendo linearmente
    (OnShoot ->  NewPokeball = [Shoot|Position];
    % OnShoot é inicializado como false na mesma posição no pokemon
    % a pokebola está fora do mapa ou foi interceptada, logo vira uma pokeball que move-se
    % deve inicializar na mesma posição do pokemon que está atirando essa ao apertar a tecla
    NewPokeball = [NewShoot|Location]).