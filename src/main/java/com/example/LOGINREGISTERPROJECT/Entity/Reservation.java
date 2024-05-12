package com.example.LOGINREGISTERPROJECT.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Entity
@Table(name="reservation")
@Getter
@Setter
@NoArgsConstructor


public class Reservation {
    @Id
    @Column(name = "id_reservation")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id_reservation;

    @Column(name = "date_entree", length = 255)
    private String date_entree;

    @Column(name = "date_sortie", length = 255)
    private String date_sortie;

    @Column(name = "prix_total", length = 255)
    private double prix_total ;
    @ManyToOne
    @JoinColumn(name = "place_id")
    private Place place;

    @ManyToOne
    @JoinColumn(name = "id_client")
    private Employee client;


    public Long getId_reservation() {
        return id_reservation;
    }

    public void setId_reservation(Long id_reservation) {
        this.id_reservation = id_reservation;
    }

    public String getDate_entree() {
        return date_entree;
    }

    public void setDate_entree(String date_entree) {
        this.date_entree = date_entree;
    }

    public String getDate_sortie() {
        return date_sortie;
    }

    public void setDate_sortie(String date_sortie) {
        this.date_sortie = date_sortie;
    }

    public Place getPlace() {
        return place;
    }

    public void setPlace(Place place) {
        this.place = place;
    }

    public Employee getClient() {
        return client;
    }

    public void setClient(Employee client) {
        this.client = client;
    }

    public double getPrix_total() {
        return prix_total;
    }

    public void setPrix_total(double prix_total) {
        this.prix_total = prix_total;
    }
}
