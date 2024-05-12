package com.example.LOGINREGISTERPROJECT.Service.impl;

import com.example.LOGINREGISTERPROJECT.Entity.Reservation;
import com.example.LOGINREGISTERPROJECT.Repo.ReservationRepository;
import com.example.LOGINREGISTERPROJECT.Repo.PlaceRepository;
import com.example.LOGINREGISTERPROJECT.Service.ReservationService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
@AllArgsConstructor
public class ReservationServiceImpl implements ReservationService {

    private final ReservationRepository reservationRepository;
    @Autowired
    private PlaceRepository placeRepo;

    @Override
    public Reservation creer(Reservation reservation) {
        return reservationRepository.save(reservation);
    }


    @Override
    public List<Reservation> lire() {
        return reservationRepository.findAll();
    }
@Override
public Reservation modifier(Long id, Reservation reservation){
        return reservationRepository.findById(id).map(p->{
            p.setPrix_total(reservation.getPrix_total());
            p.setDate_entree(reservation.getDate_entree());
            p.setDate_sortie(reservation.getDate_sortie());
            return reservationRepository.save(p);
        }).orElseThrow(()->new RuntimeException("reservation non trouvé"));
}
    @Override
    public String supprimer(Long id) {
        try {
            reservationRepository.deleteById(id);
            return "Reservation supprimée avec succès";
        } catch (EmptyResultDataAccessException ex) {
            throw new RuntimeException("La réservation avec l'ID spécifié n'a pas été trouvée");
        } catch (Exception ex) {
            throw new RuntimeException("Une erreur s'est produite lors de la suppression de la réservation");
        }
    }

}
