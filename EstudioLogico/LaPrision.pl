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
prisionero(suzanne, robo(250000)).
prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotrafico([heroina, opio])).
prisionero(dayanara, narcotrafico([metanfetaminas])).

%1
% controla(Controlador, Controlado)

controla(piper, alex).
controla(bennett, dayanara).
controla(Guardia, Otro):- 
    prisionero(Otro,_),
    guardia(Guardia),
    not(controla(Otro, Guardia)).

%2
conflictoDeIntereses(Persona1,Persona2):-
    controla(Persona1,Tercero),
    controla(Persona2,Tercero),
    not(controla(Persona1,Persona2)),
    not(controla(Persona2,Persona1)),
    Persona1 \= Persona2.

%3
peligroso(Preso):-
    prisionero(Preso,_),
    forall(prisionero(Preso,Crimen), cometioCrimenGrave(Crimen)).

cometioCrimenGrave(homicidio(_)).
cometioCrimenGrave(narcotrafico(Lista)):-
    problemasDeDroga(Lista).

problemasDeDroga(Lista):-
    length(Lista,Valor),
    Valor >= 5.
problemasDeDroga(Lista):-
    member(metanfetaminas, Lista).

%4
ladronDeGuanteBlanco(Preso):-
    prisionero(Preso,_),
    forall(prisioneroQueSoloRobo(Preso,_,Monto),Monto>100000).

prisioneroQueSoloRobo(Preso,robo(Monto),Monto):-
    prisionero(Preso,robo(Monto)).

%5

condena(Preso, SumaAnios):-
    prisionero(Preso,_),
    findall(Anios,calculadora(Preso,_,Anios),AniosTotal),
    sumlist(AniosTotal, SumaAnios).
    
calculadora(Preso,Crimen,Anios):-
    prisionero(Preso,Crimen),
    calculadoraAnios(Crimen,Anios).    

calculadoraAnios(robo(Cantidad),Anios):-
    Anios is Cantidad / 10000.
calculadoraAnios(homicidio(Victima),7):-
    not(guardia(Victima)).
calculadoraAnios(homicidio(Victima),9):-
    guardia(Victima).
calculadoraAnios(narcotrafico(Drogas),AniosTotal):-
    length(Drogas,Anios),
    AniosTotal is Anios * 2.

%6
capoDiTutiLiCapi(Preso):-
    prisionero(Preso,_),
    not(controla(_,Preso)),
    forall(presoOGuardia(Alguien), controladoPorEl(Preso,Alguien)).

presoOGuardia(Alguien):-
    prisionero(Alguien,_).
presoOGuardia(Alguien):-
    guardia(Alguien).

controladoPorEl(Preso,Alguien):-
    controla(Preso,Alguien).
controladoPorEl(Preso,Alguien):-            %%Recursiiivo. 
    controla(Preso, Tercero),
    controladoPorEl(Tercero, Alguien).


    



