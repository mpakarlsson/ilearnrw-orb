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
        <h1>iLearnRW On Line Resource Bank</h1>
        
        <p> <spring:message code="index.message" text="default text" /> </p>
        <a class="btn btn-primary btn-lg" href="http://www.ilearnrw.eu/" role="button" target="_blank"><spring:message code="index.learnmore" text="default text" /> &raquo;</a></p>
      </div>
    </div>

    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
          <h2><spring:message code="quickinfo.analyze.title" text="default text" /></h2>
          <p><spring:message code="quickinfo.analyze.text" text="default text" /></p>
          <ul>
				<li><spring:message code="quickinfo.analyze.readability" text="default text" /></li>
				<li><spring:message code="quickinfo.analyze.time" text="default text" /></li>
				<li><spring:message code="quickinfo.analyze.stats" text="default text" /></li>
				<li><spring:message code="quickinfo.analyze.heatmap" text="default text" /></li>          
          </ul>
          <!--  <p><a class="btn btn-default" href="#" role="button"><spring:message code="general.viewdetails" text="default text" /> &raquo;</a></p> -->
        </div>
        <div class="col-md-4">
          <h2><spring:message code="quickinfo.checkword.title" text="default text" /></h2>
          <p><spring:message code="quickinfo.checkword.text" text="default text" /></p>
          <ul>
				<li><spring:message code="quickinfo.checkword.pronunciation" text="default text" /></li>
				<li><spring:message code="quickinfo.checkword.syllables" text="default text" /></li>
				<li><spring:message code="quickinfo.checkword.phonic" text="default text" /></li>
				<li><spring:message code="quickinfo.checkword.freq" text="default text" /></li>          
          </ul>
       </div>
        <div class="col-md-4">
          <h2><spring:message code="quickinfo.annotation.title" text="default text" /></h2>
          <p><spring:message code="quickinfo.annotation.text" text="default text" /></p>
          <ul>
				<li><spring:message code="quickinfo.annotation.rules" text="default text" /></li>
				<li><spring:message code="quickinfo.annotation.highlight" text="default text" /></li>
				<li><spring:message code="quickinfo.annotation.multiple" text="default text" /></li>          
          </ul>
        </div>
      </div>

      <hr>

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