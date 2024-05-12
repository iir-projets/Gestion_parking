package com.ProjetParking.demo.models;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "place")
@Getter
@Setter
@NoArgsConstructor
public class Place {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long num_pl;

    private Boolean statut_pl;








    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="id_pk",referencedColumnName = "id_pk")
    private Parking parking;


    public Parking getParking() {
        return parking;
    }

    public void assignparking(Parking parking) {
        this.parking = parking;
    }

    // Constructor, getters, setters





}