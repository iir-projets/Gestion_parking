package com.ProjetParking.demo.repositories;

import com.ProjetParking.demo.models.Admin;
import com.ProjetParking.demo.models.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation,Long>
{



}
