package org.example.Interfaces;
import org.example.Driver;
import org.example.Line;
import org.example.Station;
import org.example.Train;

import java.util.Date;
import java.util.List;

public interface SubwayInterface {
    int getId();
    String getName();
    boolean addTrain(Train train);
    boolean addLine(Line line);
    boolean addDriver(Driver driver);
    void assignTrainToLine(Train train, Line line);
    void assignDriverToTrain(Train train, Driver driver, Date departureTime,
                             Station departureStation, Station arrivalStation, int lineID);
    Station whereIsTrain(Train train, Date time);
    List<Station> trainPath(Train train, Date time);
}