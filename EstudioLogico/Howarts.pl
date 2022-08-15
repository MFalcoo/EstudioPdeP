

mago(harry).
mago(draco).
mago(hermione).

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

odia(harry, slytherin).
odia(draco, hufflepuff).

casa(slytherin).
casa(hufflepuff).
casa(gryffindor).
casa(ravenclaw).

paraEntrarPide(slytherin, orgulloso).
paraEntrarPide(slytherin, inteligente).
paraEntrarPide(gryffindor, corajudo).
paraEntrarPide(ravenclaw, inteligente).
paraEntrarPide(ravenclaw, responsable).
paraEntrarPide(hufflepuff, amistoso).




caracteristica(harry, corajudo).
caracteristica(harry, amistoso).
caracteristica(harry, orgulloso).
caracteristica(harry, inteligente).
caracteristica(draco, orgulloso).
caracteristica(draco, inteligente).
caracteristica(hermione, orgulloso).
caracteristica(hermione, inteligente).
caracteristica(hermione, responsable).
caracteristica(hermione, amistoso).



%1

permiteEntrar(Casa,Mago):- 
    casa(Casa),   
    mago(Mago),
    Casa \= slytherin.

permiteEntrar(slytherin, Mago):-
    sangre(Mago, TipoSangre),
    TipoSangre \= impura.

%2

caracterApropiado(Casa, Mago):-
    mago(Mago),
    casa(Casa),
    forall(paraEntrarPide(Casa,Caracteristica),caracteristica(Mago, Caracteristica)).
    

%3
quedaSeleccionado(hermione,gryffindor).

quedaSeleccionado(Mago,Casa):-
    caracterApropiado(Casa,Mago),
    permiteEntrar(Casa,Mago),
    not(odia(Casa,Mago)).

noOdia(Casa,Mago):-
    mago(Mago),
    casa(Casa),
    not(odia(Mago,Casa)).

%4
cadenaDeAmistades(Magos):-
    todosAmistosos(Magos),
    cadenaDeCasas(Magos).

todosAmistosos(Magos):-
    forall(member(Mago,Magos), esAmistoso(Mago)).

esAmistoso(Mago):-
    caracteristica(Mago,amistoso).

cadenaDeCasas([Mago1, Mago2 | MagosSiguientes]):-
    quedaSeleccionado(Mago1,Casa),
    quedaSeleccionado(Mago2,Casa),
    cadenaDeCasas([Mago2 | MagosSiguientes]).

cadenaDeCasas([_]).
cadenaDeCasas([]).

    
%Parte 2

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

accion(harry,fueraDeCama).
accion(harry,fueA(bosque)).
accion(harry,fueA(tercerPiso)).
accion(harry,buenaAccion(60, ganarleAVoldemort)).
accion(hermione,fueA(tercerPiso)).
accion(hermione,fueA(biblioteca)).
accion(hermione, buenaAccion(50, salvarAmigos)).
accion(draco, fueA(mazmorras)).
accion(ron, buenaAccion(50, ganarAjegrez)).

hizoAlgunaAccion(Mago):-
    accion(Mago,_).
hizoAlgoMalo(Mago):-
    accion(Mago,Accion),
    puntajeQueGenera(Accion,Puntos),
    Puntos < 0.

puntajeQueGenera(fueraDeCama, -50).
puntajeQueGenera(fueA(Lugar), Puntos):-
    lugarProhibido(Lugar, PuntosLugar),
    Puntos is (-1) * PuntosLugar.
puntajeQueGenera(buenaAccion(Puntos,_), Puntos).

lugarProhibido(bosque, 50).
lugarProhibido(biblioteca, 10).
lugarProhibido(tercerPiso, 75).



%1
buenAlumno(Mago):-
    accion(Mago, _),
    not(hizoAlgoMalo(Mago)).

esRecurrente(Accion):-
    accion(Mago1, Accion),
    accion(Mago2, Accion),
    Mago1 \= Mago2.

%2
puntajeDeCasa(Casa,Puntaje):-
    esDe(_,Casa),
    findall(Puntos,
        (esDe(Mago,Casa), accion(Mago,Accion), puntajeQueGenera(Accion,Puntos)), ListaPuntos),
    sum_list(ListaPuntos, Puntaje).

%3
casaGanadora(Casa):-
    puntajeDeCasa(Casa,PuntajeMayor),
    forall((puntajeDeCasa(OtraCasa,PuntajeMenor),  Casa\= OtraCasa),
            PuntajeMayor > PuntajeMenor).

casaGanadora2(Casa):-
    puntajeDeCasa(Casa,PuntajeMayor),
    not((puntajeDeCasa(_, OtroPuntaje), OtroPuntaje > PuntajeMayor)).

%4

accion(hermione, respondio(20, snaze)).
accion(hermione, respondio(25, flitwick)).

puntajeQueGenera(respondio(Puntaje, snaze), PuntajeFinal):-
    PuntajeFinal is Puntaje / 2.
puntajeQueGenera(respondio(Puntaje, Profesor), Puntaje):-
    Profesor \= snaze.
