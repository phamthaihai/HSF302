package com.example.repository;

import com.example.model.User;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserAccountRepository {

    private final JdbcTemplate jdbc;

    public UserAccountRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    // ===== GET ALL USERS (HIỂN THỊ ROLE NAME) =====
    public List<User> findAll() {
        String sql = """
        SELECT u.user_id,
               u.full_name,
               u.email,
               r.role_name,
               u.status
        FROM users u
        JOIN roles r ON u.role_id = r.role_id
        WHERE u.status = 1
    """;

        return jdbc.query(sql, (rs, rowNum) -> {
            User u = new User();
            u.setUserId(rs.getInt("user_id"));
            u.setFullName(rs.getString("full_name"));
            u.setEmail(rs.getString("email"));
            u.setRoleName(rs.getString("role_name"));
            u.setStatus(true);
            return u;
        });
    }

    public void insert(User user) {
        String sql = """
        INSERT INTO users(full_name, email, password, role_id, status)
        VALUES (?, ?, ?, ?, ?)
    """;

        jdbc.update(
                sql,
                user.getFullName(),
                user.getEmail(),
                user.getPassword(),
                user.getRoleId(),
                1
        );
    }

    public User findById(int id) {
        String sql = """
        SELECT u.user_id,
               u.full_name,
               u.email,
               u.role_id,
               r.role_name,
               u.status
        FROM users u
        JOIN roles r ON u.role_id = r.role_id
        WHERE u.user_id = ?
    """;

        return jdbc.queryForObject(sql, (rs, rowNum) -> {
            User u = new User();
            u.setUserId(rs.getInt("user_id"));
            u.setFullName(rs.getString("full_name"));
            u.setEmail(rs.getString("email"));
            u.setRoleId(rs.getInt("role_id"));
            u.setRoleName(rs.getString("role_name"));
            u.setStatus(rs.getInt("status") == 1);
            return u;
        }, id);
    }
    public void update(User user) {
        String sql = """
        UPDATE users
        SET full_name = ?,
            email = ?,
            role_id = ?
        WHERE user_id = ?
    """;

        jdbc.update(
                sql,
                user.getFullName(),
                user.getEmail(),
                user.getRoleId(),
                user.getUserId()
        );
    }

    public void softDelete(int userId) {
        String sql = "UPDATE users SET status = 0 WHERE user_id = ?";
        jdbc.update(sql, userId);
    }

}

