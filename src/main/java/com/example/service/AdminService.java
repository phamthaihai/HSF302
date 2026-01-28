package com.example.service;

import com.example.model.UserAccount;
import com.example.repository.UserAccountRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    private final UserAccountRepository repo;

    public AdminService(UserAccountRepository repo) {
        this.repo = repo;
    }

    public List<UserAccount> getAllUsers() {
        return repo.findAll();
    }

    public void addUser(UserAccount user) {

        String fullName = user.getFullName();
        String email = user.getEmail();
        String password = user.getPassword();

        // ===== rỗng =====
        if (fullName == null || fullName.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            throw new RuntimeException("Không được để trống dữ liệu");
        }

        // ===== tên không có số =====
        if (!fullName.matches("^[a-zA-ZÀ-Ỹà-ỹ\\s]+$")) {
            throw new RuntimeException("Full Name không được chứa số");
        }

        // ===== email đúng định dạng =====
        if (!email.matches("^[A-Za-z0-9+_.-]+@.+\\.com$")) {
            throw new RuntimeException("Email sai định dạng (@...com)");
        }

        // ===== password tối thiểu =====
        if (password.length() < 6) {
            throw new RuntimeException("Password phải từ 6 ký tự trở lên");
        }

        // ===== trùng email =====
        repo.findAll().forEach(u -> {
            if (u.getEmail().equalsIgnoreCase(email)) {
                throw new RuntimeException("Email đã tồn tại");
            }
        });

        repo.insert(user);
    }

    public UserAccount getUserById(int id) {
        return repo.findById(id);
    }

    public void updateUser(UserAccount user) {

        String fullName = user.getFullName();
        String email = user.getEmail();

        if (fullName == null || fullName.trim().isEmpty()
                || email == null || email.trim().isEmpty()) {
            throw new RuntimeException("Không được để trống dữ liệu");
        }

        if (!fullName.matches("^[a-zA-ZÀ-Ỹà-ỹ\\s]+$")) {
            throw new RuntimeException("Tên không được chứa số");
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@.+\\.com$")) {
            throw new RuntimeException("Email sai định dạng (@...com)");
        }

        // ===== trùng tên =====
        repo.findAll().forEach(u -> {
            if (u.getFullName().equalsIgnoreCase(fullName)
                    && u.getUserId() != user.getUserId()) {
                throw new RuntimeException("Tên đã tồn tại");
            }
        });

        // ===== trùng email =====
        repo.findAll().forEach(u -> {
            if (u.getEmail().equalsIgnoreCase(email)
                    && u.getUserId() != user.getUserId()) {
                throw new RuntimeException("Email đã tồn tại");
            }
        });

        repo.update(user);
    }

}

