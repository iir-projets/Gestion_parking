package com.example.LOGINREGISTERPROJECT.Repo;

import com.example.LOGINREGISTERPROJECT.Entity.plaace;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface plaacerepo extends JpaRepository <plaace,Long> {
}
