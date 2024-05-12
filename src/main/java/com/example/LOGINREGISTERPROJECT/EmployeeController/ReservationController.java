package com.example.LOGINREGISTERPROJECT.EmployeeController;


import com.example.LOGINREGISTERPROJECT.Entity.Employee;
import com.example.LOGINREGISTERPROJECT.Entity.Place;
import com.example.LOGINREGISTERPROJECT.Entity.Reservation;
import com.example.LOGINREGISTERPROJECT.Repo.EmployeeRepo;
import com.example.LOGINREGISTERPROJECT.Repo.PlaceRepository;
import com.example.LOGINREGISTERPROJECT.Service.ReservationService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("reservation")
@AllArgsConstructor
public class ReservationController {
private final ReservationService reservationService;
@Autowired
    // Assurez-vous que ClientRepository est correctement injecté
private EmployeeRepo clientRepository;
    private final PlaceRepository PlaceRepo;

    @PostMapping("create/{idClient}/{idPlace}")
    public ResponseEntity<Reservation> create(@RequestBody Reservation reservation, @PathVariable Long idClient, @PathVariable Long idPlace) {
        // Vérifiez si le client avec l'ID spécifié existe
        Optional<Employee> optionalClient = clientRepository.findById(idClient);
        if (optionalClient.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }

        // Vérifiez si la place avec l'ID spécifié existe
        Optional<Place> optionalPlace = PlaceRepo.findById(idPlace);
        if (optionalPlace.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }

        // Récupérez les informations du client et de la place
        Employee client = optionalClient.get();
        Place place = optionalPlace.get();
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm");
        Date entree;
        Date sortie;
        try {
            entree = dateFormat.parse(reservation.getDate_entree());
            sortie = dateFormat.parse(reservation.getDate_sortie());
        } catch (ParseException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
        // Créez une nouvelle réservation
        Reservation newReservation = new Reservation();
        newReservation.setDate_entree(reservation.getDate_entree());
        newReservation.setDate_sortie(reservation.getDate_sortie());
        newReservation.setPrix_total(reservation.getPrix_total());
        // Liez la réservation au client et à la place récupérés
        newReservation.setClient(client);
        newReservation.setPlace(place);

        // Enregistrez la réservation
        Reservation savedReservation = reservationService.creer(newReservation);

        // Ajoutez les informations du client et de la place à la réponse
        savedReservation.getClient().setPrenom_client(client.getPrenom_client());
        savedReservation.getClient().setGmail_client(client.getGmail_client());
        savedReservation.getPlace().setNum_pl(place.getNum_pl());

        return ResponseEntity.status(HttpStatus.CREATED).body(savedReservation);
    }

    @GetMapping("/read")
    public List<Reservation> read() {
    return reservationService.lire();
}
@PutMapping ("/update/{id}")
    public Reservation update(@PathVariable Long id, @RequestBody Reservation reservation) {
    return reservationService.modifier(id,reservation);
}





@DeleteMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
    return reservationService.supprimer(id);
}
}
