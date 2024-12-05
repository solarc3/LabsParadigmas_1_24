package org.example.Loaders;
import org.example.Abstract.DataLoader;
import org.example.Station;
import org.example.Subway;
import org.example.Combination;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * Clase para cargar las combinaciones
 */
public class CombinationLoader extends DataLoader {
    private static final String FILE_NAME = "combinaciones.txt";
    private Map<Station, List<Station>> loadedCombinations;
    /**
     * Constructor
     * @param subway
     * @param directLoading
     */
    public CombinationLoader(Subway subway, boolean directLoading) {
        super(subway, directLoading);
        this.loadedCombinations = new HashMap<>();
    }
    /**
     * Metodo para cargar las combinaciones, solamente se ven las lineas y se cargan a la funcion de procesar
     */
    @Override
    public void loadData() {
        try {
            String filePath = getFilePath(FILE_NAME);
            List<String> fileLines = Files.readAllLines(Paths.get(filePath));

            for (String line : fileLines) {
                processCombination(line);
            }
        } catch (IOException e) {
            System.out.println("Error al cargar el archivo de combinaciones: " + e.getMessage());
        }
    }
    /**
     * Metodo para procesar las combinaciones
     * Se separan las combinaciones por estaciones y ademas se agregan a la lista de combinaciones
     * @param combinationLine
     */
    private void processCombination(String combinationLine) {
        String[] stationPairs = combinationLine.split("\\|");
        if (stationPairs.length != 2) {
            System.out.println("Error: Formato de combinacion incorrecto: " + combinationLine);
            return;
        }

        try {
            Station station1 = createStation(stationPairs[0]);
            Station station2 = createStation(stationPairs[1]);

            if (directLoading) {
                subway.addCombination(station1, station2);
            } else {
                loadedCombinations.computeIfAbsent(station1, k -> new ArrayList<>()).add(station2);
                loadedCombinations.computeIfAbsent(station2, k -> new ArrayList<>()).add(station1);
            }
        } catch (NumberFormatException e) {
            System.out.println("Error al analizar datos de la combinacion: " + combinationLine);
        }
    }
    /**
     * Metodo para crear una estacion
     * @param stationData
     * @return Station
     */
    private Station createStation(String stationData) {
        String[] data = stationData.split(",");
        if (data.length != 4) {
            throw new IllegalArgumentException("Formato de estacion incorrecto: " + stationData);
        }

        int id = Integer.parseInt(data[0].trim());
        String name = data[1].trim();
        String type = data[2].trim();
        int stopTime = Integer.parseInt(data[3].trim());

        return new Station(id, name, type, stopTime);
    }

    public Map<Station, List<Station>> getLoadedCombinations() {
        return loadedCombinations;
    }
}