package com.example.LOGINREGISTERPROJECT.Repo;

import com.example.LOGINREGISTERPROJECT.Entity.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UtilisateurRepository extends JpaRepository<Utilisateur,Integer> {

    Optional<Utilisateur> findUtilisateurByEmail(String email);
}
