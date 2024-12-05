package org.example;

import org.example.Interfaces.AdjacentStationInterface;

/**
 * Staciones adjacentes
 * se utiliza para guardar lo que tiene alrededor una estacion de otra.
 */
public class AdjacentStation implements AdjacentStationInterface {
    private int distance;
    private int cost;
    private Station station;

    /**
     * Constructor
     * @param distance
     * @param cost
     * @param station
     */
    public AdjacentStation(int distance, int cost, Station station) {
        this.distance = distance;
        this.cost = cost;
        this.station = station;
    }

    /**
     * getter del parametro distancia
     * @return distancia a la estacion
     */
    public int getDistance() {
        return distance;
    }
    /**
     * getter del parametro costo
     * @return costo a la estacion
     */
    public int getCost() {
        return cost;
    }
    /**
     * getter del parametro estacion
     * @return estacion
     */
    public Station getStation() {
        return station;
    }
}