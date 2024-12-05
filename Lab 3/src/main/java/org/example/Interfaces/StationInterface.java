package org.example.Interfaces;
/**
 * Interfaz para las estaciones, solo se tienen los getters
 */
public interface StationInterface {
    int getId();
    String getName();
    String getType();
    int getStopTime();
}