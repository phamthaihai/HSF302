package com.example.repository;

import com.example.model.UserAccount;
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
    public List<UserAccount> findAll() {
        String sql = """
            SELECT u.user_id,
                   u.full_name,
                   u.email,
                   r.role_name,
                   u.status
            FROM users u
            JOIN roles r ON u.role_id = r.role_id
        """;

        return jdbc.query(sql, (rs, rowNum) -> {
            UserAccount u = new UserAccount();
            u.setUserId(rs.getInt("user_id"));
            u.setFullName(rs.getString("full_name"));
            u.setEmail(rs.getString("email"));
            u.setRoleName(rs.getString("role_name")); // 🔥 HIỂN THỊ ADMIN / TEACHER / STUDENT
            u.setStatus(rs.getInt("status") == 1);
            return u;
        });
    }
    public void insert(UserAccount user) {
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

    public UserAccount findById(int id) {
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
            UserAccount u = new UserAccount();
            u.setUserId(rs.getInt("user_id"));
            u.setFullName(rs.getString("full_name"));
            u.setEmail(rs.getString("email"));
            u.setRoleId(rs.getInt("role_id"));
            u.setRoleName(rs.getString("role_name"));
            u.setStatus(rs.getInt("status") == 1);
            return u;
        }, id);
    }
    public void update(UserAccount user) {
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


}
