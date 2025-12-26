<%-- 
    Document   : login
    Created on : Dec 25, 2025, 9:41:21 PM
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
                    <p>Sign in into your account</p>
                </div>

                <!-- Login Form -->
                <form class="card__form" action="${pageContext.request.contextPath}/login" method="POST">
                    <div>
                        <label for="stud_number">Student No.</label>
                        <input name="stud_number" type="text" placeholder="Enter your Student No.">
                    </div>
                    <div>
                        <label for="password">Password</label>
                        <input name="password" type="password" placeholder="············">
                    </div>
                    <div class="card__button__container">
                        <button class="card__button" type="submit">Sign In</button>
                    </div>
                </form>
                <!-- End Login Form-->

                <p class="card__footer">
                    New on our platform?
                    <a href="${pageContext.request.contextPath}/register">Create an account</a>
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
