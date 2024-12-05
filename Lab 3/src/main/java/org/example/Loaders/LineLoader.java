package org.example.Loaders;

import org.example.Abstract.DataLoader;
import org.example.Line;
import org.example.Section;
import org.example.Station;
import org.example.Subway;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
/**
 * Clase que se encarga de cargar las lineas desde un archivo de texto.
 */
public class LineLoader extends DataLoader {
    private static final String FILE_NAME = "lineas.txt";
    private static final String LINE_SEPARATOR = "-";
    private List<Line> loadedLines;
    /**
     * Constructor de la clase.
     * @param subway
     * @param directLoading
     */
    public LineLoader(Subway subway, boolean directLoading) {
        super(subway, directLoading);
        this.loadedLines = new ArrayList<>();
    }
    /**
     * Carga de datos datos, se pasan a otra funcion para procesar
     * en este caso, se usa una constante para separar, es lo mismo
     */
    @Override
    public void loadData() {
        try {
            String filePath = getFilePath(FILE_NAME);
            List<String> fileLines = Files.readAllLines(Paths.get(filePath));


            List<String> currentLineData = new ArrayList<>();
            for (String line : fileLines) {
                if (line.equals(LINE_SEPARATOR)) {
                    if (!currentLineData.isEmpty()) {
                        processLine(currentLineData);
                        currentLineData.clear();
                    }
                } else {
                    currentLineData.add(line);
                }
            }

            if (!currentLineData.isEmpty()) {
                processLine(currentLineData);
            }


        } catch (IOException e) {
            System.out.println("Error al cargar el archivo de lineas: " + e.getMessage());
        }
    }

    /**
     * Por cada linea, se separar en 3 con el splitter, luego los primeros 2 son el id y nombre de la linea
     * y el tercero es el tipo de riel, luego se procesan las secciones
     * @param lineData
     */
    private void processLine(List<String> lineData) {
        if (lineData.size() < 2) {
            System.out.println("Error: Datos de linea incompletos");
            return;
        }

        String[] lineInfo = lineData.get(0).split(";");
        if (lineInfo.length != 3) {
            System.out.println("Error: Formato de informacion de linea incorrecto: " + lineData.get(0));
            return;
        }

        try {
            int lineID = Integer.parseInt(lineInfo[0].trim());
            String lineName = lineInfo[1].trim();
            String railType = lineInfo[2].trim();

            List<Section> sections = new ArrayList<>();
            for (int i = 1; i < lineData.size(); i++) {
                Section section = parseSection(lineData.get(i));
                if (section != null) {
                    sections.add(section);
                }
            }

            Line line = new Line(lineID, lineName, railType, sections);

            if (directLoading) {
                boolean added = subway.addLine(line);
                if (!added) {
                    System.out.println("No se pudo agregar la linea al Subway: " + line.getId());
                }
            } else {
                loadedLines.add(line);
            }

            //System.out.println("Linea procesada: " + lineName);
        } catch (NumberFormatException e) {
            System.out.println("Error al analizar datos de la linea: " + lineData.get(0));
        }
    }

    /**
     * Se separa en 10 elementos. que son 2 estaciones (8) y 2 enteros (distancia y costo)
     * Se crean las estaciones y luego todo se agrupa en una section
     * @param sectionData
     * @return
     */
    private Section parseSection(String sectionData) {
        String[] elements = sectionData.split(",");
        if (elements.length != 10) {
            System.out.println("Error: Formato de seccion incorrecto: " + sectionData);
            return null;
        }

        try {
            Station station1 = new Station(
                    Integer.parseInt(elements[0].trim()),
                    elements[1].trim(),
                    elements[2].trim(),
                    Integer.parseInt(elements[3].trim())
            );

            Station station2 = new Station(
                    Integer.parseInt(elements[4].trim()),
                    elements[5].trim(),
                    elements[6].trim(),
                    Integer.parseInt(elements[7].trim())
            );

            int distance = Integer.parseInt(elements[8].trim());
            int cost = Integer.parseInt(elements[9].trim());

            return new Section(station1, station2, distance, cost);
        } catch (NumberFormatException e) {
            System.out.println("Error al analizar datos de la seccion: " + sectionData);
            return null;
        }
    }

    public List<Line> getLoadedLines() {
        return loadedLines;
    }
}