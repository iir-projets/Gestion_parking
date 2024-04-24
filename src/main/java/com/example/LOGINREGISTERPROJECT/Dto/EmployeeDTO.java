package com.example.LOGINREGISTERPROJECT.Dto;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

public class EmployeeDTO {

    private int id_client;
    private String gmail_client;
    private String prenom_client;
    private String mot_de_passe_client;

    public EmployeeDTO(int id_client, String gmail_client, String prenom_client, String mot_de_passe_client) {
        this.id_client = id_client;
        this.gmail_client = gmail_client;
        this.prenom_client = prenom_client;
        this.mot_de_passe_client = mot_de_passe_client;
    }

    public EmployeeDTO() {
    }

    public String getMot_de_passe_client() {
        return mot_de_passe_client;
    }

    public String getPrenom_client() {
        return prenom_client;
    }

    public String getGmail_client() {
        return gmail_client;
    }

    public int getId_client() {
        return id_client;
    }

    public void setId_client(int id_client) {
        this.id_client = id_client;
    }

    public void setGmail_client(String gmail_client) {
        this.gmail_client = gmail_client;
    }

    public void setPrenom_client(String prenom_client) {
        this.prenom_client = prenom_client;
    }

    public void setMot_de_passe_client(String mot_de_passe_client) {
        this.mot_de_passe_client = mot_de_passe_client;
    }

    @Override
    public String toString() {
        return "EmployeeDTO{" +
                "id_client=" + id_client +
                ", gmail_client='" + gmail_client + '\'' +
                ", prenom_client='" + prenom_client + '\'' +
                ", mot_de_passe_client='" + mot_de_passe_client + '\'' +
                '}';
    }
}
