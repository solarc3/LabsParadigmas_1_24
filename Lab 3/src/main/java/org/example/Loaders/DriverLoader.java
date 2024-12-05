package org.example.Loaders;

import org.example.Abstract.DataLoader;
import org.example.Driver;
import org.example.Subway;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
/**
 * Clase que se encarga de cargar los conductores desde un archivo de texto.
 */
public class DriverLoader extends DataLoader {
    private static final String FILE_NAME = "conductores.txt";
    private List<Driver> loadedDrivers;
    /**
     * Constructor de la clase.
     * @param subway
     * @param directLoading
     */
    public DriverLoader(Subway subway, boolean directLoading) {
        super(subway, directLoading);
        this.loadedDrivers = new ArrayList<>();
    }
    /**
     * Carga de datos datos, se pasan a otra funcion para procesar
     */
    @Override
    public void loadData() {
        try {
            String filePath = getFilePath(FILE_NAME);
            List<String> fileLines = Files.readAllLines(Paths.get(filePath));
            for (String line : fileLines) {
                processDriverLine(line);
            }
        } catch (IOException e) {
            System.out.println("Error al cargar el archivo de conductores: " + e.getMessage());
        }
    }
    /**
     * Por cada linea de texto se separa en 3 partes y se crea un objeto Driver
     * @param line
     */
    private void processDriverLine(String line) {
        String[] driverData = line.split(",");
        if (driverData.length == 3) {
            try {
                int id = Integer.parseInt(driverData[0].trim());
                String name = driverData[1].trim();
                String trainMaker = driverData[2].trim();

                Driver driver = new Driver(id, name, trainMaker);

                if (directLoading) {
                    boolean added = subway.addDriver(driver);
                    if (!added) {
                        System.out.println("No se pudo agregar el conductor al Subway: " + driver.getId());
                    }
                } else {
                    loadedDrivers.add(driver);
                }

                //System.out.println("Conductor procesado: " + name);
            } catch (NumberFormatException e) {
                System.out.println("Error al analizar el ID del conductor: " + line);
            }
        } else {
            System.out.println("Error: Formato de datos del conductor incorrecto: " + line);
        }
    }
    /**
     * Getter, Retorna la lista de conductores cargados
     * @return
     */
    public List<Driver> getLoadedDrivers() {
        return loadedDrivers;
    }
}