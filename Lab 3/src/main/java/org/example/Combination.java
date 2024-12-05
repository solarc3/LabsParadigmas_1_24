package org.example;

/**
 * Una combinacion es una acumulacion de 2 estaciones y sus parametros
 * Se puede utilizar la clase de estaciones para saber las caracteristicas de cada estacion
 */
public class Combination {
    private Station station1;
    private Station station2;
    /**
     * Constructor de la clase
     * @param station1 Estacion 1
     * @param station2 Estacion 2
     */
    public Combination(Station station1, Station station2) {
        this.station1 = station1;
        this.station2 = station2;
    }
    /**
     * Metodo que verifica si la estacion esta en la combinacion
     * @param station Estacion a verificar
     * @return True si esta, sino, false
     */
    public boolean contains(Station station) {
        return station.equals(station1) || station.equals(station2);
    }
    /**
     * Metodo que retorna la otra estacion de la combinacion
     * @param station Estacion a la que se le quiere saber la otra estacion
     * @return La otra estacion
     */
    public Station getOtherStation(Station station) {
        if (station.equals(station1)) {
            return station2;
        } else if (station.equals(station2)) {
            return station1;
        } else {
            throw new IllegalArgumentException("La estacion no existe en esta combinacion");
        }
    }
}