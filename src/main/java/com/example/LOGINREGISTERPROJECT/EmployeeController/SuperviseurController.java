package com.example.LOGINREGISTERPROJECT.EmployeeController;

import com.example.LOGINREGISTERPROJECT.Entity.Superviseur;
import com.example.LOGINREGISTERPROJECT.Repo.SuperviseurRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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