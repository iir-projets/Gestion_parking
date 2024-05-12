package com.example.LOGINREGISTERPROJECT.Service;

import com.example.LOGINREGISTERPROJECT.Dto.EmployeeDTO;
import com.example.LOGINREGISTERPROJECT.Dto.LoginDTO;
import com.example.LOGINREGISTERPROJECT.response.LoginResponse;

public interface EmployeeService {

    String addEmployee(EmployeeDTO employeeDTO);

    LoginResponse loginEmlpoyee(LoginDTO loginDTO);

    LoginResponse loginResponse(LoginDTO loginDTO);
}
