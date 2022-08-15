% Relaciona Pirata con Tripulacion

tripulante(luffy, sombreroDePaja).
tripulante(zoro, sombreroDePaja).
tripulante(nami, sombreroDePaja).
tripulante(ussop, sombreroDePaja).
tripulante(sanji, sombreroDePaja).
tripulante(chopper, sombreroDePaja).

tripulante(law, heart).
tripulante(bepo, heart).

tripulante(arlong, piratasDeArlong).
tripulante(hatchan, piratasDeArlong).

% Relaciona Pirata, Evento y Monto

impactoEnRecompensa(luffy, arlongPark, 30000000).
impactoEnRecompensa(luffy, baroqueWorks, 70000000).
impactoEnRecompensa(luffy, eniesLobby, 200000000).
impactoEnRecompensa(luffy, marineford, 100000000).
impactoEnRecompensa(luffy, dressrosa, 100000000).

impactoEnRecompensa(zoro, baroqueWorks, 60000000).
impactoEnRecompensa(zoro, eniesLobby, 60000000).
impactoEnRecompensa(zoro, dressrosa, 200000000).

impactoEnRecompensa(nami, eniesLobby, 16000000).
impactoEnRecompensa(nami, dressrosa, 50000000).

impactoEnRecompensa(ussop, eniesLobby, 30000000).
impactoEnRecompensa(ussop, dressrosa, 170000000).

impactoEnRecompensa(sanji, eniesLobby, 77000000).
impactoEnRecompensa(sanji, dressrosa, 100000000).

impactoEnRecompensa(chopper, eniesLobby, 50).
impactoEnRecompensa(chopper, dressrosa, 100).

impactoEnRecompensa(law, sabaody, 200000000).
impactoEnRecompensa(law, descorazonamientoMasivo, 240000000).
impactoEnRecompensa(law, dressrosa, 60000000).

impactoEnRecompensa(bepo,sabaody,500).

impactoEnRecompensa(arlong, llegadaAEastBlue, 20000000).
impactoEnRecompensa(hatchan, llegadaAEastBlue, 3000).


%1

participaronVarios(Tripulacion1, Tripulacion2, Evento):-
    participoDeEvento(Tripulacion2,Evento),
    participoDeEvento(Tripulacion2,Evento),
    Tripulacion1 \= Tripulacion2.

participoDeEvento(Tripulacion,Evento):-
    tripulante(Pirata, Tripulacion),
    impactoEnRecompensa(Pirata, Evento,_).

%2

seDestaco(Pirata, Evento):-
    impactoEnRecompensa(Pirata, Evento, Monto),
    forall((impactoEnRecompensa(OtroPirata, Evento, OtroMonto), OtroPirata\= Pirata), Monto > OtroMonto).

%3

pasoDesapercibido(Pirata, Evento):-
    tripulante(Pirata,Tripulacion),
    participoDeEvento(Tripulacion, Evento),
    not(impactoEnRecompensa(Pirata,Evento,_)).

%4
recompenzaTotal(Tripulacion, MontoTotal):-
    tripulante(_,Tripulacion),
    findall(Monto,(tripulante(Pirata,Tripulacion),recompenzaActual(Pirata,Monto)),Montos),
    sumlist(Montos,MontoTotal).

recompenzaActual(Pirata,Monto):-
    tripulante(Pirata,_),
    findall(Recompenza,impactoEnRecompensa(Pirata,_,Recompenza),Recompenzas),
    sumlist(Recompenzas,Monto).

%Version mas simple

recompenzaTotalV2(Tripulacion, MontoTotal):-
    tripulante(_,Tripulacion),
    findall(Monto,(tripulante(Pirata,Tripulacion),impactoEnRecompensa(Pirata,_,Monto)),Montos),
    sumlist(Montos,MontoTotal).

%5
esTemible(Tripulacion):-
    recompenzaTotal(Tripulacion,Monto),
    Monto > 500000000.
esTemible(Tripulacion):-
    tripulante(_,Tripulacion),
    forall(tripulante(Pirata,Tripulacion),esPeligroso(Pirata)).


esPeligroso(Pirata):-
    recompenzaActual(Pirata, Monto),
    Monto > 100000000.  

%6
come(luffy,paramecia(gomugomu, noPeligrosa)).
come(buggy,paramecia(barabara, noPeligrosa)).
come(law,paramecia(opeope, peligrosa)).
come(choper,zoan(hitohito, humano)).
come(lucci,zoan(nekoneko, leopardo)).
come(smoker, logia(mokumoku, humo)).


esPeligroso(Pirata),
    come(Pirata,Fruta),
    frutaPeligrosa(Fruta).

frutaPeligrosa(paramecia(_,peligrosa)).
frutaPeligrosa(zoan(_,Especie)):-
    especiePeligrosa(Especie).
frutaPeligrosa(logia(_,_)).

especiePeligrosa(lobo).
especiePeligrosa(leopardo).
especiePeligrosa(anaconda).

%7
esDeAsfalto(Tripulacion):-
    tripulante(_,Tripulacion),
    forall(tripulante(Pirata,Tripulacion), noNada(Pirata)).

noNada(Pirata):-
    come(Pirata, Fruta),
    frutaPeligrosa(Fruta).







