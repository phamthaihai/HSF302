package com.example.controller;

import com.example.model.User;
import com.example.service.AdminService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
        model.addAttribute("user", new User());
        return "admin/user-add";
    }

    // ================= SAVE USER =================
    @PostMapping("/users/add")
    public String saveUser(@ModelAttribute User user, Model model) {

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
    public String updateUser(@ModelAttribute User user, Model model) {

        try {
            service.updateUser(user);
            return "redirect:/admin/users";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("user", user);
            return "admin/user-edit";
        }
    }

    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable("id") int id, RedirectAttributes ra) {
        try {
            service.deleteUser(id);
            ra.addFlashAttribute("success", "Xóa tài khoản thành công");
        } catch (RuntimeException e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/users";
    }

}

