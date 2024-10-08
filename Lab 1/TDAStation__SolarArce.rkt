#lang racket
(provide(all-defined-out))
;TDA Station = id X name X type X stop-time
; id = int
; name = string
; type = c | t | r | m
; stop-time = int

; ------------------------------------------------
; Nombre: c
; Descripcion: Definicion de la constante "combinacion" para el tipo de estacion
; Dominio: --
; Recorrido: string
; Recursion: No
; Tipo de recursion: --
(define c "combinacion")
; ------------------------------------------------
; Nombre: t
; Descripcion: Definicion de la constante "terminal" para el tipo de estacion
; Dominio: --
; Recorrido: string
; Recursion: No
; Tipo de recursion: --
(define t "terminal")
; ------------------------------------------------
; Nombre: r

; Descripcion: Definicion de la constante "regular" para el tipo de estacion
; Dominio: --
; Recorrido: string
; Recursion: No
; Tipo de recursion: --
(define r "regular")
; ------------------------------------------------
; Nombre: m
; Descripcion: Definicion de la constante "mantencion" para el tipo de estacion
; Dominio: --
; Recorrido: string
; Recursion: No
; Tipo de recursion: --
(define m "mantencion")
; ------------------------------------------------
; Nombre: station-id
; Descripcion: Obtiene el id (int) de una station
; Dominio: station

; Recorrido: id(int)
; Recursion: No
; Tipo de recursion: --
(define (station-id station) (car station))

; ------------------------------------------------
; Nombre: station-name
; Descripcion: Obtiene el nombre (string) de una station
; Dominio: station
; Recorrido: name(string)
; Recursion: No
; Tipo de recursion: --
(define (station-name station) (cadr station))
; ------------------------------------------------
; Nombre: station-type

; Descripcion: Obtiene el tipo (string) de una station
; Dominio: station
; Recorrido: type(string)
; Recursion: No
; Tipo de recursion: --
(define (station-type station) (caddr station))
; ------------------------------------------------
; Nombre: station-stop-time
; Descripcion: Obtiene el tiempo de parada (int) de una station
; Dominio: station
; Recorrido: stop-time(int)
; Recursion: No

; Tipo de recursion: --
(define (station-stop-time station) (cadddr station))
; ------------------------------------------------
; Nombre: station?

; Descripcion: Verifica si un dato corresponde a una station valida
; Dominio: station
; Recorrido: bool
; Recursion: No
; Tipo de recursion: --
(define (station? station)
  (and (list? station)
       (= (length station) 4)
       (integer? (station-id station))
       (string? (station-name station))
       (member (station-type station) (list c t r m))
       (integer? (station-stop-time station))))