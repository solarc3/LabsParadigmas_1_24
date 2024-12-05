package org.example.Loaders;

import org.example.Abstract.DataLoader;
import org.example.Subway;
import org.example.Train;
import org.example.Pcar;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase que se preocuppa del archivo para los trenes
 */
public class TrainLoader extends DataLoader {
    private static final String FILE_NAME = "trenes.txt";
    private List<Train> loadedTrains;
    private List<Pcar> loadedPcars;

    /**
     * Constructor
     * @param subway
     * @param directLoading
     */
    public TrainLoader(Subway subway, boolean directLoading) {
        super(subway, directLoading);
        this.loadedTrains = new ArrayList<>();
        this.loadedPcars = new ArrayList<>();
    }

    /**
     * Se leen todas las lineas, existe diferencia cuando encuentra un -, que cambia de modo a solo pcars
     * Este tiene la diferencia de que se leen 2 lineas conjuntas, una de los datos del tren y luego los carros. Existe aparte de la seleccionar de pcars solitaria
     */
    @Override
    public void loadData() {
        try {
            String filePath = getFilePath(FILE_NAME);
            List<String> fileLines = Files.readAllLines(Paths.get(filePath));

            boolean processingTrains = true;
            for (int i = 0; i < fileLines.size(); i++) {
                String line = fileLines.get(i).trim();

                if (line.equals("-")) {
                    processingTrains = false;
                    continue;
                }

                if (processingTrains) {
                    if (i + 1 < fileLines.size()) {
                        processTrainData(line, fileLines.get(i + 1));
                        i++;
                    } else {
                        System.out.println("Error: datos incompletos al final del texto");
                    }
                } else {
                    processSoloPcars(line);
                }
            }
        } catch (IOException e) {
            System.out.println("Error al cargar el archivo de trenes: " + e.getMessage());
        }
    }

    /**
     * Procesar un train y sus carros, son 2 lineas de texto
     * @param trainLine
     * @param carLine
     */
    private void processTrainData(String trainLine, String carLine) {
        String[] trainData = trainLine.split(",");
        if (trainData.length == 4) {
            try {
                int id = Integer.parseInt(trainData[0].trim());
                String maker = trainData[1].trim();
                int speed = Integer.parseInt(trainData[2].trim());
                int stationStayTime = Integer.parseInt(trainData[3].trim());

                List<Pcar> carList = processCarData(carLine, maker);

                Train train = new Train(id, maker, speed, stationStayTime, carList);

                if (directLoading) {
                    boolean added = subway.addTrain(train);
                    if (!added) {
                        System.out.println("No se pudo agregar el tren al Subway: " + train.getId());
                    }
                } else {
                    loadedTrains.add(train);
                }
            } catch (NumberFormatException e) {
                System.out.println("Error al analizar los datos del tren: " + trainLine);
            }
        } else {
            System.out.println("Error: Formato de datos del tren incorrecto: " + trainLine);
        }
    }

    /**
     * lectura de pcars
     * @param carLine
     * @param trainMaker
     * @return carList
     */
    private List<Pcar> processCarData(String carLine, String trainMaker) {
        List<Pcar> carList = new ArrayList<>();
        String[] carDataArray = carLine.split("\\|");
        for (String carData : carDataArray) {
            Pcar car = createPcar(carData, trainMaker);
            if (car != null) {
                carList.add(car);
            }
        }
        return carList;
    }

    /**
     * Procesar pcars solitarios, la diferencia es que en vez de guardar en una lista, se lleva al tema de direct loading o no
     * @param soloPcarsLine
     */
    private void processSoloPcars(String soloPcarsLine) {
        String[] carDataArray = soloPcarsLine.split("\\|");
        for (String carData : carDataArray) {
            Pcar car = createPcar(carData, null);
            if (car != null) {
                if (directLoading) {
                    boolean added = subway.addPcar(car);
                    if (!added) {
                        System.out.println("No se pudo agregar el Pcar al Subway: " + car.getId());
                    }
                } else {
                    loadedPcars.add(car);
                }
            }
        }
    }

    private Pcar createPcar(String carData, String trainMaker) {
        String[] carProperties = carData.trim().split(":");
        if (carProperties.length == 5) {
            try {
                int id = Integer.parseInt(carProperties[0]);
                int passengerCapacity = Integer.parseInt(carProperties[1]);
                String model = carProperties[2];
                String maker = carProperties[3];
                String type = carProperties[4];

                if (trainMaker != null && !maker.equals(trainMaker)) {
                    System.out.println("Advertencia: El fabricante del carro no coincide con el del tren para el carro: " + carData);
                }

                return new Pcar(id, passengerCapacity, model, maker, type);
            } catch (Exception e) {
                System.out.println("Error al crear Pcar: " + e.getMessage() + " para los datos: " + carData);
            }
        } else {
            System.out.println("Error: Formato de datos del carro incorrecto: " + carData);
        }
        return null;
    }

    public List<Train> getLoadedTrains() {
        return loadedTrains;
    }

    public List<Pcar> getLoadedPcars() {
        return loadedPcars;
    }
}