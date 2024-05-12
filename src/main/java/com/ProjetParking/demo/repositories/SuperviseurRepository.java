package com.ProjetParking.demo.repositories;

import com.ProjetParking.demo.models.Superviseur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface SuperviseurRepository extends JpaRepository<Superviseur,Long>
{


    @Query("SELECT COUNT(s) FROM Superviseur s")
    int getSuperviseurCount();

}
