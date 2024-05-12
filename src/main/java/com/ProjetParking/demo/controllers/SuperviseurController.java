package com.ProjetParking.demo.controllers;

import com.ProjetParking.demo.repositories.SuperviseurRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.ProjetParking.demo.models.Superviseur;
import java.util.List;
import java.util.Optional;


@RestController

@AllArgsConstructor
public class SuperviseurController {


    @Autowired
    private SuperviseurRepository superviseurRepository;

    @PostMapping("/superviseur")
    public Superviseur create(@RequestBody Superviseur superviseur)
    {
        return superviseurRepository.save(superviseur);
    }
    @GetMapping("/superviseurs")
    public List<Superviseur> read()
    {
        return superviseurRepository.findAll();
    }

    @GetMapping("/superviseur/{id}")
    public ResponseEntity<Superviseur> read(@PathVariable Long id) {
        Optional<Superviseur> superviseurOptional = superviseurRepository.findById(id);
        if (superviseurOptional.isPresent()) {
            Superviseur superviseur = superviseurOptional.get();
            return ResponseEntity.ok(superviseur);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/superviseurs/count")
    public int getParkingCount() {
        return superviseurRepository.getSuperviseurCount();
    }




    @PutMapping("/superviseur/{id}")

    public Superviseur update(@PathVariable  Long id, @RequestBody Superviseur superviseur)
    {
        return superviseurRepository.findById(id)
                .map(p->{
                    p.setNom_sup(superviseur.getNom_sup());
                    p.setPrenom_sup(superviseur.getPrenom_sup());
                    p.setEmail_sup(superviseur.getEmail_sup());
                    p.setMdp_sup(superviseur.getMdp_sup());
                    return superviseurRepository.save(p);
                }).orElseThrow(()-> new RuntimeException(("Superviseur non trouvé ! ")));
    }


    @DeleteMapping("/superviseur/{id}")

    public String delete(@PathVariable Long id)
    {
        Optional<Superviseur> optionalSuperviseur = superviseurRepository.findById(id);
        if (optionalSuperviseur.isPresent()) {
            superviseurRepository.deleteById(id);
            return "Superviseur supprimé !";
        } else {
            throw new RuntimeException("Superviseur non trouvé !");
        }

    }

}