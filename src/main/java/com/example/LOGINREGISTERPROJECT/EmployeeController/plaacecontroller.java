package com.example.LOGINREGISTERPROJECT.EmployeeController;

import com.example.LOGINREGISTERPROJECT.Entity.Place;
import com.example.LOGINREGISTERPROJECT.Entity.plaace;
import com.example.LOGINREGISTERPROJECT.Repo.plaacerepo;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController

@AllArgsConstructor
public class plaacecontroller {
    @Autowired
    plaacerepo placeRepository;
    @PostMapping("/placee")
    public plaace create(@RequestBody plaace place) {

        return placeRepository.save(place);

    }
}
