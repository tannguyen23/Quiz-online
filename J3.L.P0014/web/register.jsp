<%-- 
    Document   : register
    Created on : Feb 14, 2021, 2:36:28 PM
    Author     : tanta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>register page</title>
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
            
        </nav>
        <!-- Masthead-->
        <div class="container-fluid " style="margin-top: 200px;">
         <div class="d-flex justify-content-center ">
          <div class="card  w-50">
              <form action="register" method="POST">

              <div class="card-header text-center">
                Register
            </div>
            <div class="card-body">
             <div class="form-group">
                 <label >Email address &nbsp;&nbsp;&nbsp;&nbsp; <label class="text-danger">${requestScope.emailError}</label></label>
                 <input type="email" class="form-control"  placeholder="name@example.com" required="" name="txtEmail" value="${requestScope.email}" maxlength="100">
            </div>
            <div class="form-group">
                <label >Name</label>
                <input type="text" class="form-control" placeholder="name" required="" name="txtName" value="${requestScope.name}" maxlength="50">
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" class="form-control" required="" name="txtPassword" maxlength="100">
            </div>
        </div>
        <div class="card-footer text-muted">
            <button type="submit" class="btn btn-primary btn-lg btn-block">Register</button>
        </div>
    </form>
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



