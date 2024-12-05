package org.example.Interfaces;

import org.example.Station;
/**
 * Interfaz para las secciones, solo se tienen los getters
 */
public interface SectionInterface {
    Station getStation1();
    Station getStation2();
    int getDistance();
    int getCost();
}