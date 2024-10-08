:- module(tdaline__solararce, [lineSections/2,getPath/4,getPathAux/5,lineUniqueIds/1]).
:- use_module("TDASection__SolarArce").
:- use_module("TDAStation__SolarArce").

/*
Descripcion: getter sections de un line
Dominio: Line (línea)
Predicado: lineSections(Line, Sections)
Meta Primaria: lineSections/2
Clausulas:
*/
lineSections(line(_,_,_,Sections), Sections).

/*
Descripcion: funcion wrapper para obtener el camino entre 2 sections
Dominio: Sections (lista de secciones), Station1Name (string), Station2Name (string), Path (lista)
Predicado: getPath(Sections, Station1Name, Station2Name, Path)
Meta Primaria: getPath/4
Meta Secundaria: getPathAux/5
Clausulas:
*/
getPath(Sections, Station1Name, Station2Name, Path) :-
 getPathAux(Sections, Station1Name, Station2Name, [], Path).

/*
Descripcion: va revisando si estan conectados y va agregando
Dominio: Sections (lista de secciones), Station1Name (string), Station2Name (string), Acc (lista), Path (lista)
Predicado: getPathAux(Sections, Station1Name, Station2Name, Acc, Path)
Meta Primaria: getPathAux/5
Meta Secundaria: sectionPoint1/2, sectionPoint2/2, stationName/2, reverse/2
Clausulas:
*/
getPathAux([], _, _, _, []).
getPathAux([Section|Rest], Station1Name, Station2Name, Acc, Path) :-
 sectionPoint1(Section, Point1),
 sectionPoint2(Section, Point2),
 (
   (stationName(Point1, Station1Name), getPathAux(Rest, Station1Name, Station2Name, [Section|Acc], Path));
   (stationName(Point2, Station2Name), reverse([Section|Acc], Path));
   (getPathAux(Rest, Station1Name, Station2Name, [Section|Acc], Path))
 ).

/*
Descripcion: verifica que los ID sean todos unicos
Dominio: Line (línea)
Predicado: lineUniqueIds(Line)
Meta Primaria: lineUniqueIds/1
Meta Secundaria: lineSections/2, sectionIds/2
Clausulas:
*/
lineUniqueIds(Line) :-
 lineSections(Line, Sections),
 sectionIds(Sections, []).
