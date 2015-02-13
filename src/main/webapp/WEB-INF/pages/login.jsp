<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>

<jsp:include page="includes/includes.jsp"></jsp:include>

<title>iLearnRW ORB</title>

<!-- Custom styles for this template -->

<link
	href="${pageContext.request.contextPath}/resources/project-libs/css/login.css"
	rel="stylesheet">

</head>

<body>


	<div class="container">
		<c:if test="${not empty error}">
			<div class="alert alert-danger">
				<a class="close" data-dismiss="alert">×</a> <strong>Error!</strong>
				${error}
			</div>
		</c:if>
		<div class="panel panel-default">
			<form method="POST" class="form-signin" action="${pageContext.request.contextPath}/login">
				<div class="panel-heading">
					<h2 class="form-signin-heading">iLearnRW <br> Online Resource Bank</h2>
					<span>Please enter your details below</span>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<input name="username" type="text" class="form-control"
							placeholder="Username">
					</div>
					<div class="form-group">
						<input name="pass" type="password" class="form-control"
							placeholder="Password">
					</div>
					<div class="form-group">
						<button class="btn btn-large btn-primary" type="submit">Sign
							in</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- /container -->


	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>