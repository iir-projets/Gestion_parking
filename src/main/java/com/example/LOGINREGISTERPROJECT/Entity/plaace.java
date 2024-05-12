package com.example.LOGINREGISTERPROJECT.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="plaace")
@Getter
@Setter
@NoArgsConstructor
public class plaace {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pl")
    private Long id_pl;
    @Column(name = "num_pl", nullable = false)
    private Integer num_pl;

    @Column(name = "statut_pl", nullable = false)
    private boolean statut_pl;
    @Column(name = "id_pk", nullable = false)
    private Long id_pk;
}
