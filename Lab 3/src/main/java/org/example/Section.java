package org.example;

import org.example.Interfaces.SectionInterface;

/**
 * Clase que representa una union de estaciones junto a su distancia y costo
 */
public class Section implements SectionInterface {
    private Station station1;
    private Station station2;
    private int distance;
    private int cost;

    /**
     * Constructor, tiene la peculiridad de que verifica si el costo o la distancia es negativa y lanza un exception
     * @param station1
     * @param station2
     * @param distance
     * @param cost
     */
    public Section(Station station1, Station station2, int distance, int cost) {
        if(distance <= 0 || cost <= 0) {
            throw new IllegalArgumentException("Distancia o costo invalida");
        }
        this.station1 = station1;
        this.station2 = station2;
        this.distance = distance;
        this.cost = cost;
    }
    @Override
    public String toString() {
        return "----\n" +
                "Station 1 = " + station1.getName() + "\n"+
                "Station 2 = " + station2.getName() + "\n"+
                "Distance = " + distance + "\n"+
                "Cost = " + cost + "\n";
                }
    public Station getStation1() {
        return station1;
    }


    public Station getStation2() {
        return station2;
    }


    public int getDistance() {
        return distance;
    }


    public int getCost() {
        return cost;
    }
}
