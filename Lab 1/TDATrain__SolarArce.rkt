#lang racket
(require "TDAPcar__SolarArce.rkt")
(provide (all-defined-out))

;TDA Train = id X maker X rail-type X speed X station-stay-time X pcars
; id = int
; maker = string
; rail-type = string
; speed = int
; station-stay-time = int => 0
; pcars = null | pcar X pcar
; ------------------------------------------------
; Nombre: tr
; Descripcion: Definicion de la constante "terminal" para el tipo de pcar
; Dominio: --
; Recorrido: string
; Recursion: No
; Tipo de recursion: --
(define tr "terminal")
; ------------------------------------------------
; Nombre: ct
; Descripcion: Definicion de la constante "central" para el tipo de pcar
; Dominio: --
; Recorrido: string
; Recursion: No
; Tipo de recursion: --
(define ct "central")
; ------------------------------------------------
; Nombre: train-id
; Descripcion: Obtiene el id (int) de un train
; Dominio: train
; Recorrido: id(int)
; Recursion: No
; Tipo de recursion: --
(define (train-id train) (car train))
; ------------------------------------------------
; Nombre: train-maker
; Descripcion: Obtiene el fabricante (string) de un train
; Dominio: train
; Recorrido: maker(string)
; Recursion: No
; Tipo de recursion: --
(define (train-maker train) (cadr train))
; ------------------------------------------------
; Nombre: train-rail-type
; Descripcion: Obtiene el tipo de riel (string) de un train
; Dominio: train
; Recorrido: rail-type(string)
; Recursion: No
; Tipo de recursion: --
(define (train-rail-type train) (caddr train))
; ------------------------------------------------
; Nombre: train-speed
; Descripcion: Obtiene la velocidad (number) de un train
; Dominio: train
; Recorrido: speed(number)
; Recursion: No
; Tipo de recursion: --
(define (train-speed train) (cadddr train))
; ------------------------------------------------
; Nombre: train-station-stay-time
; Descripcion: Obtiene el tiempo de estancia en estacion (int) de un train
; Dominio: train
; Recorrido: stay-time(int)
; Recursion: No
; Tipo de recursion: --
(define (train-station-stay-time train) (car (cddddr train)))
; ------------------------------------------------
; Nombre: train-pcar-list
; Descripcion: Obtiene la lista de pcars (list) de un train
; Dominio: train
; Recorrido: pcar-list(list)
; Recursion: No
; Tipo de recursion: --
(define (train-pcar-list train) (car (reverse train)))
; ------------------------------------------------
; Nombre: train-terminal-in-middle?
; Descripcion: Verifica si un tren tiene un pcar terminal en medio de la lista de pcars
; Dominio: pcars(list)
; Recorrido: bool
; Recursion: Si
; Tipo de recursion: Natural, se recorre la lista de pcars hasta encontrar un terminal o llegar al final
(define (train-terminal-in-middle? pcars)
(cond
[(null? pcars) #f]
[(equal? (pcar-type (car pcars)) tr) #t]
[else (train-terminal-in-middle? (cdr pcars))]))
; ------------------------------------------------
; Nombre: train-unique-ids?
; Descripcion: Verifica si todos los pcars de un tren tienen ids únicos
; Dominio: pcars(list)
; Recorrido: bool
; Recursion: Si
; Tipo de recursion: Natural, se recorre la lista de pcars comparando cada id con los demas
(define (train-unique-ids? pcars)
(cond
[(null? pcars) #t]
[(train-id-in-rest? (pcar-id (car pcars)) (cdr pcars)) #f]
[else (train-unique-ids? (cdr pcars))]))
; ------------------------------------------------
; Nombre: train-id-in-rest?
; Descripcion: Verifica si un id de pcar esta presente en el resto de la lista de pcars
; Dominio: id(int) X pcars(list)
; Recorrido: bool
; Recursion: Si
; Tipo de recursion: Natural, se recorre la lista de pcars buscando el id dado
(define (train-id-in-rest? id pcars)
(cond
[(null? pcars) #f]
[(equal? id (pcar-id (car pcars))) #t]
[else (train-id-in-rest? id (cdr pcars))]))
; ------------------------------------------------
; Nombre: train-same-model?

; Descripcion: Verifica si todos los pcars de un tren son del mismo modelo
; Dominio: pcars(list)
; Recorrido: bool
; Recursion: Si
; Tipo de recursion: Natural, se compara cada par de pcars consecutivos hasta llegar al final de la lista
(define (train-same-model? pcars)
(cond

[(null? (cdr pcars)) #t]
[(equal? (pcar-model (car pcars)) (pcar-model (cadr pcars)))

(train-same-model? (cdr pcars))]
[else #f]))


