package com.ProjetParking.demo.controllers;

import com.ProjetParking.demo.models.Client;
import com.ProjetParking.demo.models.Parking;
import com.ProjetParking.demo.models.Place;
import com.ProjetParking.demo.models.Reservation;
import com.ProjetParking.demo.repositories.ClientRepository;
import com.ProjetParking.demo.repositories.ParkingRepository;
import com.ProjetParking.demo.repositories.PlaceRepository;
import com.ProjetParking.demo.repositories.ReservationRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ReservationController {

    @Autowired
    private ReservationRepository reservationRepository;
    @Autowired
    private ClientRepository clientRepository;
    @Autowired
    private ParkingRepository parkingRepository;
    @Autowired
    private PlaceRepository placeRepository;
    // Endpoint to retrieve all reservations
    @GetMapping("/reservations")
    public List<Reservation> getAllReservations() {
        return reservationRepository.findAll();
    }

    // Endpoint to retrieve a specific reservation by ID
    @GetMapping("/reservation/{id}")
    public Reservation getReservationById(@PathVariable Long id) {
        return reservationRepository.findById(id).orElse(null);
    }

    // Endpoint to create a new reservation
    // Endpoint to create a new reservation
    @PostMapping("/reservation")
    public Reservation createReservation(@RequestBody Reservation reservation) {
        // Retrieve client information (assuming it's available in the reservation object)
        Long clientId = reservation.getClient().getId();

        // Retrieve the selected parking and spot from the reservation object
        Parking selectedParking = reservation.getParking();
        Place selectedSpot = reservation.getSpot();

        // Retrieve the client entity from the database using the clientRepository
        Client client = clientRepository.findById(clientId)
                .orElseThrow(() -> new EntityNotFoundException("Client not found with id: " + clientId));

        // Retrieve the parking entity from the database using the parkingRepository
        Parking parking = parkingRepository.findById(selectedParking.getId_pk())
                .orElseThrow(() -> new EntityNotFoundException("Parking not found with id: " + selectedParking.getId_pk()));

        // Retrieve the spot entity from the database using the placeRepository
        Place spot = placeRepository.findById(selectedSpot.getNum_pl())
                .orElseThrow(() -> new EntityNotFoundException("Spot not found with id: " + selectedSpot.getNum_pl()));

        // Check if the selected spot belongs to the chosen parking
        if (!spot.getParking().equals(parking)) {
            throw new IllegalArgumentException("The selected spot does not belong to the chosen parking.");
        }

        // Set the retrieved client, parking, and spot as the respective entities of the reservation
        reservation.setClient(client);
        reservation.setParking(parking);
        reservation.setSpot(spot);

        // Save the Reservation entity
        return reservationRepository.save(reservation);
    }



    // Endpoint to delete a reservation by ID
    @DeleteMapping("/reservation/{id}")
    public void deleteReservation(@PathVariable Long id) {
        reservationRepository.deleteById(id);
    }
}
