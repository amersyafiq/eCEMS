<%-- 
    Document   : index
    Created on : Dec 25, 2025, 9:56:32 PM
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Home" />
    
    <body style="background-color: #121026">
        <div class="d-flex vh-100 overflow-hidden">

            <div class="h-100">
                <%@ include file="/WEB-INF/jspf/nav_staff.jspf" %>
            </div>

            <main class="d-flex flex-grow-1 overflow-hidden">
                
                <div class="flex-grow-1 rounded-start-5 p-4 p-xl-5 overflow-auto no-scrollbar d-flex flex-column gap-4" style="background-color: #F3F9FE;">
                    <h1 class="h4 fw-bold mb-0">Home</h1>

                    <div class="rounded-4 px-5 py-4 text-white position-relative shadow-sm" style="background: linear-gradient(90deg, #121026 0%, #7065E9 100%);">
                        <div class="position-relative" style="z-index: 2;">
                            <h2 class="display-6 fw-bold mb-0">Welcome Back,</h2>
                            <p class="fs-4 text-white fw-lighter mb-0">${sessionScope.loggedUser.full_name}</p>
                        </div>
                        <img src="${pageContext.request.contextPath}/assets/image/home_logo.svg" alt="Home Logo" class="position-absolute d-none d-md-block" style="width: 14rem; right: 5%; top: -20px;">
                    </div>

                    <div class="row g-3">
                        <!-- Upcoming Elections -->
                        <div class="col-12 col-md-4">
                            <div class="card border-0 shadow-sm h-100" style="background: linear-gradient(135deg, #1e1b4b 0%, #2d2a5a 100%); border-radius: 1rem;">
                                <div class="card-body px-3 py-2">
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="me-auto">
                                            <h3 class="h6 text-white fw-semibold mb-0">Students</h3>
                                            <p class="small text-white opacity-75 mb-0">registered</p>
                                        </div>
                                        <sql:query dataSource="${myDatasource}" var="statStud">
                                            SELECT COUNT(*) AS COUNT FROM STUDENTS WHERE (CAMPUS_ID IS NULL OR CAMPUS_ID = ?)
                                            <sql:param value="${loggedUser.campus_id}" />
                                        </sql:query>
                                        <c:set var="stud" value="${statStud.rows[0]}" />
                                        <div class="display-4 fw-bold text-white">${stud.count != null ? stud.count : 0}</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Active Elections -->
                        <div class="col-12 col-md-4">
                            <div class="card border-0 shadow-sm h-100" style="background: linear-gradient(135deg, #4c3d99 0%, #5b4fc9 100%); border-radius: 1rem;">
                                <div class="card-body px-3 py-2">
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="me-auto">
                                            <h3 class="h6 text-white fw-semibold mb-0">Staff</h3>
                                            <p class="small text-white opacity-75 mb-0">registered</p>
                                        </div>
                                        <sql:query dataSource="${myDatasource}" var="statStaff">
                                            SELECT COUNT(*) AS COUNT FROM STAFFS WHERE (CAMPUS_ID IS NULL OR CAMPUS_ID = ?)
                                            <sql:param value="${loggedUser.campus_id}" />
                                        </sql:query>
                                        <c:set var="staff" value="${statStaff.rows[0]}" />
                                        <div class="display-4 fw-bold text-white">${staff.count != null ? staff.count : 0}</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Closed Elections -->
                        <div class="col-12 col-md-4">
                            <div class="card border-0 shadow-sm h-100" style="background-color: #d4d4f7; border-radius: 1rem;">
                                <div class="card-body px-3 py-3">
                                    <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                        <div class="me-auto">
                                            <h3 class="h6 fw-semibold mb-0" style="color: #1e1b4b;">Elections</h3>
                                            <p class="small mb-0" style="color: #5b4fc9;">created</p>
                                        </div>
                                        <sql:query dataSource="${myDatasource}" var="statElect">
                                            SELECT COUNT(*) AS COUNT FROM ELECTIONS WHERE (CAMPUS_ID IS NULL OR CAMPUS_ID = ?)
                                            <sql:param value="${loggedUser.campus_id}" />
                                        </sql:query>
                                        <c:set var="election" value="${statElect.rows[0]}" />
                                        <div class="display-4 fw-bold" style="color: #1e1b4b;">${election.count != null ? election.count : 0}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mt-2">
                        <h3 class="h6 fw-bold text-dark text-uppercase mb-3">Active Elections</h3>

                        <sql:query dataSource="${myDatasource}" var="activeElections">
                            SELECT e.ELECTION_ID, e.TITLE, e.END_DATE, COUNT(c.CANDIDATE_ID) as CANDIDATE_COUNT
                            FROM ELECTIONS e
                            LEFT JOIN CANDIDATES c ON e.ELECTION_ID = c.ELECTION_ID AND c.STATUS = 'approved'
                            WHERE e.CAMPUS_ID = ? AND e.STATUS = 'active'
                            GROUP BY e.ELECTION_ID, e.TITLE, e.END_DATE
                            ORDER BY e.END_DATE ASC
                            <sql:param value="${loggedUser.campus_id}" />
                        </sql:query>

                        <c:choose>
                            <c:when test="${empty activeElections.rows}">
                                <div class="table-responsive mx-3">
                                    <p class="text-muted text-center py-4">No active elections at this time.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive mx-3">
                                    <table class="table table-borderless table-striped table-rounded mb-0" style="border-collapse: separate; border-spacing: 0 5px;">                                
                                        <thead class="text-secondary small fw-bold">
                                            <tr>
                                                <th class="ps-4" style="width: 50%;">ELECTIONS</th>
                                                <th class="">NO. OF CANDIDATES</th>
                                                <th class="">ENDING DATE</th>
                                                <th class="pe-4">ACTION</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="elec" items="${activeElections.rows}">
                                                <tr>
                                                    <td class="py-2 ps-4 text-secondary fw-normal rounded-start-5">${elec.title}</td>
                                                    <td class="py-2 text-secondary">${elec.candidate_count}</td>
                                                    <td class="py-2 text-secondary"><fmt:formatDate value="${elec.end_date}" pattern="dd, MMM yyyy HH:mm"/></td>
                                                    <td class="py-2 text-end pe-4 text-secondary rounded-end-5">
                                                        <a href="${pageContext.request.contextPath}/elections/page/${elec.election_id}" class="btn btn-sm btn-outline-primary rounded-pill px-3">
                                                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                <circle cx="9.99992" cy="10.0002" r="1.66667" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                                <path d="M18.3334 9.99984C16.1109 13.889 13.3334 15.8332 10.0001 15.8332C6.66675 15.8332 3.88925 13.889 1.66675 9.99984C3.88925 6.11067 6.66675 4.1665 10.0001 4.1665C13.3334 4.1665 16.1109 6.11067 18.3334 9.99984" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                            </svg>
                                                            View
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="h-100 bg-primary-subtle rounded-4 p-4 px-5 d-flex align-items-center justify-content-between mt-auto">
                                <div>
                                    <h3 class="h5 fw-bold text-dark mb-2">View Elections</h3>
                                    <p class="small text-dark opacity-75 mb-0 lh-1">Vote in elections or register as candidate</p>
                                </div>
                                <button class="card-anim btn btn-outline-primary bg-white text-primary rounded-pill px-4 shadow-sm d-flex justify-content-between align-items-center gap-2" 
                                        onclick="location.href='${pageContext.request.contextPath}/elections'">
                                    Elections
                                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M4.16675 9.99992H15.8334" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M10.8333 15L15.8333 10" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M10.8333 5L15.8333 10" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="h-100 bg-primary-subtle rounded-4 p-4 px-5 d-flex align-items-center justify-content-between mt-auto">
                                <div>
                                    <h3 class="h5 fw-bold text-dark mb-2">Create Elections</h3>
                                    <p class="small text-dark opacity-75 mb-0 lh-1">Create a new campus-wide or faculty-specific election</p>
                                </div>
                                <button class="card-anim btn btn-outline-primary bg-white text-primary rounded-pill px-4 shadow-sm d-flex justify-content-between align-items-center gap-2" 
                                        onclick="location.href='${pageContext.request.contextPath}/elections/create'">
                                    Create
                                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M4.16675 9.99992H15.8334" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M10.8333 15L15.8333 10" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M10.8333 5L15.8333 10" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="d-none d-xl-block bg-white p-4 p-xl-5 overflow-auto no-scrollbar" style="width: 300px; min-width: 28%;">
                    <h3 class="h6 fw-bold text-dark text-uppercase">Statistics</h3>
                    <div class="col-12">
                        <div class="card border-0 shadow-sm h-100" style="background: linear-gradient(135deg, #1e1b4b 0%, #2d2a5a 100%); border-radius: 1rem;">
                            <sql:query dataSource="${myDatasource}" var="createdByUser">
                                SELECT COUNT(*) AS COUNT FROM ELECTIONS 
                                WHERE CAMPUS_ID = ? AND CREATED_BY = ?
                                <sql:param value="${loggedUser.campus_id}" />
                                <sql:param value="${loggedUser.staff_id}" />
                            </sql:query>
                            <c:set var="createdCount" value="${createdByUser.rows[0].count}" />
                            <div class="card-body px-3 py-2">
                                <div class="d-flex align-items-center justify-content-center gap-3 h-100 px-4">
                                    <div class="me-auto">
                                        <h3 class="h6 text-white fw-semibold mb-0">Elections</h3>
                                        <p class="small text-white opacity-75 mb-0">Created by you</p>
                                    </div>
                                    <div class="display-4 fw-bold text-white">${createdCount != null ? createdCount : 0}</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <h3 class="h6 fw-bold text-dark text-uppercase mb-2 mt-4">Your Elections</h3>

                    <sql:query dataSource="${myDatasource}" var="userElections">
                        SELECT e.ELECTION_ID, e.TITLE, e.STATUS, e.CREATED_AT
                        FROM ELECTIONS e
                        WHERE e.CAMPUS_ID = ? AND e.CREATED_BY = ?
                        ORDER BY e.CREATED_AT DESC
                        LIMIT 5
                        <sql:param value="${loggedUser.campus_id}" />
                        <sql:param value="${loggedUser.staff_id}" />
                    </sql:query>

                    <c:choose>
                        <c:when test="${empty userElections.rows}">
                            <div class="alert alert-info alert-sm rounded-3 py-2 px-3 small">
                                <p class="mb-0">No elections created yet.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="d-flex flex-column gap-2">
                                <c:forEach var="elec" items="${userElections.rows}">
                                    <div class="card border-1 border-primary bg-primary-subtle shadow-sm rounded-3 p-3" style="cursor: pointer; transition: all 0.3s ease;" 
                                         onclick="location.href='${pageContext.request.contextPath}/elections/page/${elec.election_id}'"
                                         onmouseover="this.style.boxShadow='0 0.5rem 1rem rgba(0,0,0,0.15)'" 
                                         onmouseout="this.style.boxShadow='0 0.125rem 0.25rem rgba(0,0,0,0.075)'">
                                        <div class="d-flex align-items-start justify-content-between">
                                            <div style="flex: 1;">
                                                <h6 class="fw-semibold text-dark mb-1 small lh-sm text-truncate-2" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                                    ${elec.title}
                                                </h6>
                                                <p class="text-muted mb-0 small">
                                                    <c:choose>
                                                        <c:when test="${elec.status == 'upcoming'}">
                                                            <span class="badge rounded-2 px-2 py-1" style="background-color: #4c3d99; color: white; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                                                Upcoming
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${elec.status == 'active'}">
                                                            <span class="badge rounded-2 px-2 py-1" style="background-color: #7367F0; color: white; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                                                Active
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${elec.status == 'closed'}">
                                                            <span class="badge rounded-2 px-2 py-1" style="background-color: #d4d4f7; color: #5b4fc9; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                                                Closed
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge rounded-2 px-2 py-1" style="background-color: #9CA3AF; color: white; font-size: 0.75rem; font-weight: 600; width: fit-content; ">
                                                                ${elec.status}
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>  
                                                    <span class="text-muted ms-2">
                                                        <c:set var="now" value="<%= new java.util.Date() %>" />
                                                        <c:set var="diffTime" value="${now.time - elec.created_at.time}" />
                                                        <c:set var="diffDays" value="${diffTime / (1000 * 60 * 60 * 24)}" />
                                                        <c:choose>
                                                            <c:when test="${diffDays < 1}">Created today</c:when>
                                                            <c:when test="${diffDays < 2}">Created 1 day ago</c:when>
                                                            <c:when test="${diffDays < 7}">Created <fmt:formatNumber value="${diffDays}" maxFractionDigits="0"/> days ago</c:when>
                                                            <c:otherwise><fmt:formatDate value="${elec.created_at}" pattern="MMM dd, yyyy"/></c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/elections" class="small text-decoration-none text-primary fw-semibold">View More</a>
                    </div>
                </div>

            </main>
        </div>

        <%-- Javascripts  --%>
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
