<%-- 
    Document   : create
    Created on : Feb 16, 2021, 11:33:09 AM
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
        <title>create page</title>
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
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="welcomeAdmin.jsp">Home</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="searchQuestion">Question</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="viewCreateQuestion">Create Question</a></li>
                    </ul>
                </div>
            </div>
            <!-- User-Dropdown-btn -->
            <div class="dropdown d-flex justify-content-end">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    ${sessionScope.user.name}
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="logout">Log out</a>
                </div>
            </div>
        </nav>
        <div class="container-fluid " style="margin-top: 110px;">
            <div class="d-flex justify-content-center ">
                <div class="card  w-50 mb-5">
                    <form action="createQuestion" method="GET">
                        <div class="card-body">
                            <div class="form-group">
                                <label >Content</label>
                                <textarea  type="text" name="txtContent"class="form-control" required="" rows="5" maxlength="500">${question.getContent()}</textarea>
                            </div>

                            <div class="form-group">
                                <label >Answer</label>
                                <div class="form-check">
                                    <c:forEach items="${requestScope.listAnswer}" var="answerCharacter">
                                    <div class="row g-3 my-1">
                                        <div class="col-auto">
                                            <input class="form-check-input " type="radio" name="rdoAnswer" checked="" value="${answerCharacter}">
                                            <label class=""> ${answerCharacter}</label>
                                        </div>
                                        <div class="col-10">
                                            <input type="text" name="txtAnswer${answerCharacter}" class="form-control p-1" required="" maxlength="500"/>                           
                                        </div>
                                    </div>
                                    </c:forEach>
                                </div>
                            </div>


                            <div class="form-group">
                                <label for="SubjectSelect">Subject</label>
                                <select multiple name="slSubject" class="form-control" id="SubjectSelect" required="" >
                                    <c:forEach items="${requestScope.listSubject}" var="subject">
                                        <option  value="${subject.id}">${subject.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="StatusSelect">Status</label>
                                <select name="slStatus" class="form-control" id="SubjectSelect">
                                    <option selected="" class="p-2" value="${true}">True</option>
                                    <option class="p-2" value="${false}">False</option>
                                </select>
                            </div>
                        </div>
                        <div class="card-footer text-center">
                            <button type="submit" class="btn btn-primary btn-sm btn-block">Create</button>
                        </div>
                </div>

                </form>
            </div>
        </div>

    </div>



    <!-- Copyright Section-->
    <div class="copyright py-2 text-center text-white footer fixed-bottom">
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


