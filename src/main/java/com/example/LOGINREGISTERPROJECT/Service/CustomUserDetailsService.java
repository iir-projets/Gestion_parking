package com.example.LOGINREGISTERPROJECT.Service;


import com.example.LOGINREGISTERPROJECT.Entity.Employee;
import com.example.LOGINREGISTERPROJECT.Repo.UserRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    public CustomUserDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Employee user = userRepository.findUserByEmail(email);
        List<String> roles = new ArrayList<>();
        roles.add("USER");
        UserDetails userDetails =
                org.springframework.security.core.userdetails.User.builder()
                        .username(user.getGmail_client())
                        .password(user.getMot_de_passe_client())
                        .roles(roles.toArray(new String[0]))
                        .build();
        return userDetails;
    }
}
