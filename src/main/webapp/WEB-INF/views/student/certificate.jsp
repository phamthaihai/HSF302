<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Certificate"/>
<%@ include file="/WEB-INF/views/_layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <h3 class="mb-1">Certificate</h3>
        <div class="text-muted">Course: <span class="fw-semibold"><c:out value="${course.title}"/></span></div>
    </div>
    <a class="btn btn-outline-secondary"
       href="${pageContext.request.contextPath}/student/player?courseId=${course.courseId}">
        Back to Player
    </a>
</div>

<c:choose>
    <c:when test="${certificate == null}">
        <div class="alert alert-info">
            Not completed yet. Please complete all lessons to receive your certificate.
        </div>
    </c:when>
    <c:otherwise>
        <div class="card">
            <div class="card-body">
                <div class="text-muted small">Certificate Code</div>
                <div class="display-6 fw-semibold"><c:out value="${certificate.certificateCode}"/></div>
                <div class="text-muted small mt-2">Issued at: <c:out value="${certificate.issueDate}"/></div>
                <button class="btn btn-primary mt-3" onclick="window.print()">Print</button>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/views/_layout/footer.jsp" %>
