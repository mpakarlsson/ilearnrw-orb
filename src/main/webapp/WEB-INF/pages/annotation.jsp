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

<link
	href=${pageContext.request.contextPath}/resources/project-libs/css/scrollable_table.css
	rel="stylesheet">



<script>
	$(document).ready(function() {
		$('.add').click(function() {
			var id = $(this).data('details');
			$(this).css("color", "green");
			$('table.tr.hiddens').hide();
			$('#' + id).show();
		});

		$('.enabled').click(function() {
			var id = $(this).data('details');
			$(this).parent().parent().hide();
			$('#' + id).css("color", "red");
		});
	});
</script>

<style>
.show {
	display: block;
}

.hiddens {
	display: none;
}
</style>

</head>

</head>

<body>

	<jsp:include page="includes/navbar.jsp"></jsp:include>


	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<br>

				<div class="dropdown">
					<button class="btn btn-default dropdown-toggle" type="button"
						id="menu1" data-toggle="dropdown">
						<spring:message code="text.analysis.select" text="default text" />
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
						<c:forEach items="${students}" var="student">
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="${pageContext.request.contextPath}/annotation/${student.getId()}">${student.getUsername()}</a></li>
						</c:forEach>
					</ul>
				</div>

				<!--  <table class="table table-striped">
					<thead>
						<tr>
							<th style="width: 100%">Col 1</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<tr> <td style="width: 100%">..</td><td>..</td> </tr>
						<tr> <td style="width: 100%">..</td><td>..</td> </tr>
						<tr> <td style="width: 100%">..</td><td>..</td> </tr>
						<tr> <td style="width: 100%">..</td><td>..</td> </tr>
					</tbody>
				</table> -->

				<hr>
				<c:choose>
					<c:when test="${selectedStudent == null}">
						<h2>
							<spring:message code="profile.selectprofile" text="default text" />
						</h2>
					</c:when>
					<c:otherwise>
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
															<td>${selectedProfile.getUserProblems().getProblemDescription(i, j).getHumanReadableDescription()}
															</td>
															<td style="min-width: 50px"><span id="enabled${i}_${j}"
																data-details="data${i}_${j}" data-toggle="tooltip"
																data-placement="top" style="color:red"
																title="${selectedProfile.getUserProblems().getProblemDescription(i, j).getHumanReadableDescription()}"
																class="add glyphicon glyphicon-plus-sign"
																aria-hidden="true" style="cursor: pointer;"> </span></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>

					</c:otherwise>
				</c:choose>

				<form name="textForm"
					action="${pageContext.request.contextPath}/annotated/${profileId}"
					method="post" target="_blank">

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



				<c:choose>
					<c:when test="${selectedStudent != null}">

						<h2>
							<spring:message code="text.annotation.list" text="default text" />
						</h2>

						<div class="panel-group" id="accordion" role="tablist"
							aria-multiselectable="true">
							<table class="table table-condensed">

								<c:forEach begin="0"
									end="${selectedProfile.getUserProblems().getNumerOfRows()-1}"
									var="i">

									<!-- ${selectedProfile.getUserProblems().getProblemDefinition(i).getUri()} -->

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

										<tr id="data${i}_${j}" class="<%=str%> hiddens">
											<td>${selectedProfile.getUserProblems().getProblemDescription(i, j).getHumanReadableDescription()}
											</td>
											<td style="min-width: 70px"><a href="test"> <span
													class="glyphicon glyphicon-text-color" aria-hidden="true"></span>
											</a> <a href="test"> <span
													class="glyphicon glyphicon-text-size" aria-hidden="true"></span>
											</a></td>
											<td style="min-width: 50px"><span
												data-details="enabled${i}_${j}" data-toggle="tooltip"
												data-placement="top"
												title="${selectedProfile.getUserProblems().getProblemDescription(i, j).getHumanReadableDescription()}"
												class="glyphicon glyphicon-trash enabled" aria-hidden="true"
												style="cursor: pointer;"> </span></td>
										</tr>
									</c:forEach>
								</c:forEach>
							</table>
						</div>

					</c:when>
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