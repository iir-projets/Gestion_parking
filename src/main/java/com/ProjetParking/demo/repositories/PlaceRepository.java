package com.ProjetParking.demo.repositories;

import com.ProjetParking.demo.models.Place;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository

public interface PlaceRepository extends JpaRepository<Place,Long>
{


        @Query("SELECT p FROM Place p WHERE p.parking.id_pk = :parkingId")
        List<Place> getSpotsForParking(Long parkingId);


}
