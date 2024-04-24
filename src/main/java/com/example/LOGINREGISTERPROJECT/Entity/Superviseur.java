package com.example.LOGINREGISTERPROJECT.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name="superviseur")
@Getter
@Setter
@NoArgsConstructor
public class Superviseur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_sup")
    private Long id_sup;

    @Column(name = "email_sup", length = 250, unique = true, nullable = false)
    private String email_sup;

    @Column(name = "nom_sup", length = 50, nullable = false)
    private String nom_sup;

    @Column(name = "prenom_sup", length = 50, nullable = false)
    private String prenom_sup;

    @Column(name = "mdp_sup", length = 50, nullable = false)
    private String mdp_sup;

    @ManyToOne
    @JoinColumn(name = "id_pk")
    private Parking parking;
}
