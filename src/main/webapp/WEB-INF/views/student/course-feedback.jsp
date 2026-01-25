<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Course Feedback"/>
<%@ include file="/WEB-INF/views/_layout/header.jsp" %>

<div class="mb-3">
    <h3 class="mb-1">Feedback: <span class="fw-semibold"><c:out value="${course.title}"/></span></h3>
    <div class="text-muted">Share your rating and comment.</div>
</div>

<div class="card">
    <div class="card-body">
        <form method="post" action="${pageContext.request.contextPath}/student/feedback">
            <input type="hidden" name="courseId" value="${course.courseId}"/>

            <div class="mb-3">
                <label class="form-label">Rating (1-5)</label>
                <input class="form-control" type="number" name="rating" min="1" max="5"
                       value="${feedback != null ? feedback.rating : 5}" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Comment</label>
                <textarea class="form-control" name="comment" rows="4"
                          required>${feedback != null ? feedback.comment : ''}</textarea>
            </div>

            <button class="btn btn-primary">Save Feedback</button>
            <a class="btn btn-outline-secondary ms-2"
               href="${pageContext.request.contextPath}/student/player?courseId=${course.courseId}">
                Back
            </a>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/views/_layout/footer.jsp" %>
