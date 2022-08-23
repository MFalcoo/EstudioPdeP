cantante(luka,nightFever,4).
cantante(luka,foreverYoung,5).
cantante(miku,tellYourWorld,4).
cantante(gumi,foreverYoung,4).
cantante(gumi,tellYourWorld,5).
cantante(seeU,novemberRain,6).
cantante(seeU,nightFever,5).

%1
esNovedoso(Cantante):-
    sabeMasDeUna(Cantante),
    cantaMasDe15(Cantante).

sabeMasDeUna(Cantante):-
    cantante(Cantante,Cancion,_),
    cantante(Cantante,OtraCancion,_),
    Cancion \= OtraCancion.

cantaMasDe15(Cantante):-
    tiempoQueCanta(Cantante,SumaTiempos),
    SumaTiempos < 15.

tiempoQueCanta(Cantante,SumaTiempos):-
    findall(Tiempo,cantante(Cantante,_,Tiempo),TotalTiempo),
    sumlist(TotalTiempo, SumaTiempos).

%2
esAcelerado(Cantante):-
    cantante(Cantante,_,_),
    forall(cantante(Cantante,Cancion,_),duraMasDe4(Cancion)).

duraMasDe4(Cancion):-
    cantante(_,Cancion,Dura),
    Dura =< 4.


concierto(mikuExpo,usa,gigante(2,6),2000).
concierto(magicalMirai,japon,gigante(3,10),3000).
concierto(vocalektVisions,usa,mediano(9),1000).
concierto(mikuExpo,argentina,pequenio(4),100).


%2
puedeParticipar(miku,Concierto):- concierto(Concierto,_,_,_).
puedeParticipar(Cantante,Concierto):-
    cantante(Cantante,_,_),
    concierto(Concierto,_,Requisitos,_),
    requisitosAprobados(Cantante,Requisitos).

requisitosAprobados(Cantante,gigante(MinimoCanciones,DuracionEsperada)):-
    cuantasCancionesTiene(Cantante,Canciones),
    tiempoQueCanta(Cantante,SumaTiempos),
    Canciones >= MinimoCanciones,
    SumaTiempos > DuracionEsperada.
requisitosAprobados(Cantante,mediano(DuracionEsperada)):-
    tiempoQueCanta(Cantante,SumaTiempos),
    SumaTiempos < DuracionEsperada.
requisitosAprobados(Cantante,pequenio(DureMas)):-
    cantante(Cantante,_,Duracion),
    Duracion > DureMas.

cuantasCancionesTiene(Cantante,Cuantas):-
    findall(Cancion,cantante(Cantante,Cancion,_),Canciones),
    length(Canciones, Cuantas).

%3
masFamoso(Cantante):-
    cantante(Cantante,_,_),
    sumatoriaDeFama(Cantante,TotalFama),
    forall(sumatoriaDeFama(_,Fama),TotalFama > Fama).


sumatoriaDeFama(Cantante,TotalFama):-
    findall(Fama,(puedeParticipar(Cantante,Concierto),concierto(Concierto,_,_,Fama)),TodasLasFamas),
    sumlist(TodasLasFamas,NivelFama),
    cuantasCancionesTiene(Cantante,Canciones),
    TotalFama is NivelFama * Canciones.

%4
conoce(luka,miku).
conoce(luka,gumi).
conoce(gumi,seeU).
conoce(seeU,kaito).

esElUnico(Cantante,Concierto):-
    puedeParticipar(Cantante,Concierto),
    forall(conoceDeAlgunaForma(Cantante,Otro),not(puedeParticipar(Otro,Concierto))).

conoceDeAlgunaForma(Cantante,Otro):-
    conoce(Cantante,Otro).
conoceDeAlgunaForma(Cantante,Otro):-
    conoce(Cantante,Tercero).
    conoceDeAlgunaForma(Tercero,Otro).





