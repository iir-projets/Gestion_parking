package com.ProjetParking.demo.models;
import java.util.*;import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Table(name = "reservation")
@Getter
@Setter
@NoArgsConstructor
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String timestamp;
    private String duration;
    private double price;

    @ManyToOne
    @JoinColumn(name = "client_id", referencedColumnName = "id")
    private Client client;

    @ManyToOne
    @JoinColumn(name = "parking_id", referencedColumnName = "id_pk")
    private Parking parking;

    @ManyToOne
    @JoinColumn(name = "spot_id", referencedColumnName = "num_pl")
    private Place spot;

    // Constructors, getters, setters
}
