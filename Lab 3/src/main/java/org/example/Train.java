package org.example;
import org.example.Interfaces.TrainInterface;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static org.example.ConsoleColors.GREEN_BOLD;
import static org.example.ConsoleColors.RESET;

/**
 * Clase que representa un tren con su id, maker, velocidad, tiempo de estancia en estacion y lista de carros
 */
public class Train implements TrainInterface {
    private int id;
    private String maker;
    private int speed;
    private int stationStayTime;
    private List<Pcar> carList;
    /*
        * Constructor de la clase Train
     */
    public Train(int id, String maker, int speed, int StationStayTime, List<Pcar> carList) {
        this.id = id;
        this.maker = maker;
        this.speed = speed;
        this.stationStayTime = StationStayTime;
        this.carList = carList;
    }

    @Override
    public int getId() {
        return id;
    }

    @Override
    public String getMaker() {
        return maker;
    }

    @Override
    public int getSpeed() {
        return speed;
    }

    @Override
    public int getStationStayTime() {
        return stationStayTime;
    }

    @Override
    public List<Pcar> getCarList() {
        return carList;
    }

    /**
     * Metodo que agrega un carro a la lista de carros, verificando que la posicion sea valida
     * @param car
     * @param position
     */
    @Override
    public void addCar(Pcar car, int position) {
        if (position < 0 || position > carList.size()) {
            throw new IllegalArgumentException("Invalid position");
        }
        carList.add(position, car);
    }

    /**
     * Metodo que elimina un carro de la lista de carros, verificando que la posicion sea valida
     * @param position
     */
    @Override
    public void removeCar(int position) {
        if (position < 0 || position >= carList.size()) {
            throw new IllegalArgumentException("Invalid position");
        }
        carList.remove(position);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Train ID: ").append(id).append("\n");
        sb.append("Maker: ").append(maker).append("\n");
        sb.append("Speed: ").append(speed).append("\n");
        sb.append("Station Stay Time: ").append(stationStayTime).append("\n");
        sb.append("Cars:\n");
        for (Pcar car : carList) {
            sb.append("----\n").append(car.toString()).append("\n");
        }
        sb.append(GREEN_BOLD + "------" + RESET + "\n");
        return sb.toString();
    }
    /**
     * Metodo que verifica si el tren es valido
     * Verifica el size minimo, ids unicos, maker igual, y configuracion de los carros
     * @return true si lo es, false si no
     */
    @Override
    public boolean isTrain() {
        // Verificar que haya al menos 2 carros
        if (carList.size() < 2) {
            return false;
        }

        // Verificar que el maker de todos los Pcars sea el mismo que el del tren
        // y que no haya IDs repetidos
        Set<Integer> seenIds = new HashSet<>();
        for (Pcar pcar : carList) {
            if (!pcar.getMaker().equals(this.maker) || !seenIds.add(pcar.getId())) {
                return false;
            }
        }

        // Verificar la configuracion de los Pcars
        int totalCars = carList.size();
        if (totalCars == 2) {
            // Ambos deben ser terminales "tr"
            return carList.get(0).getType().equals("tr") &&
                    carList.get(1).getType().equals("tr");
        } else if (totalCars == 3) {
            // Los de las esquinas deben ser "tr" y el central "ct"
            return carList.get(0).getType().equals("tr") &&
                    carList.get(1).getType().equals("ct") &&
                    carList.get(2).getType().equals("tr");
        } else {
            // N carros: el primero y el ultimo deben ser "tr", el resto "ct"
            if (!carList.get(0).getType().equals("tr") ||
                    !carList.get(totalCars - 1).getType().equals("tr")) {
                return false;
            }
            for (int i = 1; i < totalCars - 1; i++) {
                if (!carList.get(i).getType().equals("ct")) {
                    return false;
                }
            }
            return true;
        }
    }

    /**
     * Metodo que calcula la capacidad de pasajeros del tren
     * @return
     */
    @Override
    public int fetchCapacity() {
        return carList.stream()
                .mapToInt(Pcar::getPassengerCapacity)
                .sum();

    }
}
