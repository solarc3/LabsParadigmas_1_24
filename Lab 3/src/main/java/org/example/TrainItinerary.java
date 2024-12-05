package org.example;

import java.util.Date;

/**
 * Clase que se utiliza para almacenar la informacion de un itinerario de un tren
 * El itinerario se utiliza para las funciones que requiere un tiempo y coneccion de datos entre un tren, un driver y una linea
 * Mantiendo toda la informacion acumuluada en un solo objeto, facilita su recoleccion, en vez de tener que generar metodos
 * que recuperen informacion anteriormente almacenada en diferentes objetos
 */
public class TrainItinerary {
    private Train train;
    private Driver driver;
    private Line line;
    private Date departureTime;
    private Station departureStation;
    private Station arrivalStation;

    /**
     * Constructor de la clase TrainItinerary
     * @param train
     * @param driver
     * @param line
     * @param departureTime
     * @param departureStation
     * @param arrivalStation
     */
    public TrainItinerary(Train train, Driver driver, Line line, Date departureTime, Station departureStation, Station arrivalStation) {
        this.train = train;
        this.driver = driver;
        this.line = line;
        this.departureTime = departureTime;
        this.departureStation = departureStation;
        this.arrivalStation = arrivalStation;
    }
    // Getters
    public Train getTrain() { return train; }
    public Driver getDriver() { return driver; }
    public Line getLine() { return line; }
    public Date getDepartureTime() { return departureTime; }
    public Station getDepartureStation() { return departureStation; }
    public Station getArrivalStation() { return arrivalStation; }

    // Setters
    public void setTrain(Train train) { this.train = train; }
    public void setDriver(Driver driver) { this.driver = driver; }
    public void setLine(Line line) { this.line = line; }
    public void setDepartureTime(Date departureTime) { this.departureTime = departureTime; }
    public void setDepartureStation(Station departureStation) { this.departureStation = departureStation; }
    public void setArrivalStation(Station arrivalStation) { this.arrivalStation = arrivalStation; }

    @Override
    public String toString() {
        return "TrainItinerary{" +
                "train=" + train.getId() +
                ", driver=" + driver.getName() +
                ", line=" + line.getName() +
                ", departureTime=" + departureTime +
                ", departureStation=" + departureStation.getName() +
                ", arrivalStation=" + arrivalStation.getName() +
                '}';
    }

}