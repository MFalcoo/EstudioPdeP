atiende(dodain,lunes,entre(9,15)).
atiende(dodain,miercoles,entre(9,15)).
atiende(dodain,viernes,entre(9,15)).
atiende(lucas,martes,entre(10,20)).
atiende(juanC,sabado,entre(18,22)).
atiende(juanC,domingo,entre(18,22)).
atiende(juanFds,jueves,entre(10,20)).
atiende(juanFds,viernes,entre(12,20)).
atiende(leoC,lunes,entre(14,18)).
atiende(leoC,miercoles,entre(14,18)).
atiende(martu,miercoles,entre(23,24)).
%1
atiende(vale,Dias,Horario):- atiende(dodain,Dias,Horario).
atiende(vale,Dias,Horario):- atiende(juanC,Dias,Horario).

%2
quienAtiende(Persona,Dia,Horario):-
    atiende(Persona,Dia,entre(Entra,Sale)),
    between(Entra, Sale, Horario).

%3
sola(Persona,Dia,Horario):-
    quienAtiende(Persona,Dia,Horario),
    not(comparteHorario(Persona,_,Dia,Horario)).

comparteHorario(Persona,OtraPersona,Dia,Horario):-
    quienAtiende(Persona,Dia,Horario),
    quienAtiende(OtraPersona,Dia,Horario),
    Persona \= OtraPersona.

%4
posibilidadesAtencion(Dia, Personas):-
    findall(Persona, distinct(Persona, quienAtiende(Persona, Dia, _)), PersonasPosibles),
    combinar(PersonasPosibles, Personas).
  
  combinar([], []).
  combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
  combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).

% Qué conceptos en conjunto resuelven este requerimiento
% - findall como herramienta para poder generar un conjunto de soluciones que satisfacen un predicado
% - mecanismo de backtracking de Prolog permite encontrar todas las soluciones posibles
    

%5

ventas(dodain,lunes(10),[golosinas(1200),cigarrillos([jockey]),golosinas(50)]).

ventas(dodain,miercoles(12),[bebidas(alcoholica,8),bebidas(noAlcoholica,1),golosinas(10)]).

ventas(martu,miercoles(12),[golosinas(1000),cigarrillos([chesterfield,colorado,parisienne])]).

ventas(lucas,martes(11),[golosinas(600)]).
ventas(lucas,martes(18),[bebidas(noAlcoholica,2),cigarrillos([derby])]).

suertuda(Persona):-
    ventas(Persona,_,_),
    forall(ventas(Persona,_,Ventas),(nth0(0, Ventas, PrimerVenta), primerVentaImportante(PrimerVenta))).
    %forall(ventas(Persona,_,[Venta|_]), primerVentaImportante(Venta)).     Otra Forma

primerVentaImportante(golosinas(Precio)):-
    Precio > 100.
primerVentaImportante(cigarrillos(Marcas)):-
    length(Marcas,Cantindad),
    Cantindad > 2.
primerVentaImportante(bebidas(alcoholica,_)).
primerVentaImportante(bebidas(noAlcoholica,Nro)):-
    Nro > 5.




    
    
