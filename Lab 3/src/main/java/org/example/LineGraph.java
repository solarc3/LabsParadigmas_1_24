package org.example;

import java.util.*;

/**
 * Clase que representa el metro como un grafo no dirigido, implementa con multimap analogo a una tabla hash con listas
 */
public class LineGraph {
    private Map<Integer, LinkedList<AdjacentStation>> adjacencyList;
    private List<Section> sections;
    /**
     * Constructor
     * @param sections
     */
    public LineGraph(List<Section> sections) {
        this.sections = sections;
        this.adjacencyList = new HashMap<>();
        buildAdjacencyList();
    }

    /**
     * Se requiere ademas de construir los datos, agregar los datos a la lista, esto se ve tambien al generar cambios
     * se debe reconstuir la lista de adyacencia
     */
    private void buildAdjacencyList() {
        initializeAdjacencyList();
        populateAdjacencyList();
    }

    /**
     * Inicia la lista de adyacencia con las estaciones
     * putIfAbsent permite que solo existan modificaciones si no existe la clave nueva, si ya existe no se modifica
     */
    private void initializeAdjacencyList() {
        for (Section section : sections) {
            adjacencyList.putIfAbsent(section.getStation1().getId(), new LinkedList<>());
            adjacencyList.putIfAbsent(section.getStation2().getId(), new LinkedList<>());
        }
    }

    /**
     * Para poblar la lista de adyacencia, se recorren las secciones y con sus stations ids se toman como llaves
     * Se utiliza la clase de Adjacent station para agrupar mas de un dato (como un nodo)
     */
    private void populateAdjacencyList() {
        for (Section section : sections) {
            Station station1 = section.getStation1();
            Station station2 = section.getStation2();
            int distance = section.getDistance();
            int cost = section.getCost();
            adjacencyList.get(station1.getId()).add(new AdjacentStation(distance, cost, station2));
            adjacencyList.get(station2.getId()).add(new AdjacentStation(distance, cost, station1));
        }
    }

    /**
     * Metodo para encontrar el camino entre dos estaciones, se aplica la funcion dfs
     * @param station1Id
     * @param station2Id
     * @return Lista de secciones que componen el camino, si no existe, retorna lista vacia
     */
    public List<Section> findPath(int station1Id, int station2Id) {
        Set<Integer> visited = new HashSet<>();
        List<Section> path = new ArrayList<>();

        if (dfs(station1Id, station2Id, visited, path)) {
            return path;
        }
        return Collections.emptyList();
    }

    /**
     * Implementacion primitiva de dfs, no funcion para grafos con ciclos
     * Verifica por cada id de estacion cada lista de adjacencia que tenga adjunta, donde se agrega a un set de visitados
     * Llamados recursivos para seguir probando combinaciones
     * Se acumula todo en la lista path, en vez de dejarlo como retorno, se espera como atributo
     * @param currentStationID
     * @param endStationID
     * @param visited
     * @param path
     * @return true si existe camino, false si no
     */
    private boolean dfs(int currentStationID, int endStationID, Set<Integer> visited, List<Section> path) {
        if (currentStationID == endStationID) {
            return true;
        }

        visited.add(currentStationID);

        for (AdjacentStation adjacentStation : adjacencyList.get(currentStationID)) {
            int adjacentStationID = adjacentStation.getStation().getId();
            if (!visited.contains(adjacentStationID)) {
                Section section = findSection(currentStationID, adjacentStationID);
                path.add(section);

                if (dfs(adjacentStationID, endStationID, visited, path)) {
                    return true;
                }

                path.remove(path.size() - 1);
            }
        }

        return false;
    }

    /**
     * Dado 2 ids, se recorren todas las secciones para encontrar la que contenga esos ids, se verifica en ambas direcciones y se retorna
     * @param station1Id
     * @param station2Id
     * @return Seccion
     */
    private Section findSection(int station1Id, int station2Id) {
        return sections.stream()
                .filter(section ->
                        (section.getStation1().getId() == station1Id && section.getStation2().getId() == station2Id) ||
                                (section.getStation1().getId() == station2Id && section.getStation2().getId() == station1Id))
                .findFirst()
                .orElseThrow(() -> new IllegalStateException("Seccion no encontrada entre estaciones"));
    }
}