package org.example;

import org.example.Interfaces.SubwayInterface;

import java.time.Duration;
import java.util.*;
import java.util.stream.Collectors;

import static org.example.ConsoleColors.*;

/**
 * Clase que representa el subway en su totalidad
 */
public class Subway implements SubwayInterface {
    private List<Train> trainList;
    private List<Line> lineList;
    private List<Driver> driverList;
    private List<Pcar> pcarsList;
    private List<TrainItinerary> trainItineraries;
    private Map<Station, List<Station>> combinations; // para guardar las combinaciones
    private int id;
    private String name;

    public Subway(int id, String name) {
        this.id = id;
        this.name = name;
        this.trainList = new ArrayList<>();
        this.lineList = new ArrayList<>();
        this.driverList = new ArrayList<>();
        this.pcarsList = new ArrayList<>();
        this.trainItineraries = new ArrayList<>();
        this.combinations = new HashMap<>();
    }

    /**
     * retorna el id de un subway
     * @return id
     */
    @Override
    public int getId() {
        return id;
    }

    @Override
    public String getName() {
        return name;
    }

    public List<Line> getLineList(){
        return lineList;
    }

    public List<Train> getTrainList(){
        return trainList;
    }

    public List<Driver> getDriverList() {
        return driverList;
    }

    public List<Pcar> getPcarsList() {
        return pcarsList;
    }

    public List<TrainItinerary> getTrainItineraries() {
        return trainItineraries;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(GREEN_BOLD + "Subway ID: ").append(id).append(", Name: ").append(name).append(RESET).append("\n");

        sb.append(GREEN_BOLD + "Trains: " + RESET).append(trainList.stream()
                .map(Train::toString)
                .collect(Collectors.joining(""))).append("\n");

        sb.append(GREEN_BOLD + "Lines: " + RESET).append(lineList.stream()
                .map(Line::toString)
                .collect(Collectors.joining(""))).append("\n");

        sb.append(GREEN_BOLD + "Drivers: " + RESET).append(driverList.stream()
                .map(Driver::toString)
                .collect(Collectors.joining(""))).append("\n");

        sb.append(GREEN_BOLD + "Passenger Cars: " + RESET).append(pcarsList.stream()
                .map(Pcar::toString)
                .collect(Collectors.joining(""))).append("\n");

        sb.append(GREEN_BOLD + "Train Itineraries:\n" + RESET);
        for (TrainItinerary ti : trainItineraries) {
            sb.append("  Train:").append(ti.getTrain().getId())
                    .append(", Line:").append(ti.getLine().getName())
                    .append(", Driver:").append(ti.getDriver() != null ? ti.getDriver().getName() : "N/A")
                    .append(", Departure:").append(ti.getDepartureStation() != null ? ti.getDepartureStation().getName() : "N/A")
                    .append(", Arrival:").append(ti.getArrivalStation() != null ? ti.getArrivalStation().getName() : "N/A")
                    .append("\n");
        }
        sb.append(GREEN_BOLD + "Combinations: " + RESET);
        combinations.forEach((station, connectedStations) -> {
            sb.append(station.getName()).append(": ");
            sb.append(connectedStations.stream()
                    .map(Station::getName)
                    .collect(Collectors.joining(", ")));
            sb.append(" | ");
        });
        sb.append("\n");
        return sb.toString();
    }

    /**
     * Para agregar un train al subway se verificar que no exista ya en la lista de trains
     * @param train
     * @return True si se agrego, False si no se agrego
     */
    @Override
    public boolean addTrain(Train train) {
        for (Train existingTrain : trainList) {
            if (existingTrain.getId() == train.getId()) {
                System.out.println(YELLOW_BOLD + "\nAlerta: Train con ID: " + train.getId() + " ya existe en el subway, no se agrego." + RESET);
                return false;
            }
            if (existingTrain.equals(train)) {
                System.out.println(YELLOW_BOLD + "Alerta: Ya existe un Train identico en el subway, no se agrego." + RESET);
                return false;
            }
        }
        this.trainList.add(train);
        System.out.println(GREEN_BOLD + "Train ID: " + train.getId() + " agregado al Subway.\n" + RESET);
        return true;
    }

    /**
     * Para agregar una linea se verifica que no exista en el subway
     * @param line
     * @return True si se agrego, False si no se agrego
     */
    @Override
    public boolean addLine(Line line) {
        for (Line existingLine : lineList) {
            if (existingLine.getId() == line.getId()) {
                System.out.println(YELLOW_BOLD + "\nAdvertencia: Line con ID " + line.getId() + " ya existe en el subway, no fue agregado." + RESET);
                return false;
            }
            if (existingLine.equals(line)) {
                System.out.println(YELLOW_BOLD + "\nAdvertencia: Ya existe un line identico en el subway, no fue agregado." + RESET);
                return false;
            }
        }
        this.lineList.add(line);
        System.out.println(GREEN_BOLD + "Line ID: " + line.getId() + " agregado al Subway.\n" + RESET);
        return true;
    }

    /**
     * Para agregar un driver se verifica con el id si no existe ya
     * @param driver
     * @return True si se agrego, False si no se agrego
     */
    @Override
    public boolean addDriver(Driver driver) {
        for (Driver existingDriver : driverList) {
            if (existingDriver.getId() == driver.getId()) {
                System.out.println(YELLOW_BOLD + "\nAlerta: Driver con ID " + driver.getId() + " ya existe en el subway, no fue agregado." + RESET);
                return false;
            }
            if (existingDriver.equals(driver)) {
                System.out.println(YELLOW_BOLD + "\nAlerta: Ya existe un driver identico en el subway, no fue agregado" + RESET);
                return false;
            }
        }
        this.driverList.add(driver);
        System.out.println(GREEN_BOLD + "\nDriver ID: " + driver.getId() + " agregado al Subway." + RESET);
        return true;
    }

    /**
     * Se verifica que el pcar no exista ya en el subway para ser agregado
     * @param pcar
     * @return True si se agrego, False si no se agrego
     */
    public boolean addPcar(Pcar pcar) {
        for (Pcar existingPcar : pcarsList) {
            if (existingPcar.getId() == pcar.getId()) {
                System.out.println(YELLOW_BOLD + "Alerta: Pcar con ID " + pcar.getId() + " ya existe en el subway." + RESET);
                return false;
            }
            if (existingPcar.equals(pcar)) {
                System.out.println(YELLOW_BOLD + "Aletar: Un pcar identico ya existe en el subway." + RESET);
                return false;
            }
        }
        this.pcarsList.add(pcar);
        System.out.println(GREEN_BOLD + "Passenger Car agregado exitosamente al Subway." + RESET);
        return true;
    }

    /**
     * Se verifica inicialmente que el train y line dado se encuentre en el subway, algo rebuscado ya que el Menu tambien hace
     * esta verificacion para presentarlo
     * Si ambos existen, se procede a crear un itinerario para el train y asignarle la linea
     * Los itinerarios guardan la info respecto a un train, driver, line, estacion de salida y llegada
     * @param train
     * @param line
     */
    @Override
    public void assignTrainToLine(Train train, Line line) {
        if (!trainList.contains(train)) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nError: Train no encontrado en el sistema" + RESET);
            return;
        }
        if (!lineList.contains(line)) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nError: Linea no encontrada en el sistema." + RESET);
            return;
        }

        // Si la verificacion pasa, proceder con la asignacion
        TrainItinerary itinerary = trainItineraries.stream()
                .filter(ti -> ti.getTrain().equals(train))
                .findFirst()
                .orElseGet(() -> {
                    TrainItinerary newItinerary = new TrainItinerary(train, null, line, null, null, null);
                    trainItineraries.add(newItinerary);
                    return newItinerary;
                });

        itinerary.setLine(line);
        System.out.println(GREEN_BOLD + "\nTrain asignado a la linea." + RESET);
    }

    /**
     * Se verifica que el train y driver existan en el subway
     * Si es que ya fue asignado el train o el driver, se rechaza la solicitud
     * Si es que se pasa todo, se agrega a su itinerario con los datos faltantes, en el paso anterior,
     * varios parametros quedaban como NULL
     * De igual forma se verifica si no tiene, es redundante pero se hace por si acaso
     * @param train
     * @param driver
     * @param departureTime
     * @param departureStation
     * @param arrivalStation
     * @param lineID
     */
    @Override
    public void assignDriverToTrain(Train train, Driver driver, Date departureTime, Station departureStation, Station arrivalStation, int lineID) {
        Line line = getLineById(lineID);
        if (line == null) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nError: Linea no encontrada en el sistema" + RESET);
            return;
        }
        if (!driverList.contains(driver)) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nError: Driver no encontrado en el sistema" + RESET);
            return;
        }

        boolean driverAlreadyAssigned = trainItineraries.stream()
                .anyMatch(ti -> ti.getDriver() != null && ti.getDriver().equals(driver) && !ti.getTrain().equals(train));
        if (driverAlreadyAssigned) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nError: El driver ya esta asignado a otro Train" + RESET);
            return;
        }

        // Verificar si el tren ya tiene un conductor asignado
        boolean trainAlreadyHasDriver = trainItineraries.stream()
                .anyMatch(ti -> ti.getTrain().equals(train) && ti.getDriver() != null && !ti.getDriver().equals(driver));
        if (trainAlreadyHasDriver) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nError: el Train ya tiene un Driver asignado" + RESET);
            return;
        }

        // Verificar si el tren ya esta asignado a una linea diferente
        boolean trainAssignedToDifferentLine = trainItineraries.stream()
                .anyMatch(ti -> ti.getTrain().equals(train) && !ti.getLine().equals(line));
        if (trainAssignedToDifferentLine) {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nError: El Train ya esta asignado a otra Linea" + RESET);
            return;
        }

        // Si todas las verificaciones pasan, proceder con la asignacion
        TrainItinerary itinerary = trainItineraries.stream()
                .filter(ti -> ti.getTrain().equals(train))
                .findFirst()
                .orElseGet(() -> {
                    TrainItinerary newItinerary = new TrainItinerary(train, null, line, null, null, null);
                    trainItineraries.add(newItinerary);
                    return newItinerary;
                });

        itinerary.setDriver(driver);
        itinerary.setLine(line);
        itinerary.setDepartureTime(departureTime);
        itinerary.setDepartureStation(departureStation);
        itinerary.setArrivalStation(arrivalStation);

        //System.out.println(GREEN_BOLD + "Driver assigned to train successfully." + RESET);
    }

    /**
     * Funcion que dado el itinerario inicial puede encontrar junto al grafo el camino y la duracion que hay entre medio
     * No es necesario recuperar el line debido a que esa informacion se esta almacenando en su itinerario, se usa un getter simplemente
     * Se encuentra del path el tamaño y se calcula el tiempo que se demora en llegar a la siguiente estacion
     * Se va restando respecto a los elapsedSeconds y se va avanzando en el camino mientras aun quedan segundos
     * Al terminar retorna la estacion mas proxima (la ultima que dejo positivo los elapsedSeconds)
     * @param selectedTrain
     * @param time
     * @return Station donde se encuentra el train dada la diferencia de tiempo
     */
    @Override
    public Station whereIsTrain(Train selectedTrain, Date time) {
        TrainItinerary trainItinerary = getItineraryById(selectedTrain.getId());

        Line line = trainItinerary.getLine();
        Station departureStation = trainItinerary.getDepartureStation();
        Station arrivalStation = trainItinerary.getArrivalStation();
        List<Section> forwardPath = line.getGraph().findPath(departureStation.getId(), arrivalStation.getId());
        if (forwardPath.isEmpty()) {
            return null;
        }

        long elapsedSeconds = Duration.between(trainItinerary.getDepartureTime().toInstant(), time.toInstant()).getSeconds();
        System.out.println("Initial elapsed time: " + elapsedSeconds + " seconds");

        Station currentStation = departureStation;
        boolean isForwardDirection = true;

        while (elapsedSeconds > 0) {
            List<Section> currentPath = isForwardDirection ? forwardPath : reverseList(forwardPath);

            for (Section section : currentPath) {
                int stationStopTime = currentStation.getStopTime();
                if (elapsedSeconds <= stationStopTime) {
                    return currentStation;
                }
                elapsedSeconds -= stationStopTime;

                int sectionTravelTime = kmToSeconds(section.getDistance(), selectedTrain.getSpeed());

                if (elapsedSeconds <= sectionTravelTime) {
                    return currentStation;
                }

                elapsedSeconds -= sectionTravelTime;
                currentStation = isForwardDirection ? section.getStation2() : section.getStation1();
            }

            isForwardDirection = !isForwardDirection;
        }

        return currentStation;
    }

    /**
     * Metodo que transforma una distancia a segundos, para poder usar como calculo de tiempo
     * @param distance
     * @param speed
     * @return seconds en int
     */
    private int kmToSeconds(double distance, int speed) {
        return (int) Math.ceil((distance / speed) * 3600);
    }

    /**
     * Metodo que dada una lista, la invierte simplemente, util por si se llega al final del tramo y aun queda tiempo
     * @param original
     * @return
     */
    private List<Section> reverseList(List<Section> original) {
        List<Section> reversed = new ArrayList<>(original);
        Collections.reverse(reversed);
        return reversed;
    }

    /**
     * Metodo que recupera del itinerario la informacion y en conjunto al tiempo de parametro encuentra una cantidad de
     * segundos y va calculando el camino que sigue el train mientras aun tenga tiempo para seguir.
     * Se calcula en base al tiempo de parada de cada estacion y el tiempo de viaje entre cada una
     * Se recupera la info del trayecto respecto al findpath de la estacion de llegada y salida (que se recuperan del itinerario)
     * @param train
     * @param time
     * @return
     */
    @Override
    public List<Station> trainPath(Train train, Date time) {
        TrainItinerary trainItinerary = getItineraryById(train.getId());

        Line line = trainItinerary.getLine();
        Station departureStation = trainItinerary.getDepartureStation();
        Station arrivalStation = trainItinerary.getArrivalStation();

        List<Section> forwardPath = line.getGraph().findPath(departureStation.getId(), arrivalStation.getId());
        if (forwardPath.isEmpty()) {
            return null;
        }

        long elapsedSeconds = Duration.between(trainItinerary.getDepartureTime().toInstant(), time.toInstant()).getSeconds();

        Station currentStation = departureStation;
        boolean isForwardDirection = true;
        List<Station> subwayPath = new ArrayList<>();

        while (elapsedSeconds > 0) {
            List<Section> currentPath = isForwardDirection ? forwardPath : reverseList(forwardPath);

            for (Section section : currentPath) {
                int stationStopTime = currentStation.getStopTime();
                if (elapsedSeconds <= stationStopTime) {
                    subwayPath.add(currentStation);
                    return subwayPath;
                }
                elapsedSeconds -= stationStopTime;
                subwayPath.add(currentStation);

                int sectionTravelTime = kmToSeconds(section.getDistance(), train.getSpeed());
                if (elapsedSeconds <= sectionTravelTime) {
                    return subwayPath;
                }
                elapsedSeconds -= sectionTravelTime;
                currentStation = isForwardDirection ? section.getStation2() : section.getStation1();
            }

            isForwardDirection = !isForwardDirection;
        }

        subwayPath.add(currentStation);
        return subwayPath;
    }

    /**
     * Metodo que recibe dos estaciones y verifica si son combinaciones validas, si lo son, se agregan a la lista de combinaciones
     * @param station1
     * @param station2
     */
    public void addCombination(Station station1, Station station2) {
        //si no es terminal o combinacion, no es una combinacion valida
        List<String> validTypes = Arrays.asList("t","c");
        if(validTypes.contains(station1.getType()) && validTypes.contains(station2.getType())) {
            //si ambos son, se puede agregar
            combinations.computeIfAbsent(station1, k -> new ArrayList<>()).add(station2);
            combinations.computeIfAbsent(station2, k -> new ArrayList<>()).add(station1);
        }
        else {
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "Seleccion de estaciones no validas, alguna o ambas no son del tipo terminal o combinacion." + RESET);
        }
    }

    /**
     * Metodo para encontrar si existe una linea en base al id entregado, util para recuperar la informacion
     * @param id
     * @return
     */
    public Line getLineById(int id) {
        for (Line line : lineList) {
            if (line.getId() == id) {
                return line;
            }
        }
        return null;
    }

    /**
     * Metodo para encontrar un itinerario en base al id de un train especifico
     * Se retorna solamente el primero que se encuentra del Optional, si no se encuentra, se retorna null
     * @param train_id
     * @return Itinerario del train
     */
    public TrainItinerary getItineraryById(int train_id){
        return trainItineraries.stream()
                .filter(ti -> ti.getTrain().getId() == train_id)
                .findFirst()
                .orElse(null);
    }


}
