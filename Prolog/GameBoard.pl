:- include('EventHandler.pl').
:- include('Render.pl').
:- include('Initial.pl').
:- include('Util.pl').
:- include('GameUpdate.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

% O estado inicial do jogo é de exibição de menu
% O jogo espera receber como entrada um enter para iniciar a gameplay
play(menu, _, _, _, _, _, _) :-
    % Renderiza o menu do jogo
    render(menu, _, _, _, _, _, _),
    
    % Coleta a entrada do teclado do usuário para mudar o estado do jogo
    eventHandler(menu, NewGameState, _, _, _, _, _, _, _, _),

    % Informa ao jogo o novo estado 
    play(NewGameState, [], [], [], [], [], []).

% O segundo estado do jogo é a inicialização das entidades
% O jogo recebe as entidades em seu estado incial
play(game, [], [], [], [], [], []) :-
    % Definem as entidades para manipulação no jogo
    initialBulbasaur(NewBulbasaur),
    initialCharmander(NewCharmander),
    initialObstacles(NewObstacles),
    initialShoot(NewBulbasaur, NewPokeballBulbasaur),
    initialShoot(NewCharmander, NewPokeballCharmander),
    initialProjectiles(NewProjectiles),

    % Informa ao jogo o novo estado 
    % Define as novas entidades estabelicidas
    play(game, NewBulbasaur, NewPokeballBulbasaur, NewCharmander, NewPokeballCharmander, NewObstacles, NewProjectiles).

% O terceiro estado do jogo é a manipulação das entidades de acordo com a lógica
% O jogo recebe as entidades em seu estado incial, passando essas conforme alteradas até o fim do jogo
play(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles) :-
    sleep(1),

    % Renderiza o jogo com as entidades contidas
    render(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles),
    
    % Coleta a entrada do teclado do usuário para mudar o estado do jogo
    eventHandler(game, _, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, NewBulbasaur, NewCharmander, NewPokeballBulbasaur, NewPokeballCharmander),

    % Atualiza o estado do jogo conforme a lógica de colisão
    updateCollisions(NewPokeballBulbasaur, NewPokeballCharmander, Obstacles, Projectiles, FinalPokeballBulbasaur, FinalPokeballCharmander, NewObstacles, NewProjectiles), 

    % Atualiza o estado dos players conforme a lógica de fim de jogo
    updatePlayers(NewBulbasaur, NewCharmander, NewProjectiles, FinalPokeballBulbasaur, FinalPokeballCharmander, FinalBulbasaur, FinalCharmander),

    % Verifica se o jogo acabou com o fim da vida de algum player
    checkGameOver(FinalBulbasaur, FinalCharmander, NewGameState),
    
    % Informa ao jogo o novo estado 
    % Define os novos estados das entidades do jogo
    play(NewGameState, FinalBulbasaur, FinalPokeballBulbasaur, FinalCharmander, FinalPokeballCharmander, NewObstacles, NewProjectiles).

% O estado final do jogo é, geralmente, um player ter vencido outro
% O jogo renderiza o estado final e acaba a execução informando o pokemon vencedor
play(over, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles):- 
    render(game, Bulbasaur, PokeballBulbasaur, Charmander, PokeballCharmander, Obstacles, Projectiles),
    render(over, Bulbasaur, _, Charmander, _, _, _), 
    halt.