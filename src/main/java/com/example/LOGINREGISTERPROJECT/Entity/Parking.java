package com.example.LOGINREGISTERPROJECT.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name="parking")
@Getter
@Setter
@NoArgsConstructor
public class Parking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pk")
    private Long id_pk;

    @Column(name = "nom_pk", length = 50, nullable = false)
    private String nom_pk;

    @Column(name = "adresse_pk", length = 50, nullable = false)
    private String adresse_pk;

    @ManyToOne
    @JoinColumn(name = "id_admin")
    private Admin admin;
}
