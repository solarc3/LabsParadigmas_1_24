:- module(tdapcar__solararce, [pcarModel/2,pcarType/2,pcarCapacity/2,validPcars/1,validPcarsCentral/2,pcarsCapacity/3]).

/*
Descripcion: getter model de un pcar
Dominio: Pcar (coche de pasajeros), Model (string)
Predicado: pcarModel(Pcar, Model)
Meta Primaria: pcarModel/2
Clausulas:
*/
pcarModel(pcar(_,_,Model,_),Model).

/*
Descripcion: getter type pcar
Dominio: Pcar (coche de pasajeros), Type (átomo)
Predicado: pcarType(Pcar, Type)
Meta Primaria: pcarType/2
Clausulas:
*/
pcarType(pcar(_,_,_,Type),Type).

/*
Descripcion: getter capacity pcar
Dominio: Pcar (coche de pasajeros), Capacity (entero)
Predicado: pcarCapacity(Pcar, Capacity)
Meta Primaria: pcarCapacity/2
Clausulas:
*/
pcarCapacity(pcar(_,Capacity,_,_),Capacity).

/*
Descripcion: verifica si la lista de pcars es valida, revisa si hay 2 y si son tr ambos o 3 pero tr en esquinas y ct al medio
Dominio: Pcars (lista de coches de pasajeros)
Predicado: validPcars(Pcars)
Meta Primaria: validPcars/1
Meta Secundaria: pcarModel/2, pcarType/2, member/2, append/3, validPcarsCentral/2
Clausulas:
*/
validPcars([]).
validPcars([Pcar1, Pcar2]) :-
 pcarModel(Pcar1, Model),
 pcarModel(Pcar2, Model),
 pcarType(Pcar1, Type1),
 pcarType(Pcar2, Type2),
 member(Type1, [tr, "tr"]),
 member(Type2, [tr, "tr"]).
validPcars([Pcar | T]) :-
 pcarType(Pcar, Type),
 member(Type, [tr, "tr"]),
 pcarModel(Pcar, Model),
 append(CentralCars, [LastPcar], T),
 validPcarsCentral(CentralCars, Model),
 pcarType(LastPcar, TypeLast),
 member(TypeLast, [tr, "tr"]).

/*
Descripcion: verifica que todos los centrales sean realmente centrales, se eliminaron los tr de la lista y quedan solo los ct
Dominio: CentralCars (lista de coches centrales), Model (string)
Predicado: validPcarsCentral(CentralCars, Model)
Meta Primaria: validPcarsCentral/2
Meta Secundaria: pcarType/2, member/2, pcarModel/2, validPcarsCentral/2 (recursivo)
Clausulas:
*/
validPcarsCentral([], _).
validPcarsCentral([Pcar | T], Model) :-
 pcarType(Pcar, Type),
 member(Type, [ct, "ct"]),
 pcarModel(Pcar, Model),
 validPcarsCentral(T, Model).

/*
Descripcion: funcion/3 acumuladora para el fold
Dominio: Pcar (coche de pasajeros), Acc (entero), NewAcc (entero)
Predicado: pcarsCapacity(Pcar, Acc, NewAcc)
Meta Primaria: pcarsCapacity/3
Meta Secundaria: pcarCapacity/2
Clausulas:
*/
pcarsCapacity(Pcar, Acc, NewAcc):-
 pcarCapacity(Pcar, Capacity),
 NewAcc is Acc + Capacity.
