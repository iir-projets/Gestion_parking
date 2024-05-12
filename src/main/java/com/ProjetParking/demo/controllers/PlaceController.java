package com.ProjetParking.demo.controllers;

import com.ProjetParking.demo.models.Parking;
import com.ProjetParking.demo.models.Place;
import com.ProjetParking.demo.repositories.ParkingRepository;
import com.ProjetParking.demo.repositories.PlaceRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import java.util.List;
import java.util.Optional;


@RestController

@AllArgsConstructor
public class PlaceController {
    @Autowired
    PlaceRepository placeRepository;
    @Autowired
    ParkingRepository parkingRepository;

    @PostMapping("/place")
    public Place create(@RequestBody Place place) {

        return placeRepository.save(place);

    }

    @GetMapping("/places")
    public List<Place> read() {
        return placeRepository.findAll();
    }

    @GetMapping("/parking/{parkingId}/places")
    public List<Place> getSpotsForParking(@PathVariable Long parkingId) {
        return placeRepository.getSpotsForParking(parkingId);
    }
    @PutMapping("/place/{id}")

    public Place update(@PathVariable Long id, @RequestBody Place place) {
        return placeRepository.findById(id)
                .map(p -> {
                    p.setStatut_pl(place.getStatut_pl());

                    return placeRepository.save(p);
                }).orElseThrow(() -> new RuntimeException(("Place non trouvé ! ")));
    }


    @PutMapping("/{parkingId}/places/{spotId}/occupy")
    public ResponseEntity<String> occupySpot(@PathVariable Long parkingId, @PathVariable Long spotId) {
        // Retrieve the parking spot by ID
        List<Place> spots = placeRepository.getSpotsForParking(parkingId);

        // Find the spot with the given ID
        Place spot = null;
        for (Place p : spots) {
            if (p.getNum_pl().equals(spotId)) {
                spot = p;
                break;
            }
        }

        // Check if the parking spot exists
        if (spot == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Parking spot not found");
        }

        // Update the status of the parking spot to 'true'
        spot.setStatut_pl(true);
        placeRepository.save(spot);

        return ResponseEntity.ok("Parking spot occupied successfully");
    }

    @PutMapping("/place/{num_pl}/parking/{id_pk}")
    public Place assignParkingToPlace (
            @PathVariable Long num_pl,
            @PathVariable Long id_pk
    ){
        Place place = placeRepository.findById(num_pl).get();
        Parking parking = parkingRepository.findById(id_pk).get();
        place.setParking(parking);
        return placeRepository.save(place);
    }
    @DeleteMapping("/place/{id}")

    public String delete(@PathVariable Long id) {
        Optional<Place> optionalSuperviseur = placeRepository.findById(id);
        if (optionalSuperviseur.isPresent()) {
            placeRepository.deleteById(id);
            return "Place supprimé !";
        } else {
            throw new RuntimeException("Place non trouvé !");
        }

    }
}
