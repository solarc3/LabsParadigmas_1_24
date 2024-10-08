#lang racket
(require "TDAStation__SolarArce.rkt")
(provide(all-defined-out))
;TDA Section = point1 X point2 X distance X cost
; point1 = TDA station
; point2 = TDA station
; distance = int
; cost = int
; ------------------------------------------------
; Nombre: section-point1
; Descripcion: Obtiene la primera estacion (station) de una section
; Dominio: section
; Recorrido: station
; Recursion: No
; Tipo de recursion: --
(define (section-point1 section) (car section))
; ------------------------------------------------
; Nombre: section-point2
; Descripcion: Obtiene la segunda estacion (station) de una section
; Dominio: section
; Recorrido: station
; Recursion: No
; Tipo de recursion: --
(define (section-point2 section) (cadr section))
; ------------------------------------------------
; Nombre: section-distance
; Descripcion: Obtiene la distancia (number) de una section
; Dominio: section
; Recorrido: distance(number)
; Recursion: No
; Tipo de recursion: --
(define (section-distance section) (caddr section))
; ------------------------------------------------
; Nombre: section-cost
; Descripcion: Obtiene el costo (number) de una section
; Dominio: section
; Recorrido: cost(number)
; Recursion: No
; Tipo de recursion: --
(define (section-cost section) (cadddr section))
; ------------------------------------------------
; Nombre: section?
; Descripcion: Verifica si un dato corresponde a una section valida
; Dominio: section
; Recorrido: bool
; Recursion: No
; Tipo de recursion: --
(define (section? section)
  (and (list? section)
       (= (length section) 4)
       (station? (section-point1 section))
       (station? (section-point2 section))
       (number? (section-distance section))
       (number? (section-cost section))))