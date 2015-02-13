<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>

<jsp:include page="includes/includes.jsp"></jsp:include>  

    <title>iLearnRW ORB</title>


    <!-- Custom styles for this template
    <link href="css/jumbotron.css" rel="stylesheet"> -->
<link href=${pageContext.request.contextPath}/resources/libs/css/jumbotron.css rel="stylesheet">

  </head>

  <body>

<jsp:include page="includes/navbar.jsp"></jsp:include>  
    
      <div class="container">

 		<img src="${pageContext.request.contextPath}/resources/assets/images/Logo.jpg" width="933" height="360">

      </div>

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
      <div class="container">
        <h1>Logged Out!</h1>
          
        
        <p>You have successfully logged out!</p>
        <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/" role="button">Home Page &raquo;</a></p>
      </div>
    </div>

      <footer>
        <p>&copy; iLearnRW 2015</p>
      </footer>
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster
    <script src="js/jquery-2.1.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script> -->
    <script src="${pageContext.request.contextPath}/resources/libs/js/jquery-2.1.3.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/libs/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script> -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/ie10-viewport-bug-workaround.js"></script>
    
    
  </body>
</html>