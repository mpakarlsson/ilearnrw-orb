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
<link
	href=${pageContext.request.contextPath}/resources/libs/css/bootstrap.min.css
	rel="stylesheet" />
<link
	href=${pageContext.request.contextPath}/resources/libs/css/bootstrap-colorselector.css
	rel="stylesheet" />



<script>
	$(document).ready(function() {
		$('.add').click(function() {
			var id = $(this).data('details');
			$(this).css("color", "green");
			//$('table.tr.hiddens').hide();
			$('#' + id).show();
			$('#color' + id).colorselector();
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
															<td style="min-width: 50px"><span
																id="enabled${i}_${j}" data-details="${i}_${j}"
																data-toggle="tooltip" data-placement="top"
																style="color: red"
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

				<form name="textForm" id="textForm"
					action="${pageContext.request.contextPath}/annotated/${profileId}"
					method="get" target="_blank">

					<div class="form-group">
						<label for="male"><spring:message
								code="text.analysis.inserttext" text="default text" /></label>
						<textarea class="form-control" rows="25" name="inputText">${text}</textarea>
						<input type="hidden" name="activeRules" id="activeRules"
							value="test">
					</div>
					<button type="submit" class="btn btn-default">
						<spring:message code="text.annotation.annotate" text="default text" />
					</button>
				</form>

				<script>
					$("#textForm").submit(
							function(event) {
								var visibles = $(".hiddens:visible");
								var i;
								var str = "";
								if (visibles.length > 0) {
									var e = document.getElementById("select"
											+ visibles[0].id);
									var c = document.getElementById("color"
											+ visibles[0].id);
									str = visibles[0].id + "_"
											+ e.options[e.selectedIndex].value
											+ "_"
											+ c.options[c.selectedIndex].value;
								}
								for (i = 1; i < visibles.length; ++i) {
									var e = document.getElementById("select"
											+ visibles[i].id);
									var c = document.getElementById("color"
											+ visibles[i].id);
									str = str + "," + visibles[i].id + "_"
											+ e.options[e.selectedIndex].value
											+ "_"
											+ c.options[c.selectedIndex].value;
								}
								$("#activeRules").val(str);
							});
				</script>

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

										<tr id="${i}_${j}" class="<%=str%> hiddens">
											<td>${selectedProfile.getUserProblems().getProblemDescription(i, j).getHumanReadableDescription()}<br>
												<select id="select${i}_${j}" class="form-control">
													<option value="0">Nothing</option>
													<option value="1">Paint Problematic Word Parts</option>
													<option value="2">Paint Problematic Words</option>
													<option value="3" selected="selected">Hightlight Problematic Word
														Parts</option>
													<option value="4">Hightlight Problematic Words</option>
											</select> <select id="color${i}_${j}">
													<option value="#A0522D" data-color="#A0522D">sienna</option>
													<option value="#CD5C5C" data-color="#CD5C5C">indianred</option>
													<option value="#FF4500" data-color="#FF4500">orangered</option>
													<option value="#008B8B" data-color="#008B8B">darkcyan</option>
													<option value="#B8860B" data-color="#B8860B">darkgoldenrod</option>
													<option value="#32CD32" data-color="#32CD32">limegreen</option>
													<option value="#FFD700" data-color="#FFD700">gold</option>
													<option value="#48D1CC" data-color="#48D1CC">mediumturquoise</option>
													<option value="#87CEEB" data-color="#87CEEB">skyblue</option>
													<option value="#FF69B4" data-color="#FF69B4">hotpink</option>
													<option value="#CD5C5C" data-color="#CD5C5C">indianred</option>
													<option value="#87CEFA" data-color="#87CEFA">lightskyblue</option>
													<option value="#6495ED" data-color="#6495ED">cornflowerblue</option>
													<option value="#DC143C" data-color="#DC143C">crimson</option>
													<option value="#FF8C00" data-color="#FF8C00">darkorange</option>
													<option value="#C71585" data-color="#C71585">mediumvioletred</option>
													<option value="#000000" data-color="#000000">black</option>
											</select>
											</td>
											<td style="min-width: 50px"><span
												data-details="enabled${i}_${j}" data-toggle="tooltip"
												data-placement="top"
												title="${selectedProfile.getUserProblems().getProblemDescription(i, j).getHumanReadableDescription()}"
												class="glyphicon glyphicon-trash enabled" aria-hidden="true"
												style="cursor: pointer;"></span></td>
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
	<script
		src="${pageContext.request.contextPath}/resources/libs/js/bootstrap-colorselector.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script> -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/ie10-viewport-bug-workaround.js"></script>


</body>
</html>