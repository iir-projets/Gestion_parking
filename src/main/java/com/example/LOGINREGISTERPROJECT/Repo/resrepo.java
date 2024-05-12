package com.example.LOGINREGISTERPROJECT.Repo;

import com.example.LOGINREGISTERPROJECT.Entity.plaace;
import com.example.LOGINREGISTERPROJECT.Entity.reservaation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface resrepo extends JpaRepository<reservaation,Long> {
}
