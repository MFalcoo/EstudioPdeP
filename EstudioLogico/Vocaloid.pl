%cantante(Nombre,Cancion).
cantante(megurineLuka,nightFever,4).
cantante(megurineLuka,foreverYoung,5).
cantante(hatsuneMiku,tellYourWorld,4).
cantante(gumi,tellYourWorld,5).
cantante(gumi,foreverYoung,4).
cantante(seeU,novemberRain,6).
cantante(seeU,nightFever,5).





esNovedoso(Cantante):-
    cantante(Cantante,Cancion,_),
    cantante(Cantante,OtraCancion,_),
    Cancion \= OtraCancion,
    enTotalMenosDe15(Cantante).

enTotalMenosDe15(Cantante):-
    findall(Duracion,cantante(Cantante,_,Duracion),Duraciones),
    sumlist(Duraciones, Total),
    Total < 15.

noCantaLargas(Cantante):-
    cantante(Cantante,_,_),
    forall(cantante(Cantante,Cancion,Duracion),Duracion =< 4).








