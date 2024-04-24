package com.example.LOGINREGISTERPROJECT.EmployeeController;


import com.example.LOGINREGISTERPROJECT.Dto.EmployeeDTO;
import com.example.LOGINREGISTERPROJECT.Dto.LoginDTO;
import com.example.LOGINREGISTERPROJECT.Service.EmployeeService;
import com.example.LOGINREGISTERPROJECT.response.LoginResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("api/v1/employee")
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;
    @PostMapping(path="/save")
    public String saveEmployee(@RequestBody EmployeeDTO employeeDTO) {
        String id= employeeService.addEmployee(employeeDTO);
        return id;
    }
    @PostMapping(path="/login")
    public ResponseEntity<?> loginEmlpoyee(@RequestBody LoginDTO loginDTO) {
        System.out.println(loginDTO);
        LoginResponse loginResponse= employeeService.loginEmlpoyee(loginDTO);
        return ResponseEntity.ok(loginResponse);

    }
}
