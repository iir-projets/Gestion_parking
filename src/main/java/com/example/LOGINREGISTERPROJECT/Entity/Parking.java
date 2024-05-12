package com.example.LOGINREGISTERPROJECT.Entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "parking")
@Getter
@Setter
@NoArgsConstructor
public class Parking {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_pk;

    private String nom_pk;
    private String adresse_pk;




    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "id_sup", referencedColumnName = "id_sup")
    private Superviseur superviseur;

    @JsonIgnore
    @OneToMany(mappedBy = "parking")
    private Set<Place> places = new HashSet<>();

    public Long getId_pk() {
        return id_pk;
    }

    public String getNom_pk() {
        return nom_pk;
    }

    public void setNom_pk(String nom_pk) {
        this.nom_pk = nom_pk;
    }

    public String getAdresse_pk() {
        return adresse_pk;
    }

    public void setAdresse_pk(String adresse_pk) {
        this.adresse_pk = adresse_pk;
    }

    public Superviseur getSuperviseur() {
        return superviseur;
    }

    public void setSuperviseur(Superviseur superviseur) {
        this.superviseur = superviseur;
    }

    public void setPlaces(Set<Place> places) {
        this.places = places;
    }

    public void setId_pk(Long id_pk) {
        this.id_pk = id_pk;
    }

    public Set<Place> getPlaces() {
        return places;
    }
}
