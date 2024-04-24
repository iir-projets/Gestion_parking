package com.example.LOGINREGISTERPROJECT.Service;

import org.springframework.stereotype.Service;

@Service
public class PaymentService {

    public String processPayment(double amount) {
        // Logique de traitement de paiement ici
        // Vous pouvez implémenter ici votre logique de paiement personnalisée
        return "Paiement de " + amount + " effectué avec succès.";
    }
}
