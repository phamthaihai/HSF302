<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="My Courses"/>
<%@ include file="/WEB-INF/views/_layout/header.jsp" %>

<div class="d-flex align-items-center justify-content-between mb-3">
    <div>
        <h3 class="mb-0">My Courses</h3>
        <div class="text-muted">Courses you have registered successfully.</div>
    </div>
</div>

<c:choose>
    <c:when test="${empty courses}">
        <div class="empty-box">
            <h5 class="mb-1">No courses yet</h5>
            <div class="text-muted">You don’t have any paid courses.</div>
        </div>
    </c:when>

    <c:otherwise>
        <div class="row g-3">
            <c:forEach var="c" items="${courses}">
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start">
                                <h5 class="card-title mb-1"><c:out value="${c.title}"/></h5>
                                <span class="badge badge-soft">ACTIVE</span>
                            </div>

                            <!-- QUAN TRỌNG: description có thể không tồn tại -->
                            <p class="text-muted small mb-3" style="min-height: 42px;">
                                <c:out value="${c.description != null ? c.description : ''}"/>
                            </p>

                            <a class="btn btn-primary w-100"
                               href="${pageContext.request.contextPath}/student/player?courseId=${c.courseId}">
                                Open Player
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/views/_layout/footer.jsp" %>
