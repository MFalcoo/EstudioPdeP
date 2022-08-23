% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
prisionero(piper, narcotrafico([metanfetaminas])).
prisionero(alex, narcotrafico([heroina])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(erik, robo(450000)).
prisionero(suzanne, robo(250000)).
prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotrafico([heroina, opio])).
prisionero(dayanara, narcotrafico([metanfetaminas])).

%1
controla(piper, alex).
controla(bennett, dayanara).
controla(Otro, Guardia):-
    prisionero(Otro,_),
    not(controla(Otro, Guardia)).

%2

conflictoDeIntereses(Persona1,Persona2):- 
    esPresoOGuardia(Persona1),
    esPresoOGuardia(Persona2),
    not(controla(Persona1,Persona2)),
    not(controla(Persona2,Persona1)),
    controlanUnTercero(Persona1,Persona2). 

esPresoOGuardia(Persona):-
    prisionero(Persona,_).
esPresoOGuardia(Persona):-
    guardia(Persona).

controlanUnTercero(Persona1,Persona2):-
    controla(Persona1,Tercero),
    controla(Persona2,Tercero),
    Persona1 \= Persona2.

%3 
peligroso(Preso):-
    prisionero(Preso,_),
    forall(prisionero(Preso, Crimen),crimenGrave(Crimen)).

crimenGrave(homicidio(_)).
crimenGrave(narcotrafico(Drogas)):-
    length(Drogas, Cantidad),
    Cantidad >= 5.
crimenGrave(narcotrafico(Drogas)):-
    member(metanfetaminas,Drogas).
    

%4
ladronDeGuanteBlanco(Preso):-
    prisionero(Preso,_),
    forall(prisionero(Preso,Crimen),(cometioRobosCaros(Crimen))).

cometioRobosCaros(robo(Cantidad)):-
    Cantidad > 100000.


%5
condena(Preso, Anios):-
    prisionero(Preso,_),
    findall(Anio,(prisionero(Preso,Crimen),delitos(Crimen,Anio)),Condena),
    sumlist(Condena,Anios).

delitos(robo(Monto),Anio):-
    Anio is Monto / 10000.
delitos(homicidio(Difunto),7):-
    not(guardia(Difunto)).
delitos(homicidio(Guardia),9):-
    guardia(Guardia).
delitos(narcotrafico(Drogas),Anio):-
    length(Drogas, Anio).

%6
capoDiTutiLiCapi(Preso):-
    prisionero(Preso,_),
    not(controla(_,Preso)),
    forall(esPresoOGuardia(Cualquiera),controlaATodos(Preso,Cualquiera)).

controlaATodos(Preso,Cualquiera):-
    controla(Preso, Cualquiera).
controlaATodos(Preso,Cualquiera):-
    controla(Preso,Tercero),
    controlaATodos(Tercero,Cualquiera).
    



