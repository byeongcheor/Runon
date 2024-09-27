package com.ict.finalproject.jwt;
import java.security.SecureRandom;
import java.util.Base64;

public class JWTKeyGenerator {
    public static String generateSecretKey() {
        SecureRandom secureRandom = new SecureRandom();
        byte[] keyBytes = new byte[32]; // 32 bytes for 256-bit key
        secureRandom.nextBytes(keyBytes);
        return Base64.getEncoder().encodeToString(keyBytes);
    }

    public static void main(String[] args) {
        System.out.println("Generated JWT Secret Key: " + generateSecretKey());
    }
}
