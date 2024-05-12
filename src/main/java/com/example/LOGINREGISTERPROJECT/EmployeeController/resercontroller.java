package com.example.LOGINREGISTERPROJECT.EmployeeController;

import com.example.LOGINREGISTERPROJECT.Entity.*;
import com.example.LOGINREGISTERPROJECT.Repo.resrepo;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
public class resercontroller {
    @Autowired
    resrepo reserRepository;

    @PostMapping("/res")
    public reservaation create(@RequestBody reservaation rese) {

        return reserRepository.save(rese);

    }

}
