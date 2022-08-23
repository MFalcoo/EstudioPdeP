rata(remy, gusteaus).
rata(emile, bar).
rata(django, pizzeria).

cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).

trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner). 
trabajaEn(gusteaus, horst). 
trabajaEn(cafeDes2Moulins, amelie).

%1
inspeccionSatisfactoria(Restaurante):-
  trabajaEn(Restaurante,_),
  not(rata(_,Restaurante)).

%2
chef(Empleado,Restaurante):-
  trabajaEn(Restaurante,Empleado),
  cocina(Empleado,_,_).

%3
chefcito(Rata):-
  rata(Rata,Restaurante),
  trabajaEn(Restaurante,linguini).

%4
cocinaBien(remy,Plato):-
  cocina(_,Plato,_).

cocinaBien(Empleado,Plato):-
  cocina(Empleado,Plato,Experiencia),
  Experiencia > 7.

%5

%Con Forall
encargadoDe(Empleado,Plato,Restaurante):-
  trabajadorConExperiencia(Empleado,Plato,Resaurante,Experiencia),
  forall(trabajadorConExperiencia(Persona,Plato,Resaurante,OtraExperiencia), Experiencia > OtraExperiencia).

trabajadorConExperiencia(Persona,Plato,Resaurante,OtraExperiencia):-
trabajaEn(OtraPersona,Resaurante),
cocina(OtraPersona,Plato,OtraExperiencia).

%Con Not
encargadoDe2(Empleado,Plato,Restaurante):-
  trabajadorConExperiencia(Empleado,Plato,Restaurante,Experiencia),
  not((trabajaEn(Resaurante,OtraPersona),
  Empleado \= OtraPersona,
  alguienConMasExperiencia(Experiencia,OtraPersona,Plato))).

alguienConMasExperiencia(Experiencia,OtraPersona,Plato):-
  cocina(OtraPersona,Plato,OtraExperiencia),
  Experiencia < OtraExperiencia.

%6

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

saludable(Plato):-
  plato(Plato,Tipo),
  caloriasDelPlato(Tipo,Calorias),
  Calorias < 75.

caloriasDelPlato(entrada(Ingredientes),Calorias):-
  length(Ingredientes, Cantidad),
  Calorias is Cantidad * 15.
caloriasDelPlato(principal(Guarnicion,Minutos),Calorias):-
  caloriasDeGuarnicion(Guarnicion,CaloriasGuarnicion),
  Calorias is Minutos * 5 + CaloriasGuarnicion.
caloriasDelPlato(postre(Calorias),Calorias).

caloriasDeGuarnicion(pure,20).
caloriasDeGuarnicion(papasFritas,50).
caloriasDeGuarnicion(ensalada,0).

%7
criticaPositiva(Resaurante,Critico):-
  inspeccionSatisfactoria(Resaurante),
  buenaResenia(Resaurante,Critico).

buenaResenia(Resaurante,antonEgo):-
  forall(trabajaEn(Restaurante,Empleado),cocina(Empleado,ratatouille,_)).
buenaResenia(Resaurante,christophe):-
  findall(Chef,trabajaEn(Restaurante,Chef),Chefs),
  length(Chefs,Cantidad),
  Cantidad > 3.
buenaResenia(Resaurante,cormillot):-
  forall(paraEstosPlatos(Resaurante,Plato),saludable(Plato)),
  forall(paraEstosPlatos(Resaurante,entrada(Ingredientes)),member(zanahoria, Ingredientes)).

paraEstosPlatos(Resaurante,Plato):-
  trabajaEn(Resaurante,Empleado),
  cocina(Empleado,Plato,_).




  
-

