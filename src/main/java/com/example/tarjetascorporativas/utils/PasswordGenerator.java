package com.example.tarjetascorporativas.utils;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class PasswordGenerator {

    private static final String LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String DIGITS = "0123456789";
    private static final String SYMBOLS = "!@#$%^&*";

    /**
     * Genera una contraseña segura de 10 caracteres que cumple obligatoriamente con:
     * - Mínimo 8 caracteres
     * - Al menos un símbolo (!@#$%^&*)
     * - Al menos un número
     * - Letras mayúsculas y minúsculas
     */
    public static String generateSecurePassword() {
        SecureRandom random = new SecureRandom();
        List<Character> passwordChars = new ArrayList<>();

        // Garantizar presencia de los tipos de caracteres requeridos
        passwordChars.add(UPPER.charAt(random.nextInt(UPPER.length())));
        passwordChars.add(LOWER.charAt(random.nextInt(LOWER.length())));
        passwordChars.add(DIGITS.charAt(random.nextInt(DIGITS.length())));
        passwordChars.add(SYMBOLS.charAt(random.nextInt(SYMBOLS.length())));

        // Rellenar hasta 10 caracteres
        String combined = LOWER + UPPER + DIGITS + SYMBOLS;
        for (int i = 0; i < 6; i++) {
            passwordChars.add(combined.charAt(random.nextInt(combined.length())));
        }

        // Mezclar aleatoriamente el orden de los caracteres
        Collections.shuffle(passwordChars, random);

        StringBuilder result = new StringBuilder();
        for (char c : passwordChars) {
            result.append(c);
        }
        return result.toString();
    }
}
