package com.example.LOGINREGISTERPROJECT.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="place")
@Getter
@Setter
@NoArgsConstructor
public class Place {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pl")
    private Long id_pl;
    @Column(name = "num_pl", nullable = false)
    private Integer num_pl;

    @Column(name = "statut_pl", nullable = false)
    private boolean statut_pl;

    @ManyToOne
    @JoinColumn(name = "id_pk")
    private Parking parking;

    public Parking getParking() {
        return parking;
    }

    public void setParking(Parking parking) {
        this.parking = parking;
    }

    public boolean isStatut_pl() {
        return statut_pl;
    }

    public void setStatut_pl(boolean statut_pl) {
        this.statut_pl = statut_pl;
    }

    public Integer getNum_pl() {
        return num_pl;
    }

    public void setNum_pl(Integer num_pl) {
        this.num_pl = num_pl;
    }

    public Long getId_pl() {
        return id_pl;
    }

    public void setId_pl(Long id_pl) {
        this.id_pl = id_pl;
    }
}
