#lang racket
(provide (all-defined-out))
;TDA Subway = id X name X trains X lines X drivers
; id = int
; name = string
; trains = null | TDA train X train
; lines = null | TDA line X line
; drivers = null | TDA driver X driver
; ------------------------------------------------
; Nombre: subway-id
; Descripcion: Obtiene el id (int) de un subway
; Dominio: subway
; Recorrido: id(int)

; Recursion: No
; Tipo de recursion: --
(define (subway-id subway) (car subway))
; ------------------------------------------------
; Nombre: subway-name
; Descripcion: Obtiene el nombre (string) de un subway
; Dominio: subway
; Recorrido: name(string)
; Recursion: No

; Tipo de recursion: --
(define (subway-name subway) (cadr subway))
; ------------------------------------------------
; Nombre: subway-trains
; Descripcion: Obtiene los trenes (list) de un subway
; Dominio: subway
; Recorrido: trains(list)
; Recursion: No
; Tipo de recursion: --

(define (subway-trains subway) (caddr subway))
; ------------------------------------------------
; Nombre: subway-lines

; Descripcion: Obtiene las lineas (list) de un subway
; Dominio: subway
; Recorrido: lines(list)
; Recursion: No
; Tipo de recursion: --
(define (subway-lines subway) (cadddr subway))

; ------------------------------------------------
; Nombre: subway-drivers
; Descripcion: Obtiene los conductores (list) de un subway

; Dominio: subway
; Recorrido: drivers(list)
; Recursion: No
; Tipo de recursion: --
(define (subway-drivers subway) (car (reverse subway)))
; ------------------------------------------------
; Nombre: km-to-seconds
; Descripcion: Convierte kilometros a segundos dado una velocidad
; Dominio: distance(int) X speed(int)
; Recorrido: time(int)
; Recursion: No
; Tipo de recursion: --
(define (km-to-seconds distance speed)
  (* (/ distance speed) 3600))
; ------------------------------------------------
; Nombre: time-difference

; Descripcion: Calcula la diferencia en segundos entre dos tiempos dados en formato "HH:MM:SS"
; pasandolos de string a number para calcular.
;
; Dominio: end-time(string) X start-time(string)
; Recorrido: seconds(number)
; Recursion: No

; Tipo de recursion: --
(define (time-difference end-time start-time)
  (let ((end-parts (map string->number (string-split end-time ":")))
        (start-parts (map string->number (string-split start-time ":"))))
    (+ (* (- (car end-parts) (car start-parts)) 3600)
       (* (- (cadr end-parts) (cadr start-parts)) 60)
       (- (caddr end-parts) (caddr start-parts)))))