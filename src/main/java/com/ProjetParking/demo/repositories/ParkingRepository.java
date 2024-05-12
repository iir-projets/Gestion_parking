package com.ProjetParking.demo.repositories;

import com.ProjetParking.demo.models.Parking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ParkingRepository extends JpaRepository<Parking,Long>
{
    @Query("SELECT COUNT(p) FROM Parking p")
    int getParkingCount();


}
