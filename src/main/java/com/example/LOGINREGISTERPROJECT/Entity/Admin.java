package com.example.LOGINREGISTERPROJECT.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name="administrateur")
@Getter
@Setter
@NoArgsConstructor
public class Admin {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_admin")
    private Long id_admin;

    @Column(name = "email_admin", length = 250, unique = true, nullable = false)
    private String email_admin;

    @Column(name = "nom_admin", length = 50, nullable = false)
    private String nom_admin;

    @Column(name = "prenom_admin", length = 50, nullable = false)
    private String prenom_admin;

    @Column(name = "mdp_admin", length = 50, nullable = false)
    private String mdp_admin;
}
