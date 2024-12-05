package org.example.Abstract;

import org.example.*;

import java.nio.file.Paths;

/**
 * Clase abstracta para cargar datos
 * Deja como constantes las direcciones para buscar los archivos de texto
 */
public abstract class DataLoader {
    protected Subway subway;
    protected boolean directLoading;
    protected static final String DEFAULT_RESOURCE_PATH = "src/main/resources/default";
    protected static final String DIRECT_RESOURCE_PATH = "src/main/resources";

    /**
     * Constructor
     * Direct loading habla soble que direcicon usar
     * @param subway
     * @param directLoading
     */
    public DataLoader(Subway subway, boolean directLoading) {
        this.subway = subway;
        this.directLoading = directLoading;
    }

    /**
     * Metodo para cargar datos
     */
    public abstract void loadData();

    /**
     * Metodo para obtener la direccion del archivo
     * @param fileName
     * @return String PATH
     */
    protected String getFilePath(String fileName) {
        String resourcePath = directLoading ? DEFAULT_RESOURCE_PATH : DIRECT_RESOURCE_PATH;
        return Paths.get(System.getProperty("user.dir"), resourcePath, fileName).toString();
    }
}