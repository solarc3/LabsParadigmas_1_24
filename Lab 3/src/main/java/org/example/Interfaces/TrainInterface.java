package org.example.Interfaces;

import org.example.Pcar;

import java.util.List;
/**
 * Interfaz para los trenes, ademas de getters se tienen un par de implementaciones para los RF
 */
public interface TrainInterface {
    int getId();
    String getMaker();
    int getSpeed();
    int getStationStayTime();
    List<Pcar> getCarList();
    void addCar(Pcar car, int position);
    void removeCar(int position);
    boolean isTrain();
    int fetchCapacity();
}