package com.example.LOGINREGISTERPROJECT.Entity;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "client")
public class Employee {
    @Id
    @Column(name = "id_client")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id_client;

    @Column(name = "gmail_client", length = 255)
    private String email;

    @Column(name = "prenom_client", length = 255)
    private String prenom_client;

    @Column(name = "mot_de_passe_client", length = 255)
    private String password ;

    public Employee() {
        // Default constructor required by JPA
    }

    public Employee(String gmail_client, String prenom_client, String mot_de_passe_client) {
        this.email = gmail_client;
        this.prenom_client = prenom_client;
        this.password  = mot_de_passe_client;
    }

    // Getters and setters for id_client
    public Long getId_client() {
        return id_client;
    }

    public void setId_client(Long id_client) {
        this.id_client = id_client;
    }

    // Getters and setters for gmail_client
    public String getGmail_client() {
        return email;
    }

    public void setGmail_client(String gmail_client) {
        this.email = gmail_client;
    }

    // Getters and setters for prenom_client
    public String getPrenom_client() {
        return prenom_client;
    }

    public void setPrenom_client(String prenom_client) {
        this.prenom_client = prenom_client;
    }

    // Getters and setters for mot_de_passe_client
    public String getMot_de_passe_client() {
        return password ;
    }

    public void setMot_de_passe_client(String mot_de_passe_client) {
        this.password  = mot_de_passe_client;
    }
}
