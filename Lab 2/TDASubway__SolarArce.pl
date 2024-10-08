:- module(tdasubway__solararce, [addUnique/3]).
:- use_module("TDASection__SolarArce").
:- use_module("TDAStation__SolarArce").
:- use_module("TDALine__SolarArce").


/*
Descripcion: combinacion de member y append, solo agrega si ya no existe
Dominio: OldItems (lista), NewItems (lista), Result (lista)
Predicado: addUnique(OldItems, NewItems, Result)
Meta Primaria: addUnique/3
Meta Secundaria: member/2, addUnique/3 (recursivo)
Clausulas:
*/
addUnique([], NewItems, NewItems).
addUnique([H|T], NewItems, Result) :-
 \+ member(H, NewItems),
 addUnique(T, [H|NewItems], Result).
