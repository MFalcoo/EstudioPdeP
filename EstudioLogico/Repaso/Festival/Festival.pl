% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipodromoSanIsidro).

% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipodromoSanIsidro, 85000, 3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival 
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes: 
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
plusZona(hipodromoSanIsidro, zona1, 1500).

%1
itinerante(Festival):-
    festival(Festival,Bandas,Lugar),
    festival(Festival,Bandas,OtroLugar).
    Lugar \= OtroLugar.

%2
careta(personalFest).
careta(Festival):-
    festival(Festival,_,_),
    not(entradaVendida(Festival,campo)).

%3
nacAndPop(Festival):-
    festival(Festival,Bandas,_),
    not(careta(Festival)),
    forall(member(Banda,Bandas),(banda(Banda,argentina,Popu),Popu > 1000)).

%4
sobrevendido(Festival):-
    festival(Festival,_,Lugar),
    lugar(Lugar,Capacidad,_),
    findall(Venta,entradaVendida(Festival,Venta),Ventas),
    length(Ventas, Cantidad),
    Cantidad > Capacidad.

%5
recaudaciónTotal(Festival,Recaudado):-
    festival(Festival,_,Lugar),
    lugar(Lugar,_,PrecioBase),
    findall(Precio,(entradaVendida(Festival,Tipo),precio(Lugar,Tipo,PrecioBase,Precio)),Total),
    sumlist(Total, Recaudado).
    
precio(Lugar,campo,PrecioBase,PrecioBase).
precio(Lugar,plateaGeneral(Zona),PrecioBase,Precio):-
    plusZona(Lugar,Zona,PrecioVip),
    Precio is PrecioBase + PrecioVip.
precio(Lugar,plateaNumerada(Nro),PrecioBase,Precio):-
    filaMenor10(Nro).
    Precio is PrecioBase * 3.
precio(Lugar,plateaNumerada(Nro),PrecioBase,Precio):-
    not(filaMenor10(Nro)),
    Precio is PrecioBase * 6.

filaMenor10(Nro):-
    Nro > 10.

%6
delMismoPalo(Banda,OtraBanda):-
    banda(Banda,_,_),
    banda(OtraBanda,_,_),
    tocoCon(Banda,OtraBanda).
delMismoPalo(Banda,OtraBanda):-
    banda(Banda,_,Popu),
    banda(Tercera,_,Popu2),
    Popu2>Popu,
    tocoCon(Banda,Tercera),
    delMismoPalo(Tercera,OtraBanda).

tocoCon(Banda,OtraBanda):-
    festival(_,Bandas,_),
    member(Banda, Bandas),
    member(OtraBanda, Bandas).


    



