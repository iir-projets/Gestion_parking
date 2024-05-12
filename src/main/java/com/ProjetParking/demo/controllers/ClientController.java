package com.ProjetParking.demo.controllers;

import com.ProjetParking.demo.models.Client;
import com.ProjetParking.demo.repositories.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController

public class ClientController {

    @Autowired
    private ClientRepository clientRepository;

    // Endpoint to retrieve all clients
    @GetMapping("/clients")
    public List<Client> getAllClients() {
        return clientRepository.findAll();
    }

    // Endpoint to retrieve a specific client by ID
    @GetMapping("(/client/{id}")
    public Client getClientById(@PathVariable Long id) {
        return clientRepository.findById(id).orElse(null);
    }

    // Endpoint to create a new client
    @PostMapping("/client")
    public Client createClient(@RequestBody Client client) {
        return clientRepository.save(client);
    }

    // Endpoint to update an existing client
    @PutMapping("(/client/{id}")
    public Client updateClient(@PathVariable Long id, @RequestBody Client updatedClient) {
        return clientRepository.findById(id).map(client -> {
            client.setEmail(updatedClient.getEmail());
            client.setPassword(updatedClient.getPassword());
            return clientRepository.save(client);
        }).orElse(null);
    }

    // Endpoint to delete a client by ID
    @DeleteMapping("/client/{id}")
    public void deleteClient(@PathVariable Long id) {
        clientRepository.deleteById(id);
    }
}
