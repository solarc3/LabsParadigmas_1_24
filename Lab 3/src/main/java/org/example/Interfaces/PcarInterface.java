package org.example.Interfaces;
/**
 * Interfaz para los pcars, solo se tienen los getters
 */
public interface PcarInterface {
    int getId();
    int getPassengerCapacity();
    String getModel();
    String getMaker();
    String getType();
}