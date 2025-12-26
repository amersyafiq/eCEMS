<%-- 
    Document   : index
    Created on : Dec 25, 2025, 9:56:32 PM
    Author     : ASUS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Home" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <body>
        <div class="container">

            <!-- Navigation bar -->
            <%@ include file="/WEB-INF/jspf/nav.jspf" %>
            <!-- End Navigation Bar -->

            <!-- Main -->
            <main class="main">
                <div class="main__container">
                    <h1>Home</h1>

                    <!-- Message Box -->
                    <div class="main__container__messagebox">
                        <h2>Welcome Back,</h2>
                        <p>${sessionScope.loggedUser.full_name}</p>
                        <img src="${pageContext.request.contextPath}/assets/image/home_logo.svg" alt="">
                    </div>
                    <!-- End Message Box -->

                    <!-- Recent Votes -->
                    <div class="main__container__recent">
                        <h3>Recent Votes</h3>

                        <!-- Table -->
                        <table class="main__container__table">
                            <thead>
                                <tr>
                                    <th>ELECTIONS</th>
                                    <th>VOTE</th>
                                    <th>DATE</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><div>Jawatankuasa Perwakilan Pelajar Fakulti Sains Komputer dan Matematik</div></td>
                                    <td><div>Ali bin Abu</div></td>
                                    <td><div>10, Jan 2020 20:07</div></td>
                                </tr>
                                <tr>
                                    <td><div>Jawatankuasa Perwakilan Kolej UiTM Shah Alam</div></td>
                                    <td><div>Ghana</div></td>
                                    <td><div>11, Jan 2020 10:16</div></td>
                                </tr>
                                <tr>
                                    <td><div>Jawatankuasa Perwakilan Pelajar Fakulti Sains Komputer dan Matematik</div></td>
                                    <td><div>Ali bin Abu</div></td>
                                    <td><div>10, Jan 2020 20:07</div></td>
                                </tr>
                                <tr>
                                    <td><div>Jawatankuasa Perwakilan Kolej UiTM Shah Alam</div></td>
                                    <td><div>Ghana</div></td>
                                    <td><div>11, Jan 2020 10:16</div></td>
                                </tr>
                                <tr>
                                    <td><div>Jawatankuasa Perwakilan Pelajar Fakulti Sains Komputer dan Matematik</div></td>
                                    <td><div>Ali bin Abu</div></td>
                                    <td><div>10, Jan 2020 20:07</div></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- End Table -->
                    </div>
                    <!-- End Recent Votes -->

                    <!-- Elections Button -->
                    <div class="main__container__button">
                        <div>
                            <h3>View Elections</h2>
                            <p>Vote in elections or register as candidate</p>
                        </div>
                        <button onclick="location.href='elections.html'">
                            Elections
                        </button>
                    </div>
                    <!-- End Elections Button -->

                </div>
                <div class="main__side">
                    <h3>Statistics</h3>
                </div>
            </main>
            <!-- End Main -->
        </div>
    </body>
</html>
