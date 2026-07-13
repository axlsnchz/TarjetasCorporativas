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

    public static String generateSecurePassword() {
        SecureRandom random = new SecureRandom();
        List<Character> passwordChars = new ArrayList<>();

        passwordChars.add(UPPER.charAt(random.nextInt(UPPER.length())));
        passwordChars.add(LOWER.charAt(random.nextInt(LOWER.length())));
        passwordChars.add(DIGITS.charAt(random.nextInt(DIGITS.length())));
        passwordChars.add(SYMBOLS.charAt(random.nextInt(SYMBOLS.length())));

        String combined = LOWER + UPPER + DIGITS + SYMBOLS;
        for (int i = 0; i < 6; i++) {
            passwordChars.add(combined.charAt(random.nextInt(combined.length())));
        }

        Collections.shuffle(passwordChars, random);

        StringBuilder result = new StringBuilder();
        for (char c : passwordChars) {
            result.append(c);
        }
        return result.toString();
    }
}
