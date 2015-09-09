<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
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

<style>
.dropdown-menu {
	min-width: 300px;
	max-width: 320px;
}

.dropdown-submenu {
	position: relative;
}

.dropdown-submenu>.dropdown-menu {
	top: 0;
	left: -100%;
	min-width: 310px;
	max-width: 330px; margin-top : -6px;
	margin-right: -1px;
	-webkit-border-radius: 6px 6px 6px 6px;
	-moz-border-radius: 6px 6px 6px 6px;
	border-radius: 6px 6px 6px 6px;
	margin-top: -6px;
}

.dropdown-submenu:hover>.dropdown-menu {
	display: block;
}

.dropdown-submenu>a:after {
	display: block;
	content: " ";
	float: left;
	width: 0;
	height: 0;
	border-color: transparent;
	border-style: solid;
	border-width: 5px 5px 5px 0;
	border-right-color: #999;
	margin-top: 5px;
	margin-right: 10px;
}

.dropdown-submenu:hover>a:after {
	border-left-color: #ffffff;
}

.dropdown-submenu.pull-left {
	float: none;
}

.dropdown-submenu.pull-left>.dropdown-menu {
	left: -100%;
	margin-left: 50px;
	-webkit-border-radius: 6px 6px 6px 6px;
	-moz-border-radius: 6px 6px 6px 6px;
	border-radius: 6px 6px 6px 6px;
}

.dropdown-menu-right {
	margin-left: 0;
}
</style>


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

<body>

	<jsp:include page="includes/navbar.jsp"></jsp:include>


	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<br>

				<div class="dropdown">
					<button class="btn btn-default dropdown-toggle" id="menu1"
						type="button" data-toggle="dropdown">
						<spring:message text="default text" code="text.analysis.select" />
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
															<td style="width: 100%">${selectedProfile.getUserProblems().getProblemDescription(i, j).getHumanReadableDescription()}
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

						<form name="textForm" id="textForm"
							action="${pageContext.request.contextPath}/annotated/${profileId}"
							method="post" target="_blank">

							<div class="form-group">
								<label for="male"><spring:message
										code="text.analysis.inserttext" text="default text" /></label>
								<textarea class="form-control" rows="25" name="inputText">${text}</textarea>
								<input type="hidden" name="activeRules" id="activeRules"
									value="test">
							</div>
							<button type="submit" class="btn btn-default">
								<spring:message code="text.annotation.annotate"
									text="default text" />
							</button>
						</form>

					</c:otherwise>
				</c:choose>


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
									ruleIndex = e.selectedIndex;
									colorIndex = c.selectedIndex;
									if (ruleIndex == -1)
										ruleIndex = 0;
									if (colorIndex ==  -1)
										colorIndex = 0;
									str = visibles[0].id + "_"
											+ e.options[ruleIndex].value
											+ "_"
											+ c.options[colorIndex].value;
								}
								for (i = 1; i < visibles.length; ++i) {
									var e = document.getElementById("select"
											+ visibles[i].id);
									var c = document.getElementById("color"
											+ visibles[i].id);
									ruleIndex = e.selectedIndex;
									colorIndex = c.selectedIndex;
									if (ruleIndex == -1)
										ruleIndex = 0;
									if (colorIndex ==  -1)
										colorIndex = 0;
									str = str + "," + visibles[i].id + "_"
											+ e.options[ruleIndex].value
											+ "_"
											+ c.options[colorIndex].value;
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
						<div class="btn-group">
							<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
							<spring:message code="text.annotation.quickselections" text="default text" /><span class="caret"></span>
							</a>
							<ul class="dropdown-menu dropdown-menu-right" role="menu"
								aria-labelledby="dropdownMenu">
								<c:forEach items="${presents.getGroups()}" var="group"
									varStatus="i">
									<li class="dropdown-submenu dropdown-menu-right"><a
										tabindex="-1" href="#">${group.getGroupTitle()}</a>
										<ul class="dropdown-menu">
											<c:forEach items="${group.getSubgroups()}" var="subgroup" varStatus="j">
												<!--  <li><a href="#" onclick="clearRules();enableRules(${i.index}, ${j.index});">${subgroup.getSubgroupTitle()} </a>
												</li> -->
												<li id="group${i.index}${j.index}"><a href="#">${subgroup.getSubgroupTitle()} </a>  </li>
												<script>
												$('#group${i.index}${j.index}').click(function(){
												    obj = ${presents.getItemsJson(i.index, j.index)};
												    clearRules();
													for (k = 0; k < obj.length; k++) {
														var id = obj[k].category+'_' + obj[k].index;//x[i].getAttribute("data-details");
														$('#enabled' + id).css("color", "green");
														$('#' + id).show();
														$('#color' + id).colorselector("setColor", "#"+obj[k].defaultColourHEX);
													}
												});
												</script>
											</c:forEach>
										</ul></li>
								</c:forEach>
							</ul>
						</div>
						<script>
						function clearRules() {
							var x = document
									.getElementsByClassName("enabled");
							for (i = 0; i < x.length; i++) {
								var id = x[i].getAttribute("data-details");
								x[i].parentNode.parentNode.style.display = 'none';
								$('#' + id).css("color", "red");
							}
						}
						function enableRules(i, j) {
							obj = JSON.parse('${presents.getItemsJson(i,j)}');
							for (k = 0; k < obj.length; k++) {
								var id = obj[k].category+'_' + obj[k].index;
								$('#enabled' + id).css("color", "green");
								$('#' + id).show();
								$('#color' + id).colorselector("setColor", "#"+obj[k].defaultColourHEX);
							}
						}
						</script>
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
													<option value="0"><spring:message code="text.annotation.rule.nothing" text="default text" /></option>
													<option value="1"><spring:message code="text.annotation.rule.paintparts" text="default text" /></option>
													<option value="2"><spring:message code="text.annotation.rule.paintwords" text="default text" /></option>
													<option value="3" selected="selected"><spring:message code="text.annotation.rule.highlightparts" text="default text" /></option>
													<option value="4"><spring:message code="text.annotation.rule.highlightwords" text="default text" /></option>
													<option value="5"><spring:message code="text.annotation.rule.hideparts" text="default text" /></option>
											</select> <select id="color${i}_${j}">
													<option value="#CD5C5C" data-color="#CD5C5C">indian red</option>
													<option value="#FF4500" data-color="#FF4500">orange red</option>
													<option value="#008B8B" data-color="#008B8B">dark cyan</option>
													<option value="#B8860B" data-color="#B8860B">dark golden rod</option>
													<option value="#A0522D" data-color="#A0522D">sienna</option>
													<option value="#32CD32" data-color="#32CD32">lime green</option>
													<option value="#FFD700" data-color="#FFD700">gold</option>
													<option value="#48D1CC" data-color="#48D1CC">medium turquoise</option>
													<option value="#87CEEB" data-color="#87CEEB">sky blue</option>
													<option value="#FF69B4" data-color="#FF69B4">hot pink</option>
													<option value="#87CEFA" data-color="#87CEFA">light sky blue</option>
													<option value="#ADD8E6" data-color="#ADD8E6">light blue</option>
													<option value="#6495ED" data-color="#6495ED">cornflower blue</option>
													<option value="#DC143C" data-color="#DC143C">crimson</option>
													<option value="#FF8C00" data-color="#FF8C00">dark orange</option>
													<option value="#C71585" data-color="#C71585">medium violet red</option>
													<option value="#800000" data-color="#800000">maroon</option>
													<option value="#3CB371" data-color="#3CB371">medium sea green</option>
													<option value="#C0C0C0" data-color="#C0C0C0">silver</option>
													<option value="#000000" data-color="#000000">black</option>
													<option value="#FFFFFF" data-color="#FFFFFF">white</option>
													<option value="#E8E8E8" data-color="#E8E8E8">light gray</option>
													<option value="#F9966B" data-color="#F9966B">beige</option>
													<option value="#CCFB5D" data-color="#CCFB5D">fluorescent light green</option>
													<option value="#FFF380" data-color="#FFF380">faded yellow</option>
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