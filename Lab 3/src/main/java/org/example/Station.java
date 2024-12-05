package org.example;

import org.example.Interfaces.StationInterface;

import java.util.List;

/**
 * Clase de estacion, incluye id, nombre, tipo (que se verifica con una lista estatica) y su tiempo de parada
 */
public class Station implements StationInterface {
    private int id;
    private String name;
    private String type; //r,m,c,t
    private int stopTime;

    private static final List<String> StationType = List.of("r", "m", "c", "t");

    /**
     * Constructor
     * @param id
     * @param name
     * @param type
     * @param stopTime
     */
    public Station(int id, String name, String type, int stopTime) {
        if(!StationType.contains(type)) {
            throw new IllegalArgumentException("Invalid station type");
        }
        this.id = id;
        this.name = name;
        this.type = type;
        this.stopTime = stopTime;
    }
    @Override
    public int getId() {
        return id;
    }
    @Override
    public String getName() {
        return name;
    }
    @Override
    public String getType() {
        return type;
    }
    @Override
    public int getStopTime() {
        return stopTime;
    }

    @Override
    public String toString() {
        return "Station{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", stopTime=" + stopTime +
                '}';
    }
}
