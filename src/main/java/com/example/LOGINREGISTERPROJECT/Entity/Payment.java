package com.example.LOGINREGISTERPROJECT.Entity;

import jakarta.persistence.*;


@Entity
@Table(name = "payments")
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "amount")
    private double amount;

    // Autres champs nécessaires, comme le numéro de carte, la date d'expiration, etc.

    // Getters and setters
}
