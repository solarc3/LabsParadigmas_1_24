package org.example.Interfaces;

import org.example.Station;
/**
 * Interfaz para las estaciones adyacentes, solo los getters
 */
public interface AdjacentStationInterface {
    int getDistance();
    int getCost();
    Station getStation();

}
