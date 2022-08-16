:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

% Predicado responsável por inicializar o menu e esperar receber a entrada
% do usuário, ele espera que o usuário aperte enter para iniciar o jogo.
eventHandler(menu, NewGameState, _, _, _, _, _, _, _, _) :-
    get_single_char(Key),

    (
        startKey(Key) -> NewGameState = game;
        NewGameState = menu
    ).

% Predicado responsável por receber a entrada do usuário, todos os comandos
% de movimentação e de atirar são passados por aqui.
eventHandler(game, _, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, NewBulbasaur, NewCharmander, NewPokeballBulbasaur, NewPokeballCharmander) :-
    get_single_char(Key), 

    (
        % Move o bulbasaur para cima
        bulbasaurUp(Key) ->
            moveUp(Bulbasaur, NewBulbasaur), 
            NewCharmander = Charmander, 
            movePokeball(PokeballBulbasaur, NewPokeballBulbasaur),
            movePokeball(PokeballCharmander, NewPokeballCharmander); 
        
        % Move o bulbasaur para baixo
        bulbasaurDown(Key) ->
            moveDown(Bulbasaur, NewBulbasaur), 
            NewCharmander = Charmander, 
            movePokeball(PokeballBulbasaur, NewPokeballBulbasaur),
            movePokeball(PokeballCharmander, NewPokeballCharmander);

        % Atira a pokeball do bulbasaur
        bulbasaurShoot(Key) -> 
            initializeShoot(Bulbasaur, PokeballBulbasaur, NewPokeball),
            movePokeball(NewPokeball, NewPokeballBulbasaur), 
            NewBulbasaur = Bulbasaur, 
            NewCharmander = Charmander, 
            NewPokeballCharmander = PokeballCharmander;

        % Move o charmander para cima
        charmanderUp(Key) -> 
            moveUp(Charmander, NewCharmander), 
            NewBulbasaur = Bulbasaur,
            movePokeball(PokeballBulbasaur, NewPokeballBulbasaur),
            movePokeball(PokeballCharmander, NewPokeballCharmander);

        % Move o charmander para baixo
        charmanderDown(Key) -> 
            moveDown(Charmander, NewCharmander),
            NewBulbasaur = Bulbasaur, 
            movePokeball(PokeballBulbasaur, NewPokeballBulbasaur), 
            movePokeball(PokeballCharmander, NewPokeballCharmander);

        % Atira a pokeball do charmander
        charmanderShoot(Key) -> 
            initializeShoot(Charmander, PokeballCharmander, NewPokeball), 
            movePokeball(NewPokeball, NewPokeballCharmander), 
            NewBulbasaur = Bulbasaur, 
            NewCharmander = Charmander, 
            NewPokeballBulbasaur = PokeballBulbasaur;
        
        NewBulbasaur = Bulbasaur, NewCharmander = Charmander, NewPokeballBulbasaur = PokeballBulbasaur, NewPokeballCharmander = PokeballCharmander
    ).

% Predicado utilizado para inicializar os tiros.
initializeShoot([_|Location], [Shoot|Position], NewPokeball) :-  
    % Recebe o estado de Shoot atual do tiro do pokemon
    (OnShoot, Direction, Speed) = Shoot, 
    % Define um novo estado de Shoot para uso, caso necessário
	(true, Direction, Speed) = NewShoot,
    % OnShoot é true quando a pokeball está em movimento
    % OnShoot é inicializado como false na mesma posição no pokemon
    % Se a OnShoot é false pokebola está fora do mapa ou foi interceptada, 
    % logo vira uma pokeball que move-se com OnShoot igual a true
    (
        % Se OnShoot é true, a pokeball deve continuar se movendo linearmente
        OnShoot ->  NewPokeball = [Shoot|Position];
        % Se OnShoot é false, a pokeball deve inicializar na mesma posição 
        % do pokemon que está atirando essa ao apertar a tecla
        NewPokeball = [NewShoot|Location]
    ).

% Predicado utilizado para atualizar a movimentação de baixo para cima
% do jogador, este predicado leva em conta os limites da tela.
moveUp([Name|Location], [Name, (X, NewY)]) :- 
    [(X, Y)] = Location,
    (
        constraintsUp(Y) -> NewY is Y;
        NewY is Y - 1
    ).

% Predicado utilizado para atualizar a movimentação de cima para baixo
% do jogador, este predicado leva em conta os limites da tela.
moveDown([Name|Location], [Name, (X, NewY)]) :- 
    [(X, Y)] = Location,
    (
        constraintsDown(Y) -> NewY is Y;
        NewY is Y + 1
    ).