:- dynamic abs/1.
% …jugador(Nombre, Rating, Civilizacion).
jugador(juli, 2200, jemeres).
jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos). 

% …tiene(Nombre, QueTiene).
tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, edificio(castillo, 1)).
tiene(juan, edificio(casa, 1)).
tiene(juan, unidad(alquimista, 10)).

% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0, 60, 20), infanteria).
militar(arquero, costo(25, 0, 45), arqueria).
militar(mangudai, costo(55, 0, 65), caballeria).
militar(samurai, costo(0, 60, 30), unica).
militar(keshik, costo(0, 80, 50), unica).
militar(tarcanos, costo(0, 60, 60), unica).
militar(alabardero, costo(25, 35, 0), piquero). 

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23, 0, 0)).
aldeano(granjero, produce(0, 32, 0)).
aldeano(minero, produce(0, 0, 23)).
aldeano(cazador, produce(0, 25, 0)).
aldeano(pescador, produce(0, 23, 0)).
aldeano(alquimista, produce(10000, 100000, 25000)). 

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)). 

%1
esUnAfano(Jugador,OtroJugador):-
    jugador(Jugador,Rating,_),
    jugador(OtroJugador,OtroRating,_),
    Valor is Rating - OtroRating,
    abs(Valor, Absoluto),
    Absoluto > 500.

%2
esEfectivo(samurai,Unico):-
    militar(Unico,_,unico).
esEfectivo(Unidad,OtraUnidad):-
  militar(Unidad,_,Categoria),
  militar(OtraUnidad,_,OtraCategoria),
  leGana(Categoria,OtraCategoria).

leGana(caballeria,arqueria).
leGana(arqueria,infanteria).
leGana(infanteria,piquero).
leGana(piquero,caballeria).

%3
alarico(Jugador):-
    esJugador(Jugador),
    soloEsaUnidad(Jugador,infanteria).

esJugador(Jugador):-
    jugador(Jugador,_,_).
%4
leonidas(Jugador):-
    esJugador(Jugador),
    soloEsaUnidad(Jugador,piquero).

soloEsaUnidad(Jugador,Categoria):-
    forall(tiene(Jugador,unidad(Unidad,_)),militar(Unidad,_,Categoria)).

%5
nomada(Jugador):-
    esJugador(Jugador),
    not(tieneEdificio(Jugador,casa)).

tieneEdificio(Jugador,Edificio):-
    tiene(Jugador,edificio(Edificio,_)).

%6
cuantoCuesta(Elemento,Costo):-
    esUnidadOEdificio(Elemento),
    precio(Elemento,Costo).

esUnidadOEdificio(Elemento):-
    tiene(_,unidad(Elemento,_)).
esUnidadOEdificio(Elemento):-
    tiene(_,edificio(Elemento,_)).

precio(Elemento,costo(0,50,0)):-
    aldeano(Elemento,_).
precio(Elemento,Costo):-
    edificio(Elemento,Costo).
precio(Elemento,Costo):-
    militar(Elemento,Costo,_).
precio(Elemento,costo(100,0,50)):-
    carretaOUrna(Elemento).

carretaOUrna(carreta).
carretaOUrna(urna).




%7

produccion(Unidad,produce(0,0,32)):-
    carretaOUrna(Unidad).
produccion(keshik,produce(0,0,10)).
produccion(Unidad,ProduccionPorMinuto):-
    aldeano(Unidad,ProduccionPorMinuto).

%8
produccionTotal(Jugador,ProduccionPorMinutoTotal,Recurso):-
    tiene(Jugador,_),
    recursos(Recurso),
    findall(Produce,encontrarRecursos(Jugador,Recurso,Produce),Produccion),
    sumlist(Produccion,ProduccionPorMinutoTotal).

encontrarRecursos(Jugador,Recurso,Produce):-
    tiene(Jugador,unidad(Unidad,_)),
    produccion(Unidad,Costo),
    recurso(Costo,Recurso,Produce).

recurso(produce(_,_,Produce),oro,Produce).
recurso(produce(Produce,_,_),madera,Produce).
recurso(produce(_,Produce,_),alimento,Produce).

recursos(oro).
recursos(madera).
recursos(alimento).


%9
estaPeleado(Jugador,OtroJugador):-
    esJugador(Jugador),
    esJugador(OtroJugador),
    cantidadUnidades(Jugador,Cantidad),
    cantidadUnidades(OtroJugador,Cantidad),
    noSeLlevanTanto(Jugador,OtroJugador),
    not(esUnAfano(Jugador,OtroJugador)).

noSeLlevanTanto(Jugador,OtroJugador):-
    todaSuProduccion(Jugador,Produccion),
    todaSuProduccion(OtroJugador,OtraProduccion),
    Valor is Produccion - OtraProduccion,
    abs(Valor, Absoluto),
    Absoluto < 100.

cantidadUnidades(Jugador,Cantidad):-
    findall(Unidad,tiene(Jugador,unidad(Unidad,_)),Unidades),
    length(Unidades,Cantidad).

todaSuProduccion(Jugador,Produccion):-
    produccionTotal(Jugador,ProduccionOro,oro),
    produccionTotal(Jugador,ProduccionMadera,madera),
    produccionTotal(Jugador,ProduccionAlimento,alimento),
    Produccion is (ProduccionOro * 5 + ProduccionMadera * 3 + ProduccionAlimento * 2).

%10
avanzaA(Jugador,edadMedia):-
    esJugador(Jugador).
avanzaA(Jugador,feudal):-
    produccionTotal(Jugador,Produccion,alimento),
    Produccion >= 500,
    tieneEdificio(Jugador,casa).
avanzaA(Jugador,edadCastillos):-
    produccionTotal(Jugador,ProduccionAlimento,alimento),
    ProduccionAlimento >= 800,
    produccionTotal(Jugador,ProduccionOro,oro),
    ProduccionOro >= 200,
    produccionTotal(Jugador,ProduccionMadera,madera),
    ProduccionMadera >= 1000,
    tieneEdificio(Jugador,castillo),
    tieneEdificio(Jugador,universidad).






    
    




