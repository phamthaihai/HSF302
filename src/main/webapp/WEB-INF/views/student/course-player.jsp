<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="Course Player"/>
<%@ include file="/WEB-INF/views/_layout/header.jsp" %>

<div class="mb-3">
    <h3 class="mb-1">
        Course Player: <span class="fw-semibold"><c:out value="${course.title}"/></span>
    </h3>
    <div class="text-muted">Select a lesson on the left. Mark it completed when done.</div>
</div>

<div class="row g-3">
    <!-- Sidebar lessons -->
    <div class="col-12 col-lg-4">
        <div class="card sidebar">
            <div class="card-body">
                <div class="fw-semibold mb-2">Lessons</div>

                <c:choose>
                    <c:when test="${empty lessons}">
                        <div class="empty-box">
                            <div class="fw-semibold">No lesson found</div>
                            <div class="text-muted small">Add lessons in DB for this course to see content here.</div>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="list-group">
                            <c:forEach var="l" items="${lessons}">
                                <a class="list-group-item list-group-item-action d-flex justify-content-between align-items-center
                  ${currentLesson != null && currentLesson.lessonId == l.lessonId ? 'active' : ''}"
                                   href="${pageContext.request.contextPath}/student/player?courseId=${course.courseId}&lessonId=${l.lessonId}">

                  <span class="text-truncate" style="max-width: 220px;">
                    <c:out value="${l.title}"/>
                  </span>

                                    <c:set var="done" value="false"/>
                                    <c:forEach var="cid" items="${completedLessonIds}">
                                        <c:if test="${cid == l.lessonId}">
                                            <c:set var="done" value="true"/>
                                        </c:if>
                                    </c:forEach>

                                    <span class="badge ${done ? 'text-bg-success' : 'text-bg-secondary'}">
                                            ${done ? 'Done' : 'Todo'}
                                    </span>
                                </a>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>

                <%-- Progress + Certificate (LUÔN HIỆN) --%>
                <c:set var="totalLessons" value="${empty lessons ? 0 : fn:length(lessons)}"/>
                <c:set var="doneLessons" value="${empty completedLessonIds ? 0 : fn:length(completedLessonIds)}"/>
                <c:set var="pct" value="${totalLessons == 0 ? 0 : (doneLessons * 100 / totalLessons)}"/>

                <div class="mt-3">
                    <div class="d-flex justify-content-between small text-muted mb-1">
                        <span>Progress</span>
                        <span>${doneLessons}/${totalLessons}</span>
                    </div>

                    <div class="progress" role="progressbar" aria-valuenow="${pct}" aria-valuemin="0"
                         aria-valuemax="100">
                        <div class="progress-bar" style="width:${pct}%"></div>
                    </div>

                    <c:choose>
                        <c:when test="${totalLessons == 0}">
                            <div class="alert alert-warning small mt-3 mb-2">
                                Khóa học chưa có bài học nên chưa thể cấp chứng chỉ.
                            </div>
                        </c:when>
                        <c:when test="${doneLessons < totalLessons}">
                            <div class="alert alert-info small mt-3 mb-2">
                                Chưa hoàn thành khóa học. Hoàn thành hết bài để nhận chứng chỉ.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-success small mt-3 mb-2">
                                Bạn đã hoàn thành! Có thể xem/nhận chứng chỉ.
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <a class="btn btn-outline-dark w-100"
                       href="${pageContext.request.contextPath}/student/certificate?courseId=${course.courseId}">
                        View Certificate
                    </a>
                </div>

                <a class="btn btn-outline-secondary w-100 mt-3"
                   href="${pageContext.request.contextPath}/student/my-courses">
                    Back to My Courses
                </a>
            </div>
        </div>
    </div>

    <!-- Content -->
    <div class="col-12 col-lg-8">
        <div class="card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${currentLesson == null}">
                        <div class="empty-box">
                            <h5 class="mb-1">Pick a lesson</h5>
                            <div class="text-muted">Choose a lesson from the left to start.</div>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <h4 class="mb-2"><c:out value="${currentLesson.title}"/></h4>
                        <div class="text-muted small mb-3">Lesson ID: ${currentLesson.lessonId}</div>

                        <div class="p-3 bg-white rounded-4 border">
                            <c:out value="${currentLesson.content}"/>
                        </div>

                        <form class="mt-3" method="post"
                              action="${pageContext.request.contextPath}/student/complete-lesson">
                            <input type="hidden" name="courseId" value="${course.courseId}"/>
                            <input type="hidden" name="lessonId" value="${currentLesson.lessonId}"/>
                            <button class="btn btn-success">Mark as Completed</button>

                            <a class="btn btn-outline-primary ms-2"
                               href="${pageContext.request.contextPath}/student/feedback?courseId=${course.courseId}">
                                Feedback
                            </a>

                            <a class="btn btn-outline-dark ms-2"
                               href="${pageContext.request.contextPath}/student/certificate?courseId=${course.courseId}">
                                Certificate
                            </a>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/_layout/footer.jsp" %>
