<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<jsp:include page="includes/includes.jsp"></jsp:include>

<title>iLearnRW ORB</title>


<link
	href=${pageContext.request.contextPath}/resources/libs/css/jumbotron.css
	rel="stylesheet">

</head>

<body>

	<jsp:include page="includes/navbar.jsp"></jsp:include>


	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<br>

				<form name="textForm" action="${pageContext.request.contextPath}/annotated" method="post" target="_blank">
					<label for="male"><spring:message
							code="text.analysis.select" text="default text" /></label> <select
						class="form-control" name="selectedId">
						<c:forEach items="${students}" var="student">
							<option value="${student.getId()}"
								${profileId == student.getId() ? "selected": ""}>
								${student.getUsername()}</option>
						</c:forEach>
					</select> <br>
					<div class="form-group">
						<label for="male"><spring:message
								code="text.analysis.inserttext" text="default text" /></label>
						<textarea class="form-control" rows="25" name="inputText">${text}</textarea>
					</div>
					<button type="submit" class="btn btn-default">
						<spring:message code="text.analysis.calculate" text="default text" />
					</button>
				</form>

			</div>

			<div class="col-md-4">
				Test

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