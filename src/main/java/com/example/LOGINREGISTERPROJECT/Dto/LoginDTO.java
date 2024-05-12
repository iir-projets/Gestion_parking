package com.example.LOGINREGISTERPROJECT.Dto;

public class LoginDTO {

    private String gmail_client;
    private String mot_de_passe_client;

    public LoginDTO(String gmail_client, String mot_de_passe_client) {
        this.gmail_client = gmail_client;
        this.mot_de_passe_client = mot_de_passe_client;
    }

    public LoginDTO() {
    }

    public String getGmail_client() {
        return gmail_client;
    }

    public void setGmail_client(String gmail_client) {
        this.gmail_client = gmail_client;
    }

    public String getMot_de_passe_client() {
        return mot_de_passe_client;
    }

    public void setMot_de_passe_client(String mot_de_passe_client) {
        this.mot_de_passe_client = mot_de_passe_client;
    }

    @Override
    public String toString() {
        return "LoginDTO{" +
                "gmail_client='" + gmail_client + '\'' +
                ", mot_de_passe_client='" + mot_de_passe_client + '\'' +
                '}';
    }

}
