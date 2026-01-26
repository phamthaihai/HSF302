package com.example.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String root(HttpSession session) {
        if (session.getAttribute("currentUserName") == null) {
            return "redirect:/login";
        }
        return "redirect:/home";
    }

    @GetMapping("/home")
    public String home(HttpSession session, Model model) {
        Object name = session.getAttribute("currentUserName");
        if (name == null) return "redirect:/login";

        model.addAttribute("name", name);
        model.addAttribute("email", session.getAttribute("currentUserEmail"));
        model.addAttribute("role", session.getAttribute("currentUserRole"));
        return "home/home";
    }
}
