package com.example.controller;

import com.example.model.UserAccount;
import com.example.service.AdminService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService service;

    public AdminController(AdminService service) {
        this.service = service;
    }

    // ================= DASHBOARD =================
    @GetMapping("/dashboard")
    public String dashboard() {
        return "admin/dashboard";
    }

    // ================= USER LIST =================
    @GetMapping("/users")
    public String users(Model model) {
        model.addAttribute("users", service.getAllUsers());
        return "admin/user-list";
    }

    // ================= ADD USER FORM =================
    @GetMapping("/users/add")
    public String addUserForm(Model model) {
        model.addAttribute("user", new UserAccount());
        return "admin/user-add";
    }

    // ================= SAVE USER =================
    @PostMapping("/users/add")
    public String saveUser(@ModelAttribute UserAccount user, Model model) {

        try {
            service.addUser(user);
            return "redirect:/admin/users";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("user", user);
            return "admin/user-add";
        }
    }

    // ===== SHOW EDIT FORM =====
    @GetMapping("/users/edit/{id}")
    public String editUser(@PathVariable("id") int id, Model model) {
        model.addAttribute("user", service.getUserById(id));
        return "admin/user-edit";
    }


    // ===== SAVE UPDATE =====
    @PostMapping("/users/edit")
    public String updateUser(@ModelAttribute UserAccount user, Model model) {

        try {
            service.updateUser(user);
            return "redirect:/admin/users";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("user", user);
            return "admin/user-edit";
        }
    }

}

