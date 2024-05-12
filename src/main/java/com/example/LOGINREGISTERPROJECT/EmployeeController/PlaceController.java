package com.example.LOGINREGISTERPROJECT.EmployeeController;

import com.example.LOGINREGISTERPROJECT.Entity.Parking;
import com.example.LOGINREGISTERPROJECT.Entity.Place;
import com.example.LOGINREGISTERPROJECT.Repo.ParkingRepository;
import com.example.LOGINREGISTERPROJECT.Repo.PlaceRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
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

    @PutMapping("/place/{id}")

    public Place update(@PathVariable Long id, @RequestBody Place place) {
        return placeRepository.findById(id)
                .map(p -> {
                    p.setStatut_pl(place.isStatut_pl());

                    return placeRepository.save(p);
                }).orElseThrow(() -> new RuntimeException(("Place non trouvé ! ")));
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

    }}