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
<script
	src="${pageContext.request.contextPath}/resources/libs/js/d3.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/project-libs/js/circledProfile.js"></script>
<link
	href=${pageContext.request.contextPath}/resources/project-libs/css/scrollable_table.css
	rel="stylesheet">

</head>

<body>

	<jsp:include page="includes/navbar.jsp"></jsp:include>


	<div class="container">
		<div class="row">
			<br>
			<div class="col-md-3" style="height: 850px; overflow: auto;">
				<br>
				<table class="table table-hover">
					<thead>
						<tr>
							<th><spring:message code="profile.listheader"
									text="default text" /></th>
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
						<h2>
							<spring:message code="profile.selectprofile" text="default text" />
						</h2>
					</c:when>
					<c:otherwise>
						<div>
							<h2>
								<spring:message code="profile.visualized" text="default text" />
								${selectedStudent.getUsername()}
							</h2>
							<div id=test></div>
							<div id=descriptions></div>
							<ul>
								<li><spring:message code="profile.visualized.circle"
										text="default text" /></li>
								<li><spring:message code="profile.visualized.circlesize"
										text="default text" /></li>
							</ul>
							<hr>
						</div>
						<script>
createCircles(${dataForCircles });
</script>
						<h2>${selectedStudent.getUsername()},
							<spring:message code="profile.difficulties" text="default text" />
						</h2>

						<div class="panel-group" id="accordion" role="tablist"
							aria-multiselectable="true">

							<c:forEach begin="0"
								end="${selectedProfile.getUserProblems().getNumerOfRows()-1}"
								var="i">

								<div class="panel panel-default">
									<div class="panel-heading" role="tab"
										id="heading<c:out value="${i}" />">
										<h4 class="panel-title">
											<a data-toggle="collapse" data-parent="#accordion"
												href="#collapse<c:out value="${i}" />"
												aria-expanded="${i == 0}"
												aria-controls="collapse<c:out value="${i}" />">
												${selectedProfile.getUserProblems().getProblemDefinition(i).getUri()}
											</a>
										</h4>
									</div>
									<div id="collapse<c:out value="${i}" />"
										class="panel-collapse collapse" role="tabpanel"
										aria-labelledby="heading<c:out value="${i}" />">
										<div class="panel-body">

											<table class="table table-condensed scr_table">
												<tbody class="scr_tbody">
													<c:forEach begin="0"
														end="${selectedProfile.getUserProblems().getRowLength(i)-1}"
														var="j">

														<%
															String str = "success";
														%>
														<c:choose>
															<c:when
																test="${selectedProfile.getUserProblems().getUserSeverity(i, j)/(selectedProfile.getUserProblems().getProblemDefinition(i).getSeverityType().equals(\"binary\")?1.0:3.0) > 0.9}">
																<%
																	str = "danger";
																%>
															</c:when>
															<c:when
																test="${selectedProfile.getUserProblems().getUserSeverity(i, j)/(selectedProfile.getUserProblems().getProblemDefinition(i).getSeverityType().equals(\"binary\")?1.0:3.0) > 0.5}">
																<%
																	str = "warning";
																%>
															</c:when>
															<c:when
																test="${selectedProfile.getUserProblems().getUserSeverity(i, j)/(selectedProfile.getUserProblems().getProblemDefinition(i).getSeverityType().equals(\"binary\")?1.0:3.0) > 0.3}">
																<%
																	str = "info";
																%>
															</c:when>
														</c:choose>

														<tr class="<%=str%>">

															<th scope="row">${j+1}.</th>
															<td style="width: 100%">${selectedProfile.getUserProblems().getProblemDescription(i, j).getHumanReadableDescription()}
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>

						<ul>
							<li><spring:message code="text.analysis.legend.colours"
									text="default" /></li>
						</ul>
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
		src="${pageContext.request.contextPath}/resources/libs/js/d3.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/libs/js/bootstrap.min.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script> -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/ie10-viewport-bug-workaround.js"></script>


</body>
</html>