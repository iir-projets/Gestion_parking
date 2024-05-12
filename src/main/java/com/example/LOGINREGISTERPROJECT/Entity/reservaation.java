package com.example.LOGINREGISTERPROJECT.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="reservaation")
@Getter
@Setter
@NoArgsConstructor
public class reservaation {
    @Id
    @Column(name = "id_reservation")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id_reservation;

    @Column(name = "date_entree", length = 255)
    private String date_entree;


    @Column(name = "prix_total", length = 255)
    private double prix_total ;

    @Column(name = "place_id")
    private Long place_id;

    @Column(name = "duree")
    private Long duree;
    @Column(name = "id_client")
    private Long id_client;
}
