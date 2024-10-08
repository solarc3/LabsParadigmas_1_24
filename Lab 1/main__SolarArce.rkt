#lang racket
(require "TDALine__SolarArce.rkt")
(require "TDASubway__SolarArce.rkt")
(require "TDATrain__SolarArce.rkt")
(require "TDADriver__SolarArce.rkt")
(require "TDAPcar__SolarArce.rkt")
(require "TDAStation__SolarArce.rkt")
(require "TDASection__SolarArce.rkt")
(provide (all-defined-out))
;; =====================================================================
;;
;;                              RF-01
;;
;; =====================================================================

;TDA Driver = id X nombre X train-maker
; id = int
; nombre = string
; train-maker = string

;TDA Subway = id X name X trains X lines X drivers
; id = int
; name = string
; trains = null | TDA train X train
; lines = null | TDA line X line
; drivers = null | TDA driver X driver

;TDA Station = id X name X type X stop-time
; id = int
; name = string
; type = c | t | r | m
; stop-time = int

;TDA Section = point1 X point2 X distance X cost
; point1 = TDA station
; point2 = TDA station
; distance = int
; cost = int

;TDA Pcar = id X capacity X model X type
; id = int
; capacity = int
; model = string
; type = tr | ct 

;TDA Line = id X name X rail-type X section
; id = int
; name = string
; rail-type = string
; section = null | TDA section X section

;TDA Train = id X maker X rail-type X speed X station-stay-time X pcars
; id = int
; maker = string
; rail-type = string
; speed = int
; station-stay-time = int => 0
; pcars = null | pcar X pcar

#|----------------------------------------------------------------------|#

;; =====================================================================
;;
;;                              RF-02
;;
;; =====================================================================

;; Nombre: station
;; --------------------------------------------------------------------

;; Descripcion: Constructor del TDA station
;; --------------------------------------------------------------------

;; Dominio: id (int) X name (String)  X type (station-type) X stop-time (positive integer)
;; --------------------------------------------------------------------

;; Recorrido: station
;; --------------------------------------------------------------------

;; Recursion: No aplica
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (station id name type stop-time)
  (list id name type stop-time))

;; =====================================================================
;;
;;                              RF-03
;;
;; =====================================================================

;; Nombre: section
;; --------------------------------------------------------------------

;; Descripcion: Constructor del TDA Section, entrega lista vacia si se intenta agregar valor menor a 0
;; --------------------------------------------------------------------

;; Dominio: point1 (station)  X point2 (station) X distance (positive-number) X cost (positive-number U {0}). 
;; --------------------------------------------------------------------

;; Recorrido: section
;; --------------------------------------------------------------------

;; Recursion: No aplica
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (section point1 point2 distance cost)
  (if (<= cost 0)
      '()
      (list point1 point2 distance cost)))

;; =====================================================================
;;
;;                              RF-04
;;
;; =====================================================================

;; Nombre: line
;; --------------------------------------------------------------------

;; Descripcion: Constructor del TDA line
;; --------------------------------------------------------------------

;; Dominio: id (int) X name (string) X rail-type (string) X section*
;; (* señala que se pueden agregar 0 o mas tramos)
;; --------------------------------------------------------------------

;; Recorrido: line
;; --------------------------------------------------------------------

;; Recursion: No aplica
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (line id name rail-type . sections)
  (cons id (cons name (cons rail-type sections))))

;; =====================================================================
;;
;;                              RF-05
;;
;; =====================================================================

;; Nombre: line-length
;; --------------------------------------------------------------------

;; Descripcion: Determina el largo total de una linea
;; --------------------------------------------------------------------

;; Dominio: line (line)
;; --------------------------------------------------------------------

;; Recorrido: positive-number
;; --------------------------------------------------------------------

;; Recursion y Razon: No aplica
;; --------------------------------------------------------------------

;; Tipo de Recursion: No aplica
;; --------------------------------------------------------------------
(define (line-length line)
  (foldr (λ (section acc)
           (+ (section-distance section) acc))
         0
         (line-sections line)))

;; =====================================================================
;;
;;                              RF-06
;;
;; =====================================================================

;; Nombre: line-section-length
;; --------------------------------------------------------------------

;; Descripcion: Dado 2 stations-name, calcular su distancia.
;; Se utiliza un let loop como wrapper de la recursion, que ademas invoca
;; a camino-existe? para tener el subline entre las 2 stations-name.
;; --------------------------------------------------------------------

;; Dominio: line (line) X station1-name (String) X station2-name (String)
;; --------------------------------------------------------------------

;; Recorrido: positive-number
;; --------------------------------------------------------------------

;; Recursion: Si
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon de uso: Cola, se usa Cola debido a que es
;; requerimiento de la funcion.
;; --------------------------------------------------------------------
(define (line-section-length line station1-name station2-name)
  (let ((station1 (find-station-by-name station1-name line))
        (station2 (find-station-by-name station2-name line)))
    (cond
      [(equal? station1-name station2-name) 0]
      [else
       (let ((path (camino-existe? station1 station2 line)))
         (let loop ((remaining-path path)
                    (acum 0))
           (cond
             [(null? remaining-path) acum]
             [(not (null? remaining-path))
              (loop (cdr remaining-path)
                    (+ acum (section-distance (car remaining-path))))]
             [else 0])))])))

;; =====================================================================
;;
;;                              RF-07
;;
;; =====================================================================

;; Nombre: line-cost
;; --------------------------------------------------------------------

;; Descripcion: Determina el costo monetario de una line
;; --------------------------------------------------------------------

;; Dominio: line (line)
;; --------------------------------------------------------------------

;; Recorrido: positive-number U {0}
;; --------------------------------------------------------------------

;; Recursion: Si 
;; --------------------------------------------------------------------

;; Tipo de Recursion: Natural, se usa Natural debido a que es requerimiento
;; de la funcion.
;; --------------------------------------------------------------------
(define (line-cost line)
  (if (null? (line-sections line))
      0
      (+ (section-cost (car (line-sections line)))
         (line-cost (cdr line)))))

;; =====================================================================
;;
;;                              RF-08
;;
;; =====================================================================

;; Nombre: line-section-cost
;; --------------------------------------------------------------------

;; Descripcion: Dado 2 stations-name, calcular su coste.
;; Se usa un let loop como wrapper para la recursion.
;; nuevamente dado los string, se encuentra primero su station y esas
;; station se usan en camino-existe, para luego recien calcular su coste
;; con el loop
;; --------------------------------------------------------------------

;; Dominio: line (line) X station1-name (String) X station2-name (String)
;; --------------------------------------------------------------------

;; Recorrido: positive-number U {0}
;; --------------------------------------------------------------------

;; Recursion: si
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: Cola, debido a hacer el loop con un acum y el remaining-path, ademas de utilizar camino-existe? que tambien es cola
;; --------------------------------------------------------------------
(define (line-section-cost line station1-name station2-name)
  (let ((station1 (find-station-by-name station1-name line))
        (station2 (find-station-by-name station2-name line)))
    (cond
      [(equal? station1-name station2-name) 0]
      [else
       ;;wrapper con acumulador
       (let ((camino (camino-existe? station1 station2 line)))
         (let loop ((remaining-path camino)
                    (acum 0))
           (cond
             [(null? remaining-path) acum]
             [(not (null? remaining-path))
              (loop (cdr remaining-path)
                    (+ acum (section-cost (car remaining-path))))]
             [else 0])))])))

;; =====================================================================
;;
;;                              RF-09
;;
;; =====================================================================

;; Nombre: line-add-section
;; --------------------------------------------------------------------

;; Descripcion: Dada una line, se le agrega una nueva station, ademas
;; revisa que no este ya dentro.
;; Se hace un "stack" de cons para evitar que se agregue otro parentesis
;; ademas se utiliza add-section para que haga el trabajo de la recursion natural.
;; --------------------------------------------------------------------

;; Dominio: line (line) X section (section)
;; --------------------------------------------------------------------

;; Recorrido: line(line)
;; --------------------------------------------------------------------

;; Recursion: Si
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: Natural, debido a que es un requerimiento
;; de la funcion.
;; La recursion Natural la hace add-section.
;; add-section no lleva acumulador, se aplica a si mismo la construccion
;; del nuevo line, es natural, se llama con las line-sections de line.
;; -------------------------------------------------------------------- 
(define (line-add-section line section)
  (define (add-section sections)
    (cond
      [(null? sections) (list section)]
      [(equal? (car sections) section) sections] 
      [else (cons (car sections) (add-section (cdr sections)))]))
  (if (member section (line-sections line)) 
      line 
      (cons (line-id line)
            (cons (line-name line)
                  (cons (line-rail-type line)
                        (add-section (line-sections line)))))))
;; =====================================================================
;;
;;                              RF-10
;;
;; =====================================================================

;; Nombre: line?
;; --------------------------------------------------------------------

;; Descripcion: Determina si una linea es valida o no.
;; la funcion en si es chica, se deja el trabajo de confimar las cosas de manera recursiva a las funciones helpers
;; que verificar lo siguiente:
;;
;; - no existan id repetidos.
;;
;; - que los valores sean acordes al dominio de line.
;;
;; - si tiene 2 estaciones terminales, si tiene una terminal verifique que
;; este como primera y ultima unicamente (si pilla alguna entremedio, retorna false).
;;
;; - si es ciclica, misma idea que la de arriba pero ahora verificar que
;; la primera station sea igual que la ultima y que no existan stations terminales.
;;
;; Todo eso existe dentro de un AND para verificar los tipos de datos y dentro de eso
;; un OR que verifica las condiciones
;; --------------------------------------------------------------------

;; Dominio: line(line)
;; --------------------------------------------------------------------

;; Recorrido: boolean
;; --------------------------------------------------------------------

;; Recursion: si
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: Natural y Cola, las funciones internas que invoca, ademas de la de Cola que se utiliza en camino-existe?, se revisa si existe camino entre la primera y ultima station,
;; es un or ya que no funciona para circulares la funcion camino-existe?
;; --------------------------------------------------------------------
(define (line? line)
  (and (list? line)
       (> (length line) 3)
       (integer? (line-id line))
       (string? (line-name line))
       (string? (line-rail-type line))
       (or (line-circular? line)
           (line-terminals? line))
       (line-unique-station-ids? line)
       (let ((sections (line-sections line)))
         (and (not (null? sections))
              (not (equal? (camino-existe? (section-point1 (car sections))
                                           (section-point2 (last sections))
                                           line)
                           #f))))))
;; =====================================================================
;;
;;                              RF-11
;;
;; =====================================================================

;; Nombre: pcar
;; --------------------------------------------------------------------

;; Descripcion: constructor de TDA Pcar
;; --------------------------------------------------------------------

;; Dominio: id (int) X capacity (positive integer) X model (string) X type (car-type)
;; --------------------------------------------------------------------

;; Recorrido: pcar
;; --------------------------------------------------------------------

;; Recursion: No aplica
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (pcar id capacity model type)
  (list id capacity model type))

;; =====================================================================
;;
;;                              RF-12
;;
;; =====================================================================

;; Nombre: train
;; --------------------------------------------------------------------

;; Descripcion: Constructor de train, dentro de la misma funcion se verifica que la asignacios de pcars
;; sea congruente con lo que se pide (tr en las esquinas y ct no en las esquinas, eso se prueba dentro del OR).
;; luego se usa un andmap, que tiene como obligacion retornar algo o falso si es que todo se cumple o si alguno no se cumple.
;; si no se cumple debido al andmap, se retorna nulo en vez de crear algo que no sirve.
;; --------------------------------------------------------------------

;; Dominio: id (int) X maker (string) X rail-type (string) X speed (positive number) X station-stay-time (positive number U {0})
;; X pcar* (* indica que pueden especificarse 0 o mas carros)
;; --------------------------------------------------------------------

;; Recorrido: train
;; --------------------------------------------------------------------

;; Recursion: No aplica
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (train id maker rail-type speed station-stay-time . pcars)
  (cond
    [(null? pcars)
     (list id maker rail-type speed station-stay-time pcars)]
    [(and (equal? (pcar-type (car pcars)) tr)
          (equal? (pcar-type (car (reverse pcars))) tr)
          (or
           (null? (cdr (reverse (cdr (reverse pcars)))))
           (not (member tr (map pcar-type (cdr (reverse (cdr (reverse pcars))))))))
          ; prueba con el primer carro, que todo el resto sea igual
          (andmap (λ (model) (equal? model (pcar-model (car pcars)))) (map pcar-model pcars)))
     (list id maker rail-type speed station-stay-time pcars)]
    [else null]))

;; =====================================================================
;;
;;                              RF-13
;;
;; =====================================================================

;; Nombre: train-add-car
;; --------------------------------------------------------------------

;; Descripcion: Agregar un carro a un train, dado una posicion.
;; para aplicar la recursion se hace nuevamente un let loop, va restando la posicion hasta que sea 0
;; cuando es distinto de 0 va guardando los trenes a la izquierda para luego hacer un append, de lo que ya vio
;; con el pcar que quier agregar y el cdr de las cosas de la lista que va quedando, luego de todo eso se regenera un train dado la lista de pcars nueva.
;; --------------------------------------------------------------------

;; Dominio: train (train) X pcar (pcar) X position (positive-integer U {0})
;; --------------------------------------------------------------------

;; Recorrido: train
;; --------------------------------------------------------------------

;; Recursion: Si
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: Cola, para poder ir acumulando en otra variable los trenes que vi y que me faltan por ver, para hacer mas facil el trabajo de regenerar
;; --------------------------------------------------------------------
(define (train-add-car trains pcars position)
  (let loop ((pcar-list (list (train-pcar-list trains)))
             (izquierda-list '())
             (pos position))
    (cond
      [(null? pcar-list)
       (list
        (train-id trains)
        (train-maker trains)
        (train-rail-type trains)
        (train-speed trains)
        (train-station-stay-time trains)
        (append izquierda-list (list pcars)))]
      [(zero? pos)
       (list
        (train-id trains)
        (train-maker trains)
        (train-rail-type trains)
        (train-speed trains)
        (train-station-stay-time trains)
        (append izquierda-list (list pcars) (cdr pcar-list)))]
      [else
       (loop (cdr pcar-list)
             (append izquierda-list  (car pcar-list))
             (- pos 1))])))

;; =====================================================================
;;
;;                              RF-14
;;
;; =====================================================================

;; Nombre: train-remove-car
;; --------------------------------------------------------------------

;; Descripcion: misma idea que la anterior, let loop pero ahora a diferencia,
;; al encontras que la position es 0, se agrega lo que se acumulo en la izquierda y el cdr de lo que falta por ver.
;; Luego de eso se regenera un train
;; --------------------------------------------------------------------

;; Dominio: train (train) X position (positive-integer U {0})
;; --------------------------------------------------------------------

;; Recorrido: train
;; --------------------------------------------------------------------

;; Recursion: Si
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: Cola, para poder tener acumuladores
;; --------------------------------------------------------------------
(define (train-remove-car trains position)
  (let loop ((pcar-list  (train-pcar-list trains))
             (izquierda-list '())
             (pos position))
    (cond
      [(null? pcar-list)
       (list
        (train-id trains)
        (train-maker trains)
        (train-rail-type trains)
        (train-speed trains)
        (train-station-stay-time trains)
        izquierda-list)]
      [(zero? pos)
       (list
        (train-id trains)
        (train-maker trains)
        (train-rail-type trains)
        (train-speed trains)
        (train-station-stay-time trains)
        (append izquierda-list (cdr pcar-list)))]
      [else
       (loop (cdr pcar-list)
             (append izquierda-list (list(car pcar-list)))
             (- pos 1))])))

;; =====================================================================
;;
;;                              RF-15
;;
;; =====================================================================

;; Nombre: train?
;; --------------------------------------------------------------------

;; Descripcion: Funcion que verifica si el tren dado es correcto en base a:
;; - No hay ids repetidos
;; - Todos los trenes son del mismo modelo
;; - Correcta configuracion tr - ct - ct .... - tr
;; Se usa drop right para probar directamente sin el ultimo elemento, asi pruebo directamente todos
;; los que no son terminales.
;; --------------------------------------------------------------------

;; Dominio: train
;; --------------------------------------------------------------------

;; Recorrido: boolean
;; --------------------------------------------------------------------

;; Recursion: Si
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: Natural, igual que como en line?, se pasa el trabajo el trabajo recursivo a las 3
;; funciones helpers, haciendo un and, ya que debe cumplir todo eso para ser valido.
;; --------------------------------------------------------------------
(define (train? train)
  (if (null? train)
      #f
      (let ((pcars (train-pcar-list train)))
        (and
         (not (null? pcars))  
         (>= (length pcars) 2)  
         (equal? (pcar-type (car pcars)) tr)  
         (equal? (pcar-type (last pcars)) tr)  
         (cond
           [(= (length pcars) 2) #t]  ; tr - tr
           [(= (length pcars) 3) ; tr - ct - tr
            (equal? (pcar-type (cadr pcars)) ct)]
           [else 
            (and
             (not (train-terminal-in-middle? (cdr (drop-right pcars 1))))  
             (train-unique-ids? pcars)  
             (train-same-model? pcars))])))))

;; =====================================================================
;;
;;                              RF-16
;;
;; =====================================================================

;; Nombre: train-capacity
;; --------------------------------------------------------------------

;; Descripcion: Dado un train, retornar la capacidad total que tiene
;; --------------------------------------------------------------------

;; Dominio: train 
;; --------------------------------------------------------------------

;; Recorrido: positive-number U {0}
;; --------------------------------------------------------------------

;; Recursion: Si
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: Cola, agrego una variable capacity para ir sumando el pcar-capacity de cada pcar
;; --------------------------------------------------------------------
(define (train-capacity train)
  (let ((pcars (train-pcar-list train)))
    (let loop ((remaining-pcars pcars)
               (capacity 0))
      (if (null? remaining-pcars)
          capacity
          (loop (cdr remaining-pcars)
                (+ capacity (pcar-capacity (car remaining-pcars))))))))

;; =====================================================================
;;
;;                              RF-17
;;
;; =====================================================================

;; Nombre: driver
;; --------------------------------------------------------------------

;; Descripcion: constructor del TDA Driver
;; --------------------------------------------------------------------

;; Dominio: id (int) X nombre (string) X train-maker (string)
;; --------------------------------------------------------------------

;; Recorrido: driver
;; --------------------------------------------------------------------

;; Recursion: No 
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (driver id name train-maker)
  (list id name train-maker))

;; =====================================================================
;;
;;                              RF-18
;;
;; =====================================================================

;; Nombre: subway
;; --------------------------------------------------------------------

;; Descripcion: constructor del TDA Subway, se agrega directamente las 3 listas vacias
;; para usar los getters del mismo TDA
;; --------------------------------------------------------------------

;; Dominio: id (int) X nombre (string)
;; --------------------------------------------------------------------

;; Recorrido: subway
;; --------------------------------------------------------------------

;; Recursion: No
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (subway id name)
  (list id name '() '() '()))

;; =====================================================================
;;
;;                              RF-19
;;
;; =====================================================================

;; Nombre: subway-add-train
;; --------------------------------------------------------------------

;; Descripcion: Agrega trains a un subway, de manera recursiva uno tras uno
;; se usa denuevo un "stack" de cons para evitar agregar parentesis.
;; --------------------------------------------------------------------

;; Dominio: sub (subway) X train+ (pueden ser 1 o mas trenes)
;; --------------------------------------------------------------------

;; Recorrido: subway
;; --------------------------------------------------------------------

;; Recursion: Si
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: Cola, add-trains va verificando si el que se esta intentando agrega ya existe, si existe no se agrega.
;; --------------------------------------------------------------------
(define (subway-add-train subway . trains)
  (let ((existing-trains (subway-trains subway)))
    (define (add-trains subway trains)
      (cond
        ((null? trains) subway)
        ((member (car trains) existing-trains)
         (add-trains subway (cdr trains)))
        (else
         (add-trains
          (list (subway-id subway)
                (subway-name subway)
                (cons (car trains) (subway-trains subway))
                (subway-lines subway)
                (subway-drivers subway))
          (cdr trains)))))
    
    (add-trains subway trains)))

;; =====================================================================
;;
;;                              RF-20
;;
;; =====================================================================

;; Nombre: subway-add-line
;; --------------------------------------------------------------------

;; Descripcion: Se agregan directamente los N lines al subway
;; no hay necesidad de stack de cons aca.
;; --------------------------------------------------------------------

;; Dominio: sub (subway) X line+ (pueden ser 1 o mas lineas)
;; --------------------------------------------------------------------

;; Recorrido: subway
;; --------------------------------------------------------------------

;; Recursion: No aplica
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (subway-add-line subway . lines)
  (let* ((existing-lines (subway-lines subway))
        (new-lines (filter (λ(line)
                             (not (member line existing-lines)))
                           lines)))
    (if (null? new-lines)
        subway
        (list (subway-id subway)
              (subway-name subway)
              (subway-trains subway)
              (append existing-lines new-lines)
              (subway-drivers subway)))))
;; =====================================================================
;;
;;                              RF-21
;;
;; =====================================================================

;; Nombre: subway-add-driver
;; --------------------------------------------------------------------

;; Descripcion: Agrega los N drivers a un subway.
;; Tampoco aqui es necesario el stack de cons, quedan bien los parentesis.
;; --------------------------------------------------------------------

;; Dominio: sub (subway) X driver+ (pueden ser 1 o mas conductores)
;; --------------------------------------------------------------------

;; Recorrido: subway
;; --------------------------------------------------------------------

;; Recursion: No aplica
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (subway-add-driver subway . drivers)
  (let* ((existing-drivers (subway-drivers subway))
         (new-drivers (filter (λ(driver)
                                (not (member driver existing-drivers)))
                              drivers)))
    (if (null? new-drivers)
        subway
        (list (subway-id subway)
              (subway-name subway)
              (subway-trains subway)
              (subway-lines subway)
              (append existing-drivers new-drivers)))))

;; =====================================================================
;;
;;                              RF-22
;;
;; =====================================================================

;; Nombre: subway->string
;; --------------------------------------------------------------------

;; Descripcion: Se pasa el subway directamente a un string, con string-append
;; se le agregan saltos de linea, desaparecen si se le hace display a la funcion.
;; format hace que nos evitemos usar (string-append (string-join)) combo.
;; --------------------------------------------------------------------

;; Dominio: subway
;; --------------------------------------------------------------------

;; Recorrido: string
;; --------------------------------------------------------------------

;; Recursion: No aplica
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (subway->string subway)
  (string-append
   "Subway ID: " (number->string (subway-id subway)) "\n"
   "Subway Name: " (subway-name subway) "\n"
   "Trains: " (format "~a" (subway-trains subway)) "\n"
   "Lines: " (format "~a" (subway-lines subway)) "\n"
   "Drivers: " (format "~a" (subway-drivers subway))))

;; =====================================================================
;;
;;                              RF-23
;;
;; =====================================================================

;; Nombre: subway-rise-section-cost
;; --------------------------------------------------------------------

;; Descripcion: Dado un f (funcion) al subway le aplico el coste nuevo
;; se reconstruye primero dentro del let las lineas actualizadas
;; haciendo un doble map y un "stack" de cons para evitar el parentesis extra.
;; luego de tener las lineas actualizadas, como se le debe aplicar a todos no tiene restricciones y se le aplica a todos
;; no es necesario el stack para armar el subway, solo para el updated lines.
;; --------------------------------------------------------------------

;; Dominio: sub (subway) X function
;; --------------------------------------------------------------------

;; Recorrido: subway
;; --------------------------------------------------------------------

;; Recursion: No aplica
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (subway-rise-section-cost sub f)
  (let ((updated-lines (map (λ (line)
                              (cons (line-id line)
                                    (cons (line-name line)
                                          (cons (line-rail-type line)
                                                (map (λ (section)
                                                       (list (section-point1 section)
                                                             (section-point2 section)
                                                             (section-distance section)
                                                             (f (section-cost section))))
                                                     (line-sections line))))))
                            (subway-lines sub))))
    (list (subway-id sub)
          (subway-name sub)
          (subway-trains sub)
          updated-lines
          (subway-drivers sub))))

;; =====================================================================
;;
;;                              RF-24
;;
;; =====================================================================

;; Nombre: subway-set-station-stoptime
;; --------------------------------------------------------------------

;; Descripcion: Dada una estacion, modifica su tiempo de parada (stoptime) en todas las lineas del sistema de metro.
;; Primero, se crea una lista 'stations' que contiene todas las estaciones del sistema de metro, combinando las estaciones de todas las lineas.
;; Luego, se itera sobre cada linea del sistema de metro.
;; Para cada seccion de cada linea:
;;   - Se obtienen los puntos inicial (p1) y final (p2) de la seccion.
;;   - Si el nombre del punto inicial (p1) coincide con 'name-station' y su tiempo de parada es diferente a 'stoptime':
;;     - Se crea una nueva instancia de la estacion p1 con el nuevo tiempo de parada 'stoptime', pero manteniendo su ID, nombre y tipo.
;;     - Se construye una nueva seccion con la nueva instancia de la estacion, el mismo punto final (p2), distancia y costo.
;;   - Si el nombre del punto final (p2) coincide con 'name-station' y su tiempo de parada es diferente a 'stoptime':
;;     - Se crea una nueva instancia de la estacion p2 con el nuevo tiempo de parada 'stoptime', pero manteniendo su ID, nombre y tipo.
;;     - Se construye una nueva seccion con el mismo punto inicial (p1), la nueva instancia de la estacion, distancia y costo.
;;   - Si ninguno de los puntos coincide con 'name-station' o su tiempo de parada ya es igual a 'stoptime', se mantiene la seccion sin cambios.
;; Se crea una nueva linea con las secciones actualizadas.

;; Finalmente, se crea un nuevo sistema de metro con las lineas actualizadas y los mismos ID, nombre, trenes y conductores.
;; --------------------------------------------------------------------

;; Dominio: sub (subway) X stationName (String) X time
;; --------------------------------------------------------------------

;; Recorrido: subway
;; --------------------------------------------------------------------

;; Recursion: No aplica
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (subway-set-station-stoptime subways name-station stoptime)
  (let ((stations (append (map section-point1 (append (car (map line-sections (subway-lines subways)))
                                                      (cadr (map line-sections (subway-lines subways)))))
                          (map section-point2 (append (car (map line-sections (subway-lines subways)))
                                                      (cadr (map line-sections (subway-lines subways))))))))
    (let ((updated-lines (map (λ(line)
                                (cons (line-id line)
                                      (cons (line-name line)
                                            (cons (line-rail-type line)
                                                  (map (λ (section)
                                                         (let ((p1 (section-point1 section))
                                                               (p2 (section-point2 section)))
                                                           (cond ((and (equal? (station-name p1) name-station)
                                                                       (not (equal? (station-stop-time p1) stoptime)))
                                                                  (list (list (station-id p1)
                                                                              name-station
                                                                              (station-type p1)
                                                                              stoptime)
                                                                        p2
                                                                        (section-distance section)
                                                                        (section-cost section)))
                                                                 ((and (equal? (station-name p2) name-station)
                                                                       (not (equal? (station-stop-time p2) stoptime)))
                                                                  (list p1
                                                                        (list (station-id p2)
                                                                              name-station
                                                                              (station-type p2)
                                                                              stoptime)
                                                                        (section-distance section)
                                                                        (section-cost section)))
                                                                 (else section))))
                                                       (line-sections line))))))
                              (subway-lines subways))))
      (list (subway-id subways)
            (subway-name subways)
            (subway-trains subways)
            updated-lines
            (subway-drivers subways)))))

;; =====================================================================
;;
;;                              RF-25
;;
;; =====================================================================

;; Nombre: subway-assign-train-to-line
;; --------------------------------------------------------------------

;; Descripcion: Para asignar el train, lo encontramos primero con un findf.
;; Si lo encuentra, se busca la linea dado su id y se agrega despues del line el train asignado.
;; Se modifica la estructura de subway con un elemento nuevo.
;; --------------------------------------------------------------------

;; Dominio: sub (subway) X trainId (int) X lineID (int)
;; --------------------------------------------------------------------

;; Recorrido: subway
;; --------------------------------------------------------------------

;; Recursion: No aplica
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: No aplica
;; --------------------------------------------------------------------
(define (subway-assign-train-to-line sub trainId lineId)
  (let ((train (findf (λ (t) (equal? (train-id t) trainId)) (subway-trains sub))))
    (if train
        (let ((line (findf (λ (l) (equal? (line-id l) lineId)) (subway-lines sub))))
          (if (and line (equal? (line-rail-type line) (train-rail-type train)))
              (let ((updated-lines (map (λ (l)
                                          (if (equal? (line-id l) lineId)
                                              (append (list (line-id l)
                                                            (line-name l)
                                                            (line-rail-type l))
                                                      (append (line-sections l) (list train)))
                                              l))
                                        (subway-lines sub))))
                (list (subway-id sub)
                      (subway-name sub)
                      (subway-trains sub)
                      updated-lines
                      (subway-drivers sub)))
              sub))
        sub)))

;; =====================================================================
;;
;;                              RF-26
;;
;; =====================================================================

;; Nombre: subway-assign-driver-to-train
;; --------------------------------------------------------------------

;; Descripcion: La funcion subway-assign-driver-to-train asigna un conductor a un tren especifico en una linea de metro.
;; Primero, busca el tren correspondiente al trainId en todas las lineas del metro.
;; - Si encuentra el tren, busca el conductor correspondiente al driverId en la lista de conductores del metro, verificando que el fabricante del tren coincida con el fabricante asociado al conductor.
;;   - Si encuentra tanto el tren como el conductor, busca la linea especifica que contiene el tren.
;; Luego, actualiza la informacion de la seccion correspondiente al tren en esa linea, agregando los detalles del conductor, el tiempo de salida, la estacion de partida y la estacion de llegada.
;; Finalmente, reconstruye el objeto subway con la linea actualizada y lo devuelve.
;; Si no se encuentra el tren o el conductor, o si el tren no esta en ninguna linea, devuelve el objeto subway sin modificaciones.
;; --------------------------------------------------------------------

;; Dominio: sub (subway) X driverId (int) X trainId (int) X departureTime(String en formato HH:MM:SS de 24 hrs) X departure-station (String) X arrival-station (String)
;; --------------------------------------------------------------------

;; Recorrido: subway
;; --------------------------------------------------------------------

;; Recursion: No aplica
;; --------------------------------------------------------------------


(define (subway-assign-driver-to-train sub driverId trainId departureTime departure-station arrival-station)
  (let ((train (findf (λ (t) (equal? (car t) trainId))
                      (apply append (map cdddr (subway-lines sub))))))
    (if train
        (let ((driver (findf (λ (d) (and (equal? (driver-id d) driverId) 
                                          (equal? (driver-train-maker d) (cadr train)))) 
                             (subway-drivers sub))))
          (if driver
              (let ((line-with-train (findf (λ (line) 
                                              (findf (λ (t) (equal? (car t) trainId)) 
                                                     (cdddr line))) 
                                            (subway-lines sub))))
                (if line-with-train
                    (let ((updated-line (let ((train-info (findf (λ (t) (and (list? t) (equal? (car t) trainId))) 
                                                                 (cdddr line-with-train))))
                                          (if train-info
                                              (append (list (car line-with-train) 
                                                            (cadr line-with-train) 
                                                            (caddr line-with-train))
                                                      (map (λ (section)
                                                             (if (and (list? section) (equal? (car section) trainId))
                                                                 (list (car section)
                                                                       (cadr section)
                                                                       (caddr section)
                                                                       (cadddr section)
                                                                       (car (cddddr section))
                                                                       (cadr (cddddr section))
                                                                       driver
                                                                       departureTime
                                                                       departure-station
                                                                       arrival-station)
                                                                 section))
                                                           (cdddr line-with-train)))
                                              line-with-train))))
                      (list (subway-id sub)
                            (subway-name sub)
                            (subway-trains sub)
                            (map (λ (line) (if (equal? (car line) (car line-with-train))
                                               updated-line
                                               line))
                                 (subway-lines sub))
                            (subway-drivers sub)))
                    sub))
              sub))
        sub)))

;; =====================================================================
;;
;;                              RF-27
;;
;; =====================================================================

;; Nombre: where-is-train
;; --------------------------------------------------------------------

;; Descripcion: Como primer paso, encontramos el line con su findf, para luego buscar si en esa line existe un train con ese id (ahora es cuando sirve tener todo guardado en el mismo line)
;; Luego de eso, se buscan los datos usando, para luego nuevamente usar camino-existe? para encontrar el trayecto a aplicar, agregando el dato de velocidad del tren
;; nuevamnete let loop pero ahora guardamos las stations para cambiarlas luego.
;;
;; Por cada recursion se va evaluando el tiempo que queda, restando el stop-time de cada station y ademas lo que se demora (en terminos de velocidad) en pasar
;; la distance de la section (evaluado en segundos).
;;
;; Para terminar se evalua en el cond los casos que pueden suceder, puede pasar que se termine el trayecto dado por camino-existe? y tener que devolverse, se hace eso en reverse-path,
;; para luego dar vuelta las stations y hacer el trayecto devuelta.
;; --------------------------------------------------------------------

;; Dominio: sub (subway) X trainId (int) X time (String en formato HH:MM:SS d 24 hrs)
;; --------------------------------------------------------------------

;; Recorrido: station
;; --------------------------------------------------------------------

;; Recursion: Cola
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: Para poder ir calculando directamente para los cond y saber cuando terminar, operamos con variables nuevas acumuladoras.
;; --------------------------------------------------------------------
(define (where-is-train sub trainId time)
  (let ((line (findf (λ (l)
                       (findf (λ (t) (equal? (car t) trainId))
                              (cdddr l)))
                     (subway-lines sub))))
    (if line
        (let* ((train (findf (λ (t) (equal? (car t) trainId)) (cdddr line)))
               (departure-time (list-ref train 7))
               (departure-station (list-ref train 8))
               (arrival-station (list-ref train 9))
               (elapsed-time (time-difference time departure-time))
               (path (camino-existe? (find-station-by-name departure-station (reverse (cdr (reverse line))))
                                     (find-station-by-name arrival-station (reverse (cdr (reverse line))))
                                     (reverse (cdr (reverse line)))))
               (t-speed (list-ref train 3)))
          (let loop ((remaining-path (reverse path))
                     (remaining-time elapsed-time)
                     (current-station (find-station-by-name departure-station (reverse (cdr (reverse line)))))
                     (start-station (find-station-by-name departure-station (reverse (cdr (reverse line)))))
                     (end-station (find-station-by-name arrival-station (reverse (cdr (reverse line))))))
            (if (null? remaining-path)
                (if (> remaining-time 0)
                    (let ((reverse-path (camino-existe? end-station
                                                        start-station
                                                        (reverse (cdr (reverse line))))))
                      (loop (cdr (reverse reverse-path))
                            remaining-time
                            end-station
                            end-station
                            start-station))
                    current-station)
                (let* ((section (car remaining-path))
                       (section-point1 (section-point1 section))
                       (section-point2 (section-point2 section))
                       (section-distance (section-distance section))
                       (stop-time (station-stop-time section-point1))
                       (travel-time (km-to-seconds section-distance t-speed)))
                  (cond
                   [(<= remaining-time stop-time)
                    current-station]
                   [(> remaining-time (+ stop-time travel-time))
                    (loop (cdr remaining-path)
                          (- remaining-time (+ stop-time travel-time))
                          section-point2
                          start-station
                          end-station)]
                   [else
                    current-station])))))
        '())))

;; =====================================================================
;;
;;                              RF-28
;;
;; =====================================================================

;; Nombre: subwway-train-path
;; --------------------------------------------------------------------

;; Descripcion: La logica es exactamente la misma, lo que cambia es que aca el retorno sera una lista en vez de solo la ultima station.
;; Ademas de generar el loop con un lazy que se fuerza para poder recibir el retorno, sino se queda con la promesa
;; 
;; --------------------------------------------------------------------

;; Dominio: sub (subway) X trainId (int) X time (String en formato HH:MM:SS d 24 hrs)
;; --------------------------------------------------------------------

;; Recorrido: list
;; --------------------------------------------------------------------

;; Recursion: Si 
;; --------------------------------------------------------------------

;; Tipo de Recursion y Razon: Cola, mismas razones que el anterior, acarreo mas variables acumulables para ir viendo las condiciones, ahora se agrega el route, que es la lista de stations visitadas
;; --------------------------------------------------------------------
(define (subway-train-path sub trainId time)
  (let ((line (findf (λ (l)
                       (findf (λ (t) (equal? (car t) trainId))
                              (cdddr l)))
                     (subway-lines sub))))
    (if line
        (let* ((train (findf (λ (t) (equal? (car t) trainId)) (cdddr line)))
               (departure-time (list-ref train 7))
               (departure-station (list-ref train 8))
               (arrival-station (list-ref train 9))
               (elapsed-time (time-difference time departure-time))
               (path (camino-existe? (find-station-by-name departure-station (reverse (cdr (reverse line))))
                                     (find-station-by-name arrival-station (reverse (cdr (reverse line))))
                                     (reverse (cdr (reverse line)))))
               (t-speed (list-ref train 3)))
          ; se fuerza el lazy para entregar resultado
          (force(lazy (let loop ((remaining-path (reverse path))
                           (remaining-time elapsed-time)
                           (route '())
                           (start-station departure-station)
                           (end-station arrival-station))
                  (if (null? remaining-path)
                      (if (> remaining-time 0)
                          (let ((reverse-path (camino-existe? (find-station-by-name end-station (reverse (cdr (reverse line))))
                                                              (find-station-by-name start-station (reverse (cdr (reverse line))))
                                                              (reverse (cdr (reverse line))))))
                            ; cdr del reverse-path sino se toma la misma end station 2 veces
                            (loop (cdr (reverse reverse-path)) 
                                  remaining-time
                                  route
                                  end-station
                                  start-station))
                          (reverse route))
                      (let* ((section (car remaining-path))
                             (section-point1 (section-point1 section))
                             (section-point2 (section-point2 section))
                             (section-distance (section-distance section))
                             (stop-time (station-stop-time section-point1))
                             (travel-time (km-to-seconds section-distance t-speed)))
                        (cond
                          [(<= remaining-time stop-time)
                           (reverse route)]
                          [(> remaining-time (+ stop-time travel-time))
                           (loop (cdr remaining-path)
                                 (- remaining-time (+ stop-time travel-time))
                                 (cons section-point2 route)
                                 start-station
                                 end-station)]
                          [else
                           (reverse route)])))))))
        '())))