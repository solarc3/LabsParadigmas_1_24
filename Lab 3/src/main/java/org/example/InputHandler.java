package org.example;

import java.util.Scanner;

import static org.example.ConsoleColors.*;

/**
 * Clase que permite depurar y filtrar los ingresos de datos
 * Existen muchos problemas con manejar Scanners, para evitar mas problemas, la unica que puede hacerlo, ademas de
 * la que ya existe al inicia el programa, es esta clase.
 */
public class InputHandler {
    private static final Scanner scanner = new Scanner(System.in);

    /**
     * Se verifica que el ingreso sea un int, ademas se da un mensaje sobre el rango de numeros para seleccionar
     * Como esta en un while true, si no es correcto, se debe intentar hasta que lo sea
     * @param prompt
     * @param min
     * @param max
     * @return input Value
     */
    public static int getIntInput(String prompt, int min, int max) {
        while (true) {
            System.out.print(prompt);
            if (scanner.hasNextInt()) {
                int input = scanner.nextInt();
                scanner.nextLine();
                if (input >= min && input <= max) {
                    return input;
                }
            } else {
                scanner.nextLine();
            }
            System.out.println(RED_BACKGROUND + BLACK_BOLD + "\nPor favor, ingrese un numero entre " + min + " y " + max + "." + RESET + "\n");
        }
    }

    /**
     * Para strings, misma idea pero se usa un trim para eliminar espacios en blanco
     * @param prompt
     * @return String value
     */
    public static String getStringInput(String prompt) {
        System.out.print(prompt);
        return scanner.nextLine().trim();
    }
    /**
     * Caso booleano, se permite ademas tener un while true loop para ver selecciones, pero se utiliza s o n para representar booleanos
     * @param prompt
     * @return Bool value
     */
    public static boolean getBooleanInput(String prompt) {
        while (true) {
            System.out.print(prompt + " (s/n): ");
            String input = scanner.nextLine().trim().toLowerCase();
            if (input.equals("s")) return true;
            if (input.equals("n")) return false;
            System.out.println("Por favor, responda con 's' o 'n'.");
        }
    }
}