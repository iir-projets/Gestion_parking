package com.ProjetParking.demo.models;
import java.util.*;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "parking")
@Getter
@Setter
@NoArgsConstructor
public class Parking {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_pk;
    private double price;
    private String nom_pk;
    private String adresse_pk;




    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "superviseur", referencedColumnName = "id_sup")
    private Superviseur superviseur;

    @JsonIgnore
    @OneToMany(mappedBy = "parking")
    private Set<Place> places = new HashSet<>();


    public Set<Place> getPlaces() {
        return places;
    }




}