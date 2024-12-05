package org.example.Interfaces;
import org.example.Section;

import java.util.List;
/**
 * Interfaz para las lineas, solo se tienen los getters
 */
public interface LineInterface {
    int getId();
    String getName();
    String getRailType();

    List<Section> getSections();

    void addSection(Section section);
    double getLength();
    double getSectionLength(String station1Name, String station2Name);
    double getCost();
    double  getSectionCost(String station1Name, String station2Name);
    boolean isLine();
}