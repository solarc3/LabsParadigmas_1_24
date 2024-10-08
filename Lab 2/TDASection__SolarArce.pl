:- module(tdasection__solararce, [sectionPoint1/2, sectionPoint2/2,sectionDistance/2,sectionCost/2,sectionCost/3,sectionDistance/3,sectionIds/2]).
:- use_module("TDAStation__SolarArce").

/*
Descripcion: getter point1 de una section, primera station
Dominio: Section (sección), Point1 (estación)
Predicado: sectionPoint1(Section, Point1)
Meta Primaria: sectionPoint1/2
Clausulas:
*/
sectionPoint1(section(Point1, _, _, _), Point1).

/*
Descripcion: getter 2da station
Dominio: Section (sección), Point2 (estación)
Predicado: sectionPoint2(Section, Point2)
Meta Primaria: sectionPoint2/2
Clausulas:
*/
sectionPoint2(section(_, Point2, _, _), Point2).

/*
Descripcion: getter distancia section
Dominio: Section (sección), Distance (entero)
Predicado: sectionDistance(Section, Distance)
Meta Primaria: sectionDistance/2
Clausulas:
*/
sectionDistance(section(_, _, Distance, _), Distance).

/*
Descripcion: getter costo section
Dominio: Section (sección), Cost (entero)
Predicado: sectionCost(Section, Cost)
Meta Primaria: sectionCost/2
Clausulas:
*/
sectionCost(section(_, _, _, Cost), Cost).


/*
Descripcion: funcion/3 para el fold, acumula la distancia
Dominio: Section (sección), Acc (entero), NewAcc (entero)
Predicado: sectionDistance(Section, Acc, NewAcc)
Meta Primaria: sectionDistance/3
Meta Secundaria: sectionDistance/2
Clausulas:
*/
sectionDistance(Section, Acc, NewAcc) :-
 sectionDistance(Section, Distance),
 NewAcc is Acc + Distance.


/*
Descripcion: misma idea, acumulador de cost
Dominio: Section (sección), Acc (entero), NewAcc (entero)
Predicado: sectionCost(Section, Acc, NewAcc)
Meta Primaria: sectionCost/3
Meta Secundaria: sectionCost/2
Clausulas:
*/
sectionCost(Section, Acc, NewAcc) :-
 sectionCost(Section, Cost),
 NewAcc is Acc + Cost.

/*
Descripcion: obtiene todos los ids dado una section
Dominio: Sections (lista de secciones), IDlist (lista de IDs)
Predicado: sectionIds(Sections, IDlist)
Meta Primaria: sectionIds/2
Meta Secundaria: sectionPoint1/2, sectionPoint2/2, stationId/2, sectionIds/2 (recursivo), append/3
Clausulas:
*/
sectionIds([], []).
sectionIds([Section|T], IDlist) :-
 sectionPoint1(Section, Point1),
 sectionPoint2(Section, Point2),
 stationId(Point1, ID1),
 stationId(Point2, ID2),
 sectionIds(T, RestIDs),
 append([ID1,ID2], RestIDs, IDlist).
