:- dynamic venta/3, nth/3.
atiende(dodain,lunes,9,15).
atiende(dodain,miercoles,9,15).
atiende(dodain,viernes,9,15).
atiende(lucas,martes,10,20).
atiende(juanC,sabado,18,22).
atiende(juanC,domingo,18,22).
atiende(juanFds,jueves,10,20).
atiende(juanFds,viernes,12,20).
atiende(leoC,lunes,14,18).
atiende(leoC,miercoles,14,18).
atiende(martu,miercoles,23,24).
atiende(vale,Dia,HoraInicio,HoraFinal):- atiende(dodain,Dia,HoraInicio,HoraFinal).
atiende(vale,Dia,HoraInicio,HoraFinal):- atiende(juanC,Dia,HoraInicio,HoraFinal).


%2
quienAtiende(Dia,Hora,Persona):-
    atiendeAesaHora(Persona,Dia,Hora).

atiendeAesaHora(Persona,Dia,Hora):-
    atiende(Persona,Dia,Inicio,Fin),
    between(Inicio, Fin, Hora).
    
%3
foreverAlone(Persona,Dia,Hora):-
    atiendeAesaHora(Persona,Dia,Hora),
    not((atiendeAesaHora(Otro,Dia,Hora),Otro \= Persona)).

%4


%5
ventas(dodain,lunes(10),[golosinas(1200),golosinas(50),cigarrillos([hockey])]).
ventas(dodain,miercoles(12),[bebidas(alcoholicas,8),golosinas(10),bebidas(noAlcoholicas,1)]).
ventas(martu,miercoles(12),[golosinas(1000),cigarrillos([chesterfild,colorado,parisien])]).
ventas(lucas,martes(11),[golosinas(600)]).
ventas(lucas,martes(18),[cigarrillos([derby,asd,asd]),bebidas(noAlcoholicas,2)]).

esSuertuda(Persona):-
    ventas(Persona,_,_),
    forall(ventas(Persona,_,[Primera|_]),fueImportante(Primera)).

fueImportante(golosinas(Precio)):-
    Precio > 100.
fueImportante(cigarrillos(Marcas)):-
    length(Marcas, Cantidad),
    Cantidad > 2.
fueImportante(bebidas(alcoholicas,_)).
fueImportante(bebidas(noAlcoholicas,Cantidad)):-
    Cantidad > 5.

    









