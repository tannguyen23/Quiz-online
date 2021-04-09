<%-- 
    Document   : history
    Created on : Feb 16, 2021, 7:04:02 PM
    Author     : tanta
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>history page</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="assets/css/styles.css" rel="stylesheet" />
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="#page-top">Quiz online</a>
                <button class="navbar-toggler navbar-toggler-right text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="welcome.jsp">Home</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="viewListQuiz">Quiz</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="searchHistory">History</a></li>
                    </ul>
                </div>
            </div>
            <!-- User-Dropdown-btn -->
            <div class="dropdown d-flex justify-content-start mr-5">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    ${sessionScope.user.name}
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="logout">Log out</a>
                </div>
            </div>
        </nav>
        <!-- Masthead-->
        <div class="container-fluid" style="margin-top: 150px;margin-bottom: 100px;">
            <!-- search bar -->
            <nav class="navbar navbar-light bg-light mb-2">
                <form class="form-inline" action="searchHistory" >
                    <input class="form-control mr-sm-2" name="txtSearchContent" type="search" placeholder="Search By Subject" aria-label="Search" value="${requestScope.txtSearchContent}">
                    &emsp;&emsp;&emsp;
                    <label>Subject :</label>
                    &emsp;
                    <select class="custom-select" name="slSearchSubject" id="slSearchSubject">
                        <option value="all" selected>All</option>
                        <c:forEach items="${requestScope.listSubject}" var="subject">
                            <option value="${subject.id}">${subject.name}</option>
                        </c:forEach>
                    </select>
                    &emsp;&emsp;&emsp;
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                </form>
            </nav>
            <div class="d-flex justify-content-center ">

                <table class="table">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Subject</th>
                            <th scope="col">Time Submit</th>
                            <th scope="col">Point</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.listSubmission}" var="submission" varStatus="counter">
                            <tr>
                                <th scope="row">${counter.count + requestScope.sequenceNumber}</th>
                                <td>${submission.subjectName}</td>
                                <td>${submission.getTextTimeSubmit()}</td>
                                <td>${submission.point}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
            <c:if test="${requestScope.totalPage > 1}">
                <nav aria-label="...">
                    <ul class="pagination justify-content-center">
                        <c:forEach begin="1" end="${requestScope.totalPage}" var="index" >
                            <c:url value ="viewHistoryQuestion" var = "myPagingURL">
                                <c:param name="txtIndex" value="${index}"></c:param>
                            </c:url>
                            <c:if test="${requestScope.index eq pageScope.index}">
                                <li class="page-item active">
                                    <a class="page-link" href="${myPagingURL}">${pageScope.index}</a>
                                </li>
                            </c:if>
                            <c:if test="${requestScope.index ne pageScope.index}">
                                <li class="page-item">
                                    <a class="page-link" href="${myPagingURL}">${pageScope.index}</a>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>
        </div>



        <!-- Copyright Section-->
        <div class="copyright py-1 text-center text-white footer fixed-bottom">
            <div class="container"><small>Copyright © Your Website 2020</small></div>
        </div>
        <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
        <div class="scroll-to-top d-lg-none position-fixed">
            <a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up"></i></a>
        </div>


        <!-- Bootstrap core JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Third party plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
        <!-- Contact form JS-->
        <script src="assets/mail/jqBootstrapValidation.js"></script>
        <script src="assets/mail/contact_me.js"></script>
        <!-- Core theme JS-->
        <script src="assets/js/scripts.js"></script>
    </body>
</html>

