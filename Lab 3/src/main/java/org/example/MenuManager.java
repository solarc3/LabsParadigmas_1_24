package org.example;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

import static org.example.ConsoleColors.*;
import org.example.Loaders.CombinationLoader;
import org.example.Loaders.DriverLoader;
import org.example.Loaders.LineLoader;
import org.example.Loaders.TrainLoader;

/**
 * Clase menu que se preocupa de las interacciones por CLI con el usuario
 */
public class MenuManager {
    private Scanner scanner;
    private Subway subway;
    private LineLoader lineLoader;
    private DriverLoader driverLoader;
    private TrainLoader defaultTrainLoader;
    private TrainLoader trainLoader;
    private LineLoader defaultLineLoader;
    private DriverLoader defaultDriverLoader;
    private CombinationLoader combinationLoader;
    private CombinationLoader defaultCombinationLoader;
    // flags para no volver a cargar datos
    private boolean combinationLoaded;
    private boolean driverLoaded;
    private boolean lineLoaded;
    private boolean trainLoaded;
    //line selection
    private Line selectedLine;

    /**
     * Constructor, ademas de preocupa de la carga de datos en base del valor de directLoading
     * Existen 8 archivos, los inicial que se cargan al partir el programa y los que se cargan en el menu 1
     * @param scanner
     * @param subway
     */
    public MenuManager(Scanner scanner, Subway subway) {
        this.scanner = scanner;
        this.subway = subway;
        //estos loaders dejan en la lista intermediaria
        this.lineLoader = new LineLoader(subway, false);
        this.driverLoader = new DriverLoader(subway, false);
        this.trainLoader = new TrainLoader(subway, false);
        this.combinationLoader = new CombinationLoader(subway, false);

        //defaults cargan directamente a el subway
        this.defaultTrainLoader = new TrainLoader(subway, true);  // Para carga directa inicial// Para carga intermediaria posterior
        this.defaultLineLoader = new LineLoader(subway, true);
        this.defaultDriverLoader = new DriverLoader(subway, true);
        this.defaultCombinationLoader = new CombinationLoader(subway, true);


        loadInitialData();
    }

    /**
     * Llama los metodos de cada loader, en este caso los default para cagar datos iniciales/default
     */
    private void loadInitialData() {
        System.out.println(GREEN_BOLD + "Cargando datos defaults para el subway...\n" + RESET);
        defaultTrainLoader.loadData();
        defaultLineLoader.loadData();
        defaultDriverLoader.loadData();
        defaultCombinationLoader.loadData();
        System.out.println(GREEN_BOLD + "Datos iniciales cargados.(Recordar cargar y agregar los extra!)" + RESET);
    }


    // falta combinaciones

    /**
     * Menu inicial prinicipal, selecicon para carga de datos, ver el estado, interactuar y salir
     * Se utilizan metodos de la clase InputHandler para manejar la entrada del usuario y switch cases para la seleccion, asi se ve mejor :)
     * @return
     */
    public boolean showMainMenu() {
        System.out.println(BLUE_BOLD + "\n### Sistema Metro - Inicio ###" + RESET);
        System.out.println("Opciones de creacion de la red de metro y simulacion de ejecucion\n");
        System.out.println("1. Cargar informacion del sistema de metro");
        System.out.println("2. Visualizar estado actual del sistema de metro");
        System.out.println("3. Interactuar con el sistema de metro");
        System.out.println("4. Salir del programa");

        int choice = InputHandler.getIntInput("Ingrese una opcion: ", 1, 4);

        switch (choice) {
            case 1:
                showLoadMenu();
                return false;
            case 2:
                showVisualizeMenu();
                return false;
            case 3:
                showInteractMenu();
                return false;
            case 4:
                System.out.println(YELLOW_BOLD + "Saliendo del programa..." + RESET);
                return true;
            default:
                return false;
        }
    }

    /**
     * Menu de carga de datos, se pueden cargar todos los datos, seleccion 6 carga y asigna ademas al subway.
     * Se pueden cargar los datos pero no agregar al subway, existen metodos para hacer eso manualmente.
     */
    private void showLoadMenu() {
        boolean back = false;
        while (!back) {
            System.out.println(BLUE_BOLD + "\n### Sistema Metro - Cargar informacion " + WHITE_BOLD_BRIGHT+  "adicional " + RESET + BLUE_BOLD  + "del sistema de metro ###" + RESET);
            System.out.println(BLUE_BOLD + "¡Se deben cargar los datos primero para luego agregar al subway!" + RESET + "\n");
            System.out.println("1. Cargar lineas (lineas.txt)");
            System.out.println("2. Cargar combinaciones entre lineas (combinaciones.txt)");
            System.out.println("3. Cargar trenes  (cargar archivo trenes.txt en resources)");
            System.out.println("4. Cargar conductores (cargar archivo conductores.txt)");
            System.out.println("5. Cargar los 4 archivos a la vez");
            System.out.println(GREEN_UNDERLINED + "6. Cargar y agregar todos los datos al sistema" + RESET);
            System.out.println("7. Agregar trenes al subway " + CYAN_BOLD + "RF 18" + RESET);
            System.out.println("8. Agregar lineas al subway " + CYAN_BOLD + "RF 19" + RESET);
            System.out.println("9. Agregar conductores al subway " + CYAN_BOLD + "RF 20" + RESET);
            System.out.println("10. Asignar train a una linea " + CYAN_BOLD + "RF 22" + RESET);
            System.out.println("11. Asignar conductor a un tren " + CYAN_BOLD + "RF 23" + RESET);
            System.out.println("12. Retorno al menu de Inicio");

            int choice = InputHandler.getIntInput("Ingrese una opcion: ", 1, 12);

            switch (choice) {
                case 1:
                    if(lineLoaded){
                        System.out.println(RED_BACKGROUND + BLACK_BOLD  + "\nLos datos de este archivo ya fueron cargados, NO se pueden volver a cargar" + RESET);
                        break;
                    }
                    lineLoaded = true;
                    lineLoader.loadData();
                    break;
                case 2:
                    // TODO: FALTA COMBINACIONES XDDD
                    // Logica para cargar combinaciones desde archivo combinaciones.txt
                    break;
                case 3:
                    if(trainLoaded){
                        System.out.println(RED_BACKGROUND + BLACK_BOLD  + "\nLos datos de este archivo ya fueron cargados, NO se pueden volver a cargar" + RESET);
                        break;
                    }
                    trainLoaded = true;
                    trainLoader.loadData();
                    break;
                case 4:
                    if(driverLoaded){
                        System.out.println(RED_BACKGROUND + BLACK_BOLD  + "\nLos datos de este archivo ya fueron cargados, NO se pueden volver a cargar" + RESET);
                        break;
                    }
                    driverLoaded = true;
                    driverLoader.loadData();
                    break;
                case 5:
                    if(lineLoaded || trainLoaded || driverLoaded) {
                        System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nError: Algunos datos ya han sido cargados. No se puede realizar la carga completa." + RESET);
                        break;
                    }
                    lineLoaded = true;
                    trainLoaded = true;
                    driverLoaded = true;
                    lineLoader.loadData();
                    trainLoader.loadData();
                    driverLoader.loadData();
                    System.out.println(GREEN_BACKGROUND + BLACK_BOLD + "Todos los datos han sido cargados exitosamente" + RESET);
                    break;
                case 6:
                    loadAndAddAllData();
                    break;
                case 7:
                    addTrainsToSubway();
                    break;
                case 8:
                    addLinesToSubway();
                    break;
                case 9:
                    addDriversToSubway();
                    break;
                case 10:
                    assignTrainToLine();
                    break;
                case 11:
                    assignDriverToTrain();
                    break;
                case 12:
                    back = true;
                    break;
                default:
                    System.out.println(RED_BACKGROUND + BLACK_BOLD  + "\nOpcion invalida. Intente nuevamente." + RESET);
                    break;
            }
        }
    }

    /**
     * Menu de print, llama el toString de subway que secuencialmente llama al resto de las clases internas
     * y sus metodos de toString
     */
    private void showVisualizeMenu() {
        boolean back = false;
        while (!back) {
            System.out.println(BLUE_BOLD + "\n### Sistema Metro - Visualizacion del estado actual de la red ###" + RESET);
            System.out.println("1. Mostrar en pantalla el estado actual de la red " + CYAN_BOLD + "RF 21" + RESET);
            System.out.println("2. Retornar al menu de Inicio");
            int choice = InputHandler.getIntInput("Ingrese una opcion: ", 1, 2);

            switch (choice) {
                case 1:
                    System.out.println(subway);
                    break;
                case 2:
                    back = true;
                    break;
                default:
                    System.out.println(RED_BACKGROUND + BLACK_BOLD  + "Opcion invalida. Intente nuevamente." + RESET);
                    break;
            }
        }
    }

    /**
     * Menu de interaccion con el sistema, la gran mayoria de los RF existen aqui, estan señalados con RF al imprimir
     */
    private void showInteractMenu() {
        boolean back = false;
        while (!back) {
            System.out.println(BLUE_BOLD + "\n### Sistema Metro - Interactuar con el sistema de metros ###" + RESET);
            System.out.println("1. lineLength: obtener el largo total de una linea " + CYAN_BOLD + "RF 4" + RESET);
            System.out.println("2. lineSectionLength: determinar el tracto entre una estacion origen y final " + CYAN_BOLD + "RF 5" + RESET);
            System.out.println("3. lineCost: determinar el costo total de recorrer una linea " + CYAN_BOLD + "RF 6" + RESET);
            System.out.println("4. lineSectionCost: determinar el costo de un trayecto entre estacion origen y final " + CYAN_BOLD + "RF 7" + RESET);
            System.out.println("5. isLine: verificar si una linea cumple con las restricciones especificadas " + CYAN_BOLD + "RF 9" + RESET);
            System.out.println("6. Train - addCar: anade un carro de pasajeros a un tren en la posicion establecida " + CYAN_BOLD + "RF 12" + RESET);
            System.out.println("7. Train - removeCar: remueve un carro de pasajeros de un tren en la posicion establecida " + CYAN_BOLD + "RF 13" + RESET);
            System.out.println("8. Train - isTrain: verifica si un tren cumple con las especificaciones de los carros de pasajeros " + CYAN_BOLD + "RF 14" + RESET);
            System.out.println("9. Train - fetchCapacity: entrega la capacidad maxima de pasajeros de un tren " + CYAN_BOLD + "RF 15" + RESET);
            System.out.println("10. Subway - whereIsTrain: determina la ubicacion de un tren a partir de una hora indicada del dia " + CYAN_BOLD + "RF 24" + RESET);
            System.out.println("11. Subway - trainPath: armar el recorrido del tren a partir de una hora especificada y que retorna la lista de estaciones futuras por recorrer " + CYAN_BOLD + "RF 25" + RESET);
            //System.out.println("12. Cambiar linea seleccionada"); //TODO: quiza sacar esta opcion pq ya no selecciono?
            System.out.println("12. Retorno al menu de Inicio");

            int choice = InputHandler.getIntInput("Ingrese una opcion: ", 1, 12);

            switch(choice) {
                case 1:
                    handleLineLength();
                    break;
                case 2:
                    handleLineSectionLength();
                    break;
                case 3:
                    handleLineCost();
                    break;
                case 4:
                    handleLineSectionCost();
                    break;
                case 5:
                    handleIsLine();
                    break;
                case 6:
                    handleAddCar();
                    break;
                case 7:
                    handleRemoveCar();
                    break;
                case 8:
                    handleIsTrain();
                    break;
                case 9:
                    handleFetchCapacity();
                    break;
                case 10:
                    handleWhereIsTrain();
                    break;
                case 11:
                    handleTrainPath();
                    break;
//                case 12:
//                    selectLine();
//                    break;
                case 12:
                    back = true;
                    break;
                default:
                    System.out.println(RED_BACKGROUND + BLACK_BOLD  + "\nOpcion invalida. Intente nuevamente." + RESET);
                    break;
            }
        }
    }

    /**
     * Metodo para cargar los datos de todos los archivos
     */
    private void loadAndAddAllData() {
        if(lineLoaded || trainLoaded || driverLoaded) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nError: Algunos datos ya han sido cargados. No se puede realizar la carga y adicion completa (Se deben ir cargando y asociando de a uno)." + RESET);
            return;
        }

        // Cargar datos
        combinationLoader.loadData();
        lineLoader.loadData();
        trainLoader.loadData();
        driverLoader.loadData();

        // Agregar lineas al subway
        for (Line line : lineLoader.getLoadedLines()) {
            subway.addLine(line);
        }

        // Agregar trenes al subway
        for (Train train : trainLoader.getLoadedTrains()) {
            subway.addTrain(train);
        }

        // Agregar conductores al subway
        for (Driver driver : driverLoader.getLoadedDrivers()) {
            subway.addDriver(driver);
        }

        lineLoaded = true;
        trainLoaded = true;
        driverLoaded = true;

        System.out.println(GREEN_BACKGROUND + BLACK_BOLD + "\nTodos los datos han sido cargados y agregados exitosamente al sistema" + RESET);
    }

    /**
     * Metodo manual para agregar un subway o todos los subway anteriormente cargados
     */
    private void addTrainsToSubway() {
        List<Train> loadedTrains = trainLoader.getLoadedTrains();
        if (loadedTrains.isEmpty()) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nNo hay trenes adicionales cargados para agregar." + RESET);
            return;
        }

        System.out.println("\nTrenes adicionales cargados:");
        for (int i = 0; i < loadedTrains.size(); i++) {
            Train train = loadedTrains.get(i);
            String existenceInfo = subway.getTrainList().stream()
                    .anyMatch(t -> t.getId() == train.getId()) ?
                    RED_BOLD + " [YA EXISTE ESTE ID EN EL SUBWAY]" + RESET : "";
            System.out.println((i + 1) + ". [ID: " + train.getId() + "]" + existenceInfo);
        }

        System.out.println((loadedTrains.size() + 1) + ". Agregar todos los trenes");

        int selection = InputHandler.getIntInput("Seleccione el numero del tren a agregar (0 para cancelar): ", 0, loadedTrains.size() + 1) - 1;

        if (selection == loadedTrains.size()) {
            // Agregar todos los trenes
            for (int i = loadedTrains.size() - 1; i >= 0; i--) {
                Train train = loadedTrains.get(i);
                boolean added = subway.addTrain(train);
                if (added) {
                    loadedTrains.remove(i);
                }
            }
        } else if (selection >= 0 && selection < loadedTrains.size()) {
            Train selectedTrain = loadedTrains.get(selection);
            boolean added = subway.addTrain(selectedTrain);
            if (added) {
                loadedTrains.remove(selection);
            }
        } else if (selection != -1) {
            System.out.println("Seleccion invalida.");
        }
    }

    /**
     * Metodo para agregar lineas al subway anteriormente cargadas, se puede seleccionar una o todas
     */
    private void addLinesToSubway() {
        List<Line> loadedLines = lineLoader.getLoadedLines();
        if (loadedLines.isEmpty()) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "No hay lineas cargadas para agregar." + RESET);
            return;
        }

        System.out.println("Lineas cargadas:");
        for (int i = 0; i < loadedLines.size(); i++) {
            Line line = loadedLines.get(i);
            String existenceInfo = subway.getLineList().stream()
                    .anyMatch(l -> l.getName().equals(line.getName())) ?
                    RED_BOLD + " [YA EXISTE EN EL SUBWAY]" + RESET : "";
            System.out.println((i + 1) + ". " + line.getName() + existenceInfo);
        }

        System.out.println((loadedLines.size() + 1) + ". Agregar todas las lineas");

        int selection = InputHandler.getIntInput("Seleccione el numero de la linea a agregar (0 para cancelar): ", 0, loadedLines.size() + 1) - 1;

        if (selection == loadedLines.size()) {
            // Agregar todas las lineas
            for (int i = loadedLines.size() - 1; i >= 0; i--) {
                Line line = loadedLines.get(i);
                boolean added = subway.addLine(line);
                if (added) {
                    loadedLines.remove(i);
                }
            }
        } else if (selection >= 0 && selection < loadedLines.size()) {
            Line selectedLine = loadedLines.get(selection);
            boolean added = subway.addLine(selectedLine);
            if (added) {
                loadedLines.remove(selection);
            }
        } else if (selection != -1) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD  + "\nSeleccion invalida." + RESET);
        }
    }

    /**
     * Metodo para agregar drivers al subway anteriormente cargados, se puede seleccionar uno o todos
     */
    private void addDriversToSubway() {
        List<Driver> loadedDrivers = driverLoader.getLoadedDrivers();
        if (loadedDrivers.isEmpty()) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nNo hay drivers adicionales cargados para agregar." + RESET);
            return;
        }
        System.out.println(WHITE_BOLD + "Drivers adicionales cargados:" + RESET);
        for (int i = 0; i < loadedDrivers.size(); i++) {
            Driver driver = loadedDrivers.get(i);
            String existenceInfo = subway.getDriverList().stream()
                    .anyMatch(d -> d.getId() == driver.getId()) ?
                    RED_BOLD + " [YA EXISTE ESTE ID EN EL SUBWAY]" + RESET : "";
            System.out.println((i + 1) + ". [ID: " + driver.getId() + "] " + driver.getName() + existenceInfo);
        }

        System.out.println(WHITE_BRIGHT + (loadedDrivers.size() + 1) + ". Agregar todos los drivers" + RESET);

        int selection = InputHandler.getIntInput("Seleccione el numero del driver a agregar (0 para cancelar): ", 0, loadedDrivers.size() + 1) - 1;

        if (selection == loadedDrivers.size()) {
            // Agregar todos los drivers
            for (int i = loadedDrivers.size() - 1; i >= 0; i--) {
                Driver driver = loadedDrivers.get(i);
                boolean added = subway.addDriver(driver);
                if (added) {
                    loadedDrivers.remove(i);
                }
            }
        } else if (selection >= 0 && selection < loadedDrivers.size()) {
            Driver selectedDriver = loadedDrivers.get(selection);
            boolean added = subway.addDriver(selectedDriver);
            if (added) {
                loadedDrivers.remove(selection);
            }
        } else if (selection != -1) {
            System.out.println("\nSeleccion invalida.");
        }
    }

    /**
     * Metodo para agregar un driver a un train
     * Se selecciona un driver de los que esten cargardos y agregados al subway
     * Primero se busca si tienen itinerario en TrainItinerary (Clase agrupadora de info como AdjacentStation)
     * Si no existen, no se pueden asignar
     * Toma en considerancion tambien el fabricante del tren
     * Luego de estas verificaciones, si se puede asignar se pide la hora de salida
     * Si estas verificaciones quedaron completas, se llama la funcion de subway con los argumentos
     * Todo lo anterior a eso se maneja a nivel menu
     */
    private void assignDriverToTrain() {
        List<Driver> subwayDrivers = subway.getDriverList();
        List<TrainItinerary> trainItineraries = subway.getTrainItineraries();

        if (subwayDrivers.isEmpty() || trainItineraries.isEmpty()) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nNo hay conductores o trenes con itinerarios en el subway para asignar." + RESET);
            return;
        }

        System.out.println("\nConductores disponibles:");
        for (int i = 0; i < subwayDrivers.size(); i++) {
            Driver driver = subwayDrivers.get(i);
            String assignmentInfo = "";
            Optional<TrainItinerary> assignment = trainItineraries.stream()
                    .filter(ti -> ti.getDriver() != null && ti.getDriver().equals(driver))
                    .findFirst();
            if (assignment.isPresent()) {
                TrainItinerary ti = assignment.get();
                assignmentInfo = YELLOW_BOLD + " [Asignado a Linea: " + ti.getLine().getName() +
                        ", Tren: " + ti.getTrain().getId() +
                        ", Salida: " + (ti.getDepartureStation() != null ? ti.getDepartureStation().getName() : "N/A") +
                        ", A: " + (ti.getArrivalStation() != null ? ti.getArrivalStation().getName() : "N/A") + "]" + RESET;
            } else {
                long compatibleTrainsCount = trainItineraries.stream()
                        .filter(ti -> ti.getTrain().getMaker().equals(driver.getMaker()))
                        .count();
                if (compatibleTrainsCount > 0) {
                    assignmentInfo = GREEN_BOLD + " [Disponible]" + CYAN_BOLD + " [" + compatibleTrainsCount + " tren(es) compatible(s)]" + RESET;
                } else {
                    assignmentInfo = GREEN_BOLD + " [Disponible]" + RED_BOLD + " [NO HAY TRENES DISPONIBLES DEL MISMO FABRICANTE]" + RESET;
                }
            }
            System.out.println((i + 1) + ". " + driver.getName() + " (Fabricante: " + driver.getMaker() + ")" + assignmentInfo);
        }
        int driverSelection = InputHandler.getIntInput("Seleccione el numero del conductor: ", 1, subwayDrivers.size()) - 1;

        if (driverSelection < 0 || driverSelection >= subwayDrivers.size()) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nSeleccion de conductor invalida." + RESET);
            return;
        }

        Driver selectedDriver = subwayDrivers.get(driverSelection);
        String selectedMaker = selectedDriver.getMaker();

        System.out.println("\nTrenes disponibles del fabricante " + selectedMaker + " con itinerarios incompletos:");
        List<TrainItinerary> compatibleItineraries = new ArrayList<>();
        for (TrainItinerary ti : trainItineraries) {
            if (ti.getTrain().getMaker().equals(selectedMaker) && ti.getDriver() == null) {
                compatibleItineraries.add(ti);
                String lineInfo = ti.getLine() != null ?
                        CYAN_BOLD + " [Asignado a linea: " + ti.getLine().getName() + "]" + RESET :
                        GREEN_BOLD + " [No asignado a ninguna linea]" + RESET;
                String stationInfo = "";
                if (ti.getDepartureStation() != null && ti.getArrivalStation() != null) {
                    stationInfo = YELLOW_BOLD + " [De: " + ti.getDepartureStation().getName() + ", A: " + ti.getArrivalStation().getName() + "]" + RESET;
                }
                System.out.println(compatibleItineraries.size() + ". Tren ID: " + ti.getTrain().getId() + lineInfo + stationInfo);
            }
        }

        if (compatibleItineraries.isEmpty()) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nNo hay trenes disponibles del mismo fabricante que el conductor con itinerarios incompletos." + RESET);
            return;
        }

        int trainSelection = InputHandler.getIntInput("Seleccione el numero del tren: ", 1, compatibleItineraries.size()) - 1;

        if (trainSelection < 0 || trainSelection >= compatibleItineraries.size()) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nSeleccion de tren invalida." + RESET);
            return;
        }

        TrainItinerary selectedItinerary = compatibleItineraries.get(trainSelection);
        Train selectedTrain = selectedItinerary.getTrain();
        Line selectedLine = selectedItinerary.getLine();

        if (selectedLine == null) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nError: El tren seleccionado no esta asignado a ninguna linea. " +
                    "Por favor, asigne el tren a una linea antes de asignar un conductor." + RESET);
            return;
        }

        // Si el itinerario ya tiene estaciones de salida y llegada, las usamos
        Station departureStation = selectedItinerary.getDepartureStation();
        Station arrivalStation = selectedItinerary.getArrivalStation();

        // Si no, pedimos al usuario que las seleccione
        if (departureStation == null || arrivalStation == null) {
            List<Station> lineStations = selectedLine.getUniqueStations();
            departureStation = selectStation(lineStations, "partida", null);
            if (departureStation == null) return;
            arrivalStation = selectStation(lineStations, "llegada", departureStation);
            if (arrivalStation == null) return;
        }

        // Solicitamos la hora de partida
        String departureTimeStr = InputHandler.getStringInput("\nIngrese la hora de partida (formato HH:mm): ");
        Date departureTime = parseTime(departureTimeStr);
        if(departureTime == null){
            System.out.print(RED_BACKGROUND + BLACK_BOLD + "Formato erroneo, por favor intentelo de nuevo" + RESET);
            return;
        }

        subway.assignDriverToTrain(selectedTrain, selectedDriver, departureTime, departureStation, arrivalStation, selectedLine.getId());
        System.out.println("\n" + GREEN_BOLD + "Conductor asignado al tren exitosamente." + RESET);
    }

    /**
     * Metodo para manejar la seccion de una stacion respecto a una linea
     * Se hace un while true loop para tomar 2 estaciones, con cambio de color al seleccionar
     * Se considera ademas que luego de seleccionar la inicial, esta no se puede seleccionar como final
     * No se puede salir hasta que se seleccione una estacion valida
     * @param stations
     * @param type
     * @param excludeStation
     * @return
     */
    private Station selectStation(List<Station> stations, String type, Station excludeStation) {
        while (true) {
            System.out.println("\nEstaciones disponibles para " + type + ":");
            for (int i = 0; i < stations.size(); i++) {
                Station station = stations.get(i);
                String stationInfo = (i + 1) + ". [" + station.getName() + "]";
                if (station.equals(excludeStation)) {
                    System.out.println(GREEN_BOLD  + stationInfo + " (Estacion en uso)" + RESET);
                } else {
                    System.out.println(stationInfo);
                }
            }

            int stationSelection = InputHandler.getIntInput("Seleccione el numero de la estacion de " + type + " (0 para cancelar): ", 0, stations.size()) - 1;

            if (stationSelection == -1) {
                return null;
            }

            if (stationSelection >= 0 && stationSelection < stations.size()) {
                Station selectedStation = stations.get(stationSelection);
                if (selectedStation.equals(excludeStation)) {
                    System.out.println(RED_BACKGROUND + BLACK_BOLD + "Error: No se puede seleccionar la misma estacion para origen y destino." + RESET);
                    continue;
                }
                return selectedStation;
            } else {
                System.out.println(RED_BACKGROUND + BLACK_BOLD + "Seleccion de estacion invalida." + RESET);
            }
        }
    }

    /**
     * El metodo se preocupa de pedir un train, verificar que existan carros disponibles, que se puedan agregar a una linea
     * y que no este asignado anteriormente a otra (sino se puede sobreescribir)
     * Se termina con el llamado al metodo de subway
     */
    private void assignTrainToLine() {
        List<Train> subwayTrains = subway.getTrainList();
        List<TrainItinerary> trainItineraries = subway.getTrainItineraries();
        List<Line> subwayLines = subway.getLineList();

        if (subwayTrains.isEmpty() || subwayLines.isEmpty()) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "No hay trenes o lineas disponibles en el subway para asignar." + RESET);
            return;
        }

        System.out.println("\nTrenes disponibles:");
        for (int i = 0; i < subwayTrains.size(); i++) {
            Train train = subwayTrains.get(i);
            Optional<TrainItinerary> itinerary = trainItineraries.stream()
                    .filter(ti -> ti.getTrain().equals(train))
                    .findFirst();
            String lineInfo = itinerary.map(trainItinerary -> CYAN_BOLD + " [Asignado a linea: " + trainItinerary.getLine().getName() + "]"  + RESET).orElse(GREEN_BOLD + "[No asignado a ninguna linea]" + RESET);

            long availableDrivers = subway.getDriverList().stream()
                    .filter(d -> d.getMaker().equals(train.getMaker()) &&
                            trainItineraries.stream().noneMatch(ti -> ti.getDriver() != null && ti.getDriver().equals(d)))
                    .count();
            String driverInfo = YELLOW_BOLD + " [Conductores disponibles: " + availableDrivers + "]" + RESET;

            System.out.println((i + 1) + ". ID: " + train.getId() + " [Fabricante: " + train.getMaker() + "]" + lineInfo + driverInfo);
        }
        int trainSelection = InputHandler.getIntInput("Seleccione el numero del tren: ", 1, subwayTrains.size()) - 1;

        if (trainSelection < 0 || trainSelection >= subwayTrains.size()) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "Seleccion de tren invalida." + RESET);
            return;
        }

        Train selectedTrain = subwayTrains.get(trainSelection);

        // Verificar si el tren ya esta asignado
        Optional<TrainItinerary> existingItinerary = trainItineraries.stream()
                .filter(ti -> ti.getTrain().equals(selectedTrain))
                .findFirst();

        if (existingItinerary.isPresent()) {
            System.out.println(YELLOW_BOLD + "ADVERTENCIA: El tren ya esta asignado a la linea " +
                    existingItinerary.get().getLine().getName() + RESET);
            boolean reassign = InputHandler.getBooleanInput("¿Desea reasignar?");
            if (!reassign) {
                return;
            }
        }

        System.out.println("\nLineas disponibles:");
        for (int i = 0; i < subwayLines.size(); i++) {
            Line line = subwayLines.get(i);
            System.out.println((i + 1) + ". " + line.getName());
        }
        int lineSelection = InputHandler.getIntInput("Seleccione el numero de la linea: ", 1, subwayLines.size()) - 1;

        if (lineSelection < 0 || lineSelection >= subwayLines.size()) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "Seleccion de linea invalida." + RESET);
            return;
        }

        Line selectedLine = subwayLines.get(lineSelection);

        // Asignar tren a linea
        subway.assignTrainToLine(selectedTrain, selectedLine);
        System.out.println(CYAN_BOLD + "Tren " + selectedTrain.getId() +
                " asignado exitosamente a la linea " + selectedLine.getName() + RESET);
    }

    /**
     * Funcion que da el permite parsea el tiempo formato XX:YY
     * El proyecto solo se hace alrededor de 1 dia, por lo mismo se usa SimpleDateFormat
     * Se quita Lenient para que si o si se tengan fechas validas
     * @param timeStr
     * @return
     */
    private Date parseTime(String timeStr) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
            sdf.setLenient(false);
            return sdf.parse(timeStr);
        } catch (ParseException e) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "Formato de hora invalido. Por favor, use el formato HH:mm." + RESET);
            return null;
        }
    }
    //--------------



    // Metodos auxiliares para manejar las opciones del menu de interaccion
    /**
     * METODOS HANDLERS SE PREOCUPAN DE LA INTERACCION PERSONA <-> MENU
     * RECOPILAN LOS PARAMETROS NECESARIOS PARA LLAMAR LOS METODOS DE LAS RESPECTIVAS CLASES
     * NINGA DE ESTAS TIENE LA LOGICA DE SU METODO
     * PARA LOS METODOS QUE REQUIERAN UNA LINEA, SE SELECCIONA ESTA PARA CADA UNO
     * ESTO ES PARA INTENTAR RESPETAR SINGLE RESPONSABILITY PRINCIPLE
     */

    /**
     * Metodo que maneja la seleccion de una linea y entrega su largo en pantalla
     */
    private void handleLineLength() {
        Line selectedLine = selectLine();
        if (selectedLine == null) return;
        System.out.println(CYAN_BOLD + "\nLargo total de la linea " + selectedLine.getName() + ": " + selectedLine.getLength());
    }

    /**
     * Metodo que maneja la seleccion de un tramo y entrega su largo en pantalla
     * Utiliza el metodo getSectionLength de la clase Line para para el resultado
     */
    private void handleLineSectionLength() {
        Line selectedLine = selectLine();
        if (selectedLine == null) return;

        System.out.println("\nSeleccion de estaciones para calcular el largo del tramo:");
        Station departureStation = selectStation(selectedLine.getUniqueStations(), "origen", null);
        if (departureStation == null) return;

        Station arrivalStation = selectStation(selectedLine.getUniqueStations(), "destino", departureStation);
        if (arrivalStation == null) return;

        try {
            double length = selectedLine.getSectionLength(departureStation.getName(), arrivalStation.getName());
            System.out.println(CYAN_BOLD+ "\nLargo del tramo: " + length);
        } catch (IllegalArgumentException e) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nError: " + e.getMessage() + RESET);
        }
    }
    /**
     * Metodo que maneja la seleccion de una linea y entrega su costo en pantalla
     */
    private void handleLineCost() {
        Line selectedLine = selectLine();
        if (selectedLine == null) return;
        System.out.println(CYAN_BOLD +"\nCosto total de la linea " + selectedLine.getName() + ": " + selectedLine.getCost());
    }

    /**
     * Metodo que maneja la seleccion de un tramo y entrega su costo en pantalla
     */
    private void handleLineSectionCost() {
        Line selectedLine = selectLine();
        if(selectedLine == null) return;
        System.out.println("\nSeleccion de estaciones para calcular el costo del tramo:");
        Station departureStation = selectStation(selectedLine.getUniqueStations(), "origen", null);
        if (departureStation == null) return;
        Station arrivalStation = selectStation(selectedLine.getUniqueStations(), "destino", departureStation);
        if (arrivalStation == null) return;
        double cost = selectedLine.getSectionCost(departureStation.getName(), arrivalStation.getName());
        System.out.println(CYAN_BOLD + "\nLargo del tramo: " + cost);
    }
    /**
     * Metodo que maneja la seleccion de una linea y entrega si es linea o no en pantalla
     */
    private void handleIsLine() {
        Line selectedLine = selectLine();
        if(selectedLine == null) return;
        boolean status = selectedLine.isLine();
        System.out.println(RED_BOLD + "\nES LINEA: " + RESET + (status ? CYAN_BOLD + "SI" : RED_BOLD + "NO"));
    }

    /**
     * Metodo que maneja la seleccion de un tren y entrega su capacidad en pantalla
     */
    private void handleAddCar() {
        Train selectedTrain = selectTrain();
        if (selectedTrain == null) return;

        List<Pcar> compatiblePcars = getCompatiblePcars(selectedTrain);

        if (compatiblePcars.isEmpty()) {
            System.out.println(YELLOW_BOLD + "Advertencia: Ninguno de los pcars es compatible con la seleccion." + RESET);
        } else {
            System.out.println(GREEN_BOLD + "\nPcars compatibles disponibles:" + RESET);
        }

        List<Pcar> pcarsToShow = subway.getPcarsList();

        for (int i = 0; i < pcarsToShow.size(); i++) {
            Pcar pcar = pcarsToShow.get(i);
            String compatibilityInfo = compatiblePcars.contains(pcar) ? GREEN_BOLD + " [Compatible]" + RESET : RED_BOLD + " [No compatible]" + RESET;
            System.out.println((i + 1) + ". ID: " + pcar.getId() + ", Maker: " + pcar.getMaker() + ", Type: " + pcar.getType() + compatibilityInfo);
        }

        int choice = InputHandler.getIntInput("\nSelecciona un Pcar (1-" + pcarsToShow.size() + "): ", 1, pcarsToShow.size());
        Pcar selectedPcar = pcarsToShow.get(choice - 1);

        if (!isPcarCompatible(selectedTrain, selectedPcar)) {
            System.out.println(RED_BOLD + "\nEl Pcar seleccionado no es compatible con este Train." + RESET);
            return;
        }

        int position = InputHandler.getIntInput("\nIngresa la posicion para agregar el Pcar (0 a " + selectedTrain.getCarList().size() + "): ", 0, selectedTrain.getCarList().size());

        try {
            selectedTrain.addCar(selectedPcar, position);
            subway.getPcarsList().remove(selectedPcar);
            System.out.println(GREEN_BOLD + "\nPcar agregado exitosamente." + RESET);
        } catch (IllegalArgumentException e) {
            System.out.println(RED_BOLD + "\nNo se pudo agregar el Pcar: " + e.getMessage() + RESET);
        }
    }
        private List<Pcar> getCompatiblePcars(Train train) {
        return subway.getPcarsList().stream()
                .filter(pcar -> isPcarCompatible(train, pcar))
                .collect(Collectors.toList());
    }

    /**
     * Metodo que maneja la seleccion de un tren y entrega su capacidad en pantalla
     */
    private void handleRemoveCar() {
        Train selectedTrain = selectTrain();
        if (selectedTrain == null) return;

        List<Pcar> carList = selectedTrain.getCarList();
        if (carList.isEmpty()) {
            System.out.println(YELLOW_BOLD + "\nEste tren no tiene Pcars para eliminar." + RESET);
            return;
        }

        System.out.println("\nPcars en el Train");
        for (int i = 0; i < carList.size(); i++) {
            System.out.println(i + ": " + carList.get(i));
        }

        int position = InputHandler.getIntInput("\nIngresa la posicion del carro para remover. (0 to " + (carList.size() - 1) + "): ", 0, carList.size() - 1);

        try {
            Pcar removedCar = carList.get(position);
            selectedTrain.removeCar(position);
            subway.getPcarsList().add(removedCar);
            System.out.println(CYAN_BOLD + "\nPcar eliminiado y retornado a la lista de Pcars del subway." + RESET);
        } catch (IllegalArgumentException e) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "Error: " + e.getMessage() + RESET);
        }
    }

    /**
     * Metodo que maneja la seleccion de un tren y entrega si es tren o no en pantalla
     *
     * @return Pcar seleccionado
     */
    private Pcar selectPcar() {
        List<Pcar> availablePcars = subway.getPcarsList();
        if (availablePcars.isEmpty()) {
            System.out.println(YELLOW_BOLD + "\nNo hay Pcars en la lista de Pcars del subway." + RESET);
            return null;
        }

        System.out.println("\nPcars disponibles:");
        for (int i = 0; i < availablePcars.size(); i++) {
            Pcar pcar = availablePcars.get(i);
            System.out.println((i + 1) + ". ID: " + pcar.getId() + ", Maker: " + pcar.getMaker() + ", Type: " + pcar.getType());
        }

        int choice = InputHandler.getIntInput("\nSelecciona un Pcar: (1-" + availablePcars.size() + "): ", 1, availablePcars.size());
        return availablePcars.get(choice - 1);
    }

    /**
     * Metodo que verifica si un pcar dado es compatible con un train dado
     * @param train
     * @param pcar
     * @return true si es compatible, false si no
     */
    private boolean isPcarCompatible(Train train, Pcar pcar) {
        if (!train.getMaker().equals(pcar.getMaker())) {
            return false;
        }
        List<Pcar> carList = train.getCarList();
        int totalCars = carList.size();

        if (totalCars == 0) {
            return pcar.getType().equals("tr");
        } else if (totalCars == 1) {
            return pcar.getType().equals("tr") && carList.get(0).getType().equals("tr");
        } else {
            if (pcar.getType().equals("tr")) {
                return carList.get(0).getType().equals("ct") || carList.get(totalCars - 1).getType().equals("ct");
            } else { // pcar.getType().equals("ct")
                return carList.get(0).getType().equals("tr") && carList.get(totalCars - 1).getType().equals("tr");
            }
        }
    }

    /**
     * Metodo que maneja la seleccion de un tren y entrega si es tren o no en pantalla
     * usa el metodo de train isTrain
     */
    private void handleIsTrain() {
        Train selectedTrain = selectTrain();
        if (selectedTrain == null) return;

        boolean isTrain = selectedTrain.isTrain();
        System.out.println(isTrain ?
                GREEN_BOLD + "\nEl Train seleccionado cumple los requisitos" + RESET :
                RED_BOLD + "\nEl Train seleccionado no cumple los requisitos." + RESET);
    }

    /**
     * Metodo que maneja la seleccion de un tren y entrega devuelta el mismo
     * Se usa InputHandler para seleccionar el tren
     *
     * @return Train seleccionado
     */
    private Train selectTrain() {
        List<Train> trains = subway.getTrainList();
        if (trains.isEmpty()) {
            System.out.println(YELLOW_BOLD + "\nNo hay trenes disponibles en el subway." + RESET);
            return null;
        }

        System.out.println("\nTrenes disponibles: ");
        for (int i = 0; i < trains.size(); i++) {
            System.out.println((i + 1) + ". Train ID: " + trains.get(i).getId());
        }

        int choice = InputHandler.getIntInput("\nSelecciona un Train: (1-" + trains.size() + "): ", 1, trains.size());
        return trains.get(choice - 1);
    }

    /**
     * Metodo que maneja la seleccion de un train y retorna su capacidad via .fecthCapacity()
     */
    private void handleFetchCapacity() {
        Train selectedTrain = selectTrain();
        if (selectedTrain == null) return;
        int capacity = selectedTrain.fetchCapacity();
        System.out.println(CYAN_BOLD + "\nLa capacidad maxima de pasageros del tren es: " + capacity + RESET);
    }

    /**
     * Metodo que maneja la seleccion de trenes con itinerarios completos y entrega la ubicacion dado un tiempo especifico
     * Se pide la hora y se llama a subway.whereIsTrain
     * Imprime en pantalla donde se encuentra
     */
    private void handleWhereIsTrain() {
        //recolectamos solo los trenes que tengan itinerario completo
        List<TrainItinerary> completeItineraries = subway.getTrainItineraries().stream()
                .filter(ti -> ti.getTrain() != null &&
                        ti.getDriver() != null &&
                        ti.getLine() != null &&
                        ti.getDepartureTime() != null &&
                        ti.getDepartureStation() != null &&
                        ti.getArrivalStation() != null)
                .collect(Collectors.toList());

        if (completeItineraries.isEmpty()) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "No hay trenes con itinerarios completos disponibles.\n" + RESET + YELLOW_UNDERLINED +"Hint: Agregar los itinerarios en el menu 1" + RESET+ CYAN_BOLD + "(RF22" +  " y " +  "RF23)" + RESET + "\n");
            return;
        }

        System.out.println(CYAN_BOLD + "\nTrenes disponibles con itinerarios completos:" + RESET);
        for (int i = 0; i < completeItineraries.size(); i++) {
            TrainItinerary ti = completeItineraries.get(i);
            System.out.printf("%d. Tren ID: %d, Linea: %s, Conductor: %s%n",
                    i + 1, ti.getTrain().getId(), ti.getLine().getName(), ti.getDriver().getName());
        }

        int choice = InputHandler.getIntInput("Seleccione un tren (1-" + completeItineraries.size() + "): ", 1, completeItineraries.size());
        TrainItinerary selectedItinerary = completeItineraries.get(choice - 1);

        String timeStr = InputHandler.getStringInput("Ingrese la hora para verificar la ubicacion del tren (formato HH:mm): ");
        Date time = parseTime(timeStr);
        if(time == null){
            System.out.print(RED_BACKGROUND + BLACK_BOLD + "Formato erroneo, porfavor intentalo denuevo" + RESET);
            return;
        }
        if(time.toInstant().isBefore(selectedItinerary.getDepartureTime().toInstant())){
            System.out.print(RED_BACKGROUND + BLACK_BOLD + "No se puede comparar un horario anterior al inicio del trayecto, intentalo denuevo." + RESET);
            return;
        }
        //ya teniendo el train y su tiempo, no hay que revisar denuevo el tema de si puede hacer el trayecto, eso se confirma en el itinerario
        Station location = subway.whereIsTrain(selectedItinerary.getTrain(), time);
        System.out.println(CYAN_BOLD + "\nUbicacion del tren: " + location + RESET);
    }

    /**
     * Metodo que maneja la seleccion de trenes con itinerarios completos y entrega el trayecto dado un tiempo especifico
     */
    private void handleTrainPath() {
        List<TrainItinerary> completeItineraries = subway.getTrainItineraries().stream()
                .filter(ti -> ti.getTrain() != null &&
                        ti.getDriver() != null &&
                        ti.getLine() != null &&
                        ti.getDepartureTime() != null &&
                        ti.getDepartureStation() != null &&
                        ti.getArrivalStation() != null)
                .collect(Collectors.toList());
        if (completeItineraries.isEmpty()) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nNo hay trenes con itinerarios completos disponibles." + RESET + "\n" + YELLOW_UNDERLINED +"Hint: Agregar los itinerarios en el menu 1" + RESET+ CYAN_BOLD + "(RF22" +  " y " +  "RF23)" + RESET);
            return;
        }
        System.out.println(CYAN_BOLD + "Trenes disponibles con itinerarios completos:" + RESET);
        for (int i = 0; i < completeItineraries.size(); i++) {
            TrainItinerary ti = completeItineraries.get(i);
            System.out.printf("%d. Tren ID: %d, Linea: %s, Conductor: %s%n",
                    i + 1, ti.getTrain().getId(), ti.getLine().getName(), ti.getDriver().getName());
        }
        int choice = InputHandler.getIntInput("\nSeleccione un tren (1-" + completeItineraries.size() + "): ", 1, completeItineraries.size());
        TrainItinerary selectedItinerary = completeItineraries.get(choice - 1);

        String timeStr = InputHandler.getStringInput("\nIngrese la hora para verificar la ubicacion del tren (formato HH:mm): ");
        Date time = parseTime(timeStr);
        if(time == null){
            System.out.print(RED_BACKGROUND + BLACK_BOLD + "\nFormato erroneo, porfavor intentalo denuevo" + RESET);
            return;
        }
        if(time.toInstant().isBefore(selectedItinerary.getDepartureTime().toInstant())){
            System.out.print(RED_BACKGROUND + BLACK_BOLD + "\nNo se puede comparar un horario anterior al inicio del trayecto, intentalo denuevo." + RESET);
            return;
        }
        List<Station> trainJourney = subway.trainPath(selectedItinerary.getTrain(), time);
        //imprimir estaciones
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        System.out.println(CYAN_BOLD + "\nRecorrido del tren entre: " + sdf.format(selectedItinerary.getDepartureTime()) + " y " + sdf.format(time));
        for(Station station : trainJourney){
            System.out.println("-> "+ station);
        }

    }

    /**
     * Metodo para elegir una linea para trabajar con ella
     * @return Line selected
     */
    private Line selectLine() {
        List<Line> lines = subway.getLineList();
        if (lines.isEmpty()) {
            System.out.println(RED_BACKGROUND + WHITE_BOLD + "\nNo hay lineas disponibles en el sistema." + RESET);
            return null;
        }

        System.out.println("\nLineas disponibles:");
        for (int i = 0; i < lines.size(); i++) {
            System.out.println((i + 1) + ". " + lines.get(i).getName());
        }

        int choice = InputHandler.getIntInput("Seleccione el numero de la linea: ", 1, lines.size());
        return lines.get(choice - 1);
    }
}