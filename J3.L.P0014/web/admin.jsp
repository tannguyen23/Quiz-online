<%-- 
    Document   : admin.jsp
    Created on : Feb 14, 2021, 4:57:18 PM
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
        <title>admin page</title>
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
        <!-- Masthead-->
        <div class="container-fluid" style="margin-top: 150px;margin-bottom: 100px;">
            <!-- search bar -->
            <nav class="navbar navbar-light bg-light mb-2">
                <form class="form-inline" action="searchQuestion" >
                    <input class="form-control mr-sm-2" name="txtSearchContent" type="search" placeholder="Search By Content" aria-label="Search" value="${requestScope.txtSearchContent}">
                    &emsp;&emsp;&emsp;
                    <label>Status :</label>
                    &emsp;
                    <select class="custom-select" name="slSearchStatus" id="slSearchStatus">
                        <option value="all" selected>All</option>
                        <option value="1">True</option>
                        <option value="0">False</option>
                    </select>
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
                            <th scope="col">Content</th>
                            <th scope="col">Answer Correct</th>
                            <th scope="col">Create Date</th>
                            <th scope="col">SubjectID</th>
                            <th scope="col">Status</th>
                            <th scope="col">Update</th>
                            <th scope="col">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.listQuestion}" var="question" varStatus="counter">
                            <tr>
                                <th scope="row">${counter.count + requestScope.sequenceNumber}</th>
                                <td>${question.getHtmlContent()}</td>
                                <c:forEach items="${question.listAnswer}" var="answer">
                                    <c:if test="${answer.getCharAnswer() eq question.answerCorrect}">
                                        <td>${answer.getHtmlContent()}</td>
                                    </c:if>
                                </c:forEach>
                                <td>${question.getTextCreateDate()}</td>
                                <td>${question.subjectId}</td>
                                <td>${question.status}</td>
                                <td>
                                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#updateModal${question.id}">
                                        Update
                                    </button>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal${question.id}">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>


            <!-- Delete Modal -->
            <c:forEach items="${requestScope.listQuestion}" var="question">
                <div class="modal fade" id="deleteModal${question.id}" tabindex="-1" role="dialog" >
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Notification</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="container py-3">
                                Are you sure to delete this question ? 
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-info" data-dismiss="modal">No</button>
                                <form action="deleteQuestion" method="POST">
                                    <input type="hidden" name="txtID" value="${question.id}">
                                    <button type="submit" class="btn btn-danger">Yes</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!--Update Modal-->
            <c:forEach items="${requestScope.listQuestion}" var="question">
                <div class="modal fade" id="updateModal${question.id}" tabindex="-1" role="dialog" >
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header ">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="container py-2 px-4">
                                <form action="updateQuestion" method="POST">
                                    <input type="hidden" name="txtID" value="${question.id}">
                                    <div class="card-body">
                                        <div class="form-group">
                                            <label >Content</label>
                                            <textarea  type="text" name="txtContent"class="form-control" required="" rows="8">${question.getContent()}</textarea>
                                        </div>

                                        <div class="form-group">
                                            <label >Answer</label>
                                            <c:forEach items="${question.listAnswer}" var="answer">
                                                <c:if test="${question.answerCorrect eq answer.getCharAnswer()}">
                                                    <div class="form-check my-1">

                                                        <div class="row g-3">
                                                            <input class="form-check-input " type="radio" name="rdoAnswer" checked="" value="${answer.id}" >
                                                            <div class="col-auto">
                                                                <label class=""> ${answer.getCharAnswer()}.</label>
                                                            </div>
                                                            <div class="col-10">
                                                                <input type="text" name="txtAnswer${answer.id}" class="form-control p-1" value=" ${answer.getHtmlContent()}"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <c:if test="${question.answerCorrect ne answer.getCharAnswer()}">
                                                    <div class="form-check my-1">
                                                        <div class="row">
                                                            <input class="form-check-input " type="radio" name="rdoAnswer" value="${answer.id}">
                                                            <div class="col-auto">
                                                                <label class=""> ${answer.getCharAnswer()}.</label>
                                                            </div>
                                                            <div class="col-10">
                                                                <input type="text" name="txtAnswer${answer.id}" class="form-control p-1" value=" ${answer.getHtmlContent()}"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>


                                        <div class="form-group">
                                            <label for="SubjectSelect">Subject</label>
                                            <select multiple name="slSubject" class="form-control" id="SubjectSelect" >
                                                <c:forEach items="${requestScope.listSubject}" var="subject">
                                                    <c:if test="${subject.id eq question.subjectId}">
                                                        <option selected="" class="p-2" value="${subject.id}">${subject.name}</option>
                                                    </c:if>
                                                    <c:if test="${subject.id ne question.subjectId}">
                                                        <option class="p-2" value="${subject.id}">${subject.name}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="StatusSelect">Status</label>
                                            <select name="slStatus" class="form-control" id="SubjectSelect">
                                                <c:if test="${question.status eq true}">
                                                    <option selected="" class="p-2" value="${true}">True</option>
                                                    <option class="p-2" value="${false}">False</option>
                                                </c:if>
                                                <c:if test="${question.status eq false}">
                                                    <option class="p-2" value="${true}">True</option>
                                                    <option selected="" class="p-2" value="${false}">False</option>
                                                </c:if>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="text-muted">
                                        <button type="submit" class="btn btn-primary btn-sm btn-block">Update</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${requestScope.totalPage > 1}">
                <nav aria-label="...">
                    <ul class="pagination justify-content-center">
                        <c:forEach begin="1" end="${requestScope.totalPage}" var="index" >
                            <c:url value ="searchQuestion" var = "myPagingURL">
                                <c:param name="txtSearchContent" value="${requestScope.txtSearchContent}"></c:param>
                                <c:param name="slSearchStatus" value="${requestScope.slSearchStatus}"></c:param>
                                <c:param name="slSearchSubject" value="${requestScope.slSearchSubject}"></c:param>
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

        <script>
            function selectElement(id, valueToSelect) {
                if (valueToSelect === null) {
                    valueToSelect = "all";
                }
                let element = document.getElementById(id);
                element.value = valueToSelect;
            }
            selectElement("slSearchStatus","${requestScope.slSearchStatus}");
            selectElement("slSearchSubject","${requestScope.slSearchSubject}")
        </script>
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



