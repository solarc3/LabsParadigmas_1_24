package org.example;

import org.example.Interfaces.LineInterface;
import static org.example.ConsoleColors.*;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Clase linea
 */
public class Line implements LineInterface {
    private int id;
    private String name;
    private String railType;
    private List<Section> sections;
    private LineGraph graph;

    /**
     * Constructor
     * @param id
     * @param name
     * @param railType
     * @param sections
     */
    public Line(int id, String name, String railType, List<Section> sections) {
        this.id = id;
        this.name = name;
        this.railType = railType;
        this.sections = sections;
        this.graph = new LineGraph(sections);
    }

    @Override
    public int getId() {
        return id;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public String getRailType() {
        return railType;
    }

    @Override
    public List<Section> getSections() {
        return sections;
    }

    /**
     * getter del grafo, para poder utilizarlo respecto a la linea
     * @return
     */
    public LineGraph getGraph() {
        return graph;
    }

    /**
     * Para añadir una seccion se verifica si ya existe en esta
     * ademas, cada vez que se hace un cambio, se debe reconstruir la lista de adyacencia
     * @param newSection
     */
    @Override
    public void addSection(Section newSection) {
        if (!sectionExists(newSection)) {
            this.sections.add(newSection);
            this.graph = new LineGraph(sections);  // reconstruir
        } else {
            System.out.println("La seccion ya existe y no se agregara.");
        }
    }

    /**
     * Para eliminar una seccion se verifica si existe en esta
     * @param newSection
     * @return
     */
    private boolean sectionExists(Section newSection) {
        return sections.stream().anyMatch(existingSection ->
                (existingSection.getStation1().getId() == newSection.getStation1().getId() &&
                        existingSection.getStation2().getId() == newSection.getStation2().getId()) ||
                        (existingSection.getStation1().getId() == newSection.getStation2().getId() &&
                                existingSection.getStation2().getId() == newSection.getStation1().getId())
        );
    }

    /**
     * Stream para ir sumando el getter de distancia de las secciones
     * @return size
     */
    @Override
    public double getLength() {
        return sections.stream()
                .mapToInt(Section::getDistance)
                .sum();
    }

    /**
     * Para obtener la longitud de un tramo, primero se encuentra el tramo y se hace el stream para ver la diferencia
     * stream simplementa va sumando las distancias de todos los tramos
     * @param station1Name
     * @param station2Name
     * @return value
     */
    @Override
    public double getSectionLength(String station1Name, String station2Name) {
        List<Section> subsections = graph.findPath(findStationByName(station1Name).getId(), findStationByName(station2Name).getId());
        return subsections.stream()
                .mapToInt(Section::getDistance)
                .sum();
    }

    /**
     * Funcion anonima que suma los getters de costo de las secciones
     * @return value
     */
    @Override
    public double getCost() {
        return sections.stream()
                .mapToInt(Section::getCost)
                .sum();
    }

    /**
     * Se encuentra el tramo primero y luego se aplica el stream para ir sumando
     * @param station1Name
     * @param station2Name
     * @return
     */
    @Override
    public double getSectionCost(String station1Name, String station2Name) {
        Station station1 = findStationByName(station1Name);
        Station station2 = findStationByName(station2Name);
        List<Section> subsections = graph.findPath(station1.getId(), station2.getId());
        return subsections.stream()
                .mapToInt(Section::getCost)
                .sum();
    }

    /**
     * Se obtiene una lista de estaciones terminales para utilizar
     * Se verifica que existan solamente 2 estaciones terminales y que estas conecten
     * @return true si es una linea valida, sino false
     */
    @Override
    public boolean isLine() {
        List<Station> terminals = getUniqueStations().stream()
                .filter(s -> s.getType().equals("t"))
                .collect(Collectors.toList());

        boolean result;
        if (terminals.size() == 2) {
            result = checkTerminals(terminals);
        } else {
            System.out.println(RED_BOLD + "NuMERO INVALIDO DE TERMINALES: " + RESET + terminals.size());
            result = false;
        }
        return result;
    }
    /**
     * Con la lista de terminales primero se obtienes los nombres y se les busca su path, si no existe implica que no hay camnino entre terminales, no es linea
     * @param terminals
     * @return true si las terminales estan conectadas, sino false
     */
    private boolean checkTerminals(List<Station> terminals) {
        List<Station> allStations = getUniqueStations();

        String start = terminals.get(0).getName();
        String end = terminals.get(1).getName();

        List<Section> path = graph.findPath(findStationByName(start).getId(), findStationByName(end).getId());
        if (path.isEmpty()) {
            System.out.println(RED_BOLD + "NO HAY CAMINO ENTRE LAS TERMINALES: " + RESET + start + " y " + end);
            return false;
        }

        Set<String> stationsInPath = path.stream()
                .flatMap(section -> Stream.of(section.getStation1().getName(), section.getStation2().getName()))
                .collect(Collectors.toSet());

        if (stationsInPath.size() != allStations.size()) {
            System.out.println(RED_BOLD + "EL CAMINO NO INCLUYE TODAS LAS ESTACIONES" + RESET);
            return false;
        }

        return true;
    }

    /**
     * Lista de estaciones unicas en base a un set de ids
     * @return Lista de estaciones unicas
     */
    public List<Station> getUniqueStations() {
        List<Station> uniqueStations = new ArrayList<>();
        Set<Integer> stationIds = new HashSet<>();

        for (Section section : sections) {
            addIfUnique(uniqueStations, stationIds, section.getStation1());
            addIfUnique(uniqueStations, stationIds, section.getStation2());
        }

        return uniqueStations;
    }

    /**
     * solo se agrega si esta en ids
     * @param stations
     * @param ids
     * @param station
     */
    private void addIfUnique(List<Station> stations, Set<Integer> ids, Station station) {
        if (ids.add(station.getId())) {
            stations.add(station);
        }
    }

    /**
     * Se busca en todas las estaciones de la linea por nombre y se retorna la station que tenga el mismo nombre
     * Funciona considerando que no hay estaciones con el mismo nombre, sino no se podria saber, se necesitaria mas datos
     * @param stationName
     * @return Station
     */
    private Station findStationByName(String stationName) {
        return getUniqueStations().stream()
                .filter(station -> station.getName().equals(stationName))
                .findFirst()
                .orElse(null);
    }

    /**
     * To string de una linea, concadena lo de la linea, el tipo de riel y las secciones
     * @return String
     */
    @Override
    public String toString() {
        return GREEN_BOLD + "Line ID: " + RESET + id + "\n" +
                "Line Name: " + name + "\n" +
                "Rail Type: " + railType + "\n" +
                "Sections:\n" + sections.stream()
                .map(Section::toString)
                .collect(Collectors.joining("\n")) + "\n";

    }
}