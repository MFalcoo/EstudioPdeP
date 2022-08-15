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
    festival(Festival, Bandas, Lugar),
    festival(Festival, Bandas, OtroLugar),
    Lugar \= OtroLugar.

%2
careta(Festival):-
    festival(Festival,_,_),
    not(tieneCampo(Festival)).

tieneCampo(Festival):-
    entradaVendida(Festival,campo).

%3
nacAndPop(Festival):-
    festival(Festival,Bandas,_),
    forall(member(Banda,Bandas), (banda(Banda,argentina,Popu),Popu>1000)),
    not(careta(Festival)).



%4
sobrevendido(Festival):-
    festival(Festival,_,Lugar),
    lugar(Lugar,Capacidad,_),
    totalEntradasVendidas(Festival,TotalEntradas),
    Capacidad < TotalEntradas.


totalEntradasVendidas(Festival,TotalEntradas):-
    findall(Entrada,entradaVendida(Festival,Entrada),Entradas),
    length(Entradas,NroEntradas),
    sumlist(NroEntradas,TotalEntradas).

%5
recaudacionTotal(Festival,Recaudado):-
    festival(Festival,_,Lugar),
    findall(Precio, tipoDeEntrada(Festival, Lugar, Precio), Precios),
    sumlist(Precios,Recaudado).

tipoDeEntrada(Festival,Lugar,Precio):-
    entradaVendida(Festival, campo),
    lugar(Lugar,_,Precio).
tipoDeEntrada(Festival,Lugar,Precio):-
    entradaVendida(Festival, plateaGeneral(Zona)),
    lugar(Lugar,_,Valor),
    plusZona(Lugar, Zona, Plus),
    Precio is Valor + Plus.
tipoDeEntrada(Festival,Lugar,Precio):-
    entradaVendida(Festival,plateaNumerada(Nro)),
    lugar(Lugar,_,Valor),
    valorPlateaCheta(Nro,Valor,Precio).

valorPlateaCheta(Nro,Valor,Precio):-
    Nro > 10,
    Precio is Valor * 3.
valorPlateaCheta(Nro,Valor,Precio):-
    Nro =< 10,
    Precio is Valor * 6.

%6
caca(Banda1,Banda2):-
    festival(_,Bandas,_),
    member(Banda1, Bandas),
    member(Banda2, Bandas),
    Banda1 \= Banda2.

delMismoPalo(Banda1,Banda2):-
    banda(Banda1,_,_),
    banda(Banda2,_,_),
    caca(Banda1, Banda2).

delMismoPalo(Banda1, Banda2):-
    caca(Banda1,TercerBanda),
    banda(TercerBanda,_,Popu1),
    banda(Banda1,_,Popu2),
    Popu1 > Popu2,
    delMismoPalo(TercerBanda,Banda2).


    

