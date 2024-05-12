package com.example.LOGINREGISTERPROJECT.EmployeeController;

import com.example.LOGINREGISTERPROJECT.Entity.Parking;
import com.example.LOGINREGISTERPROJECT.Entity.Superviseur;
import com.example.LOGINREGISTERPROJECT.Repo.ParkingRepository;
import com.example.LOGINREGISTERPROJECT.Repo.SuperviseurRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController

@AllArgsConstructor
public class ParkingController {

    @Autowired
    private ParkingRepository parkingRepository;

    private SuperviseurRepository superviseurRepository;


    @PostMapping("/parking")




    public Parking create(@RequestBody Parking parking) {
        // Get the ID of the supervisor associated with the parking from the parking object
        Long supervisorId = parking.getSuperviseur().getId_sup();

        // Check if the Superviseur entity exists in the database
        Superviseur existingSuperviseur = superviseurRepository.findById(supervisorId)
                .orElseThrow(() -> new EntityNotFoundException("Superviseur not found with id: " + supervisorId));

        // Set the existing Superviseur as the supervisor of the Parking entity
        parking.setSuperviseur(existingSuperviseur);

        // Save the Parking entity
        return parkingRepository.save(parking);
    }




    @GetMapping("/parkings")
    public List<Parking> read()
    {
        return  parkingRepository.findAll();
    }

    @PutMapping("/parking/{id}")

    public Parking update(@PathVariable  Long id,@RequestBody Parking parking)
    {
        return parkingRepository.findById(id)
                .map(p->{
                    p.setNom_pk(parking.getNom_pk());
                    p.setAdresse_pk(parking.getAdresse_pk());
                    return parkingRepository.save(p);
                }).orElseThrow(()-> new RuntimeException(("Parking non trouvé ! ")));
    }


    @DeleteMapping("/parking/{id}")

    public String delete(@PathVariable Long id)
    {
        parkingRepository.deleteById(id);
        return "Parking supprimé !";
    }

}
