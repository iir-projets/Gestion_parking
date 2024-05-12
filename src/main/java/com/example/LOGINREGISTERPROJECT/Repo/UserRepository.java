package com.example.LOGINREGISTERPROJECT.Repo;

import com.example.LOGINREGISTERPROJECT.Entity.Employee;
import org.springframework.stereotype.Repository;

@Repository
public class UserRepository {
    public Employee findUserByEmail(String email){
        Employee user = new Employee(email,"123456","123456");
        user.setId_client(Long.valueOf("id_client"));
        user.setPrenom_client("prenom_client");
        return user;
    }
}