package com.ProjetParking.demo.models;
import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "superviseur")
@Getter
@Setter
@NoArgsConstructor
public class Superviseur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_sup;

    private String email_sup;
    private String nom_sup;
    private String prenom_sup;
    private String mdp_sup;

    @JsonIgnore
    @OneToOne(mappedBy = "superviseur")
    private Parking parking;


    // Constructor, getters, setters





}