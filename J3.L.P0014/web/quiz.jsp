<%-- 
    Document   : quiz
    Created on : Feb 10, 2021, 5:53:29 PM
    Author     : tanta
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>quiz page</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" crossorigin="anonymous"></script>
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="assets/css/styles.css" rel="stylesheet" />
        <link href="assets/css/countdown-timer.css" rel="stylesheet" />
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <input type="hidden" id="timeLimit" value="${sessionScope.timeLimit}">
        <input type="hidden" id="timePass" value="${sessionScope.timePass}">
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

        <div class="container-fluid " >
            <div class="d-flex justify-content-center px-5 " style="margin:0;padding:0;">
                <form id="submitForm" action="joinQuiz" method="POST" style="width: 100%;">
                    <div class="d-flex justify-content-center p-1">
                        <div id="app"></div>
                    </div>
                    <input type="hidden" name="numQuestion" value="${requestScope.listQuestion.size()}"/>
                    <input type="hidden" name="questionPos" value="${requestScope.questionPos}" >
                    <div class="card mb-2 " >
                        <h5 class="card-header">Question ${requestScope.questionPos + 1}</h5>
                        <div class="card-body">
                            <h5 class="card-title">${requestScope.questionQuiz.getHtmlContent()}</h5>
                            <c:forEach items="${requestScope.questionQuiz.listAnswer}" var="answer">
                                <p class="card-text">${answer.getCharAnswer()}. ${answer.getHtmlContent()}</p>
                            </c:forEach>
                            <select id="PRJ321-1" name="slAnswer" class="btn btn-info">
                                <option disabled selected value="null" class="btn btn-info " ></option>
                                <c:forEach items="${requestScope.questionQuiz.listAnswer}" var="answer">
                                    <c:if test="${answer.getCharAnswer() eq requestScope.questionQuiz.answerCorrect}">
                                        <option selected="" class="btn btn-info " value="${answer.getCharAnswer()}">${answer.getCharAnswer()}</option>
                                    </c:if>
                                    <c:if test="${answer.getCharAnswer() ne requestScope.questionQuiz.answerCorrect}">
                                        <option  class="btn btn-info " value="${answer.getCharAnswer()}">${answer.getCharAnswer()}</option>
                                    </c:if>
                                </c:forEach>
                            </select> 
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm d-flex justify-content-start p-1">
                                <c:if test="${requestScope.questionPos ne 0}">
                                    <button type="submit" class="btn btn-primary " name="action" value="previous">Previous</button>
                                </c:if>
                                <c:if test="${requestScope.questionPos eq 0}">
                                    <button type="submit" class="btn btn-primary" disabled="" name="action" value="previous">Previous</button>
                                </c:if>
                            </div>
                            <div class="col-sm d-flex justify-content-end p-1">
                                <c:if test="${(requestScope.questionPos + 1) ne sessionScope.listQuestion.size()}">
                                    <button type="submit" class="btn btn-primary" name="action" value="next">Next</button>
                                </c:if>
                                <c:if test="${(requestScope.questionPos + 1) eq sessionScope.listQuestion.size()}">
                                    <button type="submit" class="btn btn-primary" disabled="" name="action" value="next">Next</button>
                                </c:if>

                            </div>

                        </div>
                    </div>
                    <div class="d-flex justify-content-center m-3">
                        <input class="btn btn-dark btn-lg" id="submitBtn" type="submit" name="action" value="submit" >
                    </div>
                </form>
            </div>
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
        <script src="assets/js/countdown-timer.js"></script>
        <!-- Bootstrap core JavaScript -->
        <script src="assets/vendor/jquery/jquery.min.js"></script>

        <!-- Menu Toggle Script -->
        <script>
                            $("#menu-toggle").click(function (e) {
                                e.preventDefault();
                                $("#wrapper").toggleClass("toggled");
                                $("#content-quiz").toggleClass("tmp");
                            });
        </script>
    </body>
</html>

