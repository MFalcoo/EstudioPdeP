creeEn(gabriel,campanita).
creeEn(gabriel,magoDeOz).
creeEn(gabriel,cavenaghi).
creeEn(juan,conejoPascua).
creeEn(macarena,reyesMagos).
creeEn(macarena,magoCapria).
creeEn(macarena,campanita).

suenio(gabriel, ganarLoteria([5,9])).
suenio(gabriel, futbolista(arsenal)).
suenio(juan, cantante(100000)).
suenio(macarena, cantante(10000)).

%2
ambisiosa(Persona):-
    creeEn(Persona,_),
    findall(Dificultad,dificultadSuenio(Persona,Dificultad),Dificultades).
    sumlist(Dificultades, Total),
    Total > 20.

dificultadSuenio(Persona,Dificultad):-
    suenio(Persona,TipoDeSuenio),
    tipoSuenio(Persona,TipoDeSuenio,Dificultad).


tipoSuenio(Persona,cantante(Discos),6):-
    Discos > 500000.
tipoSuenio(Persona,cantante(Discos),4):-
    Discos =< 500000.
tipoSuenio(Persona,ganarLoteria(Numeros),Dificultad):-
    length(Numeros, Cantidad),
    Dificultad is Cantidad * 10.
tipoSuenio(Persona,futbolista(Equipo),Dificultad):-
    equipo(Equipo,Dificultad).

equipo(Equipo,3):-
    chico(Equipo).
equipo(Equipo,16):-
    not(chico(Equipo)).

chico(arsenal).
chico(aldosivi).

%3
tieneQuimica(Persona,Personaje):-
    creeEn(Persona,Personaje),
    condicionesPorPersonaje(Persona,Personaje).

condicionesPorPersonaje(Persona,campanita):-
    dificultadSuenio(Persona,Dificultad),
    Dificultad < 5.
condicionesPorPersonaje(Persona,Personaje):-
    Personaje \= campanita,
    forall(suenio(Persona,Tipo),esPuro(Tipo)),
    not(ambisiosa(Persona)).


esPuro(futbolista(_)).
esPuro(cantante(Nro)):-
    Nro < 200000.

%4
esAmigo(campanita,reyesMagos).
esAmigo(campanita,conejoPascua).
esAmigo(conejoPascua,cavenaghi).

alegra(Personaje,Persona):-
    suenio(Persona,_),
    tieneQuimica(Persona,Personaje),
    algunAmigoSinEnfermar(Personaje).

algunAmigoSinEnfermar(Personaje):-
    not(estaEnfermo(Personaje)).
algunAmigoSinEnfermar(Personaje):-
    esAmigo(Personaje,OtroPersonaje),
    algunAmigoSinEnfermar(OtroPersonaje).

estaEnfermo(reyesMagos).
estaEnfermo(conejoPascua).
estaEnfermo(campanita).





