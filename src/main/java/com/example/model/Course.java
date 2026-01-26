package com.example.model;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "courses")
public class Course {
    @Id
    @Column(name = "course_id")
    private Integer courseId;

    @Column(name = "title")
    private String title;

    @Column(name = "description")
    private String description;

    @Column(name = "price")
    private BigDecimal price;

    @Column(name = "image_url")
    private String imageUrl;

    @Column(name="status")
    private String status;

    public Course(Integer courseId, String status, String imageUrl, BigDecimal price, String description, String title) {
        this.courseId = courseId;
        this.status = status;
        this.imageUrl = imageUrl;
        this.price = price;
        this.description = description;
        this.title = title;
    }

    public Course() {}

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}