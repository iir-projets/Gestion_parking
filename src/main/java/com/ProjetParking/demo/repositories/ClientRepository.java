package com.ProjetParking.demo.repositories;


import com.ProjetParking.demo.models.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClientRepository extends JpaRepository<Client,Long>
{



}
