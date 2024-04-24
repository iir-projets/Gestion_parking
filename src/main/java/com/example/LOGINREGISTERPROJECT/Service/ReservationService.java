package com.example.LOGINREGISTERPROJECT.Service;

import com.example.LOGINREGISTERPROJECT.Entity.Reservation;

import java.util.List;

public interface ReservationService {
    Reservation creer(Reservation reservation) ;
    List<Reservation> lire();
    String supprimer(Long id);
    Reservation modifier(Long id,Reservation reservation);

}
