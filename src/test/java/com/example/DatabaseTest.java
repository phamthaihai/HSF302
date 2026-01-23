package com.example;

import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class DatabaseTest {

    @Test
    public void testConnection() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        dataSource.setUrl("jdbc:sqlserver://localhost:1433;databaseName=AssignmentHSF;encrypt=true;trustServerCertificate=true;");
        dataSource.setUsername("sa");
        dataSource.setPassword("12345");

        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        try {
            Integer result = jdbcTemplate.queryForObject("SELECT 1", Integer.class);
            System.out.println("Connect");
            assertNotNull(result);
        } catch (Exception e) {
            System.err.println("Disconnect");
            e.printStackTrace();
            throw e;
        }
    }
}