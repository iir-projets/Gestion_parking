package com.ProjetParking.demo.models;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "administrateur")
@Getter
@Setter
@NoArgsConstructor
public class Admin {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Long id_admin;

    protected String nom_admin;
    protected String prenom_admin;
    protected String email_admin;
    protected String mdp_admin;










}