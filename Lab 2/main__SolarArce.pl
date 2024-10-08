:- use_module("TDADriver__SolarArce").
:- use_module("TDALine__SolarArce").
:- use_module("TDAPcar__SolarArce").
:- use_module("TDASection__SolarArce").
:- use_module("TDAStation__SolarArce").
:- use_module("TDATrain__SolarArce").
:- use_module("TDASubway__SolarArce").

/*
Descripcion: Constructor de station.
Dominio: Id (entero), Name (string), Type (atomo), StopTime (entero positivo)
Predicado: station(Id, Name, Type, StopTime, station(Id, Name, Type, StopTime))
Meta Primaria: station/5
Meta Secundaria: number/1, string/1, member/2
Clausulas:
*/
station(Id, Name, Type, StopTime, station(Id, Name, Type, StopTime)) :-
  number(Id),
  string(Name),
  member(Type, [r, m, c, t,"r","m","c","t"]),
  number(StopTime), StopTime > 0.

/*
RF3
Descripcion: constructor section.
Dominio: Point1 (estacion), Point2 (estacion), Distance (entero positivo), Cost (entero no negativo)
Predicado: section(Point1, Point2, Distance, Cost, section(Point1, Point2, Distance, Cost))
Meta Primaria: section/5
Meta Secundaria: station/5, number/1
Clausulas:
*/
section(Point1, Point2, Distance, Cost, section(Point1, Point2, Distance, Cost)) :-
  station(_, _,_ , _, Point1),
  station(_, _,_ , _, Point2),
  number(Distance), Distance > 0,
  number(Cost), Cost >= 0.

/*
RF4
Descripcion: Predicado para representar una linea de transporte.
Dominio: Id (entero), Name (string), RailType (string), Sections (lista)
Predicado: line(Id, Name, RailType, Sections, line(Id, Name, RailType, Sections))  
Meta Primaria: line/5
Meta Secundaria: number/1, string/1, is_list/1
Clausulas:
*/
line(Id, Name, RailType, Sections, line(Id, Name, RailType, Sections)) :-
  number(Id),
  string(Name),
  string(RailType),
  is_list(Sections).

/*
RF5
Descripcion: Obtiene el largo, distancia y costo total en funcion de las sections que tiene el line
Dominio: Line (linea), Length (entero), Distance (entero), Cost (entero)
Predicado: lineLength(Line, Length, Distance, Cost)
Meta Primaria: lineLength/4 
Meta Secundaria: lineSections/2, length/2, foldl/4
Clausulas:
*/
lineLength(Line, Length, Distance, Cost) :-
  lineSections(Line, Sections),
  length(Sections, Length),
  foldl(sectionDistance, Sections, 0, Distance),
  foldl(sectionCost, Sections, 0, Cost).

/*
RF6
Descripcion: Misma idea, obtiene distancia y costo, pero de un tramo de todas las sections, get_path da el camino y se trata como lista de sections
Dominio: Line (linea), Station1Name (string), Station2Name (string), Path (lista), Distance (entero), Cost (entero)
Predicado: lineSectionLength(Line, Station1Name, Station2Name, Path, Distance, Cost)
Meta Primaria: lineSectionLength/6
Meta Secundaria: lineSections/2, getPath/4, reverse/2, foldl/4  
Clausulas:
*/
lineSectionLength(Line, Station1Name, Station2Name, Path, Distance, Cost) :-
  lineSections(Line, Sections),
  (   
      getPath(Sections, Station1Name, Station2Name, Path);
      getPath(Sections, Station2Name, Station1Name, ReversePath),
      reverse(ReversePath, Path)
  ),
  foldl(sectionDistance, Path, 0, Distance),
  foldl(sectionCost, Path, 0, Cost).

/*  
RF7
Descripcion: Agrega una lista de sections a la linea, retorna una nueva linea
Dominio: Line (linea), Section (seccion), NewLine (linea)
Predicado: lineAddSection(Line, Section, NewLine)
Meta Primaria: lineAddSection/3
Meta Secundaria: member/2, append/3
Clausulas: 
*/
lineAddSection(line(Id, Name, RailType, Sections), Section, line(Id, Name, RailType, NewSections)) :-
  \+ member(Section, Sections),
  append(Sections, [Section], NewSections).

/*
RF8
Descripcion: verifica que sea line, en funcion de su construccion y cantidad de sections, ademas de comprobar que exista un camino entre la estacion inicial y final.
Dominio: Line (linea)
Predicado: isLine(Line)
Meta Primaria: isLine/1
Meta Secundaria: lineSections/2, length/2, sectionPoint1/2, sectionPoint2/2, stationName/2, reverse/2, getPath/4
Clausulas:
*/
isLine(Line) :-
  lineSections(Line, Sections),
  length(Sections, Length),
  Length > 0,
  Sections = [FirstSection|_],
  sectionPoint1(FirstSection, StartStation),
  stationName(StartStation, StartStationName),
  reverse(Sections, [LastSection|_]),
  sectionPoint2(LastSection, EndStation),
  stationName(EndStation, EndStationName),
  getPath(Sections, StartStationName, EndStationName, _).

/*
RF9
Descripcion: construcor de pcar 
Dominio: Id (entero), Capacity (entero positivo), Model (string), Type (atomo)
Predicado: pcar(Id, Capacity, Model, Type, pcar(Id, Capacity, Model, Type))
Meta Primaria: pcar/5  
Meta Secundaria: number/1, string/1, member/2
Clausulas:
*/
pcar(Id, Capacity, Model, Type, pcar(Id, Capacity, Model, Type)) :-
  number(Id),
  number(Capacity), Capacity > 0,
  string(Model),  
  member(Type, [ct,tr,"ct","tr"]).

/*  
RF10
Descripcion: constructor de train
Dominio: Id (entero), Maker (string), RailType (string), Speed (entero positivo), Pcars (lista)
Predicado: train(Id,Maker,RailType,Speed,Pcars,train(Id,Maker,RailType,Speed,Pcars))
Meta Primaria: train/6
Meta Secundaria: number/1, string/1, is_list/1, validPcars/1  
Clausulas:
*/
train(Id,Maker,RailType,Speed,Pcars,train(Id,Maker,RailType,Speed,Pcars)) :-
  number(Id),
  string(Maker),
  string(RailType),
  number(Speed), Speed > 0,
  is_list(Pcars),
  validPcars(Pcars).  

/*
RF11
Descripcion: Agrega una lista de pcars, dada una posicion nth0 lo agrega, no revisa si es valido como train
Dominio: Train (tren), Pcar (coche pasajeros), Position (entero no negativo), NewTrain (tren)
Predicado: trainAddCar(Train, Pcar, Position, NewTrain) 
Meta Primaria: trainAddCar/4
Meta Secundaria: number/1, length/2, member/2, nth0/4  
Clausulas:
*/
trainAddCar(train(Id,Maker,RailType,Speed,OldPcars), Pcar, Position, train(Id,Maker,RailType,Speed,NewPcars)) :-
  number(Position), Position >= 0,
  length(OldPcars, Length),
  Position =< Length,
  \+ member(Pcar,OldPcars), 
  nth0(Position, NewPcars, Pcar, OldPcars).

/*
RF12
Descripcion: Misma idea que add, pero nth0 deja _ en vez de pcar nuevo
Dominio: Train (tren), Position (entero no negativo), NewTrain (tren)  
Predicado: trainRemoveCar(Train, Position, NewTrain)
Meta Primaria: trainRemoveCar/3
Meta Secundaria: number/1, length/2, nth0/4
Clausulas:  
*/
trainRemoveCar(train(Id, Maker, RailType, Speed, OldPcars), Position, train(Id, Maker, RailType, Speed, NewPcars)) :-
  number(Position), Position >= 0,
  length(OldPcars, Length),
  Position < Length,  
  nth0(Position, OldPcars, _, NewPcars).

/*
RF13
Descripcion: Verifica que sea train valido, validando que los carros tengan correcta distribucion y que sean del mismo tipo
Dominio: Train (tren)
Predicado: isTrain(Train)
Meta Primaria: isTrain/1 
Meta Secundaria: trainPcars/2, validPcars/1
Clausulas:
*/ 
isTrain(Train) :-
  trainPcars(Train, Pcars),
  validPcars(Pcars).

/*
RF14
Descripcion: Dado un train, encuentra la capacidad total de los carros del train
Dominio: Train (tren), Capacity (entero)
Predicado: trainCapacity(Train, Capacity)
Meta Primaria: trainCapacity/2
Meta Secundaria: trainPcars/2, foldl/4, pcarsCapacity/3  
Clausulas: 
*/
trainCapacity(Train, Capacity) :-  
	trainPcars(Train, Pcars),
	foldl(pcarsCapacity, Pcars, 0, Capacity).

/*
RF15
Descripcion: constructor de driver
Dominio: Id (entero), Name (string), TrainMaker (string)
Predicado: driver(Id,Name,TrainMaker,driver(Id,Name,TrainMaker)) 
Meta Primaria: driver/4
Meta Secundaria: number/1, string/1
Clausulas:
*/
driver(Id,Name,TrainMaker,driver(Id,Name,TrainMaker)):-
  number(Id),
  string(Name),  
  string(TrainMaker).

/*
RF16
Descripcion: constructor de subway, se ponen las 3 listas vacias ya que son las otras 3 cosas que faltan
Dominio: Id (entero), Name (string)
Predicado: subway(Id,Name,subway(Id, Name, [], [], []))
Meta Primaria: subway/3 
Meta Secundaria: number/1, string/1
Clausulas:
*/
subway(Id,Name,subway(Id, Name, [], [], [])):-
  number(Id),
  string(Name).

/*
RF17
Descripcion: Agrega trenes a los que ya estaban, se verifica con addUnique que no este antes
Dominio: Subway (metro), NewTrains (lista), UpdatedSubway (metro)
Predicado: subwayAddTrain(Subway, NewTrains, UpdatedSubway) 
Meta Primaria: subwayAddTrain/3
Meta Secundaria: addUnique/3
Clausulas:
*/
subwayAddTrain(subway(Id,Name,Trains,Lines,Drivers), NewTrains, subway(Id,Name,UnionTrains,Lines,Drivers)) :-
  addUnique(Trains, NewTrains, UnionTrains).

/*  
RF18
Descripcion: Misma idea, mismo procedimiento pero ahora agrega lineas
Dominio: Subway (metro), NewLines (lista), UpdatedSubway (metro)  
Predicado: subwayAddLine(Subway, NewLines, UpdatedSubway)
Meta Primaria: subwayAddLine/3  
Meta Secundaria: addUnique/3
Clausulas:
*/
subwayAddLine(subway(Id,Name,Trains,Lines,Drivers), NewLines, subway(Id,Name,Trains,UnionLines,Drivers)) :-
  addUnique(Lines, NewLines, UnionLines).

/*
RF19
Descripcion: Misma idea, mismo procedimiento pero ahora agrega Drivers 
Dominio: Subway (metro), NewDrivers (lista), UpdatedSubway (metro)
Predicado: subwayAddDriver(Subway, NewDrivers, UpdatedSubway)
Meta Primaria: subwayAddDriver/3
Meta Secundaria: addUnique/3  
Clausulas:
*/
subwayAddDriver(subway(Id,Name,Trains,Lines,Drivers), NewDrivers, subway(Id,Name,Trains,Lines,UnionDrivers)) :-
  addUnique(Drivers, NewDrivers, UnionDrivers).

/*
RF20
Descripcion: Pasa todo el subway a un string, format pasa todo a atom(String) y deja todo como string
Dominio: Subway (metro), String (string)
Predicado: subwayToString(Subway, String)
Meta Primaria: subwayToString/2
Meta Secundaria: format/3
Clausulas:
*/  
subwayToString(subway(Id, Name, Trains, Lines, Drivers), String) :-
  format(atom(String), "Subway(~d, ~w, Trains: ~w, Lines: ~w, Drivers: ~w)", [Id, Name, Trains, Lines, Drivers]).
