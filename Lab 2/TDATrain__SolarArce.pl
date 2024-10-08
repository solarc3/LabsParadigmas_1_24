:- module(tdatrain__solararce, [trainPcars/2]).
/*
Descripcion: getter de los carros de un train
Dominio: Train (tren), Pcars (lista de carros)
Predicado: trainPcars(Train, Pcars)
Meta Primaria: trainPcars/2
Clausulas:
*/
trainPcars(train(_,_,_,_,Pcars), Pcars).
