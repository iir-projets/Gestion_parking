package com.example.LOGINREGISTERPROJECT.EmployeeController;

import com.example.LOGINREGISTERPROJECT.Entity.Admin;
import com.example.LOGINREGISTERPROJECT.Repo.AdminRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@AllArgsConstructor
public class AdminController {

    private final AdminRepository adminRepository;

@Autowired


    @GetMapping("/admin")
    public List<Admin> read()
    {
        return adminRepository.findAll();
    }


}