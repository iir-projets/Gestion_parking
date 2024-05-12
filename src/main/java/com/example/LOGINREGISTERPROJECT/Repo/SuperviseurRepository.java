package com.example.LOGINREGISTERPROJECT.Repo;

import com.example.LOGINREGISTERPROJECT.Entity.Superviseur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SuperviseurRepository extends JpaRepository<Superviseur,Long>
{



}