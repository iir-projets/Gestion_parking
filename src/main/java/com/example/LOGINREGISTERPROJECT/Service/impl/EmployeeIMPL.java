package com.example.LOGINREGISTERPROJECT.Service.impl;

import com.example.LOGINREGISTERPROJECT.Dto.EmployeeDTO;
import com.example.LOGINREGISTERPROJECT.Dto.LoginDTO;
import com.example.LOGINREGISTERPROJECT.Entity.Employee;
import com.example.LOGINREGISTERPROJECT.Repo.EmployeeRepo;
import com.example.LOGINREGISTERPROJECT.Service.EmployeeService;
import com.example.LOGINREGISTERPROJECT.response.LoginResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class EmployeeIMPL  implements EmployeeService {

    @Autowired
private EmployeeRepo employeeRepo;
@Autowired
private PasswordEncoder passwordEncoder;

    @Override
    public String addEmployee(EmployeeDTO employeeDTO) {
        Employee employee = new Employee(
                employeeDTO.getGmail_client(),
                employeeDTO.getPrenom_client(),
                this.passwordEncoder.encode(employeeDTO.getMot_de_passe_client()));

        employeeRepo.save(employee);
        return employee.getGmail_client();
    }



    @Override
    public LoginResponse loginEmlpoyee(LoginDTO loginDTO){

        System.out.println(loginDTO);
        String msg = "";
        Employee foundEmployee = employeeRepo.findByEmail(loginDTO.getGmail_client());
        if (foundEmployee != null) {
            String password = loginDTO.getMot_de_passe_client();
            String encodedPassword = foundEmployee.getMot_de_passe_client();
            boolean isPasswordCorrect = passwordEncoder.matches(password, encodedPassword);
            if (isPasswordCorrect) {
                Optional<Employee> employee = employeeRepo.findOneByEmailAndPassword(loginDTO.getGmail_client(),encodedPassword);
                if (employee.isPresent()) {
                    return new LoginResponse("login success", true);
                } else {
                    return new LoginResponse("login failed", false);
                }
            } else {
                return new LoginResponse("password not match", false);
            }
        } else {
            return new LoginResponse("email not exists", false);
        }
    }

    @Override
    public LoginResponse loginResponse(LoginDTO loginDTO) {
        return null;
    }


}