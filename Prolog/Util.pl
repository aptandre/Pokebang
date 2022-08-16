:-style_check(-discontiguous).
:-style_check(-singleton).

%       W    S    D    J    K    I
% X = [119, 115, 100, 106, 107, 105].
% Teclas apertadas para começar a rodar a aplicação
startKey(13).
startKey(10).

% Tecla apertada para mover o bulbasaur para cima
bulbasaurUp(119).
% Tecla apertada para mover o bulbasaur para baixo
bulbasaurDown(115).

% Tecla apertada para mover o charmannder para cima
charmanderUp(105).
% Tecla apertada para mover o charmannder para baixo
charmanderDown(107).

% Tecla apertada para atirar a pokeball do bulbasaur
bulbasaurShoot(100).
% Tecla apertada para atirar a pokeball do charmander
charmanderShoot(106).

% Tecla para sair do jogo incondicionalmente
stopGame(109).

% Definem as limitações da matriz
% Limite superior
constraintsUp(0).
% Limite inferior
constraintsDown(12).
% Limite lateral direito
constraintsRight(24).
% Limite lateral esquerdo
constraintsLeft(0).

% Move a pokeball do pokemon conforme lógcas
movePokeball([Shoot|Position], NewPokeball) :-
    % Recebe o estado de Shoot atual do tiro do pokemon
    (OnShoot, _, _) = Shoot, 
    (   
        % Se OnShoot é true, a pokeball deve mover-se efetivamente
        OnShoot -> moveShoot([Shoot|Position], NewPokeball);
        % Se OnShoot é false, a pokeball deve continuar na mesma posição 
        NewPokeball = [Shoot|Position]
    ).

moveShoot([Shoot|Position], NewPokeball) :- 
    % Recebe o estado de Shoot atual do tiro do pokemon
    (OnShoot, Direction, Speed) = Shoot, 
    % Recebe a posição atual do tiro do pokemon
    [(X, Y)] = Position, 
    (      
        % Se o tiro em direção a esquerda ultrapasa o limite lateral esquerdo esse para de se mover
        Direction =:= -1, constraintsLeft(X) -> NewX is X, NewOnShoot = false;
        % Se o tiro em direção a direita ultrapasa o limite lateral direita esse para de se mover
        Direction =:= 1, constraintsRight(X) -> NewX is X, NewOnShoot = false;
        % Caso o contrário, o tiro pode continuar a se mover de acordo com sua velocidade e direção
        NewX is X + (Direction * Speed), NewOnShoot = true
    ), 
    NewPokeball = [(NewOnShoot, Direction, Speed), (NewX, Y)].

% Predicados responsáveis por verificar se algum dos players ganhou ou perdeu.
winner(["B"|_]).
winner(["C"|_]).
loser(["X"|_]).

% Checa se houve GameOver, o jogo acaba quando: o Charmander morre, o Bulbasaur morre
% ou ambos morrem. Em todo caso, um player morto será substituído por "X" no tabuleiro.
checkGameOver([Bulbasaur|_], [Charmander|_], NewGameState):- 
    (   
        Bulbasaur =:= "X" -> NewGameState = over;
        Charmander  =:= "X" -> NewGameState = over;
        NewGameState = game
    ).