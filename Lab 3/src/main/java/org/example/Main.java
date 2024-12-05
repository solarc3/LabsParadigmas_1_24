package org.example;

import java.util.Scanner;

/**
 * Clase inicial, se genera un scanner y un subway, ademas se agregan los datos default y se spawnea un menu
 */
public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Subway subway = new Subway(1, "Metro de Santiago");
        MenuManager menuManager = new MenuManager(scanner, subway);

        boolean exitProgram = false;
        while (!exitProgram) {
            exitProgram = menuManager.showMainMenu();
        }

        System.out.println("Gracias por usar el sistema de Metro. ¡Hasta luego!");
        scanner.close();
    }
}