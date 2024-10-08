#lang racket
(provide (all-defined-out))
;TDA Pcar = id X capacity X model X type
; id = int
; capacity = int
; model = string
; type = tr | ct 
; ------------------------------------------------
; Nombre: pcar-id
; Descripcion: Obtiene el id (int) de un pcar
; Dominio: pcar
; Recorrido: id(int)
; Recursion: No
; Tipo de recursion: --
(define (pcar-id pcar) (car pcar))
; ------------------------------------------------
; Nombre: pcar-capacity
; Descripcion: Obtiene la capacidad (int) de un pcar
; Dominio: pcar

; Recorrido: capacity(int)
; Recursion: No
; Tipo de recursion: --
(define (pcar-capacity pcar) (cadr pcar))
; ------------------------------------------------
; Nombre: pcar-model
; Descripcion: Obtiene el modelo (string) de un pcar
; Dominio: pcar
; Recorrido: model(string)
; Recursion: No

; Tipo de recursion: --
(define (pcar-model pcar) (caddr pcar))
; ------------------------------------------------
; Nombre: pcar-type

; Descripcion: Obtiene el tipo (string) de un pcar
; Dominio: pcar
; Recorrido: type(string)
; Recursion: No
; Tipo de recursion: --

(define (pcar-type pcar) (cadddr pcar))