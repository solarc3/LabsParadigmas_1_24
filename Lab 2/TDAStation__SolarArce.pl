:- module(tdastation__solararce, [stationId/2,stationName/2,stationType/2,stationStopTime/2]).


/*
Descripcion: getter de ID de una station
Dominio: Station (estación), Id (entero)
Predicado: stationId(Station, Id)
Meta Primaria: stationId/2
Clausulas:
*/
stationId(station(Id, _, _, _), Id).

/*
Descripcion: getter nombre station
Dominio: Station (estación), Name (string)
Predicado: stationName(Station, Name)
Meta Primaria: stationName/2
Clausulas:
*/
stationName(station(_, Name, _, _), Name).

/*
Descripcion: getter Type de station
Dominio: Station (estación), Type (átomo)
Predicado: stationType(Station, Type)
Meta Primaria: stationType/2
Clausulas:
*/
stationType(station(_, _, Type, _), Type).

/*
Descripcion: getter Stoptime de una station
Dominio: Station (estación), StopTime (entero)
Predicado: stationStopTime(Station, StopTime)
Meta Primaria: stationStopTime/2
Clausulas:
*/
stationStopTime(station(_, _, _, StopTime), StopTime).
