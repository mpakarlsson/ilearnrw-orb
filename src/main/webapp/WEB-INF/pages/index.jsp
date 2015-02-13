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
        
        <h3>
welcome.springmvc : <spring:message code="welcome.message" text="default text" />
</h3>
<h2>Hello ${name}, how are you?</h2>
     
        
        <p>This site was developed as part of the iLearnRW project.
        It is a resource for teachers, parents and students who want help with phonics.
		Unlike standard text readability tools online, this site not only displays a total score for any text but also gives a heatmap of difficulties and can link any individual word to potential problems.
		It can also help by giving examples of words with similar features. You can check any word.
		Furthermore, you can learn more about phonics by seeing the big picture.</p>
        <a class="btn btn-primary btn-lg" href="http://www.ilearnrw.eu/" role="button" target="_blank">Learn more &raquo;</a></p>
      </div>
    </div>

    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
          <h2>Analyze a text</h2>
          <p>Enter a text to find out how difficult it is for your students.</p>
          <ul>
				<li>Readability scores</li>
				<li>Time estimate</li>
				<li>Vital statistics</li>
				<li>Difficulty heatmap</li>          
          </ul>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
        </div>
        <div class="col-md-4">
          <h2>Check a word</h2>
          <p>Check what sort of difficulties a word may present.</p>
          <ul>
				<li>Pronunciation</li>
				<li>Syllables</li>
				<li>Phonic breakdown</li>
				<li>Frequency information</li>          
          </ul>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
       </div>
        <div class="col-md-4">
          <h2>Check a structure</h2>
          <p>Find out a specific phonic feature or set of feature.</p>
          <ul>
				<li>Complete list of phonic features of English</li>
				<li>Examples of frequent words using that feature</li>
				<li>Similar phonic features</li>          
          </ul>
          <br>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
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