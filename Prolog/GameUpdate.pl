:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

% Atualiza todo o estado das pokeballs, pokemnos e obstáculos de acordo com colisões identidicadas
updateCollisions(PokeballBulbasaur, PokeballCharmander, ObstaclesList, Projectiles, FinalPokeballBulbasaur, FinalPokeballCharmander, NewObstacles, NewProjectiles) :-
    (
        iterateCollisions(PokeballBulbasaur, ObstaclesList, ObstaclesList, FinalPokeballBulbasaur, IntermidiateObstacles),
        iterateCollisions(PokeballCharmander, IntermidiateObstacles, IntermidiateObstacles, FinalPokeballCharmander, NewObstacles),
        updateProjectiles(Projectiles, NewProjectiles)
    ). 

% Itera sobre as colisões para descobrir se houve alguma com a pokeball
% Retorna e nova pokeball afetada ou não afetada com alguma colisão
iterateCollisions(Pokeball, [], ObstaclesList, NewPokeball, NewObstacles):- 
    NewPokeball = Pokeball, NewObstacles = ObstaclesList, !.
iterateCollisions(Pokeball, [Obstacle|Tail], ObstaclesList, NewPokeball, NewObstacles) :- 
    [(OnShoot, _, _)|[PokeballPosition]] = Pokeball,
    [Type, ObstaclePosition] = Obstacle,
    checkCollision(ObstaclePosition, PokeballPosition) -> 
    (
        resolveCollision(Type, Pokeball, OtherPokeball), 
        removeObstacle(Type, Obstacle, ObstaclesList, OtherObstacles), 
        iterateCollisions(OtherPokeball, Tail, OtherObstacles, NewPokeball, NewObstacles)
    );
    iterateCollisions(Pokeball, Tail, ObstaclesList, NewPokeball, NewObstacles).

% Verifica se exista algum obstáculo no mesmo local que a pokeball
checkCollision(ObstaclePosition, PokeballPosition) :-
    ObstaclePosition = PokeballPosition.

% Remove o obstáculo do jogo caso ocorra colisõo com o tipo de obstáculo que despararece
% No caso, apenas o obstáculo de lentidão pode desaparecer
removeObstacle("O", _, ObstaclesList, ObstaclesList) :- !.
removeObstacle("@", _, ObstaclesList, ObstaclesList) :- !.
removeObstacle(_,  Obstacle, [Obstacle|Tail], Tail) :- !.
removeObstacle(Type,  Obstacle, [Head|Tail], [Head|Other]) :- 
    removeObstacle(Type,  Obstacle, Tail, Other).

% Parte responsável por lidar com as colisões do jogo, caso
% o obstáculo colidido seja um "#" a velocidade do projétil
% será reduzida em duas unidades.
resolveCollision("#",  [Shoot|[PokeballPosition]], NewPokeball):-
    (OnShoot, Direction, _) = Shoot, 
    NewSpeed is 2,
    NewPokeball = [(OnShoot, Direction, NewSpeed), PokeballPosition],!.
% Caso o obstáculo colidido seja um "@" a pokeball será interceptada.
resolveCollision("@", [Shoot|[PokeballPosition]], NewPokeball):- 
    (_, Direction, Speed) = Shoot, 
    NewOnShoot = false,  
    NewPokeball = [(NewOnShoot, Direction, Speed), PokeballPosition], !.
% Caso o obstáculo colidido seja um "O" a pokeball será interceptada.
resolveCollision("O", [Shoot|[PokeballPosition]], NewPokeball) :-
    (_, Direction, Speed) = Shoot, 
    NewOnShoot = false,  
    NewPokeball = [(NewOnShoot, Direction, Speed), PokeballPosition], !.

% Atualiza a posição das pokeballs do vileplum
% O vileplum atira constantemente contra os pokemon
updateProjectiles([ProjectileRight|[ProjectileLeft]], NewProjectiles) :- 
    initializeProjectile(ProjectileRight, ActualProjectileRight),
    initializeProjectile(ProjectileLeft, ActualProjectileLeft),
    movePokeball(ActualProjectileRight, MovedProjectileRight), 
    movePokeball(ActualProjectileLeft, MovedProjectileLeft),
    NewProjectiles = [MovedProjectileRight, MovedProjectileLeft].

initializeProjectile([Shoot|Position], NewProjectile) :- 
    % Recebe o estado de Shoot atual do tiro do vileplum 
    (OnShoot, Direction, Speed) = Shoot, 
    % Define um novo estado de Shoot para uso, caso necessário
	(true, Direction, Speed) = NewShoot,
    % OnShoot é true quando a pokeball está em movimento
    % OnShoot é inicializado como false na mesma posição no pokemon
    % Se a OnShoot é false pokebola está fora do mapa ou foi interceptada, 
    % logo vira uma pokeball que move-se com OnShoot igual a true
    (
        % Se OnShoot é true, a pokeball deve continuar se movendo linearmente
        OnShoot ->  NewProjectile = [Shoot|Position];
        % Se OnShoot é false, a pokeball deve inicializar na mesma posição do vileplum
        NewProjectile = [NewShoot|[(12, 6)]]
    ).

% Atualiza o estado da vida atual dos players 
% Leva em consideração onde estão as pokeballs atualmente
updatePlayers(Bulbasaur, Charmander, Projectiles, PokeballBulbasaur, PokeballCharmander, FinalBulbasaur, FinalCharmander) :-
    [ProjectileRight|[ProjectileLeft]] = Projectiles,
    deathPokemon(Bulbasaur, PokeballCharmander, IntermidiateBulbasaur),
    deathPokemon(Charmander, PokeballBulbasaur, IntermidiateCharmander),
    deathPokemon(IntermidiateBulbasaur, ProjectileLeft, FinalBulbasaur),
    deathPokemon(IntermidiateCharmander, ProjectileRight, FinalCharmander).

% Verificia se houve colisão de um pokemon com alguma pokeball
% Caso ocorra colisão, o pokemon está morto
deathPokemon([Name|Location], [Shoot|PokeballPosition], FinalPokemon) :-
    (
        Location = PokeballPosition ->  FinalPokemon = ["X"|Location] ;
        FinalPokemon = [Name|Location]
    ).
