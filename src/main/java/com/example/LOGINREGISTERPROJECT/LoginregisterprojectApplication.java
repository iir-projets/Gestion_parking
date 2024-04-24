package com.example.LOGINREGISTERPROJECT;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication (exclude = SecurityAutoConfiguration.class)

public class LoginregisterprojectApplication {

	public static void main(String[] args) {
		SpringApplication.run(LoginregisterprojectApplication.class, args);
	}

}
