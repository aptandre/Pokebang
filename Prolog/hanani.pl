initializeShoot([_|Location], [Shoot|Position], NewPokeball) :-  
    (OnShoot, Direction, Speed) = Shoot, 
	(true, Direction, Speed) = NewShoot,
    (OnShoot ->  NewPokeball = [Shoot|Position];
     NewPokeball = [NewShoot|Location]).