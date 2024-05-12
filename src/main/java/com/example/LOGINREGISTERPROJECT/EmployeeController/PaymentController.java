package com.example.LOGINREGISTERPROJECT.EmployeeController;

import com.example.LOGINREGISTERPROJECT.Entity.Reservation;
import com.example.LOGINREGISTERPROJECT.Repo.PaymentRequest;
import com.example.LOGINREGISTERPROJECT.Repo.ReservationRepository;
import com.example.LOGINREGISTERPROJECT.Service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private ReservationRepository reservationRepository;

    @PostMapping("/payment")
    public ResponseEntity<String> processPayment(@RequestBody PaymentRequest paymentRequest) {
        try {

            if (paymentRequest.getIdReservation() == null) {
                return ResponseEntity.badRequest().body("L'identifiant de la réservation ne peut pas être null.");
            }

            Reservation reservation = reservationRepository.findById(paymentRequest.getIdReservation())
                    .orElseThrow(() -> new RuntimeException("Réservation non trouvée"));

            double amount = reservation.getPrix_total();

            String confirmationMessage = paymentService.processPayment(amount);

            return ResponseEntity.ok(confirmationMessage);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Erreur lors du traitement du paiement: " + e.getMessage());
        }
    }

}
