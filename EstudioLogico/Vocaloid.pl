%cantante(Nombre,Cancion).
cantante(megurineLuka,nightFever,4).
cantante(megurineLuka,foreverYoung,5).
cantante(hatsuneMiku,tellYourWorld,4).
cantante(gumi,tellYourWorld,5).
cantante(gumi,foreverYoung,4).
cantante(seeU,novemberRain,6).
cantante(seeU,nightFever,5).




%1
esNovedoso(Cantante):-
    cantante(Cantante,Cancion,_),
    cantante(Cantante,OtraCancion,_),
    Cancion \= OtraCancion,
    enTotalMenosDe15(Cantante).

enTotalMenosDe15(Cantante):-
    findall(Duracion,cantante(Cantante,_,Duracion),Duraciones),
    sumlist(Duraciones, Total),
    Total < 15.

%2
noCantaLargas(Cantante):-
    cantante(Cantante,_,_),
    forall(cantante(Cantante,_,Duracion),Duracion =< 4).



concierto(mikuExpo,eeuu,gigante(2,6),2000).
concierto(magicalMirai,japon,gigante(3,10),3000).
concierto(vocalekt,eeuu,mediano(9),1000).
concierto(mikuFest,argentina,pequenio(4),100).

%2
puedeParticipar(hatsuneMiku,Concierto):- concierto(Concierto,_,_,_).
puedeParticipar(Cantante,Concierto):-
    cantante(Cantante,_,_),
    concierto(Concierto,_,Condiciones,_),
    cumpleCondiciones(Cantante,Condiciones).

cumpleCondiciones(Cantante,gigante(MinimoCanciones,TiempoMinimo)):-
    cancionesTotales(Cantante,Canciones),
    tiempoTotal(Cantante,Tiempo),
    Canciones > MinimoCanciones,
    Tiempo >= TiempoMinimo.
cumpleCondiciones(Cantante,mediano(TiempoMaximo)):-
    tiempoTotal(Cantante,Tiempo),
    Tiempo =< TiempoMaximo.
cumpleCondiciones(Cantante,pequenio(DureMas)):-
    cantante(Cantante,_,Duracion),
    Duracion > DureMas.

cancionesTotales(Cantante,Canciones):-
    findall(Cancion,cantante(Cantante,Cancion,_),NroCanciones),
    length(NroCanciones,Canciones).

tiempoTotal(Cantante,Tiempo):-
    findall(Minutos, cantante(Cantante,_,Minutos),CantTiempo),
    sumlist(CantTiempo,Tiempo).
    
%3
masFamoso(Cantante):-
    sumaFama(Cantante,MayorFama),
    forall(sumaFama(_,Fama), MayorFama >= Fama).

sumaFama(Cantante,NivelFama):-
    famaTotal(Cantante,CantidadFama),
    cancionesTotales(Cantante,Canciones),
    NivelFama is CantidadFama * Canciones.

famaTotal(Cantante,CantidadFama):-
    cantante(Cantante,_,_),
    findall(Fama,(puedeParticipar(Cantante,Concierto),concierto(Concierto,_,_,Fama)),Famosidad),
    list_to_set(Famosidad, FamosidadSinRepes),
    sumlist(FamosidadSinRepes,CantidadFama).

%4

conocidos(megurineLuka,hatsuneMiku).
conocidos(megurineLuka,gumi).
conocidos(gumi,seeU).
conocidos(seeU,kaito).

esElUnico(Cantante):-
    puedeParticipar(Cantante,Concierto),
    not((algoConocido(Otro,Cantante),puedeParticipar(Otro,Concierto))).

algoConocido(Otro,Cantante):-
    conocidos(Otro,Cantante).
algoConocido(Otro,Cantante):-
    conocidos(Otro,Tercero),
    algoConocido(Tercero,Cantante).


%5

