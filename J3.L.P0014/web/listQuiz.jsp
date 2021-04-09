<%-- 
    Document   : selectQuiz.jsp
    Created on : Feb 9, 2021, 4:36:38 PM
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
        <title>select quiz page</title>
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

        <!-- Portfolio Section-->
        <section class="page-section portfolio" id="portfolio">
            <div class="container">
                <!-- Portfolio Section Heading-->
                <h2 class="page-section-heading text-center text-uppercase text-secondary mt-3">Select Quiz</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <!-- Subject Grid Items-->
                <div class="row justify-content-center">
                    <c:forEach items="${requestScope.listSubject}" var="subject">
                        <div class="col-md-6 col-lg-4 mb-5">
                            <p>${subject.name}</p>
                            <div class="portfolio-item mx-auto" data-toggle="modal" data-target="#${subject.id}">
                                <div class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
                                    <div class="portfolio-item-caption-content text-center text-white">
                                        <p>${subject.name}</p>
                                        <i class="fas fa-forward fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="assets/img/portfolio/quiz.png" alt="" />
                            </div>
                        </div>

                        <!-- Subject Modal -->
                        <div class="portfolio-modal modal fade" id="${subject.id}" tabindex="-1" role="dialog" aria-labelledby="portfolioModal1Label" aria-hidden="true">
                            <div class="modal-dialog modal-xl" role="document">
                                <div class="modal-content">
                                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true"><i class="fas fa-times"></i></span>
                                    </button>
                                    <div class="modal-body text-center">
                                        <div class="container" >
                                            <div class="row justify-content-center" >
                                                <div class="col-lg-9" >
                                                    <!-- Portfolio Modal - Title-->
                                                    <h2 class="portfolio-modal-title text-secondary mb-0" id="portfolioModal1Label">${subject.name}</h2>
                                                    <!-- Icon Divider-->
                                                    <div class="divider-custom">
                                                        <div class="divider-custom-line"></div>
                                                        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                                        <div class="divider-custom-line"></div>
                                                    </div>
                                                    <!-- Portfolio Modal - Image-->
                                                    <img class="img-fluid rounded mb-5" src="assets/img/portfolio/quiz.png" alt="" />
                                                    <!-- Portfolio Modal - Text-->
                                                    <p class="mb-2 text-left" >&emsp; ${subject.description}</p>
                                                    <p class="mb-2 ">
                                                        Time : ${subject.time}
                                                    </p>
                                                    <p class="mb-2 ">
                                                        Number of questions : ${subject.mount}
                                                    </p>
                                                    <form action="joinQuiz" method="POST">
                                                        <input type="hidden" name="txtSubjectID" value="${subject.id}"/>
                                                        <button type="submit" class="btn btn-primary" >
                                                            <i class="fas fa-play fa-fw"></i>
                                                            Join 
                                                        </button>
                                                    </form>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
            </div>
        </section>


        <!-- Copyright Section-->

        <div class="copyright py-4 text-center text-white footer fixed-bottom">
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

