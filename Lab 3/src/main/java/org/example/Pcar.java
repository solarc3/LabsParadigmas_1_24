package org.example;

import org.example.Interfaces.PcarInterface;

import java.util.List;

/**
 * Clase que representa un carro de pasajeros
 */
public class Pcar implements PcarInterface {
    private int id;
    private int passengerCapacity;
    private String model;
    private String maker;
    private String type; //tr o cr
    // Lista de tipos de carros estatica
    private static final List<String> PcarType = List.of("tr", "ct");
    // Constructor
    public Pcar(int id, int passengerCapacity, String model, String maker, String type) {
        if(passengerCapacity <= 0) {
            throw new IllegalArgumentException("Capacidad invalida");
        }
        if(!PcarType.contains(type)) {
            throw new IllegalArgumentException("Tipo de carro invalido");
        }
        this.id = id;
        this.passengerCapacity = passengerCapacity;
        this.model = model;
        this.maker = maker;
        this.type = type;
    }

    public int getId() {
        return id;
    }


    public int getPassengerCapacity() {
        return passengerCapacity;
    }


    public String getModel() {
        return model;
    }


    public String getMaker() {
        return maker;
    }

    public String getType() {
        return type;
    }

    @Override
    public String toString() {
        return "Pcar: " + "\n" +
                "Car ID: " + getId() + "\n" +
                "Passenger Capacity: " + getPassengerCapacity() + "\n" +
                "Model: " + getModel() + "\n" +
                "Maker: " + getMaker() + "\n" +
                "Type: " + getType() + "\n" +
                "----";

    }
}
