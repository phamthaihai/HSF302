package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RegisterController {

    @GetMapping("/register")
    public String showRegisterPage() {
        // maps tới: /WEB-INF/views/login/register.jsp
        return "login/register";
    }
}
