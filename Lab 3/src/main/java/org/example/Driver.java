package org.example;

import org.example.Interfaces.DriverInterface;
/**
 * Clase driver, almancena los datos de un conductor, id, nombre y su trainMaker
 */
public class Driver implements DriverInterface {
    private int id;
    private String name;
    private String trainMaker;

    /**
     * Constructor
     * @param id
     * @param name
     * @param trainMaker
     */
    public Driver(int id, String name, String trainMaker) {
        this.id = id;
        this.name = name;
        this.trainMaker = trainMaker;
    }

    /**
     * Getter del ID de un driver
     * @return
     */
    @Override
    public int getId() {
        return id;
    }
    /**
     * Getter del nombre de un driver
     * @return
     */
    @Override
    public String getName() {
        return name;
    }
    /**
     * Getter del trainMaker de un driver
     * @return
     */
    @Override
    public String getMaker() {
        return trainMaker;
    }

    /**
     * Metodo que devuelve los datos de un driver
      * @return String driver data
     */
    @Override
    public String toString() {
        return "ID: " + getId() + "\n" +
                "Name: " + getName() + "\n" +
                "TrainMaker: " + getMaker() + "\n"
                + "-----------------------------------";
    }
}
