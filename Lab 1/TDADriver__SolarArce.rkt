#lang racket
(provide (all-defined-out))
;TDA Driver id X nombre X train-maker
; id = int
; nombre = string
; train-maker = string
; ------------------------------------------------
; Nombre: driver-id
; Descripcion: Obtiene el id (int) de un driver
; Dominio: driver
; Recorrido: id(int)
; Recursion: No
; Tipo de recursion: --
(define (driver-id driver) (car driver))
; ------------------------------------------------
; Nombre: driver-name
; Descripcion: Obtiene el nombre (string) de un driver
; Dominio: driver
; Recorrido: name(string)
; Recursion: No
; Tipo de recursion: --
(define (driver-name driver) (cadr driver))
; ------------------------------------------------
; Nombre: driver-train-maker
; Descripcion: Obtiene el fabricante de tren (string) de un driver
; Dominio: driver
; Recorrido: train-maker(string)
; Recursion: No
; Tipo de recursion: --
(define (driver-train-maker driver) (caddr driver))