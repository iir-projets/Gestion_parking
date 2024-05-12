package com.ProjetParking.demo.controllers;

import com.ProjetParking.demo.models.Admin;
import com.ProjetParking.demo.repositories.AdminRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController

@AllArgsConstructor
public class AdminController {

    @Autowired
    private final AdminRepository adminRepository;




    @GetMapping("/admin")
public List<Admin> read()
{
    return adminRepository.findAll();
}


}
