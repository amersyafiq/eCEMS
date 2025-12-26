<%-- 
    Document   : register
    Created on : Dec 25, 2025, 9:49:40 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <body>
        <main>
            <!-- Login/Sign Up -->
            <div class="card">
                <img class="card__logo" src="${pageContext.request.contextPath}/assets/image/uitm_logo.png" alt="UiTM Logo">
                <div class="card__title">
                    <h1>Welcome to UiTM eCEMS 👋🏻</h1>
                    <p>Sign up account for new user</p>
                </div>

                <!-- Login Form -->
                <form class="card__form" action="${pageContext.request.contextPath}/register" method="POST">
                    <div>
                        <sql:query var="campusList" dataSource="${myDatasource}">
                            SELECT * FROM CAMPUS
                        </sql:query>
                        <label for="campus_id">Campus</label>
                        <select 
                            name="campus_id" 
                            onChange="javascript:location.href='${pageContext.request.contextPath}/register?campus=' + this.value"
                        >
                            <option value="-1" <c:if test="${param.campus == '-1' || param.campus == null}">selected</c:if>>Select Campus</option>
                            <c:forEach var="campus" items="${campusList.rows}">
                                <option value="${campus.campus_id}" <c:if test="${param.campus == campus.campus_id}">selected</c:if>>${campus.campus_name}</option> 
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <sql:query var="facultyList" dataSource="${myDatasource}">
                            SELECT * FROM FACULTY WHERE CAMPUS_ID = ?::integer
                            <sql:param value="${param.campus}"/>
                        </sql:query>
                        <label for="faculty_id">Faculty</label>
                        <select 
                            name="faculty_id" 
                            <c:if test="${empty param.campus}">disabled</c:if>
                        >
                            <option value="-1" <c:if test="${param.campus == '-1' || param.campus == null}">selected</c:if>>Select Faculty</option>
                            <c:forEach var="faculty" items="${facultyList.rows}">
                                <option value="${faculty.faculty_id}">${faculty.faculty_name}</option> 
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label for="email">Email</label>
                        <input name="email" type="text" placeholder="Enter your email">
                    </div>
                    <div>
                        <label for="full_name">Full Name</label>
                        <input name="full_name" type="text" placeholder="Enter your name">
                    </div>
                    <div>
                        <label for="stud_number">Student Number</label>
                        <input name="stud_number" type="text" placeholder="Enter your Student Number">
                    </div>
                    <div>
                        <label for="password">Password</label>
                        <input name="password" type="password" placeholder="············">
                    </div>
                    <div class="card__button__container">
                        <button class="card__button" onclick="location.href='login.html'">Sign Up</button>
                    </div>
                </form>
                <!-- End Login Form-->

                <p class="card__footer">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/login">Sign in instead</a>
                </p>
            </div>
            <!-- End Login/Sign Up -->

            <!-- Banner -->
            <div class="banner">
                <img src="${pageContext.request.contextPath}/assets/image/banner.png" alt="Banner">
            </div>
            <!-- End Banner -->

            <%-- Error Display Start --%>
            <c:if test="${not empty errors}">
                <div class="error">
                    <c:forEach var="err" items="${errors}">
                        <div class="error__item">
                            <p>${err}</p>
                            <svg style="cursor: pointer;" width="20" height="20" viewBox="0 0 800 800" fill="none" xmlns="http://www.w3.org/2000/svg" onclick="this.closest('.error__item').remove()">
                                <path d="M112 682.24L688 106.24" stroke="currentColor" stroke-width="48" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M112 106.24L688 682.24" stroke="currentColor" stroke-width="48" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <%-- Error Display END --%>
        </main>
    </body>
</html>
