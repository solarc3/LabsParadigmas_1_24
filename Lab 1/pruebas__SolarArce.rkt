#lang racket
(require "TDALine__SolarArce.rkt")
(require "TDASubway__SolarArce.rkt")
(require "TDADriver__SolarArce.rkt")
(require "TDAStation__SolarArce.rkt")
(require "TDASection__SolarArce.rkt")
(require "TDATrain__SolarArce.rkt")
(require "TDAPcar__SolarArce.rkt")
(require "main__SolarArce.rkt")
;====================================================;
; Script de pruebas del enunciado

;Estaciones L1 simplificada metro santiago
(define e0 (station 0 "San Pablo" t 90))
(define e1 (station 1 "Neptuno" r 45))
(define e2 (station 2 "Pajaritos" c 45))
(define e3 (station 3 "Las Rejas" r 45))
(define e4 (station 4 "Ecuador" r 60))
(define e5 (station 5 "San Alberto Hurtado" r 40))
(define e6 (station 6 "Universidad de Santiago de Chile" c 40))
(define e7 (station 7 "Estación Central" c 45))
(define e8 (station 8 "Unión Latinoamericana" r 30))
(define e9 (station 9 "República" r 40))
(define e10 (station 10 "Los Héroes" c 60))
(define e11 (station 11 "La Moneda" r 40))
(define e12 (station 12 "Universidad de Chile" c 90))
(define e13 (station 13 "Santa Lucía" r 40))
(define e14 (station 14 "Universidad Católica" c 60))
(define e15 (station 15 "Baquedano" r 40))
(define e16 (station 16 "Los Dominicos" t 90))
(define e17 (station 17 "Cochera Neptuno" m 3600))

;Estaciones L2 simplificada metro santiago, para una versión circular
(define e18 (station 18 "El Llano" r 60))
(define e19 (station 19 "Franklin" r 50))
(define e20 (station 20 "Rondizzoni" r 55))
(define e21 (station 21 "Parque O'Higgins" r 65))
(define e22 (station 22 "Toesca" r 65))
(define e23 (station 23 "Santa Ana" c 65))
(define e24 (station 24 "Puente Cal y Canto" r 65))

;Tramos Línea 1
(define s0 (section e0 e1 4 15))
(define s1 (section e1 e2 3 14))
(define s2 (section e2 e3 2.5 10))
(define s3 (section e3 e4 4.5 17))
(define s4 (section e4 e5 4.7 18))
(define s5 (section e5 e6 4.3 17))
(define s6 (section e6 e7 3.8 12))
(define s7 (section e7 e8 2.5 10))
(define s8 (section e8 e9 4.5 17))
(define s9 (section e9 e10 4.7 18))
(define s10 (section e10 e11 4.3 17))
(define s11 (section  e11 e12 3.8 12))
(define s12 (section e12 e13 4.5 17))
(define s13 (section e13 e14 4.7 18))
(define s14 (section e14 e15 4.3 17))
(define s15 (section e15 e16 4.2 17))
;enlace cochera
(define s16 (section e1 e17 3.8 12))

;Tramos Línea 2, línea circular
(define s17 (section e18 e19 4 15))
(define s18 (section e19 e20 3 12))
(define s19 (section e20 e21 5 18))
(define s20 (section e21 e22 4.5 16))
(define s21 (section e22 e10 4.2 16))
(define s22 (section e10 e23 4.2 16))
(define s23 (section e23 e24 4.2 16))
(define s24 (section e24 e18 28 90))

;Creación de Línea 1 con todos los tramos
(define l1 (line 1 "Línea 1" "UIC 60 ASCE" s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15))
;Creación de Línea 2 sin incluir tramos
(define l2 (line 2 "Línea 2" "100 R.E."))

(line-length l1) ;resultado debe ser 64,3 si considera inclusive los tramos hacia estaciones de mantenimiento 
(line-length l2) ;resultado debe ser 0
(line-section-length l1 "San Pablo"  "Las Rejas")   ;respuesta es 9.5

(line-cost l1) ;resultado debe ser 246 si considera inclusive los tramos hacia estaciones de mantenimiento 
(line-cost l2) ;resultado debe ser 0
(line-section-cost l1 "San Pablo" "Las Rejas")     ;respuesta es 39

;añadiendo tramos a l2
(define l2a (line-add-section l2 s17))
(define l2b (line-add-section l2a s18))
(define l2c (line-add-section l2b s19))
(define l2d (line-add-section l2c s20))
(define l2e (line-add-section l2d s21))
(define l2f (line-add-section l2e s22))
(define l2g (line-add-section l2f s23))
(define l2h (line-add-section l2g s24))
(define l2i (line-add-section l2h s19))  ;dependiendo de como implemente la función, esta operación no añade la estación duplicada. Puede lanzar un “error o excepción” (no un mensaje de error como String, para no comprometer el recorrido de la función) o bien devolver la línea de entrada intacta. En este caso, l2i sería igual a l2h. 

(line? l1)  ;devuelve true
(line? l2)  ;devuelve false
(line? l2e)  ;devuelve false
(line? l2h)  ;devuelve true

;creando carros
(define pc0 (pcar 0 100 "NS-74" tr))
(define pc1 (pcar 1 100 "NS-74" ct))
(define pc2 (pcar 2 150 "NS-74" ct))
(define pc3 (pcar 3 100 "NS-74" ct))
(define pc4 (pcar 4 100 "NS-74" tr))
(define pc5 (pcar 5 100 "AS-2014" tr))
(define pc6 (pcar 6 100 "AS-2014" ct))
(define pc7 (pcar 7 100 "AS-2014" ct))
(define pc8 (pcar 8 100 "AS-2014" ct))
(define pc9 (pcar 9 100 "AS-2014" tr))
(define pc10 (pcar 10 100 "AS-2014" tr))
(define pc11a (pcar 11 100 "AS-2016" tr))
(define pc11 (pcar 12 100 "AS-2016" ct))
(define pc12 (pcar 13 100 "AS-2016" ct))
(define pc13 (pcar 14 150 "AS-2016" ct))
(define pc14 (pcar 15 100 "AS-2016" ct))
(define pc15 (pcar 16 100 "AS-2016" ct))
(define pc16 (pcar 17 100 "AS-2016" ct))
(define pc17 (pcar 18 100 "AS-2016" tr))

;creando trenes
(define t0 (train 0 "CAF" "UIC 60 ASCE" 60 1.5)) ;tren sin carros definidos
(define t1 (train 1 "CAF" "UIC 60 ASCE" 70  2 pc0 pc1 pc2 pc3 pc4)) ;tren válido
(define t2 (train 2 "CAF" "100 R.E." 70  2 pc5 pc6 pc7 pc8 pc9)) ;tren válido
(define t3 (train 3 "CAF" "100 R.E." 70  2 pc11a pc11 pc12 pc13 pc14 pc15 pc16 pc17)) ;tren válido
(define t4 (train 4 "CAF" "100 R.E." 70  2 pc1 pc2 pc3)) ;tren inválido sin terminales en extremos
(define t5 (train 5 "CAF" "100 R.E." 70  2 pc0 pc5 pc9 pc12 pc17))  ;tren inválido por incompatibilidad de carros

(define t0a (train-add-car t0 pc5 0))
(define t0b (train-add-car t0a pc6 1))
(define t0c (train-add-car t0b pc7 2))
(define t0d (train-add-car t0c pc8 3))
(define t0e (train-add-car t0d pc9 4)) ;tren válido

(define t1a (train-remove-car t1 0))
(define t1b (train-remove-car t1 2))

;verificación de válidez en la conformación de trenes
(train? t0) ;debe arrojar #f
(train? t1) ;debe arrojar #t
(train? t2) ;debe arrojar #t
(train? t3) ;debe arrojar #t
(train? t4) ;debe arrojar #f
(train? t0a) ;debe arrojar #f
(train? t0b) ;debe arrojar #f
(train? t0c) ;debe arrojar #f
(train? t0d) ;debe arrojar #f
(train? t0e) ;debe arrojar #t
(train? t1a) ;debe arrojar #f
(train? t1b) ;debe arrojar #t

;determinar capacidad del tren
(train-capacity t0) ;debe arrojar 0
(train-capacity t1) ;debe arrojar 550


;Creando drivers
(define d0 (driver 0 "Juan" "CAF"))
(define d1 (driver 1 "Alejandro" "Alsthom"))
(define d2 (driver 2 "Diego" "Alsthom"))
(define d3 (driver 3 "Pedro" "CAF"))

;Creando Metros
(define sw0 (subway 0 "Metro de Santiago"))
(define sw1 (subway 1 "Subte"))

;Agregando trenes
(define sw0a (subway-add-train sw0 t1 t2 t0e))

;Agregando lineas
(define sw0b (subway-add-line sw0a l1 l2h))

;Agregando drivers
(define sw0c (subway-add-driver sw0b d0 d1 d2 d3))

;Expresado subway como string
(subway->string sw0c)

;Aumentando los costos de las estaciones en un 30%
(define sw0d (subway-rise-section-cost sw0c (lambda (c) (* c 1.3))))

;Cambiando el tiempo de parada de algunas estaciones
(define sw0e (subway-set-station-stoptime sw0d "Los Héroes" 180))
(define sw0f (subway-set-station-stoptime sw0e "San Pablo" 50))

;Asignando trenes a líneas
(define sw0g (subway-assign-train-to-line sw0f 0 1))
(define sw0h (subway-assign-train-to-line sw0g 2 2))

;Asignando conductores a trenes
(define sw0i (subway-assign-driver-to-train sw0h 0 0 "11:00:00" "San Pablo" "Los Héroes"))
(define sw0j (subway-assign-driver-to-train sw0i 2 2 "12:00:00" "El Llano" "Toesca")) ; no lo agrega ya que el driver 2 maneja equipos "Alsthom"
; deberia ser id 3 de driver para que funcione
;preguntando dónde está el tren
(where-is-train sw0j 0 "11:12:00")  ;Debería estar mas cerca de Las Rejas. Hasta esta hora el tren debería haber recorrido 12km (asumiendo esta unidad), sumando los tiempos de parada en las estaciones


;produciendo la ruta que sigue el tren
(subway-train-path sw0j 0 "11:12:00")
;====================================================;
; Script de pruebas propio
; Simplificacion del metro de Amsterdam
(display "Script de pruebas Propio\n")
; stations linea m51
(define my-e1 (station 31 "Isolatorweg" t 120))
(define my-e2 (station 32 "Spaklerweg" r 110))
(define my-e3 (station 33 "Reigersbos" c 130))
(define my-e4 (station 34 "Gein" r 90))
(define my-e5 (station 35 "Gouverneurplein" r 100))
(define my-e6 (station 36 "Dijkgraafplein" c 140))
(define my-e7 (station 37 "Ganzenhoef" r 80))
(define my-e8 (station 38 "Zuidmeer" r 95))
(define my-e9 (station 39 "Centraal Station" t 180))
; stations linea m52
(define my-e10 (station 48 "Noord" t 150))
(define my-e11 (station 49 "Noorderpark" r 90))
(define my-e12 (station 50 "Vlugtlaan" r 120))
(define my-e13 (station 51 "De Vlugtlaan" c 100))
(define my-e14 (station 52 "Van der Madeweg" r 110))
(define my-e15 (station 53 "Zuid/WTC" t 180))
; stations linea m53
(define my-e16 (station 40 "Gaasperplas" t 120))
(define my-e17 (station 41 "Reigersbos" c 130))
(define my-e18 (station 42 "Gein" r 90))
(define my-e19 (station 43 "Holendrecht" r 110))
(define my-e20 (station 44 "Bullewijk" c 140))
(define my-e21 (station 45 "Bijlmermeer" r 100))
(define my-e22 (station 46 "Strandvliet" r 80))
(define my-e23 (station 47 "Centraal Station" t 180))
; sections m51
(define my-s1 (section my-e1 my-e2 50 10))
(define my-s2 (section my-e2 my-e3 60 12))
(define my-s3 (section my-e3 my-e4 40 8))
(define my-s4 (section my-e4 my-e5 70 14))
(define my-s5 (section my-e5 my-e6 50 10))
(define my-s6 (section my-e6 my-e7 60 12))
(define my-s7 (section my-e7 my-e8 30 6))
(define my-s8 (section my-e8 my-e9 80 16))
;sections linea m52
(define my-s9 (section my-e10 my-e11 80 16))
(define my-s10 (section my-e11 my-e12 60 12))
(define my-s11 (section my-e12 my-e13 40 8))
(define my-s12 (section my-e13 my-e14 70 14))
(define my-s13 (section my-e14 my-e15 10 20))
; sections m53
(define my-s14 (section my-e16 my-e17 60 12))
(define my-s15 (section my-e17 my-e18 40 8))
(define my-s16 (section my-e18 my-e19 10 20))
(define my-s17 (section my-e19 my-e20 50 10))
(define my-s18 (section my-e20 my-e21 70 14))
(define my-s19 (section my-e21 my-e22 30 6))
(define my-s20 (section my-e22 my-e23 10 24)) ; se agrega denuevo my-e9, terminando en la misma
; se crea la linea m51 con todas sus sections
(define m51(line 51 "Linea M51" "BS75A" my-s1 my-s2 my-s3 my-s4 my-s5 my-s6 my-s7 my-s8))
; linea m52 sin stations
(define m52(line 52 "Linea M52" "JIS50N"))
; linea m53 con un par de stations
(define m53(line 53 "Linea M53" "AREMA" my-s14 my-s15 my-s16 my-s17))
(display "line-length \n")
(line-length m51) ; suma de los costos de las sections es 440
(line-length m52) ; 0 ya que no tiene sections asociadas
(line-length m53) ; 160 pero faltan sections
(display "line-cost\n")
(line-cost m51) ; 88
(line-cost m52) ; 0
(line-cost m53) ; faltan sections pero la suma de lo que hay es 50

; agregamos las sections a m52 pero intentamos agregas varias veces 2 sections
(define m52a (line-add-section m52 my-s9))
(define m52b (line-add-section m52a my-s9))
(define m52c (line-add-section m52b my-s9)) ; no se agrega varias veces, sigue siendo una section
(define m52d (line-add-section m52c my-s10))
(define m52e (line-add-section m52d my-s11))
(define m52f (line-add-section m52e my-s12))
(define m52g (line-add-section m52f my-s13))

;agregamos las que faltan en m53
(define m53a (line-add-section m53 my-s17))
(define m53b (line-add-section m53a my-s18))
(define m53c (line-add-section m53b my-s19))
(define m53d (line-add-section m53c my-s20))

(display "line-section-length\n")
(line-section-length m51 "Isolatorweg" "Zuidmeer") ; 360
(line-section-length m51 "Zuidmeer" "Isolatorweg") ; 360 tambien aunque este invertido
(line-section-length m52 "Noord" "Zuid/WTC") ; 0 ya que no existen esos tramos en ese estado de m52
(line-section-length m52g "Noord" "Zuid/WTC") ; 260
(display "line-section-cost\n")
(line-section-cost m51 "Isolatorweg" "Zuidmeer") ; 72
(line-section-cost m52 "Isolatorweg" "Zuidmeer") ; puse las mismas stations que arriba, no existe en m52, es 0
(line-section-cost m53d "Bijlmermeer" "Centraal Station") ;30
(display "line?\n")
(line? m51)  ; t
(line? m52e) ; f
(line? m52g) ; t
(line? m53d) ; t
; creacion de pcars
(define my-pc0(pcar 10 300 "Zilvermeeuw" tr))
(define my-pc1(pcar 11 300 "Zilvermeeuw" ct))
(define my-pc2(pcar 12 300 "Zilvermeeuw" ct))
(define my-pc3(pcar 13 300 "Zilvermeeuw" ct))
(define my-pc4(pcar 14 300 "Zilvermeeuw" ct))
(define my-pc5(pcar 15 300 "Zilvermeeuw" tr))

(define my-pc6(pcar 16 700 "CAF M4" tr))
(define my-pc7(pcar 17 700 "CAF M4" ct))
(define my-pc8(pcar 18 700 "CAF M4" ct))
(define my-pc9(pcar 19 700 "CAF M4" tr))

(define my-pc10(pcar 20 1200 "AK M5" tr))
(define my-pc11(pcar 21 1200 "AK M5" ct))
(define my-pc12(pcar 22 1200 "AK M5" ct))
(define my-pc13(pcar 23 1200 "AK M5" ct))
(define my-pc14(pcar 24 1200 "AK M5" ct))
(define my-pc15(pcar 25 1200 "AK M5" tr))

; creacion de trains
(define BN (train 9 "BN" "BS75A" 100 1 my-pc0 my-pc1 my-pc2 my-pc3 my-pc4 my-pc5)) ; tren valido
(define BNx (train 10 "BN" "BS75A" 100 1 my-pc0 my-pc1 my-pc2 my-pc3 my-pc4)) ; falta my-pc5, tren invalido, queda como lista vacia
(define LHB (train  11 "LHB" "JIS50N" 40 2 my-pc6 my-pc7 my-pc8 my-pc9)) ; tren valido
(define AREMA (train  12 "OV" "AREMA" 80 10 my-pc10 my-pc15)) ;tren valido de solo terminales

; eliminamos pcars de BN
(define BN1 (train-remove-car BN 5)) ; elimina el tr que era el ultimo
(define BN2 (train-remove-car BN1 10)) ; no cambia nada porque no existe esa posicion
(define BN3 (train-remove-car BN2 4)) ; elimina el central id 14
(define AREMA1 (train-remove-car AREMA 1)) ; eliminamos ultimo id 25

;agregamos pcars
(define BN4 (train-add-car BN3 my-pc4 4)) ; agregamos de ultimo
(define BN5 (train-add-car BN4 my-pc5 10)) ; agregamos a una posicion que no existe, igual queda de ultimo
(define AREMA2 (train-add-car AREMA1 my-pc11 1))
(define AREMA3 (train-add-car AREMA2 my-pc12 2))
(define AREMA4 (train-add-car AREMA3 my-pc13 3))
(define AREMA5 (train-add-car AREMA4 my-pc14 4))
(define AREMA6 (train-add-car AREMA5 my-pc15 5)) ; tren AREMA reconstruido
(display "train?\n")
(train? BNx)    ; f por falla al constuir
(train? BN)     ; t
(train? AREMA)  ; t
(train? AREMA6) ; t
(train? BN5)    ; t
(display "train-capacity\n")
(train-capacity BN1)    ; 1500
(train-capacity AREMA6) ; 7200
(train-capacity LHB)    ; 2800

; creacion drivers
(define my-d0 (driver 10 "Miguelito" "BN"))
(define my-d1 (driver 11 "Harambe" "LHB"))
(define my-d2 (driver 12 "Pacheco" "OV"))
; creacion subways
(define my-sw0 (subway 0 "Metro de Amsterdam"))
(define my-sw1 (subway 1 "Metro de Paris"))
(define my-sw2 (subway 2 "Metro de New York"))
; agregar trenes
(define my-sw0a (subway-add-train my-sw0 BN5 AREMA6 LHB))

(define my-sw1a (subway-add-train my-sw1 AREMA))
(define my-sw2a (subway-add-train my-sw2 BN))

; agregar lineas
(define my-sw0b (subway-add-line my-sw0a m51))
(define my-sw0c (subway-add-line my-sw0b m52g))
(define my-sw0d (subway-add-line my-sw0c m53d))
(define my-sw0X (subway-add-line my-sw0a m51 m52g m53d))
; (equal? my-sw0X my-sw0d) #t
; agregar drivers
(define my-sw0e (subway-add-driver my-sw0d my-d0))
(define my-sw0f (subway-add-driver my-sw0e my-d1))
(define my-sw0g (subway-add-driver my-sw0f my-d2))

(define my-sw0Z (subway-add-driver my-sw0X my-d0 my-d1 my-d2))
; (equal? my-sw0Z my-sw0g) #t

; subway como string
(subway->string my-sw0b)
(display "\n")
(subway->string my-sw0X)
(display "\n")
(subway->string my-sw0Z)
(display "\n")

; cambio de costo
(define my-sw0h (subway-rise-section-cost my-sw0g (λ(x) (* 1.5 x)))) ; aumento del 50%
(define my-sw0Za (subway-rise-section-cost my-sw0Z (λ(x) (* 0.8 x)))) ; dismunucion del 20%
(define my-sw0i (subway-rise-section-cost my-sw0h (λ(x) (* 3 x)))) ; aumento del 300%

; stop time
(define my-sw0j (subway-set-station-stoptime my-sw0i "Centraal Station" 45)) ;cambia en las 2 lineas inclusive con id distintos
(define my-sw0k (subway-set-station-stoptime my-sw0j "Bijlmermeer" 100))
(define my-sw0l (subway-set-station-stoptime my-sw0k "Noord" 80))
; train to line
(define my-sw0m (subway-assign-train-to-line my-sw0l 9 51))
(define my-sw0n (subway-assign-train-to-line my-sw0m 12 51)) ; train con tipo que no sirve para la line, no se agrega
; (equal? my-sw0m my-sw0n) #t
(define my-sw0o (subway-assign-train-to-line my-sw0n 12 53))
(define my-sw0p (subway-assign-train-to-line my-sw0o 11 52)) ; ambos validos, se agregan

; driver to train
(define my-sw0q (subway-assign-driver-to-train my-sw0p 10 9 "14:20:00" "Isolatorweg" "Ganzenhoef"))
(define my-sw0r (subway-assign-driver-to-train my-sw0q 11 11 "09:02:00" "Noord" "Van der Madeweg"))
(define my-sw0s (subway-assign-driver-to-train my-sw0r 12 12 "18:15:00" "Gaasperplas" "Bijlmermeer"))
(define my-sw0t (subway-assign-driver-to-train my-sw0s 12 12 "18:15:00" "Gaasperplas" "Centraal Station")) ; se reemplaza por el ultimo valido
; where is train
(where-is-train my-sw0t 9 "16:00:00") ;sumando los stoptime + las distancias de cada section en base a la velocidad del tren
(where-is-train my-sw0t 12 "22:00:00") ; si el trayecto se pasa, se devuele por el mismo trayecto definido en driver-train
(where-is-train my-sw0t 11 "08:00:00") ; si es una hora anterior a la inicial, esta en la station inicial

(subway-train-path my-sw0t 9 "18:30:00")
(subway-train-path my-sw0t 12 "19:45:00")
(subway-train-path my-sw0t 11 "23:15:00")



