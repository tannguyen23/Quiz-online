<%-- 
    Document   : login
    Created on : Feb 7, 2021, 12:42:52 PM
    Author     : tanta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>login page</title>
    <link href="assets/css/styles.css" rel="stylesheet" />
</head>
<body id="page-top">
    <!-- Navigation-->
    <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
        <div class="container">
            <a class="navbar-brand js-scroll-trigger" >Quiz online</a>
            
        </nav>
        <!-- Masthead-->
        <div class="container-fluid  "  >
          <div class="row" style="margin-top: 200px;">
            <div class="col-sm">
                <img style="max-width: 60%;height: auto;" class="rounded mx-auto d-block" src="assets/img/logoQuiz.png">
           </div>
           <div class="col-sm">
                <form action="login" method="POST" style="width: 80%;">
                  <div class="form-group">
                    <label for="exampleInputEmail1">Email address</label>
                    &emsp;&emsp;&emsp;
                    <div id="errorUsername" style="display: inline;color:red">${requestScope.errorLogin}</div>
                    <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" name="txtEmail" required="" maxlength="100">
                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Password</label>
                    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password" name="txtPassword" required="" maxlength="100">
                </div>
                <button type="submit" class="btn btn-primary">Login</button><a href="register.jsp" class="btn btn-link">Register</a>
            </form>
    </div>
</div>
</div>


</div>



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


