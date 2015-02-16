<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<html>
<head>

<jsp:include page="includes/includes.jsp"></jsp:include>

<title>iLearnRW ORB</title>


<!-- Custom styles for this template
    <link href="css/jumbotron.css" rel="stylesheet"> -->
<link
	href=${pageContext.request.contextPath}/resources/libs/css/jumbotron.css
	rel="stylesheet">

</head>

<body>

	<jsp:include page="includes/navbar.jsp"></jsp:include>


	<div class="container">
		<div class="row">
			<div class="col-md-3">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>Available Profiles</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${students}" var="student">
							<tr>
								<td><a
									href="${pageContext.request.contextPath}/profiles/${student.getId()}?lang=${pageContext.response.locale}">
										${student.getUsername()} </a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

			</div>
			<div class="col-md-9">
				<c:choose>
					<c:when test="${selectedStudent == null}">
						<h2>Please select a profile</h2>
					</c:when>
					<c:otherwise>
						<h2>${selectedStudent.getUsername()}</h2>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<hr>

		<footer>
			<p>&copy; iLearnRW 2015</p>
		</footer>
	</div>
	<!-- /container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster
    <script src="js/jquery-2.1.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script> -->
	<script
		src="${pageContext.request.contextPath}/resources/libs/js/jquery-2.1.3.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/libs/js/bootstrap.min.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script> -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/ie10-viewport-bug-workaround.js"></script>


</body>
</html>