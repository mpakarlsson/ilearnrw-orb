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

<script>
	$(document).ready(function() {
		$('.badge').click(function() {
			var id = $(this).data('details');
			$('table.hiddens').hide();
			$('#' + id).show();
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

				<form name="textForm" action="" method="post">
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
				<br>
				<h4>
					<spring:message code="text.analysis.metrics" text="default text" />
				</h4>
				<table class="table table-striped" id="resultsTable">
					<thead>
						<tr>
							<th><spring:message code="text.analysis.property"
									text="default text" /></th>
							<th><spring:message code="text.analysis.value"
									text="default text" /></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><spring:message code="text.analysis.words"
									text="default text" /></td>
							<td>${analysisResults.getNumberOfTotalWords() }</td>
						</tr>
						<tr>
							<td><spring:message code="text.analysis.bigwords"
									text="default text" /></td>
							<td>${analysisResults.getNumberOfPolysyllabicWords()}</td>
						</tr>
						<tr>
							<td><spring:message code="text.analysis.sentences"
									text="default text" /></td>
							<td>${analysisResults.getNumberOfSentences() }</td>
						</tr>
						<tr>
							<td><spring:message code="text.analysis.bigsentences"
									text="default text" /></td>
							<td>${analysisResults.getNumberOfBigSentences() }</td>
						</tr>
						<tr>
							<td><spring:message code="text.analysis.paragraphs"
									text="default text" /></td>
							<td>${analysisResults.getNumberOfParagraphs() }</td>
						</tr>
						<tr>
							<td><spring:message code="text.analysis.avgword"
									text="default text" /></td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									minFractionDigits="2"
									value="${analysisResults.getAverageWordLength() }" /></td>
						</tr>
						<tr>
							<td><spring:message code="text.analysis.avgsyllables"
									text="default text" /></td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									minFractionDigits="2"
									value="${analysisResults.getAverageSyllablesPerWord() }" /></td>
						</tr>
						<tr>
							<td><spring:message code="text.analysis.avgwordspersentence"
									text="default text" /></td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									minFractionDigits="2"
									value="${analysisResults.getAverageWordsPerSentence() }" /></td>
						</tr>
						<tr>
							<td><spring:message code="text.analysis.flesch"
									text="default text" /></td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									minFractionDigits="2"
									value="${analysisResults.getFleschKincaid()}" /></td>
						</tr>
				</table>
				<hr>
				<h4>
					<spring:message code="text.analysis.usermetrics"
						text="default text" />
				</h4>
				<table class="table table-striped" id="resultsTable">
					<thead>
						<tr>
							<th><spring:message code="text.analysis.property"
									text="default text" /></th>
							<th><spring:message code="text.analysis.value"
									text="default text" /></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><spring:message code="text.analysis.difficulty"
									text="default text" /></td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									minFractionDigits="2" value="${analysisResults.getTscore()}" /></td>
						</tr>
						<tr>
							<td><spring:message code="text.analysis.diffwords"
									text="default text" /></td>
							<td>${analysisResults.getDiffWords()}</td>
						</tr>
						<tr>
							<td><spring:message code="text.analysis.verydiffwords"
									text="default text" /></td>
							<td>${analysisResults.getVeryDiffWords()}</td>
						</tr>
				</table>

			</div>
		</div>


		<c:choose>
			<c:when test="${selectedProfile != null}">
				<hr>
				<div class="row">
					<div class="col-md-8">
						<div class="panel-group" id="accordion" role="tablist"
							aria-multiselectable="true">

							<c:forEach begin="0"
								end="${selectedProfile.getUserProblems().getNumerOfRows()-1}"
								var="i">



								<div class="panel panel-default">
									<div class="panel-heading" style="padding: 5px 15px;">${selectedProfile.getUserProblems().getProblemDefinition(i).getUri()}</div>
									<div class="panel-body">
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

											<span class="badge alert-<%= str %>"
												data-details="data${i}_${j}" data-toggle="tooltip"
												data-placement="top"
												title="${selectedProfile.getUserProblems().getProblemDescription(i, j).getHumanReadableDescription()}"
												style="cursor:pointer; font-size:${75+170*analysisResults.getUserCounters().getValue(i, j) / maxWordsMatched}%">
												${analysisResults.getUserCounters().getValue(i, j)} </span>
										</c:forEach>
									</div>
								</div>



							</c:forEach>
						</div>
						<hr>
						<ul>
							<li><spring:message code="text.analysis.legend.colours" text="default"/></li>
							<li><spring:message code="text.analysis.legend.numbers" text="default"/></li>
							<li><spring:message code="text.analysis.legend.click" text="default"/></li>
						</ul>
					</div>
					<div class="col-md-4" style="height:810px;overflow:auto;">


						<c:forEach begin="0"
							end="${selectedProfile.getUserProblems().getNumerOfRows()-1}"
							var="i">

							<c:forEach begin="0"
								end="${selectedProfile.getUserProblems().getRowLength(i)-1}"
								var="j">
								<table id="data${i}_${j}" class="table table-bordered hiddens">
									<thead>
										<tr>
											<th colspan="3">
												${selectedProfile.getUserProblems().getProblemDescription(i, j).getHumanReadableDescription()}
											</th>
										<tr>
											<td>Word</td>
											<td>Syllables</td>
											<td>Phonetics</td>
										</tr>
									</thead>
									<tbody>

										<c:choose>
											<c:when
												test="${analysisResults.getProblematicWords().getTable()[i][j].getWordList().size() > 0}">
												<c:forEach begin="0"
													end="${analysisResults.getProblematicWords().getTable()[i][j].getWordList().size()-1}"
													var="k">
													<tr>
														<td>${ analysisResults.getProblematicWords().getTable()[i][j].getWordList().get(k).toString() }
														</td>
														<td>${ analysisResults.getProblematicWords().getTable()[i][j].getWordList().get(k).getWordInToSyllables().toLowerCase() }
														</td>
														<td>${ analysisResults.getProblematicWords().getTable()[i][j].getWordList().get(k).getPhonetics() }
														</td>
													</tr>
												</c:forEach>
											</c:when>
										</c:choose>
									</tbody>
								</table>
							</c:forEach>
						</c:forEach>

					</div>
				</div>
			</c:when>
		</c:choose>




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