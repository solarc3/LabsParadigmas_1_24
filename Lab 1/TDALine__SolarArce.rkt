#lang racket
(require "TDASection__SolarArce.rkt")
(require "TDAStation__SolarArce.rkt")
(provide (all-defined-out))

;TDA Line = id X name X rail-type X section
; id = int
; name = string
; rail-type = string
; section = null | TDA section X section

; ------------------------------------------------
; Nombre: line-id
; Descripcion: Obtiene el id (int) de un line
; Dominio: line
; Recorrido: id(int)
; Recursion: No
; Tipo de recursion: --
(define (line-id line) (car line))
; ------------------------------------------------
; Nombre: line-name
; Descripcion: Obtiene el nombre (string) de un line
; Dominio: line
; Recorrido: name(string)
; Recursion: No
; Tipo de recursion: --
(define (line-name line) (cadr line))
; ------------------------------------------------
; Nombre: line-rail-type
; Descripcion: Obtiene el rail-type (string) de un line
; Dominio: line
; Recorrido: rail-type(string)
; Recursion: No
; Tipo de recursion: --
(define (line-rail-type line) (caddr line))
; ------------------------------------------------
; Nombre: line-sections
; Descripcion: Obtiene las sections de un line
; Dominio: line
; Recorrido: sections(list)
; Recursion: No
; Tipo de recursion: --
(define (line-sections line)
  (cdddr line))
; ------------------------------------------------
; Nombre: line-stations
; Descripcion: Obtiene todas las estaciones de una linea, aplicando el map a ambos section-points y removiendo duplicados
; Dominio: line
; Recorrido: stations(list)
; Recursion: No
; Tipo de recursion: --
(define (line-stations line)
  (remove-duplicates
   (append (map section-point1 (line-sections line))
           (map section-point2 (line-sections line)))))
; ------------------------------------------------
; Nombre: line-circular?
; Descripcion: Verifica si una linea es circular, dado 3 condiciones
; Dominio: line
; Recorrido: bool
; Recursion: No
; Tipo de recursion: --

(define (line-circular? line)
  (let ((stations (line-sections line)))
    (and (equal? (station-name (section-point2 (car (reverse stations))))
                 (station-name (section-point1 (car stations))))
         (not (line-terminal-in-middle? (cdr stations))))))
; ------------------------------------------------
; Nombre: line-terminals?
; Descripcion: Verifica si una linea tiene terminales, dado 3 condiciones
; Dominio: line
; Recorrido: bool
; Recursion: No
; Tipo de recursion: --
(define (line-terminals? line)
  (let ((stations (line-sections line)))
    (and (equal? (station-type (section-point1 (car stations))) t)
         (not (line-terminal-in-middle? (cdr (reverse (cdr (reverse stations))))))
         (equal? (station-type (section-point2 (car (reverse stations)))) t))))
; ------------------------------------------------
; Nombre: line-terminal-in-middle?
; Descripcion: Verifica si una linea tiene un terminal en medio
; Dominio: sections
; Recorrido: bool
; Recursion: Si
; Tipo de recursion: Natural, como retorno bool, voy verificando cada section
(define (line-terminal-in-middle? sections)
  (cond
    [(null? sections) #f]
    [(or (equal? (station-type (section-point1 (car sections))) t)
         (equal? (station-type (section-point2 (car sections))) t))
     #t]
    [else (line-terminal-in-middle? (cdr sections))]))
; ------------------------------------------------
; Nombre: line-unique-station-ids?
; Descripcion: Verifica si una linea tiene identificadores unicos de estacion, se usa el helper
; Dominio: line
; Recorrido: bool
; Recursion: No
; Tipo de recursion: --
(define (line-unique-station-ids? line)
  (let ((stations (line-stations line)))
    (line-unique-station-ids-helper? stations)))
; ------------------------------------------------
; Nombre: line-unique-station-ids-helper?
; Descripcion: Funcion auxiliar para verificar si una lista de estaciones tiene identificadores unicos, usa otra funcion helper tambien
; Dominio: stations
; Recorrido: bool
; Recursion: Si
; Tipo de recursion: Natural, reviso cada station y voy comparando cada una, no es necesario guardar debido al tipo de retorno
(define (line-unique-station-ids-helper? stations)
  (cond
    [(null? stations) #t]
    [(station-id-in-rest? (station-id (car stations)) (cdr stations)) #f]
    [else (line-unique-station-ids-helper? (cdr stations))]))
; ------------------------------------------------
; Nombre: station-id-in-rest?
; Descripcion: Verifica si un identificador esta presente en el resto de la linea.
; Dominio: id X stations
; Recorrido: bool
; Recursion: Si 
; Tipo de recursion: Natural, para cada id reviso todas las stations, no es necesario guardar info
(define (station-id-in-rest? id stations)
  (cond
    [(null? stations) #f]
    [(equal? id (station-id (car stations))) #t]
    [else (station-id-in-rest? id (cdr stations))]))
; ------------------------------------------------
; Nombre: camino-existe?
; Descripcion: Verifica si existe un camino entre dos estaciones en una linea, implementacion rudimentaria de DFS, no funciona con lineas circulares,
; esos casos dependera de como este hecha la linea.
;
; Dominio: start-station(station) X end-station(station) X line(line)
; Recorrido: sections(list) | false
; Recursion: Si
; Tipo de recursion: Recursion de cola, se va acumulando el camino que me lleva a mi destino via el let loop (visitados para member y sections para el retorno)
(define (camino-existe? start-station end-station line)
  (let loop ((current-station start-station)
             (visitados '())
             (sections '()))
    (cond
      [(equal? current-station end-station)
       sections]
      [(member current-station visitados)
       #f]
      [else
       (let ((connected-sections (connected-stations current-station line)))
         (ormap (λ (section)
                  (let ((next-station (if (equal? current-station (section-point1 section))
                                          (section-point2 section)
                                          (section-point1 section))))
                    (loop next-station
                          (cons current-station visitados)
                          (cons section sections))))
                connected-sections))])))
; ------------------------------------------------
; Nombre: find-station-by-name
; Descripcion: Encuentra una estacion por su nombre y a la linea que pertenece.
; Se usa findf luego de encontrar la station list de una linea para encontrar mi station y retornarla
;
; Dominio: name(string) X line(line)
; Recorrido: station(station) | false
; Recursion: No
; Tipo de recursion: --
(define (find-station-by-name name line)
  (let ((stations (remove-duplicates (append (map section-point1 (line-sections line))
                                             (map section-point2 (line-sections line))))))
    (findf (λ (station) (equal? (station-name station) name)) stations)))
; ------------------------------------------------
; Nombre: connected-stations
; Descripcion: retorna las stations conectadas a la station de entrada
; Dominio: station(station) X line(line)
; Recorrido: sections(list)
; Recursion: No
; Tipo de recursion: --
(define (connected-stations station line)
  (let ((sections (line-sections line)))
    (filter (λ (x)
              (or (equal? (station-name (section-point1 x)) (station-name station))
                  (equal? (station-name (section-point2 x)) (station-name station))))
            sections)))