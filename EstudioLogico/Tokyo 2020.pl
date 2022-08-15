atleta(marco,20,argentina).
atleta(pepe,27,argentina).
atleta(jorge,28,peru).
atleta(cristi,30,argentina).
atleta(lamda,30,holanda).


disciplina(voleyMasculino,marco).
disciplina(natacion100Metros,pepe).
disciplina(hockeyFemenino,cristi).
disciplina(hockeyFemenino,lamda).


medalla(plata,voleyMasculino, argentina).
medalla(plata,natacion100Metros, argentina).
medalla(bronce,natacion100Metros, argentina).
medalla(oro,natacion100Metros, argentina).


evento(hockeyFemenino, final, argentina).
evento(hockeyFemenino, final, holanda).
evento(hockeyFemenino, semifinal, bolivia).
evento(futbol, semifinal, bolivia).
evento(futbol, final, bolivia).




evento(natacion100Metros, ronda1, pepe).
evento(natacion100Metros, ronda1, jorge).






%2
vinoAPasear(Atleta):-
    atleta(Atleta,_,_),
    not(disciplina(_,Atleta)).


%3
medallasDelPais(Medalla, Disciplina, Pais):-
    medalla(Medalla, Disciplina, Pais).

%4
participoEn(Disciplina,Ronda,Atleta):-
    evento(Disciplina,Ronda,Atleta).

%5
dominio(Pais,Disciplina):-
    atleta(_,_,Pais),
    disciplina(Disciplina,_),
    forall(medalla(Medalla,Disciplina,Pais), atleta(_,_,Pais)).

%6
medallaRapida(Disciplina):-
    evento(Disciplina,Ronda,_).
    not(noEsRondaUnica(Disciplina,Ronda)).

noEsRondaUnica(Disciplina,Ronda):-
    evento(Disciplina,OtraRonda,_),
    Ronda \= OtraRonda.







