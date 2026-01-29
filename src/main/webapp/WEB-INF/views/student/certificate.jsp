<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Certificate"/>
<%@ include file="/WEB-INF/views/_layout/header.jsp" %>

<!-- Load CSS riêng cho trang Certificate -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/certificate.css?v=1" />

<div class="d-flex justify-content-between align-items-center mb-3 no-print">
    <div>
        <h3 class="mb-1">Certificate</h3>
        <div class="text-muted">
            Course: <span class="fw-semibold"><c:out value="${course.title}"/></span>
        </div>
    </div>

    <a class="btn btn-outline-secondary btn-sm w-auto px-3 ms-auto"
       href="${pageContext.request.contextPath}/student/player?courseId=${course.courseId}">
        Back to the course
    </a>
</div>

<c:choose>
    <c:when test="${certificate == null}">
        <div class="alert alert-info">
            Not completed yet. Please complete all lessons to receive your certificate.
        </div>
    </c:when>

    <c:otherwise>
        <div class="certificate-sheet">
            <div class="certificate-watermark">STUDYHUB</div>

            <div class="certificate-top">
                <div class="certificate-brand">StudyHub</div>
                <div class="certificate-sub">Certificate of Completion</div>
            </div>

            <div class="certificate-body">
                <div class="certificate-text">This certifies that</div>
                <div class="certificate-name">
                    <c:out value="${studentName != null ? studentName : 'Student'}"/>
                </div>

                <div class="certificate-text mt-2">has successfully completed the course</div>
                <div class="certificate-course">
                    <c:out value="${course.title}"/>
                </div>

                <div class="certificate-meta">
                    <div>
                        <div class="meta-label">Certificate Code</div>
                        <div class="meta-value text-break">
                            <c:out value="${certificate.certificateCode}"/>
                        </div>
                    </div>
                    <div>
                        <div class="meta-label">Issued at</div>
                        <div class="meta-value">
                            <c:out value="${issuedAtText != null ? issuedAtText : certificate.issueDate}"/>
                        </div>
                    </div>
                </div>

                <div class="certificate-sign">
                    <div class="sign-box">
                        <div class="sign-line"></div>
                        <div class="sign-label">Instructor / Admin</div>
                    </div>

                    <div class="sign-box">
                        <div class="sign-line"></div>
                        <div class="sign-label">StudyHub</div>
                    </div>
                </div>
            </div>
        </div>

    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/views/_layout/footer.jsp" %>
